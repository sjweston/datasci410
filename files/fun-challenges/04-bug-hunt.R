# ============================================================
# Fun Challenge 4: Bug Hunt
# ============================================================
# This script is SUPPOSED to:
#   1. Load a dataset of survey responses
#   2. Clean it up
#   3. Make a plot of satisfaction by department
#
# But it has 8 BUGS. Find them all and fix them.
# Submit the corrected script AND a list of what you fixed.
# ============================================================

# Load packages
library(tidyverse)

# Bug hunt dataset (included with this challenge)
survey <- read_CSV("files/fun-challenges/04-bug-hunt-data.csv")

# Keep only completed responses
survey_clean <- survey |>
  filter(completed = TRUE)

# Calculate mean satisfaction by department
dept_means <- survey_clean |>
  group_by(department) |>
  summarize(
    mean_satisfaction = mean(satisfaction)
    n = n()
  )

# Keep only departments with at least 5 responses
dept_means <- dept_means |>
  filter(n >= 5) |>
  arange(desc(mean_satisfaction))

# Make a bar chart
ggplot(dept_means, aes(x = department, y = mean_satisfaction)) +
  geom_bar() +
  labs(
    title = "Mean Satisfaction by Department"
    x = "Department",
    y = "Mean Satisfaction (1-7)"
  ) +
  theme_minimal() +
  coord_flip()
