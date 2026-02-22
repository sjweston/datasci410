# Session 15: Missing Data — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The data: `therapy_survey`

Survey data from a therapy study:

| id | age | baseline_depression | followup_depression | satisfaction |
|----|-----|---------------------|---------------------|-------------|
| 1  | 25  | 22                  | 12                  | 4           |
| 2  | 30  | 25                  | 23                  | 3           |
| 3  | NA  | 18                  | NA                  | NA          |
| 4  | 22  | 20                  | 15                  | 5           |
| 5  | 28  | 24                  | NA                  | 4           |
| 6  | NA  | 19                  | NA                  | NA          |
| 7  | 35  | NA                  | NA                  | NA          |
| 8  | 26  | 21                  | 16                  | 5           |

---

## The task (same as the slide exercise)

1. How many participants are missing baseline data? Followup data?
2. How many participants have **complete data** (no NAs anywhere)?
3. Create a version that drops rows missing followup data
4. What percentage of participants completed the followup?

### Your pen-and-paper version

**Step 1: Count NAs per variable.** Go through each column and count the missing values:

| Variable             | Count of NAs |
|---------------------|-------------|
| id                  |             |
| age                 |             |
| baseline_depression |             |
| followup_depression |             |
| satisfaction        |             |

**Step 2: Find complete cases.** Mark each row as complete or not:

| id | Any NAs in this row? | Complete? |
|----|:---:|:---:|
| 1  |     |     |
| 2  |     |     |
| 3  |     |     |
| 4  |     |     |
| 5  |     |     |
| 6  |     |     |
| 7  |     |     |
| 8  |     |     |

**How many complete cases?** _____

**Step 3: Drop rows missing followup.** Cross out any row where `followup_depression` is NA. Which rows survive?

Surviving rows: _____________________________

**How many rows remain?** _____

**Step 4: Calculate completion rate.**

- Total participants: _____
- Participants with followup data: _____
- Completion rate: _____ / _____ = _____ = _____%

**Step 5: Think about it.** Look at the rows you crossed out. Do participants missing followup data also tend to be missing other variables? What might this pattern suggest?

Your answer: ___________________________________________________________________

**Step 6: Write the code.** Fill in the blanks:

```r
# 1. Count missing by variable
therapy_survey |>
  summarize(across(everything(), ~sum(______(.x))))

# 2. Complete cases
therapy_survey |>
  drop_na() |>
  _______()

# 3. Drop if missing followup
therapy_survey |>
  drop_na(___________________)

# 4. Completion rate
therapy_survey |>
  summarize(
    completion_rate = mean(!is.na(___________________))
  )
```

---

## Check your work

Compare your counts with your partner's screen.

**NAs per variable:** id = 0, age = 2, baseline_depression = 1, followup_depression = 4, satisfaction = 3

**Complete cases:** 4 (rows 1, 2, 4, 8)

**After dropping missing followup:** Rows 1, 2, 4, 8 remain (4 rows)

**Completion rate:** 4/8 = 0.50 = 50%

**Pattern:** Participants 3, 6, and 7 are missing followup, satisfaction, AND other data. This clustering of missingness suggests these participants may have dropped out entirely — a common pattern in longitudinal studies where attrition affects multiple measures at once.

**Expected code:**
```
therapy_survey |>
  summarize(across(everything(), ~sum(is.na(.x))))

therapy_survey |>
  drop_na() |>
  nrow()

therapy_survey |>
  drop_na(followup_depression)

therapy_survey |>
  summarize(
    completion_rate = mean(!is.na(followup_depression))
  )
```
