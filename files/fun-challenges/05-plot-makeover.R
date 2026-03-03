# ============================================================
# Fun Challenge 5: Plot Makeover
# ============================================================
# The plot below is technically correct but ugly and hard to read.
# Your mission: make it good.
#
# Change at least 5 things to improve the plot using what you've
# learned about perception and design. Submit:
#   1. Your improved code
#   2. A screenshot of the new plot
#   3. A brief note (1-2 sentences per change) explaining what
#      you changed and why
#
# Due: Sunday, May 3 at 11:59 PM
# ============================================================

library(tidyverse)

# Load the dataset
stress <- read_csv("files/fun-challenges/05-makeover-data.csv")

# THE UGLY PLOT — improve this!
ggplot(stress, aes(x = hours_sleep, y = stress_score, color = exercise)) +
  geom_point() +
  geom_smooth()
