# Generate the simulated sleep + GPA dataset for Session 16 (Storytelling).
# Writes files/data/sleep_study.csv. Re-run only when the spec changes.

library(tidyverse)
library(here)

set.seed(410)

n <- 200

sleep_study <- tibble(
  student_id = 1:n,
  year = sample(
    factor(c("Freshman", "Sophomore", "Junior", "Senior"),
           levels = c("Freshman", "Sophomore", "Junior", "Senior")),
    n, replace = TRUE, prob = c(0.30, 0.28, 0.24, 0.18)
  ),
  caffeine_cups = pmax(0, round(rnorm(n, mean = 1.8, sd = 1.2))),
  sleep_hours = pmin(9.5, pmax(4.5,
    rnorm(n, mean = 7.0 - 0.15 * caffeine_cups, sd = 1.05)
  )),
  study_hours = pmax(2, round(rnorm(n, mean = 14, sd = 5)))
) |>
  mutate(
    gpa_raw = 1.6 +
      0.20 * sleep_hours +
      0.015 * study_hours +
      as.numeric(year) * 0.02 +
      rnorm(n, 0, 0.32),
    gpa = pmin(4.0, pmax(1.5, round(gpa_raw, 2))),
    sleep_group = case_when(
      sleep_hours < 6 ~ "Short (<6)",
      sleep_hours < 7 ~ "Medium (6-7)",
      TRUE ~ "Long (7+)"
    ),
    sleep_group = factor(sleep_group,
                          levels = c("Short (<6)", "Medium (6-7)", "Long (7+)"))
  ) |>
  select(student_id, year, sleep_hours, sleep_group,
         study_hours, caffeine_cups, gpa)

# Quick sanity checks
cat("N:", nrow(sleep_study), "\n")
cat("Correlation sleep ~ GPA:",
    round(cor(sleep_study$sleep_hours, sleep_study$gpa), 3), "\n")
cat("Mean GPA by sleep group:\n")
print(sleep_study |>
        group_by(sleep_group) |>
        summarize(n = n(),
                  mean_gpa = round(mean(gpa), 2),
                  .groups = "drop"))
cat("Slope from lm(gpa ~ sleep_hours):",
    round(coef(lm(gpa ~ sleep_hours, data = sleep_study))[2], 3), "\n")

write_csv(sleep_study, here("files", "data", "sleep_study.csv"))
cat("\nWrote files/data/sleep_study.csv\n")
