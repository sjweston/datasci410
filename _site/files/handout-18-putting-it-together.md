# Session 18: Putting It All Together — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The task: Debug this code

This code has several errors. Find and fix them all.

```r
library(tidyverse)

# Load data
Study_data <- tibble(
  id = 1:5,
  Score = c(10, 15, 12, 18, 14),
  Group = c("A", "B", "A", "B", "A")
)

# Analyze
study_data |>
  filter(Group = "A") |>
  summarize(
    mean_score = mean(score)
    sd_score = sd(score)
  )
```

### Your pen-and-paper version

**Step 1: Read the code carefully.** Go line by line and circle every error you can find. There are at least 4 bugs.

**Step 2: List the errors.** For each bug, explain what's wrong and how to fix it:

| # | Line | What's wrong | Fix |
|---|------|-------------|-----|
| 1 |      |             |     |
| 2 |      |             |     |
| 3 |      |             |     |
| 4 |      |             |     |

**Step 3: Categorize the errors.** For each bug, what *type* of error is it? Write the letter:

- **(A)** Name mismatch (variable/object name doesn't match)
- **(B)** Wrong operator (using the wrong symbol)
- **(C)** Syntax error (missing punctuation, brackets, etc.)

| Bug # | Type |
|-------|------|
| 1     |      |
| 2     |      |
| 3     |      |
| 4     |      |

**Step 4: Predict the error messages.** For each bug, what error would R give you? Match:

- `Error: object 'study_data' not found`
- `Error in filter(): ... did you mean '=='?`
- `Error: unexpected symbol`
- `Error: object 'score' not found`

**Step 5: Write the corrected code.** Rewrite the full code block with all fixes applied:

```r
library(tidyverse)

# Load data
__________ <- tibble(
  id = 1:5,
  Score = c(10, 15, 12, 18, 14),
  Group = c("A", "B", "A", "B", "A")
)

# Analyze
__________ |>
  filter(Group _____ "A") |>
  summarize(
    mean_score = mean(________)___
    sd_score = sd(________)
  )
```

**Step 6: What should the output be?** After fixing the code, what values do you expect?

Group A has scores: _____, _____, _____

mean_score = _____

sd_score = _____ (hint: use n-1 in the denominator)

---

## Check your work

Compare your error list and corrected code with your partner's screen.

**The 4 bugs:**

| # | Line | What's wrong | Fix | Type |
|---|------|-------------|-----|------|
| 1 | `Study_data` vs `study_data` | Object created as `Study_data` (capital S) but referenced later as `study_data` (lowercase s) | Change creation to `study_data` (or change reference to `Study_data`) | (A) |
| 2 | `filter(Group = "A")` | Single `=` is assignment, not comparison | Change to `==` | (B) |
| 3 | `mean(score)` | Column is named `Score` (capital S), but code uses lowercase `score` | Change to `Score` | (A) |
| 4 | Missing comma between `mean_score = mean(Score)` and `sd_score` | `summarize()` arguments need commas | Add `,` after `mean(Score)` | (C) |

**Expected corrected code:**
```
library(tidyverse)

study_data <- tibble(
  id = 1:5,
  Score = c(10, 15, 12, 18, 14),
  Group = c("A", "B", "A", "B", "A")
)

study_data |>
  filter(Group == "A") |>
  summarize(
    mean_score = mean(Score),
    sd_score = sd(Score)
  )
```

**Expected output:** Group A scores are 10, 12, 14. Mean = 12, SD = 2.
