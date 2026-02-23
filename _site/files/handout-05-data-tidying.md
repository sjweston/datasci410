# Session 5: Data Tidying — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The data: `survey_wide`

This dataset has BDI (Beck Depression Inventory) item scores for 3 participants in wide format:

| participant | bdi_1 | bdi_2 | bdi_3 | bdi_4 |
|-------------|-------|-------|-------|-------|
| 1           | 2     | 1     | 3     | 2     |
| 2           | 1     | 0     | 2     | 1     |
| 3           | 3     | 2     | 2     | 1     |

Each column (`bdi_1` through `bdi_4`) is a separate BDI item score.

---

## The task (same as the slide exercise)

Which participant has the highest mean BDI score?

**Hint from the slides:** You'll need `pivot_longer()` followed by `group_by()` + `summarize()`.

### Your pen-and-paper version

**Step 1: Pivot to long format by hand.** Rewrite the data so each row is one participant-item combination. Fill in the table:

| participant | item  | response |
|-------------|-------|----------|
| 1           | bdi_1 | 2        |
| 1           | bdi_2 |          |
| 1           | bdi_3 |          |
| 1           | bdi_4 |          |
| 2           | bdi_1 |          |
| 2           | bdi_2 |          |
| 2           | bdi_3 |          |
| 2           | bdi_4 |          |
| 3           | bdi_1 |          |
| 3           | bdi_2 |          |
| 3           | bdi_3 |          |
| 3           | bdi_4 |          |

**How many rows does the long version have?** _____ (vs. 3 rows in wide)

**Step 2: Group and summarize.** Calculate the mean response for each participant:

| participant | sum of responses | n items | mean_bdi (sum / n) |
|-------------|-----------------|---------|---------------------|
| 1           |                 |         |                     |
| 2           |                 |         |                     |
| 3           |                 |         |                     |

**Which participant has the highest mean BDI score?** _____

**Step 3: Write the code.** Fill in the blanks:

```r
survey_wide |>
  pivot_longer(
    cols = starts_with("_____"),
    names_to = "_____",
    values_to = "_____"
  ) |>
  group_by(_________) |>
  summarize(mean_bdi = _______(response))
```

---

## Check your work

Compare your long table and mean calculations with your partner's screen.

**Long table:** 12 rows (3 participants x 4 items). Each response value comes from the original wide table.

**Mean BDI scores:**

| participant | sum | n | mean_bdi |
|-------------|-----|---|----------|
| 1           | 8   | 4 | 2.00     |
| 2           | 4   | 4 | 1.00     |
| 3           | 8   | 4 | 2.00     |

**Highest mean:** Participants 1 and 3 are tied at 2.00.

**Expected code:**
```
survey_wide |>
  pivot_longer(
    cols = starts_with("bdi"),
    names_to = "item",
    values_to = "response"
  ) |>
  group_by(participant) |>
  summarize(mean_bdi = mean(response))
```
