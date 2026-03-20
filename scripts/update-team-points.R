# =============================================================================
# Team Challenge Points Calculator
# =============================================================================
#
# Reads a Canvas gradebook export and the team roster, computes points
# per team across all four challenge categories, and outputs a summary.
#
# Weekly workflow:
#   1. In Canvas: Grades → Export → Download CSV
#   2. Save as data/canvas_gradebook.csv (overwrites the old one)
#   3. Source this script
#   4. Copy the printed scoreboard code into files/scoreboard.qmd
#
# =============================================================================

library(tidyverse)

# ── Configuration ────────────────────────────────────────────────────────────

# File paths
roster_file    <- "data/team_rosters.csv"
gradebook_file <- "data/canvas_gradebook.csv"
output_file    <- "data/team_points.csv"

# Team names — update after Session 2 when students choose names.
# Keys are team numbers (from roster), values are display names.
team_names <- c(
  "1" = "Team 1",
  "2" = "Team 2",
  "3" = "Team 3",
  "4" = "Team 4",
  "5" = "Team 5"
  # Add more if you have more teams
)

# Column patterns — these match Canvas assignment names.
# The script uses str_detect() so partial matches work.
# Adjust these to match however you named things in Canvas.
pair_coding_pattern   <- "Pair Coding|In-Class"
assignment_pattern    <- "^Assignment \\d"
quiz_pattern          <- "^Quiz \\d"
fun_challenge_pattern <- "Fun Challenge|Team Challenge"

# Thresholds
# "All but one" rule: a team earns the point if at most this many
# members are missing a submission
max_missing <- 1


# ── Read data ────────────────────────────────────────────────────────────────

roster <- read_csv(roster_file, show_col_types = FALSE) |>
  select(student_name, team) |>
  mutate(team = as.character(team))

# Canvas gradebook: skip the "Points Possible" row (row 2)
gradebook_raw <- read_csv(gradebook_file, show_col_types = FALSE)

# Canvas puts a "Points Possible" or "    Points Possible" row as row 1 of data
# Detect and remove it
if (str_detect(gradebook_raw$Student[1], regex("point", ignore_case = TRUE))) {
  gradebook_raw <- gradebook_raw |> slice(-1)
}

cat("Roster:", nrow(roster), "students in", n_distinct(roster$team), "teams\n")
cat("Gradebook:", nrow(gradebook_raw), "students\n\n")


# ── Match gradebook students to roster ───────────────────────────────────────

# Canvas uses "Last, First" format; roster uses "First Last"
# Build both formats for flexible matching
gradebook <- gradebook_raw |>
  mutate(
    canvas_name = Student,
    # Try to convert "Last, First" to "First Last"
    name_flipped = if_else(
      str_detect(Student, ","),
      str_trim(paste(
        str_extract(Student, "(?<=,\\s?).*"),
        str_extract(Student, "^[^,]+")
      )),
      Student
    ),
    name_clean = str_to_lower(str_squish(name_flipped))
  )

roster <- roster |>
  mutate(name_clean = str_to_lower(str_squish(student_name)))

# Join on cleaned names
merged <- gradebook |>
  left_join(roster, by = "name_clean", suffix = c("_canvas", "_roster"))

# Check for unmatched students
unmatched_canvas <- merged |> filter(is.na(team))
unmatched_roster <- roster |>
  filter(!name_clean %in% merged$name_clean)

if (nrow(unmatched_canvas) > 0) {
  cat("WARNING: These Canvas students are NOT in the roster:\n")
  cat(paste("  ", unmatched_canvas$canvas_name), sep = "\n")
  cat("\n")
}
if (nrow(unmatched_roster) > 0) {
  cat("WARNING: These roster students are NOT in the gradebook:\n")
  cat(paste("  ", unmatched_roster$student_name), sep = "\n")
  cat("\n")
}

# Drop unmatched students (not on a team)
merged <- merged |> filter(!is.na(team))


# ── Identify columns by category ────────────────────────────────────────────

all_cols <- names(gradebook_raw)

pair_coding_cols <- all_cols[str_detect(all_cols, regex(pair_coding_pattern, ignore_case = TRUE))]
assignment_cols  <- all_cols[str_detect(all_cols, regex(assignment_pattern, ignore_case = TRUE))]
quiz_cols        <- all_cols[str_detect(all_cols, regex(quiz_pattern, ignore_case = TRUE))]
fun_challenge_cols <- all_cols[str_detect(all_cols, regex(fun_challenge_pattern, ignore_case = TRUE))]

cat("Columns matched:\n")
cat("  Pair coding:    ", length(pair_coding_cols), "\n")
cat("  Assignments:    ", length(assignment_cols), "\n")
cat("  Quizzes:        ", length(quiz_cols), "\n")
cat("  Fun challenges: ", length(fun_challenge_cols), "\n\n")


# ── Helper: did the student submit? ──────────────────────────────────────────
# A submission counts if the cell is not blank and not zero.

submitted <- function(x) {
  !is.na(x) & x != "" & as.numeric(x) > 0
}


# ── Category 1: Pair coding (1 pt per session) ──────────────────────────────
# Team earns 1 point if all-but-one members submitted.

if (length(pair_coding_cols) > 0) {
  pair_coding_points <- map_dfr(pair_coding_cols, function(col) {
    merged |>
      group_by(team) |>
      summarize(
        n_team     = n(),
        n_submitted = sum(submitted(.data[[col]])),
        n_missing   = n_team - n_submitted,
        earned      = as.integer(n_missing <= max_missing),
        column      = col,
        .groups     = "drop"
      )
  })

  pair_coding_summary <- pair_coding_points |>
    group_by(team) |>
    summarize(pair_coding = sum(earned), .groups = "drop")
} else {
  pair_coding_summary <- roster |>
    distinct(team) |>
    mutate(pair_coding = 0L)
}


# ── Category 2: Assignment submission (1 pt per assignment) ──────────────────
# Team earns 1 point if all members submitted.

if (length(assignment_cols) > 0) {
  assignment_points <- map_dfr(assignment_cols, function(col) {
    merged |>
      group_by(team) |>
      summarize(
        n_team      = n(),
        n_submitted = sum(submitted(.data[[col]])),
        n_missing   = n_team - n_submitted,
        earned      = as.integer(n_missing <= max_missing),
        column      = col,
        .groups     = "drop"
      )
  })

  assignment_summary <- assignment_points |>
    group_by(team) |>
    summarize(assignments = sum(earned), .groups = "drop")
} else {
  assignment_summary <- roster |>
    distinct(team) |>
    mutate(assignments = 0L)
}


# ── Category 3: Quiz performance (1 pt — top 2 teams per quiz) ──────────────
# For each quiz, the 2 teams with the highest average score earn 1 point.

if (length(quiz_cols) > 0) {
  quiz_points <- map_dfr(quiz_cols, function(col) {
    team_avgs <- merged |>
      mutate(score = as.numeric(.data[[col]])) |>
      filter(!is.na(score)) |>
      group_by(team) |>
      summarize(avg_score = mean(score), .groups = "drop") |>
      arrange(desc(avg_score)) |>
      mutate(
        rank = row_number(),
        earned = as.integer(rank <= 2),
        column = col
      )
  })

  quiz_summary <- quiz_points |>
    group_by(team) |>
    summarize(quizzes = sum(earned), .groups = "drop")
} else {
  quiz_summary <- roster |>
    distinct(team) |>
    mutate(quizzes = 0L)
}


# ── Category 4: Fun challenges (2 pts each) ─────────────────────────────────
# Group assignment — if any member has a score, team submitted.
# Each challenge is worth 2 points.

if (length(fun_challenge_cols) > 0) {
  fun_challenge_points <- map_dfr(fun_challenge_cols, function(col) {
    merged |>
      group_by(team) |>
      summarize(
        any_submitted = any(submitted(.data[[col]])),
        earned        = as.integer(any_submitted) * 2L,
        column        = col,
        .groups       = "drop"
      )
  })

  fun_challenge_summary <- fun_challenge_points |>
    group_by(team) |>
    summarize(fun_challenge = sum(earned), .groups = "drop")
} else {
  fun_challenge_summary <- roster |>
    distinct(team) |>
    mutate(fun_challenge = 0L)
}


# ── Combine everything ──────────────────────────────────────────────────────

points <- roster |>
  distinct(team) |>
  left_join(pair_coding_summary, by = "team") |>
  left_join(assignment_summary, by = "team") |>
  left_join(quiz_summary, by = "team") |>
  left_join(fun_challenge_summary, by = "team") |>
  mutate(
    across(c(pair_coding, assignments, quizzes, fun_challenge),
           ~ replace_na(.x, 0L)),
    team_name = team_names[team],
    total = pair_coding + assignments + quizzes + fun_challenge
  ) |>
  arrange(desc(total), team_name) |>
  select(team, team_name, pair_coding, assignments, quizzes, fun_challenge, total)


# ── Output ───────────────────────────────────────────────────────────────────

cat("=" |> strrep(60), "\n")
cat("TEAM POINTS SUMMARY\n")
cat("=" |> strrep(60), "\n\n")

points |>
  select(-team) |>
  knitr::kable(
    col.names = c("Team", "Pair Coding", "Assignments", "Quizzes",
                   "Fun Challenge", "Total"),
    align = c("l", "c", "c", "c", "c", "c")
  ) |>
  print()

cat("\n")

# Save CSV
write_csv(points, output_file)
cat("Points saved to:", output_file, "\n\n")


# ── Print scoreboard code ───────────────────────────────────────────────────
# Copy-paste this into files/scoreboard.qmd

cat("=" |> strrep(60), "\n")
cat("COPY THIS INTO files/scoreboard.qmd:\n")
cat("=" |> strrep(60), "\n\n")

cat("scoreboard <- tribble(\n")
cat('  ~team,', paste0(rep(' ' , 20), collapse = ''),
    '~pair_coding, ~assignments, ~quizzes, ~fun_challenge,\n')
for (i in seq_len(nrow(points))) {
  row <- points[i, ]
  comma <- if (i < nrow(points)) "," else ""
  cat(sprintf('  %-30s %d,            %d,            %d,        %d%s\n',
              paste0('"', row$team_name, '",'),
              row$pair_coding, row$assignments,
              row$quizzes, row$fun_challenge, comma))
}
cat(")\n")
