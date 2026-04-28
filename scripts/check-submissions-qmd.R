# check-submissions-qmd.R
# Render all student .qmd submissions and report errors, then create deidentified copies
# Usage: Set submissions_dir below, then source this script
#
# Note: Quarto rendering takes much longer than running an .R script. Expect
# ~10–60s per submission. Bump timeout_seconds if students do heavy work.
#
# If the assignment loads local data files (e.g. survey_data.csv), copy those
# files into submissions_dir before sourcing — otherwise Part 3 chunks will fail.

library(processx)
library(tidyverse)

# ── Configuration ──────────────────────────────────────────────
if (!exists("submissions_dir")) {
  submissions_dir <- "path/to/submissions"  # <-- set this
}
timeout_seconds <- 300
output_csv <- file.path(submissions_dir, "submission_results.csv")

# ── Find all .qmd files ───────────────────────────────────────
qmds <- list.files(submissions_dir, pattern = "\\.qmd$",
                   full.names = TRUE, ignore.case = TRUE)

if (length(qmds) == 0) {
  stop("No .qmd files found in: ", submissions_dir)
}

cat(sprintf("Found %d submissions in %s\n\n", length(qmds), submissions_dir))

# ── Extract student name from Canvas filename ─────────────────
# Canvas format: lastnamefirstname_12345_67890_filename.qmd
extract_student_name <- function(filepath) {
  basename <- tools::file_path_sans_ext(basename(filepath))
  name_part <- str_extract(basename, "^[a-zA-Z]+")
  if (is.na(name_part)) return(basename)
  name_part
}

# ── Render each qmd ───────────────────────────────────────────
results <- map(qmds, function(qmd_path) {
  student <- extract_student_name(qmd_path)
  cat(sprintf("  Rendering: %-30s", student))

  status <- "pass"
  error_line <- NA_character_
  error_message <- NA_character_

  res <- tryCatch({
    processx::run(
      "quarto",
      args = c("render", qmd_path),
      timeout = timeout_seconds,
      error_on_status = TRUE
    )
  }, error = function(e) e)

  if (inherits(res, "error")) {
    status <- "fail"

    # processx puts everything in $stderr when error_on_status=TRUE
    raw_output <- res$stderr %||% conditionMessage(res)

    # Strip ANSI color escape sequences (Quarto colors its console output)
    raw_output <- str_remove_all(raw_output, "\u001b\\[[0-9;]*m")

    out_lines <- str_split(raw_output, "\n")[[1]]

    # Quarto-specific: "Quitting from filename.qmd:42-45 [chunk-name]"
    # (older versions used "lines 42-45" — match either)
    quit_idx <- which(str_detect(out_lines, "Quitting from"))
    if (length(quit_idx) > 0) {
      line_match <- str_extract(
        out_lines[quit_idx[1]],
        "(?::|lines? )(\\d+)(?:-\\d+)?",
        group = 1
      )
      error_line <- line_match
    }

    # Find the actual R error
    error_idx <- which(str_detect(out_lines, "^Error"))
    if (length(error_idx) > 0) {
      start <- error_idx[1]
      context <- out_lines[start:min(start + 5, length(out_lines))]
      context <- context[!str_detect(context, "^(Backtrace|Execution halted|\\s+\\d+\\.)")]
      context <- str_subset(context, "^\\s*$", negate = TRUE)
      error_message <- paste(str_squish(context), collapse = " | ")
    } else {
      # Quarto-only error (e.g. YAML parse, missing format)
      qerr_idx <- which(str_detect(out_lines, "^(ERROR|Error)"))
      if (length(qerr_idx) > 0) {
        error_message <- str_squish(out_lines[qerr_idx[1]])
      } else {
        error_message <- str_squish(conditionMessage(res))
      }
    }

    # Detect timeout
    if (inherits(res, "system_command_timeout_error")) {
      error_message <- sprintf("Timed out after %ds", timeout_seconds)
    }

    cat(" ✗\n")
  } else {
    cat(" ✓\n")
  }

  tibble(
    student = student,
    file = basename(qmd_path),
    status = status,
    error_line = error_line,
    error_message = error_message
  )
}) |>
  list_rbind()

# ── Console summary ──────────────────────────────────────────
n_pass <- sum(results$status == "pass")
n_fail <- sum(results$status == "fail")

cat(sprintf("\n── Results: %d passed, %d failed (out of %d) ──\n\n",
            n_pass, n_fail, nrow(results)))

if (n_fail > 0) {
  cat("Failed submissions:\n\n")
  results |>
    filter(status == "fail") |>
    rowwise() |>
    group_walk(~ {
      cat(sprintf("  %s (%s)\n", .x$student, .x$file))
      if (!is.na(.x$error_line)) {
        cat(sprintf("    Line: %s\n", .x$error_line))
      }
      cat(sprintf("    Error: %s\n\n", .x$error_message))
    })
}

# ── Write CSV ─────────────────────────────────────────────────
write_csv(results, output_csv)
cat(sprintf("Results saved to: %s\n", output_csv))

# ── Create de-identified copies ──────────────────────────────
# Copies each .qmd under a random filename with the student's name scrubbed
# from YAML, comment headers, and inline text. Key file maps random IDs back
# to students (keep this private — it contains PII).
anon_dir <- file.path(submissions_dir, "deidentified")
dir.create(anon_dir, showWarnings = FALSE)

results <- results |>
  mutate(anon_id = replicate(n(), paste0(sample(c(letters, 0:9), 8, replace = TRUE), collapse = "")))

results |>
  rowwise() |>
  group_walk(~ {
    src <- file.path(submissions_dir, .x$file)
    dest <- file.path(anon_dir, paste0(.x$anon_id, ".qmd"))

    lines <- readLines(src, warn = FALSE)
    raw_name <- .x$student

    # 1. Scrub author/name/by fields inside the first YAML block
    yaml_markers <- which(str_trim(lines) == "---")
    yaml_range <- if (length(yaml_markers) >= 2) {
      yaml_markers[1]:yaml_markers[2]
    } else {
      integer(0)
    }
    if (length(yaml_range) > 0) {
      lines[yaml_range] <- str_replace(
        lines[yaml_range],
        "(?i)^(\\s*(author|name|by)\\s*:\\s*).*$",
        "\\1\"[redacted]\""
      )
    }

    # 2. Scrub "Your Name / By / Author / Name [value]" lines OUTSIDE the YAML
    #    Catches code-chunk comments ("# Your Name: ...") and markdown body
    #    text ("By: Jane Smith"). Skipping YAML avoids stripping "author:" from
    #    the line we just redacted in step 1.
    non_yaml <- setdiff(seq_along(lines), yaml_range)
    if (length(non_yaml) > 0) {
      lines[non_yaml] <- str_replace(
        lines[non_yaml],
        "(?i)^(\\s*#?\\s*)(your name|by|author|name)\\s*:?\\s+\\S.*$",
        "\\1[redacted]"
      )
    }

    # 3. Scrub the raw concatenated filename name (e.g. "smithjane")
    if (nchar(raw_name) >= 4) {
      lines <- str_replace_all(
        lines,
        regex(raw_name, ignore_case = TRUE),
        "[redacted]"
      )
    }

    # 4. Scrub plausible split-name variants from the filename.
    #    Canvas concatenates "lastnamefirstname"; we don't know the split,
    #    so try every split where each side is >=3 chars, and look for
    #    "First Last" or "Last First" with strict word boundaries.
    if (nchar(raw_name) >= 6) {
      for (i in 3:(nchar(raw_name) - 3)) {
        a <- substr(raw_name, 1, i)
        b <- substr(raw_name, i + 1, nchar(raw_name))
        for (p in c(sprintf("\\b%s[, ]+%s\\b", a, b),
                    sprintf("\\b%s[, ]+%s\\b", b, a))) {
          lines <- str_replace_all(lines, regex(p, ignore_case = TRUE), "[redacted]")
        }
      }
    }

    # 5. Catch a bare-name comment line near the top of the document
    #    (e.g. line 2 of the setup chunk is just "# Jane Smith").
    first_comments <- which(str_detect(head(lines, 30), "^#\\s*[A-Za-z]"))
    if (length(first_comments) >= 1) {
      for (i in head(first_comments, 3)) {
        content <- str_remove(lines[i], "^#\\s*")
        if (nchar(str_squish(content)) > 0 &&
            nchar(str_squish(content)) < 40 &&
            str_detect(content, "^[A-Za-z][A-Za-z .'-]+$") &&
            !str_detect(content, "(?i)(assignment|date|library|install|setup|part|task)")) {
          lines[i] <- "# [redacted]"
        }
      }
    }

    writeLines(lines, dest)
  })

# Write the key file (maps anon_id back to student — keep private!)
key_csv <- file.path(submissions_dir, "deidentified_key.csv")
results |>
  select(student, file, anon_id, status) |>
  write_csv(key_csv)

cat(sprintf("\nDe-identified copies: %s/ (%d files)\n", anon_dir, nrow(results)))
cat(sprintf("Key file (PRIVATE): %s\n", key_csv))
