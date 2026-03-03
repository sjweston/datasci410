# =============================================================================
# Team Sorting Script for PSY 410
# =============================================================================
#
# Takes a Canvas survey export CSV and assigns students to balanced teams.
#
# Usage:
#   1. Export the Team Formation Survey results from Canvas
#      (Quiz → Quiz Statistics → Student Analysis → Download CSV)
#   2. Update the file path and column mapping below
#   3. Source or run this script in R
#   4. Review the output and team_rosters.csv
#
# =============================================================================

library(tidyverse)

# -----------------------------------------------------------------------------
# CONFIGURATION — Update these before running
# -----------------------------------------------------------------------------

# Path to Canvas survey export CSV
survey_file <- "data/team-formation-survey.csv"

# Target team size (script will calculate number of teams from class size)
target_team_size <- 5

# Column mapping — update these to match your Canvas export column names
# Canvas typically names columns after the question text
col_name        <- "name"          # student name column
col_stats       <- "question_1"    # stats experience
col_coding      <- "question_2"    # coding experience
col_spreadsheet <- "question_3"    # spreadsheet comfort
col_friend      <- "question_4"    # friend request (optional)

# Output file
output_file <- "data/team_rosters.csv"


# -----------------------------------------------------------------------------
# STEP 1: Read and score survey responses
# -----------------------------------------------------------------------------

raw <- read_csv(survey_file, show_col_types = FALSE)

# Print column names so you can verify the mapping
cat("Column names in CSV:\n")
cat(paste(" ", names(raw)), sep = "\n")
cat("\n")

# Rename columns for easier use
survey <- raw |>
  rename(
    student_name = all_of(col_name),
    stats_exp    = all_of(col_stats),
    coding_exp   = all_of(col_coding),
    spreadsheet  = all_of(col_spreadsheet),
    friend_req   = all_of(col_friend)
  ) |>
  select(student_name, stats_exp, coding_exp, spreadsheet, friend_req)

# Score each response (0, 1, or 2)
score_stats <- function(x) {
  case_when(
    str_detect(x, regex("no", ignore_case = TRUE))         ~ 0L,
    str_detect(x, regex("intro", ignore_case = TRUE))      ~ 1L,
    str_detect(x, regex("beyond", ignore_case = TRUE))     ~ 2L,
    TRUE ~ 0L
  )
}

score_coding <- function(x) {
  case_when(
    str_detect(x, regex("no|never", ignore_case = TRUE))       ~ 0L,
    str_detect(x, regex("little|tried", ignore_case = TRUE))   ~ 1L,
    str_detect(x, regex("yes|completed", ignore_case = TRUE))  ~ 2L,
    TRUE ~ 0L
  )
}

score_spreadsheet <- function(x) {
  case_when(
    str_detect(x, regex("not comfortable|rarely", ignore_case = TRUE))   ~ 0L,
    str_detect(x, regex("somewhat|basic", ignore_case = TRUE))           ~ 1L,
    str_detect(x, regex("very|regularly|pivot", ignore_case = TRUE))     ~ 2L,
    TRUE ~ 0L
  )
}

survey <- survey |>
  mutate(
    stats_score       = score_stats(stats_exp),
    coding_score      = score_coding(coding_exp),
    spreadsheet_score = score_spreadsheet(spreadsheet),
    experience_score  = stats_score + coding_score + spreadsheet_score,
    friend_req_clean  = str_squish(str_to_lower(replace_na(friend_req, "")))
  )

cat("Experience score distribution:\n")
print(table(survey$experience_score))
cat("\n")


# -----------------------------------------------------------------------------
# STEP 2: Process friend requests
# -----------------------------------------------------------------------------

# Build a lookup of clean names for matching
name_lookup <- survey |>
  mutate(name_clean = str_squish(str_to_lower(student_name))) |>
  select(student_name, name_clean)

# Match friend requests to actual students
match_friend <- function(request, all_names) {
  if (is.na(request) || request == "") return(NA_character_)

  # Try exact match first
  exact <- all_names |> filter(name_clean == request)
  if (nrow(exact) == 1) return(exact$student_name)

  # Try partial match (request appears within a name, or vice versa)
  partial <- all_names |>
    filter(str_detect(name_clean, fixed(request)) |
           str_detect(request, fixed(name_clean)))
  if (nrow(partial) == 1) return(partial$student_name)

  # Try approximate match
  matches <- agrep(request, all_names$name_clean, max.distance = 0.2,
                   value = FALSE)
  if (length(matches) == 1) return(all_names$student_name[matches])

  # No confident match
  return(NA_character_)
}

survey <- survey |>
  mutate(
    friend_matched = map_chr(friend_req_clean, ~match_friend(.x, name_lookup))
  )

# Build friend pairs (each student in at most one pair)
# A pair is formed when A requests B (B doesn't have to request A back)
paired <- character(0)
friend_pairs <- list()

for (i in seq_len(nrow(survey))) {
  student <- survey$student_name[i]
  friend  <- survey$friend_matched[i]

  if (is.na(friend)) next
  if (student %in% paired || friend %in% paired) next
  if (student == friend) next

  friend_pairs <- c(friend_pairs, list(c(student, friend)))
  paired <- c(paired, student, friend)
}

cat("Friend pairs formed:", length(friend_pairs), "\n")
for (pair in friend_pairs) {
  cat("  ", pair[1], "<->", pair[2], "\n")
}

# Flag unmatched requests
unmatched <- survey |>
  filter(friend_req_clean != "", is.na(friend_matched))
if (nrow(unmatched) > 0) {
  cat("\nUnmatched friend requests (could not find student):\n")
  for (i in seq_len(nrow(unmatched))) {
    cat("  ", unmatched$student_name[i], "requested:", unmatched$friend_req[i], "\n")
  }
}
cat("\n")


# -----------------------------------------------------------------------------
# STEP 3: Assign teams via stratified snake draft
# -----------------------------------------------------------------------------

n_students <- nrow(survey)
n_teams <- round(n_students / target_team_size)

# Ensure reasonable team sizes
if (n_students / n_teams > 6) n_teams <- n_teams + 1
if (n_students / n_teams < 4) n_teams <- n_teams - 1

cat("Class size:", n_students, "\n")
cat("Number of teams:", n_teams, "\n")
cat("Target size:", target_team_size, "(actual will be",
    floor(n_students / n_teams), "to", ceiling(n_students / n_teams), ")\n\n")

# Initialize team assignments
assignments <- tibble(
  student_name = character(),
  team = integer()
)
team_sizes <- rep(0L, n_teams)

# Snake draft helper: returns team order for a round of assignments
snake_order <- function(n_teams, round) {
  if (round %% 2 == 1) {
    seq_len(n_teams)
  } else {
    rev(seq_len(n_teams))
  }
}

# --- Phase A: Place friend pairs ---
# Sort pairs by combined experience (highest first, so they get spread out)
pair_scores <- map_dbl(friend_pairs, function(pair) {
  survey |>
    filter(student_name %in% pair) |>
    pull(experience_score) |>
    sum()
})
pair_order <- order(pair_scores, decreasing = TRUE)
friend_pairs <- friend_pairs[pair_order]

# Assign each pair to the team with the fewest members (snake-ish)
for (pair in friend_pairs) {
  # Pick the team with the fewest members; break ties by lowest team number
  target_team <- which.min(team_sizes)

  assignments <- bind_rows(assignments, tibble(
    student_name = pair,
    team = target_team
  ))
  team_sizes[target_team] <- team_sizes[target_team] + 2L
}

# --- Phase B: Place remaining students via snake draft ---
remaining <- survey |>
  filter(!student_name %in% assignments$student_name) |>
  arrange(desc(experience_score))

# Snake draft: go through sorted students, assign to teams in snake order
round_num <- 1
team_idx <- 1
order <- snake_order(n_teams, round_num)

for (i in seq_len(nrow(remaining))) {
  # Find next team in snake order that isn't already full
  # (full = already at ceiling size)
  max_size <- ceiling(n_students / n_teams)

  while (team_sizes[order[team_idx]] >= max_size) {
    team_idx <- team_idx + 1
    if (team_idx > n_teams) {
      round_num <- round_num + 1
      order <- snake_order(n_teams, round_num)
      team_idx <- 1
    }
  }

  target_team <- order[team_idx]
  assignments <- bind_rows(assignments, tibble(
    student_name = remaining$student_name[i],
    team = target_team
  ))
  team_sizes[target_team] <- team_sizes[target_team] + 1L

  team_idx <- team_idx + 1
  if (team_idx > n_teams) {
    round_num <- round_num + 1
    order <- snake_order(n_teams, round_num)
    team_idx <- 1
  }
}


# -----------------------------------------------------------------------------
# STEP 4: Output results
# -----------------------------------------------------------------------------

# Join team assignments back with survey data
roster <- assignments |>
  left_join(survey |> select(student_name, experience_score, friend_req),
            by = "student_name") |>
  mutate(
    in_friend_pair = student_name %in% paired
  ) |>
  arrange(team, student_name)

# Print team rosters
cat("=" |> strrep(60), "\n")
cat("TEAM ROSTERS\n")
cat("=" |> strrep(60), "\n\n")

for (t in sort(unique(roster$team))) {
  team_members <- roster |> filter(team == t)
  cat(sprintf("Team %d (%d members, avg experience: %.1f)\n",
              t, nrow(team_members), mean(team_members$experience_score)))
  cat("-" |> strrep(40), "\n")
  for (j in seq_len(nrow(team_members))) {
    m <- team_members[j, ]
    pair_flag <- if (m$in_friend_pair) " [paired]" else ""
    cat(sprintf("  %-25s (score: %d)%s\n",
                m$student_name, m$experience_score, pair_flag))
  }
  cat("\n")
}

# Print summary
cat("=" |> strrep(60), "\n")
cat("SUMMARY\n")
cat("=" |> strrep(60), "\n\n")

summary_stats <- roster |>
  group_by(team) |>
  summarize(
    n = n(),
    mean_exp = mean(experience_score),
    min_exp = min(experience_score),
    max_exp = max(experience_score),
    .groups = "drop"
  )

print(summary_stats)

cat("\nOverall experience mean:", round(mean(roster$experience_score), 1), "\n")
cat("Team experience means range:",
    round(min(summary_stats$mean_exp), 1), "to",
    round(max(summary_stats$mean_exp), 1), "\n")
cat("Friend pairs honored:", length(friend_pairs), "of",
    sum(survey$friend_req_clean != ""), "requests\n")

# Write output CSV
write_csv(roster, output_file)
cat("\nTeam rosters written to:", output_file, "\n")
