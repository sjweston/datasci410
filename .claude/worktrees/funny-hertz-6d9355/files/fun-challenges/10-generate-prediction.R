# ============================================================
# Generate the scatterplot for Challenge 10: The Final Prediction
# Run this script once to create the PNG
# ============================================================

library(tidyverse)

set.seed(410)

# Generate data with a moderate positive correlation (~0.6)
n <- 50
x <- rnorm(n, mean = 50, sd = 12)
y <- 0.55 * x + rnorm(n, mean = 22, sd = 8)

# The actual values students are trying to guess:
cat("=== ANSWER KEY (don't share with students!) ===\n")
cat("Correlation (r):", round(cor(x, y), 2), "\n")
cat("Direction: positive\n")
model <- lm(y ~ x)
cat("R-squared:", round(summary(model)$r.squared, 2), "\n")
cat("================================================\n")

# Create the scatterplot — no numbers, no line, just points
p <- ggplot(tibble(x = x, y = y), aes(x = x, y = y)) +
  geom_point(size = 2.5, alpha = 0.7, color = "#2c3e50") +
  labs(
    title = "The Final Prediction",
    subtitle = "What's the correlation?",
    x = NULL,
    y = NULL
  ) +
  theme_minimal(base_size = 16) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid.minor = element_blank()
  )

ggsave("files/fun-challenges/10-prediction.png", p, width = 6, height = 5, dpi = 150)
cat("Scatterplot saved to files/fun-challenges/10-prediction.png\n")
