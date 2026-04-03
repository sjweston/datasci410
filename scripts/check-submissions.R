# check-submissions.R
# Run all student .R submissions and report errors
# Usage: Set submissions_dir below, then source this script

library(callr)
library(tidyverse)

# ── Configuration ──────────────────────────────────────────────
# Set submissions_dir before sourcing, or edit the default here
if (!exists("submissions_dir")) {
  submissions_dir <- "path/to/submissions"  # <-- set this
}
timeout_seconds <- 120
output_csv <- file.path(submissions_dir, "submission_results.csv")

# ── Find all .R files ─────────────────────────────────────────
scripts <- list.files(submissions_dir, pattern = "\\.R$",
                      full.names = TRUE, ignore.case = TRUE)

if (length(scripts) == 0) {
  stop("No .R files found in: ", submissions_dir)
}

cat(sprintf("Found %d submissions in %s\n\n", length(scripts), submissions_dir))

# ── Extract student name from Canvas filename ─────────────────
# Canvas format: lastnamefirstname_12345_67890_filename.R
# We grab everything before the first underscore-digit sequence
extract_student_name <- function(filepath) {
  basename <- tools::file_path_sans_ext(basename(filepath))
  # Split on first _ followed by digits (Canvas submission ID)
  name_part <- str_extract(basename, "^[a-zA-Z]+")
  if (is.na(name_part)) return(basename)
  name_part
}

# ── Run each script ───────────────────────────────────────────
results <- map(scripts, function(script_path) {
  student <- extract_student_name(script_path)
  cat(sprintf("  Running: %-30s", student))

  status <- "pass"
  error_line <- NA_character_
  error_message <- NA_character_

  tryCatch({
    callr::rscript(
      script_path,
      timeout = timeout_seconds,
      show = FALSE
    )
    cat(" ✓\n")
  },
  error = function(e) {
    status <<- "fail"

    # The actual R error is in stderr, not the generic callr message
    stderr_output <- e$stderr %||% conditionMessage(e)

    # Extract the "Error ..." line(s) from stderr
    stderr_lines <- str_split(stderr_output, "\n")[[1]]
    error_idx <- which(str_detect(stderr_lines, "^Error"))
    if (length(error_idx) > 0) {
      # Grab the Error line and any "Caused by" or detail lines after it
      start <- error_idx[1]
      context_lines <- stderr_lines[start:min(start + 5, length(stderr_lines))]
      # Keep lines that are part of the error message (not backtrace)
      context_lines <- context_lines[!str_detect(context_lines, "^(Backtrace|Execution halted|\\s+\\d+\\.)")]
      context_lines <- str_subset(context_lines, "^\\s*$", negate = TRUE)
      error_message <<- paste(str_squish(context_lines), collapse = " | ")
    } else {
      # Fallback: use the conditionMessage
      error_message <<- str_squish(conditionMessage(e))
    }

    # Try to extract line number from stderr
    # Pattern: "filename.R:42:" or "(from filename#42)"
    line_match <- str_extract(stderr_output, "\\.(R|r):(\\d+)")
    if (!is.na(line_match)) {
      error_line <<- str_extract(line_match, "\\d+$")
    }

    cat(" ✗\n")
  })

  tibble(
    student = student,
    file = basename(script_path),
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
# Copies each submission under a random filename (no student info)
# so files can be shared for pattern analysis without FERPA concerns.
# A key file maps random IDs back to students (keep this private).
anon_dir <- file.path(submissions_dir, "deidentified")
dir.create(anon_dir, showWarnings = FALSE)

results <- results |>
  mutate(anon_id = replicate(n(), paste0(sample(c(letters, 0:9), 8, replace = TRUE), collapse = "")))

results |>
  rowwise() |>
  group_walk(~ {
    src <- file.path(submissions_dir, .x$file)
    dest <- file.path(anon_dir, paste0(.x$anon_id, ".R"))

    lines <- readLines(src, warn = FALSE)

    # Build name variants to scrub from file contents
    # Student name from filename is e.g. "smithjane"
    raw_name <- .x$student
    # Try to split into last + first (all lowercase, no separator)
    # We can't know the split point, so search for common patterns
    name_variants <- c(raw_name)

    # Also scrub anything on comment lines that looks like a name header
    lines <- str_replace(lines, "(?i)^(#\\s*)(your name|by:?|author:?|name:?)\\s+.*", "\\1[redacted]")

    # Scrub the raw name (case-insensitive) anywhere it appears
    for (v in name_variants) {
      if (nchar(v) >= 4) {  # Only scrub if long enough to avoid false matches
        lines <- str_replace_all(lines, regex(v, ignore_case = TRUE), "[redacted]")
      }
    }

    # Also blank out the second comment line if it looks like a name
    # (common pattern: line 1 = assignment title, line 2 = student name)
    first_comments <- which(str_detect(head(lines, 10), "^#"))
    if (length(first_comments) >= 2) {
      name_line <- first_comments[2]
      # If it's a short comment (just a name), redact it
      content <- str_remove(lines[name_line], "^#\\s*")
      if (nchar(str_squish(content)) > 0 &&
          nchar(str_squish(content)) < 40 &&
          !str_detect(content, "(?i)(assignment|date|library|install|setup)")) {
        lines[name_line] <- "# [redacted]"
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
