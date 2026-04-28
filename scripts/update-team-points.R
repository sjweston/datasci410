# =============================================================================
# Team Challenge Points Calculator
# =============================================================================
#
# Reads a Canvas gradebook export and the team roster, computes points
# per team across all four challenge categories, and outputs a summary.
#
# Weekly workflow:
#   1. In Canvas: Grades → Export → Download CSV
#   2. Save as data/private/canvas_gradebook.csv (overwrites the old one)
#   3. Source this script
#   4. Copy the printed scoreboard code into files/scoreboard.qmd
#
# =============================================================================

library(tidyverse)

# ── Configuration ────────────────────────────────────────────────────────────

# File paths
roster_file    <- "data/private/team_rosters.csv"
gradebook_file <- "data/private/canvas_gradebook.csv"
output_file    <- "data/private/team_points.csv"
rankings_file  <- "data/private/team_rankings.csv"

# Team names — update after Session 2 when students choose names.
# Keys are team numbers (from roster), values are display names.
team_names <- c(
  "1" = "Tyrannotitans",
  "2" = "Vitamin R",
  "3" = "Rticokes",
  "4" = "Coderunners",
  "5" = "R-odents",
  "6" = "The Black Cats",
  "7" = "The Bosses"
)

# Column patterns — these match Canvas assignment names.
# The script uses str_detect() so partial matches work.
# Adjust these to match however you named things in Canvas.
# IMPORTANT: Canvas exports also include computed summary columns like
# "Assignments Current Score", "In-Class Check-ins Final Score", etc.
# Patterns must be specific enough to match individual grade columns
# without also matching those summary columns.
pair_coding_pattern   <- "^Session \\d+ Check-in"
assignment_pattern    <- "^Assignment \\d"
quiz_pattern          <- "^Quiz \\d"
fun_challenge_pattern <- "^Challenge"

# Thresholds
# "All but one" rule: a team earns the point if at most this many
# members are missing a submission
max_missing <- 1

# Week start dates (Mondays of each course week)
week_starts <- as.Date(c(
  "2026-03-30",  # Week 1
  "2026-04-06",  # Week 2
  "2026-04-13",  # Week 3
  "2026-04-20",  # Week 4
  "2026-04-27",  # Week 5
  "2026-05-04",  # Week 6
  "2026-05-11",  # Week 7
  "2026-05-18",  # Week 8
  "2026-05-25",  # Week 9
  "2026-06-01"   # Week 10
))

# Session-to-week mapping
session_week <- c(
  "1" = 1, "2" = 1, "3" = 2, "4" = 2, "5" = 3, "6" = 3,
  "7" = 4, "8" = 4, "9" = 5, "10" = 5, "11" = 6, "12" = 6,
  "13" = 7, "14" = 7, "15" = 8, "16" = 9, "17" = 10, "18" = 10
)

# Assignment-to-week mapping (by due date, not assigned date)
assignment_week <- c(
  "1" = 1, "2" = 2, "3" = 4, "4" = 5, "5" = 6, "6" = 7, "7" = 8, "8" = 9
)


# ── Read data ────────────────────────────────────────────────────────────────

roster <- read_csv(roster_file, show_col_types = FALSE) |>
  select(student_name, team) |>
  mutate(team = as.character(team))

# Canvas gradebook: skip the "Points Possible" row (row 2)
gradebook_raw <- read_csv(gradebook_file, show_col_types = FALSE)

# remove row with NA value for student
gradebook_raw = gradebook_raw |>
  filter(!is.na(Student))

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


# ── Helper: which week does a column belong to? ─────────────────────────────
# Returns the course week number for a gradebook column, or NA.

col_week <- function(col) {
  num <- str_extract(col, "\\d+")
  if (is.na(num)) return(NA_integer_)
  if (str_detect(col, regex("session|check-in", ignore_case = TRUE))) {
    return(as.integer(session_week[num]))
  }
  if (str_detect(col, regex("assignment", ignore_case = TRUE))) {
    return(as.integer(assignment_week[num]))
  }
  # Quizzes and challenges: week number = item number
  as.integer(num)
}

# Current week (1-indexed). Weeks before current_week are "complete."
current_week <- max(1L, sum(Sys.Date() >= week_starts))
cat("Current date:", format(Sys.Date()), "→ Week", current_week,
    "(showing diagnostics for weeks 1–", current_week - 1, ")\n\n", sep = "")


# ── Helper: did the student submit? ──────────────────────────────────────────
# A submission counts if the cell parses to a positive number.
# Non-numeric Canvas codes ("EX", "MI", letter grades, etc.) and blanks
# count as "not submitted." Coercing first prevents NA from leaking into
# downstream sums — a single non-numeric cell would otherwise silently
# turn the whole team's category total into NA → 0.

submitted <- function(x) {
  num <- suppressWarnings(as.numeric(x))
  !is.na(num) & num > 0
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
# Team earns 1 point if all-but-one members submitted.

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
        rank = min_rank(desc(avg_score)),
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


# ── Weekly rankings ─────────────────────────────────────────────────────────
# Compute cumulative points and rank at the end of each week.

all_weekly_points <- bind_rows(
  if (length(pair_coding_cols) > 0) {
    pair_coding_points |>
      mutate(week = map_int(column, col_week)) |>
      select(team, week, earned)
  },
  if (length(assignment_cols) > 0) {
    assignment_points |>
      mutate(week = map_int(column, col_week)) |>
      select(team, week, earned)
  },
  if (length(quiz_cols) > 0) {
    quiz_points |>
      mutate(week = map_int(column, col_week)) |>
      select(team, week, earned)
  },
  if (length(fun_challenge_cols) > 0) {
    fun_challenge_points |>
      mutate(week = map_int(column, col_week)) |>
      select(team, week, earned)
  }
)

weekly_totals <- all_weekly_points |>
  group_by(team, week) |>
  summarize(week_points = sum(earned), .groups = "drop")

# Ensure all team-week combos exist up to the last completed week
max_week <- max(weekly_totals$week, 1L)
all_team_weeks <- expand_grid(
  team = sort(unique(roster$team)),
  week = seq_len(max_week)
)

rankings <- all_team_weeks |>
  left_join(weekly_totals, by = c("team", "week")) |>
  mutate(week_points = replace_na(week_points, 0L)) |>
  arrange(team, week) |>
  group_by(team) |>
  mutate(cumulative = cumsum(week_points)) |>
  ungroup() |>
  group_by(week) |>
  mutate(rank = min_rank(desc(cumulative))) |>
  ungroup() |>
  mutate(team_name = team_names[team]) |>
  select(team, team_name, week, week_points, cumulative, rank)

write_csv(rankings, rankings_file)


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


# ── Quiz averages by team and week ─────────────────────────────────────────

if (length(quiz_cols) > 0) {
  cat("=" |> strrep(60), "\n")
  cat("QUIZ AVERAGES BY TEAM\n")
  cat("=" |> strrep(60), "\n\n")

  quiz_avg_wide <- quiz_points |>
    mutate(
      week = map_int(column, col_week),
      label = paste0("Week ", week)
    ) |>
    select(team, label, avg_score, rank) |>
    mutate(display = sprintf("%.1f (#%d)", avg_score, rank)) |>
    select(team, label, display) |>
    pivot_wider(names_from = label, values_from = display) |>
    mutate(team = team_names[team]) |>
    rename(Team = team)

  quiz_avg_wide |>
    knitr::kable(align = c("l", rep("c", ncol(quiz_avg_wide) - 1))) |>
    print()

  cat("\n(Teams ranked #1–2 earn the point. Ties share a rank.)\n\n")
}


# ── Weekly rankings table ──────────────────────────────────────────────────

cat("=" |> strrep(60), "\n")
cat("WEEKLY RANKINGS (cumulative points → rank)\n")
cat("=" |> strrep(60), "\n\n")

rankings_wide <- rankings |>
  mutate(display = sprintf("%d pts (#%d)", cumulative, rank)) |>
  select(team_name, week, display) |>
  pivot_wider(names_from = week, values_from = display,
              names_prefix = "Week ") |>
  rename(Team = team_name)

rankings_wide |>
  knitr::kable(align = c("l", rep("c", ncol(rankings_wide) - 1))) |>
  print()

cat("\nRankings saved to:", rankings_file, "\n\n")


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


# ── Diagnostic: why did each team lose points? ─────────────────────────────

cat("\n")
cat("=" |> strrep(60), "\n")
cat("LOST POINTS DETAIL (by team)\n")
cat("=" |> strrep(60), "\n\n")

for (t in sort(unique(points$team))) {
  tname <- team_names[t]
  cat(tname, "\n")
  cat("-" |> strrep(nchar(tname)), "\n")

  any_lost <- FALSE

  # Pair coding losses
  if (length(pair_coding_cols) > 0) {
    lost_pc <- pair_coding_points |>
      filter(team == t, earned == 0) |>
      mutate(week = map_int(column, col_week)) |>
      filter(week < current_week)
    if (nrow(lost_pc) > 0) {
      any_lost <- TRUE
      for (j in seq_len(nrow(lost_pc))) {
        r <- lost_pc[j, ]
        label <- str_extract(r$column, "Session \\d+")
        cat(sprintf(
          "  %s check-in: %d of %d students didn't submit\n",
          label, r$n_missing, r$n_team
        ))
      }
    }
  }

  # Assignment losses
  if (length(assignment_cols) > 0) {
    lost_a <- assignment_points |>
      filter(team == t, earned == 0) |>
      mutate(week = map_int(column, col_week)) |>
      filter(week < current_week)
    if (nrow(lost_a) > 0) {
      any_lost <- TRUE
      for (j in seq_len(nrow(lost_a))) {
        r <- lost_a[j, ]
        label <- str_extract(r$column, "Assignment \\d+")
        cat(sprintf(
          "  %s: %d of %d students didn't submit\n",
          label, r$n_missing, r$n_team
        ))
      }
    }
  }

  # Quiz losses
  if (length(quiz_cols) > 0) {
    lost_q <- quiz_points |>
      filter(team == t, earned == 0) |>
      mutate(week = map_int(column, col_week)) |>
      filter(week < current_week)
    if (nrow(lost_q) > 0) {
      any_lost <- TRUE
      for (j in seq_len(nrow(lost_q))) {
        r <- lost_q[j, ]
        label <- str_extract(r$column, "Quiz \\d+")
        cat(sprintf(
          "  %s: team average ranked #%d (top 2 earn points)\n",
          label, r$rank
        ))
      }
    }
  }

  # Fun challenge losses
  if (length(fun_challenge_cols) > 0) {
    lost_fc <- fun_challenge_points |>
      filter(team == t, earned == 0) |>
      mutate(week = map_int(column, col_week)) |>
      filter(week < current_week)
    if (nrow(lost_fc) > 0) {
      any_lost <- TRUE
      for (j in seq_len(nrow(lost_fc))) {
        r <- lost_fc[j, ]
        label <- str_extract(r$column, "Challenge \\d+")
        if (is.na(label)) label <- r$column
        cat(sprintf("  %s: no team member submitted\n", label))
      }
    }
  }

  if (!any_lost) cat("  No points lost!\n")
  cat("\n")
}

