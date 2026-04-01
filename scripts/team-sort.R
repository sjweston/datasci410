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

# Path to class roster CSV (names in "Last, First" format)
roster_file <- "data/class-roster.csv"

# Target team size (script will calculate number of teams from class size)
target_team_size <- 5

# Column mapping — Canvas quiz export column names
col_name        <- "name"
col_stats       <- "5238527: Have you taken a statistics course?"
col_coding      <- "5238528: Have you written code in any language (R, Python, MATLAB, etc.)?"
col_spreadsheet <- "5238529: How comfortable are you with spreadsheets (Excel, Google Sheets)?"
col_friend      <- "5238530: (Optional) Is there someone in this class you'd like to be on a team with? Enter their name below. We'll try to honor one request per person, but can't guarantee it."

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
# Patterns match both the Canvas quiz text and any test data
score_stats <- function(x) {
  case_when(
    is.na(x)                                                   ~ 0L,
    str_detect(x, regex("beyond", ignore_case = TRUE))         ~ 2L,
    str_detect(x, regex("intro", ignore_case = TRUE))          ~ 1L,
    TRUE ~ 0L
  )
}

score_coding <- function(x) {
  case_when(
    is.na(x)                                                       ~ 0L,
    str_detect(x, regex("yes|comfortable|completed", ignore_case = TRUE)) ~ 2L,
    str_detect(x, regex("little|tried|beginner", ignore_case = TRUE))     ~ 1L,
    TRUE ~ 0L
  )
}

score_spreadsheet <- function(x) {
  case_when(
    is.na(x)                                                                  ~ 0L,
    str_detect(x, regex("very|regularly|pivot", ignore_case = TRUE))          ~ 2L,
    str_detect(x, regex("somewhat|basic|sorting", ignore_case = TRUE))        ~ 1L,
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

cat("Experience score distribution (survey respondents):\n")
print(table(survey$experience_score))
cat("\n")


# -----------------------------------------------------------------------------
# STEP 1b: Load class roster and merge non-survey students
# -----------------------------------------------------------------------------

# Normalize a name to "First Last" lowercase for matching
normalize_name <- function(x) {
  x <- str_squish(x)
  # If comma-separated ("Last, First" or "Last, First M."), flip it
  if_else(
    str_detect(x, ","),
    {
      parts <- str_split_fixed(x, ",\\s*", 2)
      last  <- parts[, 1]
      first <- parts[, 2]
      # Strip middle initials: remove single letters followed by optional period
      first <- str_remove(first, "\\s+[A-Za-z]\\.?$")
      str_squish(paste(first, last))
    },
    x
  ) |> str_to_lower()
}

roster <- read_csv(roster_file, show_col_types = FALSE)

# Expect a "grad" column (TRUE/FALSE or 1/0). If missing, assume all undergrad.
if (!"grad" %in% names(roster)) {
  cat("Note: No 'grad' column in roster — assuming all students are undergrad.\n")
  roster <- roster |> mutate(grad = FALSE)
}

roster <- roster |>
  rename(roster_name = Student) |>
  mutate(
    name_normalized = normalize_name(roster_name),
    is_grad = as.logical(grad)
  )

# Normalize survey names for matching; default is_grad to FALSE (updated below)
survey <- survey |>
  mutate(
    name_normalized = str_squish(str_to_lower(student_name)),
    is_grad = FALSE
  )

# Match roster students to survey responses
# Try exact normalized match first, then fuzzy
match_to_survey <- function(roster_name_norm, survey_names_norm) {
  # Exact match
  exact <- which(survey_names_norm == roster_name_norm)
  if (length(exact) == 1) return(exact)

  # Partial match (one name contained in the other)
  partial <- which(
    str_detect(survey_names_norm, fixed(roster_name_norm)) |
    str_detect(roster_name_norm, fixed(survey_names_norm))
  )
  if (length(partial) == 1) return(partial)

  # Fuzzy match
  fuzzy <- agrep(roster_name_norm, survey_names_norm, max.distance = 0.2)
  if (length(fuzzy) == 1) return(fuzzy)

  return(NA_integer_)
}

roster <- roster |>
  mutate(
    survey_idx = map_int(name_normalized,
                         ~match_to_survey(.x, survey$name_normalized))
  )

matched   <- roster |> filter(!is.na(survey_idx))
unmatched <- roster |> filter(is.na(survey_idx))

# Carry grad status into survey data for matched students
for (i in seq_len(nrow(matched))) {
  survey$is_grad[matched$survey_idx[i]] <- matched$is_grad[i]
}

cat("Roster:", nrow(roster), "students\n")
cat("Matched to survey:", nrow(matched), "\n")
cat("No survey response:", nrow(unmatched), "(will be assigned experience score 0)\n")
cat("Graduate students:", sum(roster$is_grad), "\n")

if (nrow(unmatched) > 0) {
  cat("  Students without survey responses:\n")
  for (i in seq_len(nrow(unmatched))) {
    cat("   ", unmatched$roster_name[i], "\n")
  }
}
cat("\n")

# Use the Canvas survey name for matched students (that's what friend requests
# reference). For unmatched students, normalize the roster name to "First Last".
non_survey_students <- unmatched |>
  mutate(
    # Convert normalized "first last" back to title case for display
    student_name = str_to_title(name_normalized)
  ) |>
  transmute(
    student_name,
    stats_exp     = NA_character_,
    coding_exp    = NA_character_,
    spreadsheet   = NA_character_,
    friend_req    = NA_character_,
    stats_score       = 0L,
    coding_score      = 0L,
    spreadsheet_score = 0L,
    experience_score  = 0L,
    friend_req_clean  = "",
    name_normalized,
    is_grad
  )

# Add non-survey students to the survey data
survey <- bind_rows(survey, non_survey_students)

cat("Total students for team assignment:", nrow(survey), "\n")
cat("Experience score distribution (all students):\n")
print(table(survey$experience_score))
cat("\n")


# -----------------------------------------------------------------------------
# STEP 2: Process friend requests
# -----------------------------------------------------------------------------

# Build a lookup of clean names for matching
name_lookup <- survey |>
  mutate(name_clean = coalesce(name_normalized,
                               str_squish(str_to_lower(student_name)))) |>
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
# Grad students cannot be paired together (must be on separate teams)
paired <- character(0)
friend_pairs <- list()
grad_pairs_blocked <- character(0)

for (i in seq_len(nrow(survey))) {
  student <- survey$student_name[i]
  friend  <- survey$friend_matched[i]

  if (is.na(friend)) next
  if (student %in% paired || friend %in% paired) next
  if (student == friend) next

  # Block grad-grad pairs
  student_grad <- survey$is_grad[survey$student_name == student]
  friend_grad  <- survey$is_grad[survey$student_name == friend]
  if (student_grad && friend_grad) {
    grad_pairs_blocked <- c(grad_pairs_blocked, student)
    next
  }

  friend_pairs <- c(friend_pairs, list(c(student, friend)))
  paired <- c(paired, student, friend)
}

# Build a per-request status log
n_requests <- sum(survey$friend_req_clean != "")
n_blocked  <- length(grad_pairs_blocked)

# Which students ended up in a formed pair?
paired_set <- unlist(friend_pairs)

cat("\nFriend requests (", n_requests, " total):\n", sep = "")
requesters <- survey |> filter(friend_req_clean != "")
for (i in seq_len(nrow(requesters))) {
  student <- requesters$student_name[i]
  raw_req <- requesters$friend_req[i]
  matched <- requesters$friend_matched[i]

  if (student %in% grad_pairs_blocked) {
    status <- "BLOCKED (grad students must be on separate teams)"
  } else if (is.na(matched)) {
    status <- "NOT FOUND (no matching student in class)"
  } else if (student %in% paired_set && matched %in% paired_set) {
    status <- "HONORED"
  } else {
    # Matched but the other person was already paired with someone else
    status <- "SKIPPED (requested student already paired)"
  }

  cat(sprintf("  %-25s -> %-25s %s\n", student, raw_req, status))
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
team_sizes    <- rep(0L, n_teams)
team_has_grad <- rep(FALSE, n_teams)  # enforce max 1 grad per team

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
if (length(friend_pairs) > 0) {
  pair_scores <- map_dbl(friend_pairs, function(pair) {
    survey |>
      filter(student_name %in% pair) |>
      pull(experience_score) |>
      sum()
  })
  pair_order <- order(pair_scores, decreasing = TRUE)
  friend_pairs <- friend_pairs[pair_order]
}

# Assign each pair to the team with the fewest members
# If either member is a grad student, skip teams that already have one
for (pair in friend_pairs) {
  pair_has_grad <- any(survey$is_grad[survey$student_name %in% pair])

  # Find eligible team with fewest members
  eligible <- seq_len(n_teams)
  if (pair_has_grad) {
    eligible <- eligible[!team_has_grad[eligible]]
  }
  target_team <- eligible[which.min(team_sizes[eligible])]

  assignments <- bind_rows(assignments, tibble(
    student_name = pair,
    team = target_team
  ))
  team_sizes[target_team] <- team_sizes[target_team] + 2L
  if (pair_has_grad) team_has_grad[target_team] <- TRUE
}

# --- Phase B: Place remaining students via snake draft ---
# Place grad students first to ensure they land on separate teams,
# then place undergrads
remaining <- survey |>
  filter(!student_name %in% assignments$student_name) |>
  arrange(desc(is_grad), desc(experience_score))

# Snake draft: go through sorted students, assign to teams in snake order
round_num <- 1
team_idx <- 1
order <- snake_order(n_teams, round_num)

advance_snake <- function() {
  team_idx <<- team_idx + 1
  if (team_idx > n_teams) {
    round_num <<- round_num + 1
    order <<- snake_order(n_teams, round_num)
    team_idx <<- 1
  }
}

for (i in seq_len(nrow(remaining))) {
  student_name_i <- remaining$student_name[i]
  student_is_grad <- remaining$is_grad[i]
  max_size <- ceiling(n_students / n_teams)

  # Find next eligible team in snake order
  # Must not be full, and if student is grad, must not already have a grad
  attempts <- 0
  while (TRUE) {
    current_team <- order[team_idx]
    full <- team_sizes[current_team] >= max_size
    grad_conflict <- student_is_grad && team_has_grad[current_team]

    if (!full && !grad_conflict) break

    advance_snake()
    attempts <- attempts + 1
    if (attempts > n_teams * 2) {
      stop("Could not find eligible team for ", student_name_i)
    }
  }

  target_team <- order[team_idx]
  assignments <- bind_rows(assignments, tibble(
    student_name = student_name_i,
    team = target_team
  ))
  team_sizes[target_team] <- team_sizes[target_team] + 1L
  if (student_is_grad) team_has_grad[target_team] <- TRUE

  advance_snake()
}


# -----------------------------------------------------------------------------
# STEP 3b: Post-draft swap optimization to balance experience
# -----------------------------------------------------------------------------
# Repeatedly try swapping unpaired, non-grad students between teams to reduce
# variance in team mean experience. Constraints preserved:
#   - Friend pairs stay on the same team
#   - Max 1 grad student per team

cat("Balancing teams via swap optimization...\n")

# Get experience scores into assignments
assignments <- assignments |>
  left_join(survey |> select(student_name, experience_score, is_grad),
            by = "student_name")

# Helper: variance of team means
team_mean_var <- function(df) {
  df |>
    group_by(team) |>
    summarize(m = mean(experience_score), .groups = "drop") |>
    pull(m) |>
    var()
}

# Students eligible for swapping: not in a friend pair and not grad
swappable <- assignments |>
  filter(!student_name %in% paired, !is_grad) |>
  pull(student_name)

current_var <- team_mean_var(assignments)
improved <- TRUE
n_swaps <- 0

while (improved) {
  improved <- FALSE
  for (i in seq_along(swappable)) {
    for (j in seq_along(swappable)) {
      if (i >= j) next

      s1 <- swappable[i]
      s2 <- swappable[j]

      t1 <- assignments$team[assignments$student_name == s1]
      t2 <- assignments$team[assignments$student_name == s2]
      if (t1 == t2) next

      # Try the swap
      test <- assignments
      test$team[test$student_name == s1] <- t2
      test$team[test$student_name == s2] <- t1

      new_var <- team_mean_var(test)
      if (new_var < current_var - 1e-10) {
        assignments <- test
        current_var <- new_var
        improved <- TRUE
        n_swaps <- n_swaps + 1
      }
    }
  }
}

# Drop the joined columns (will re-join in Step 4)
assignments <- assignments |> select(student_name, team)

cat("Swaps made:", n_swaps, "\n")
cat("Final variance in team means:", round(current_var, 3), "\n\n")


# -----------------------------------------------------------------------------
# STEP 4: Output results
# -----------------------------------------------------------------------------

# Join team assignments back with survey data
roster <- assignments |>
  left_join(survey |> select(student_name, experience_score, friend_req, is_grad),
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
  n_grad <- sum(team_members$is_grad)
  grad_label <- if (n_grad > 0) sprintf(" | %d grad", n_grad) else ""
  cat(sprintf("Team %d (%d members, avg experience: %.1f%s)\n",
              t, nrow(team_members), mean(team_members$experience_score),
              grad_label))
  cat("-" |> strrep(40), "\n")
  for (j in seq_len(nrow(team_members))) {
    m <- team_members[j, ]
    flags <- paste0(
      if (m$in_friend_pair) " [paired]" else "",
      if (m$is_grad) " [grad]" else ""
    )
    cat(sprintf("  %-25s (score: %d)%s\n",
                m$student_name, m$experience_score, flags))
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
    n_requests, "requests")
if (n_blocked > 0) cat(" (", n_blocked, " grad-grad blocked)", sep = "")
cat("\n")

# Write output CSV
write_csv(roster, output_file)
cat("\nTeam rosters written to:", output_file, "\n")
