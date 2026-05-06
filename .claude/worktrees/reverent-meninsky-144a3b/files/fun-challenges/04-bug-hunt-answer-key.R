# ============================================================
# Fun Challenge 4: Bug Hunt --- ANSWER KEY
# ============================================================
# 8 bugs total. Each is annotated with [BUG #] and an
# explanation of what was wrong and how it was fixed.
# ============================================================

library(tidyverse)

# [BUG 1] read_CSV -> read_csv
#   R is case-sensitive. The tidyverse function is read_csv()
#   (lowercase). read_CSV() doesn't exist.
survey <- read_csv("files/fun-challenges/04-bug-hunt-data.csv")

# [BUG 2] filter(completed = TRUE) -> filter(completed == TRUE)
#   A single = is assignment; a double == is comparison.
#   filter() needs the comparison form. (Equivalent: filter(completed).)
survey_clean <- survey |>
  filter(completed == TRUE)

# [BUG 3] Missing comma between summarize() arguments.
# [BUG 4] mean(satisfaction) returns NA because the column has
#   missing values. Add na.rm = TRUE.
dept_means <- survey_clean |>
  group_by(department) |>
  summarize(
    mean_satisfaction = mean(satisfaction, na.rm = TRUE),   # [BUG 3 comma, BUG 4 na.rm]
    n = n()
  )

# [BUG 5] arange -> arrange
#   Typo. The dplyr function is arrange() with two r's.
dept_means <- dept_means |>
  filter(n >= 5) |>
  arrange(desc(mean_satisfaction))

# [BUG 6] y = mean_sat -> y = mean_satisfaction
#   The column was named mean_satisfaction in summarize(),
#   so the aes() mapping must use that exact name.
# [BUG 7] geom_bar() -> geom_col()
#   geom_bar() expects to count rows (stat = "count" by default).
#   When you already have y values, use geom_col() (or
#   geom_bar(stat = "identity")).
# [BUG 8] Missing comma after the title string in labs().
ggplot(dept_means, aes(x = department, y = mean_satisfaction)) +   # [BUG 6]
  geom_col() +                                                     # [BUG 7]
  labs(
    title = "Mean Satisfaction by Department",                     # [BUG 8 comma]
    x = "Department",
    y = "Mean Satisfaction (1-7)"
  ) +
  theme_minimal() +
  coord_flip()

# ============================================================
# Summary of fixes
# ============================================================
# 1. read_CSV()        -> read_csv()                  (case typo)
# 2. completed = TRUE  -> completed == TRUE           (= vs ==)
# 3. summarize() args  -> add comma after mean(...)   (syntax)
# 4. mean(satisfaction)-> add na.rm = TRUE            (NAs in data)
# 5. arange()          -> arrange()                   (typo)
# 6. y = mean_sat      -> y = mean_satisfaction       (wrong name)
# 7. geom_bar()        -> geom_col()                  (stat default)
# 8. labs() args       -> add comma after title       (syntax)
# ============================================================
