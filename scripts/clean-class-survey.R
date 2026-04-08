# ── Clean Class Survey Data ───────────────────────────────────────────────────
# Pulls the anonymous start-of-term survey from Qualtrics, cleans it,
# and saves a CSV for use in lecture demos.
#
# Run this script once after students complete the survey (Week 1),
# or anytime you want to refresh with new test responses.
#
# Output: data/class_survey.csv
# ──────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(qualtRics)

# ── 1. Connect to Qualtrics ──────────────────────────────────────────────────
source("qualtrics_config.R")

# ── 2. Pull raw responses ───────────────────────────────────────────────────
raw <- fetch_survey(
  surveyID = SURVEY_ID_WEEK1,
  force_request = TRUE, # always pull fresh
  verbose = FALSE
)

cat("Pulled", nrow(raw), "responses from Qualtrics.\n")

# ── 3. Inspect what we got ───────────────────────────────────────────────────
# Uncomment to see all column names from Qualtrics (useful for debugging)
# names(raw)

# ── 4. Select and rename ────────────────────────────────────────────────────
# Keep only our survey variables (by export tag names).
# If Qualtrics appended suffixes or your export tags didn't take,
# adjust the column names here.
survey <- raw |>
  select(
    response_id = ResponseId,
    # Demographics / grouping
    major,
    year,
    chronotype,
    # Daily habits
    sleep_hrs,
    caffeine_per_day,
    social_media_hrs,
    tabs_open,
    # Attitudes (1-10)
    stress,
    coding_excited,
    coding_anxious,
    # Personality (1-10)
    personality_neur,
    personality_extra,
    personality_consc,
    # Open-ended
    data_words
  )

cat("Selected", ncol(survey), "columns.\n")

# ── 5. Clean numeric columns ────────────────────────────────────────────────
# Qualtrics sometimes imports numbers as character — force to numeric.
numeric_cols <- c(
  "sleep_hrs",
  "caffeine_per_day",
  "social_media_hrs",
  "tabs_open",
  "stress",
  "coding_excited",
  "coding_anxious",
  "personality_neur",
  "personality_extra",
  "personality_consc"
)

survey <- survey |>
  mutate(across(all_of(numeric_cols), as.numeric))

# ── 6. Validate ranges ──────────────────────────────────────────────────────
# Flag obviously impossible values but don't drop them — good teaching moments.
survey <- survey |>
  mutate(
    # Cap sleep at reasonable bounds (0-24)
    sleep_hrs = if_else(sleep_hrs < 0 | sleep_hrs > 24, NA_real_, sleep_hrs),
    # Cap social media (0-24)
    social_media_hrs = if_else(
      social_media_hrs < 0 | social_media_hrs > 24,
      NA_real_,
      social_media_hrs
    ),
    # Caffeine: negative doesn't make sense
    caffeine_per_day = if_else(
      caffeine_per_day < 0,
      NA_real_,
      caffeine_per_day
    ),
    # Tabs: negative doesn't make sense
    tabs_open = if_else(tabs_open < 0, NA_real_, tabs_open)
  )

# 1-10 scales: coerce out-of-range to NA
scale_cols <- c(
  "stress",
  "coding_excited",
  "coding_anxious",
  "personality_neur",
  "personality_extra",
  "personality_consc"
)

survey <- survey |>
  mutate(across(
    all_of(scale_cols),
    ~ if_else(.x < 1 | .x > 10, NA_real_, .x)
  ))

# ── 7. Clean categorical columns ────────────────────────────────────────────
survey <- survey |>
  mutate(
    major = str_trim(major),
    year = str_trim(year),
    chronotype = str_trim(chronotype),
    data_words = str_trim(str_to_lower(data_words))
  )

# ── 8. Drop empty / test responses ──────────────────────────────────────────
# Remove rows where every substantive column is NA (preview clicks, etc.)
substantive <- setdiff(names(survey), "response_id")

survey <- survey |>
  filter(!if_all(all_of(substantive), is.na))

cat("After cleaning:", nrow(survey), "valid responses.\n")

# ── 9. Summary check ────────────────────────────────────────────────────────
cat("\n── Quick summary ──\n")
cat("Majors:     ", paste(unique(survey$major), collapse = ", "), "\n")
cat("Years:      ", paste(unique(survey$year), collapse = ", "), "\n")
cat("Chronotypes:", paste(unique(survey$chronotype), collapse = ", "), "\n")
cat("Sleep range:", range(survey$sleep_hrs, na.rm = TRUE), "\n")
cat("Tabs range: ", range(survey$tabs_open, na.rm = TRUE), "\n")
cat("Missing:    ", sum(!complete.cases(survey)), "rows with at least one NA\n")

# ── 10. Save ─────────────────────────────────────────────────────────────────
write_csv(survey, "data/class_survey.csv")
cat("\nSaved to data/class_survey.csv\n")
