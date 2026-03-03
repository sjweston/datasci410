# ============================================================
# Generate Figure Courtroom images
# Run this script once to create the 5 PNG files
# ============================================================

library(tidyverse)

out_dir <- "files/fun-challenges/09-figure-courtroom"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# --- Figure A: Truncated y-axis bar chart (GUILTY) ---
schools <- tibble(
  school = c("Lincoln", "Washington", "Jefferson", "Roosevelt"),
  avg_score = c(78.2, 76.8, 79.1, 77.5)
)

p_a <- ggplot(schools, aes(x = school, y = avg_score, fill = school)) +
  geom_col(show.legend = FALSE) +
  coord_cartesian(ylim = c(72, 82)) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Average Test Scores by School",
    x = NULL,
    y = "Average Score"
  ) +
  theme_minimal(base_size = 14)
ggsave(file.path(out_dir, "figure-a.png"), p_a, width = 6, height = 4, dpi = 150)


# --- Figure B: Pie chart with too many slices (BORING) ---
majors <- tibble(
  major = c("Psychology", "Biology", "English", "Sociology",
            "Chemistry", "History", "Math", "Art",
            "Computer Science", "Economics", "Philosophy", "Nursing"),
  n = c(45, 38, 32, 28, 25, 22, 18, 15, 14, 12, 10, 8)
) |>
  mutate(pct = n / sum(n))

p_b <- ggplot(majors, aes(x = "", y = n, fill = major)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Distribution of Majors Among Respondents", fill = "Major") +
  theme_void(base_size = 12) +
  theme(legend.text = element_text(size = 8))
ggsave(file.path(out_dir, "figure-b.png"), p_b, width = 7, height = 5, dpi = 150)


# --- Figure C: Well-designed small multiples (NOT GUILTY) ---
set.seed(42)
anxiety <- expand_grid(
  group = c("Treatment", "Control"),
  time = 1:4,
  participant = 1:20
) |>
  mutate(
    anxiety = case_when(
      group == "Control" ~ 6 + rnorm(n(), 0, 0.8),
      group == "Treatment" ~ 6 - (time - 1) * 0.8 + rnorm(n(), 0, 0.6)
    )
  ) |>
  group_by(group, time) |>
  summarize(
    mean_anxiety = mean(anxiety),
    se = sd(anxiety) / sqrt(n()),
    .groups = "drop"
  )

p_c <- ggplot(anxiety, aes(x = time, y = mean_anxiety)) +
  geom_line(linewidth = 1, color = "#2c3e50") +
  geom_point(size = 3, color = "#2c3e50") +
  geom_errorbar(aes(ymin = mean_anxiety - se, ymax = mean_anxiety + se),
                width = 0.15, color = "#2c3e50") +
  facet_wrap(~group) +
  scale_x_continuous(breaks = 1:4, labels = paste("Wave", 1:4)) +
  scale_y_continuous(limits = c(2, 8)) +
  labs(
    title = "Anxiety Scores Over Time by Treatment Group",
    subtitle = "Mean +/- SE; Treatment group shows steady decline",
    x = NULL,
    y = "Mean Anxiety Score"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    strip.text = element_text(face = "bold", size = 13),
    panel.grid.minor = element_blank()
  )
ggsave(file.path(out_dir, "figure-c.png"), p_c, width = 8, height = 4, dpi = 150)


# --- Figure D: Dual-axis chart (GUILTY) ---
months_data <- tibble(
  month = factor(month.abb, levels = month.abb),
  temp_f = c(32, 35, 45, 55, 65, 78, 85, 82, 72, 58, 42, 34),
  sales = c(120, 140, 280, 450, 680, 950, 1100, 1050, 750, 400, 200, 130)
)

scale_factor <- max(months_data$sales) / max(months_data$temp_f)

p_d <- ggplot(months_data, aes(x = month)) +
  geom_col(aes(y = sales / scale_factor), fill = "#3498db", alpha = 0.7) +
  geom_line(aes(y = temp_f, group = 1), color = "#e74c3c", linewidth = 1.5) +
  geom_point(aes(y = temp_f), color = "#e74c3c", size = 2) +
  scale_y_continuous(
    name = "Temperature (F)",
    sec.axis = sec_axis(~ . * scale_factor, name = "Ice Cream Sales ($)")
  ) +
  labs(
    title = "Temperature and Ice Cream Sales by Month",
    x = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.title.y.left = element_text(color = "#e74c3c"),
    axis.title.y.right = element_text(color = "#3498db")
  )
ggsave(file.path(out_dir, "figure-d.png"), p_d, width = 8, height = 4.5, dpi = 150)


# --- Figure E: Cluttered scatterplot (BORING) ---
set.seed(123)
cluttered <- tibble(
  x = rnorm(200, 50, 15),
  y = x * 0.6 + rnorm(200, 0, 10),
  group = sample(paste("Group", LETTERS[1:8]), 200, replace = TRUE)
)

p_e <- ggplot(cluttered, aes(x = x, y = y, color = group)) +
  geom_point(size = 2) +
  labs(color = NULL)
ggsave(file.path(out_dir, "figure-e.png"), p_e, width = 7, height = 5, dpi = 150)

cat("All 5 figures saved to", out_dir, "\n")
