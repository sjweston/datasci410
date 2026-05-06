# ============================================================
# Fun Challenge 3: Data Transformation Relay — ANSWER KEY
# ============================================================
# Instructor reference. Run from the repo root.
# ============================================================

library(tidyverse)

relay <- read_csv("files/fun-challenges/03-relay-data.csv")

# ------------------------------------------------------------
# Question 1: How many participants are in each condition?
# ------------------------------------------------------------
relay |>
  count(condition)

# Expected:
#   condition       n
#   music          15
#   silence        15
#   white_noise    15

# ------------------------------------------------------------
# Question 2: Mean reading score for completed participants,
# by condition.
# ------------------------------------------------------------
relay |>
  filter(completed == "yes") |>
  group_by(condition) |>
  summarize(mean_reading = mean(reading_score))

# Expected:
#   condition    mean_reading
#   music               54.8
#   silence             84.8
#   white_noise         74.8
#
# Silence has the highest mean reading score.

# ------------------------------------------------------------
# Question 3: Among completed participants, who had the fastest
# (lowest) reaction time, and what condition were they in?
# ------------------------------------------------------------
relay |>
  filter(completed == "yes") |>
  slice_min(reaction_time_ms, n = 1)

# Expected: P011 — white_noise condition, 376 ms.

# ------------------------------------------------------------
# Question 4: Create score_category (high / medium / low) and
# count participants per category.
# ------------------------------------------------------------
relay |>
  mutate(
    score_category = case_when(
      reading_score >= 75 ~ "high",
      reading_score >= 50 ~ "medium",
      TRUE                ~ "low"
    )
  ) |>
  count(score_category)

# Expected:
#   score_category    n
#   high             21
#   low               3
#   medium           21

# ------------------------------------------------------------
# Question 5: Among completed participants aged 20 or older,
# median reaction time by condition. Which condition is lowest?
# ------------------------------------------------------------
relay |>
  filter(completed == "yes", age >= 20) |>
  group_by(condition) |>
  summarize(median_rt = median(reaction_time_ms)) |>
  arrange(median_rt)

# Expected:
#   condition    median_rt
#   silence          403
#   white_noise      402
#   music            492
#
# White_noise has the lowest median (402 ms), very closely
# followed by silence (403 ms). Accept either answer if the
# student's code is correct — a 1 ms gap is a reasonable
# rounding/tie call. The key distinction is that music is
# clearly slowest.
