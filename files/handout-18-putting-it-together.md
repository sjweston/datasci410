# Session 18: Putting It All Together — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

**Name:** ______________________________ **Date:** ______________

*No laptop today? No problem. Work with a partner who has a laptop and compare your work at the end.*

---

## The task: Debug this code

This code has several errors. Find and fix them all.

```r
library(tidyverse)

Study_data <- tibble(
  id = 1:5,
  Score = c(10, 15, 12, 18, 14),
  Group = c("A", "B", "A", "B", "A")
)

study_data |>
  filter(Group = "A") |>
  summarize(
    mean_score = mean(score)
    sd_score = sd(score)
  )
```

**Hint:** There are at least 4 bugs. Check names (capitalization), operators (`=` vs `==`), and punctuation.

---

## Step 1: Mark up the code above

Circle each error in the code block. Cross it out and write the fix above or below it.

## Step 2: List the bugs

| # | Line | What's wrong | How to fix it |
|---|------|--------------|---------------|
| 1 |      |              |               |
| 2 |      |              |               |
| 3 |      |              |               |
| 4 |      |              |               |

## Step 3: Which error would R show *first*?

R stops at the first error and doesn't report the rest. Which bug do you think R would catch first when you run this code? Why?

________________________________________________________________

________________________________________________________________

________________________________________________________________

---

## Check your work

Compare your bug list with your partner's screen. Did you find all 4?

If your partner ran the corrected code, what did `summarize()` return for Group A?

**mean_score** = _________ **sd_score** = _________

**Did R catch the bug you predicted first?** (circle one) **Yes** / **No** — actual first error: _______________
