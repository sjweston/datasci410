# Session 13: Strings, Factors & Text — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

**Name:** ______________________________ **Date:** ______________

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The data: `messy_survey`

You have messy survey responses:

| id | major              | comment                   |
|----|---------------------|---------------------------|
| 1  | "  PSYCHOLOGY"      | "Great study!"            |
| 2  | "biology  "         | "too long"                |
| 3  | "Psychology"        | "  Very interesting  "    |
| 4  | "BIOLOGY"           | "CONFUSING INSTRUCTIONS"  |
| 5  | "sociology  "       | "I enjoyed this"          |

Notice the extra spaces and inconsistent capitalization.

---

## The task (same as the slide exercise)

1. Clean `major` to lowercase with no extra spaces
2. Clean `comment` to title case with no extra spaces
3. Create a logical column `is_negative` that is TRUE if the comment contains "long" or "confusing" (case-insensitive)
4. Filter to only negative comments

### Your pen-and-paper version

**Step 1: Clean `major`.** Apply `str_trim()` then `str_to_lower()`. Write the final value:

| id | major (raw)    | major (clean) |
|----|----------------|---------------|
| 1  | "  PSYCHOLOGY" |               |
| 2  | "biology  "    |               |
| 3  | "Psychology"   |               |
| 4  | "BIOLOGY"      |               |
| 5  | "sociology  "  |               |

**Step 2: Clean `comment`.** Apply `str_trim()` then `str_to_title()`. Write the final value:

| id | comment (raw)            | comment (clean) |
|----|--------------------------|-----------------|
| 1  | "Great study!"           |                 |
| 2  | "too long"               |                 |
| 3  | "  Very interesting  "   |                 |
| 4  | "CONFUSING INSTRUCTIONS" |                 |
| 5  | "I enjoyed this"         |                 |

**Step 3: Detect negative comments.** TRUE if the original comment contains "long" or "confusing" (case-insensitive):

| id | comment                   | is_negative |
|----|---------------------------|:-:|
| 1  | "Great study!"            |   |
| 2  | "too long"                |   |
| 3  | "  Very interesting  "    |   |
| 4  | "CONFUSING INSTRUCTIONS"  |   |
| 5  | "I enjoyed this"          |   |

**Which rows survive `filter(is_negative)`?** Rows _____ and _____

**Step 4: Write the code.** Fill in the blanks:

```r
messy_survey |>
  mutate(
    major_clean = str_to_______(str_______(major)),
    comment_clean = str_to_______(str_______(comment)),
    is_negative = str_detect(
      comment,
      regex("______|__________", ignore_case = _____)
    )
  ) |>
  filter(___________)
```

---

## Check your work

Compare your cleaned values and code with your partner's screen. Do your answers match?
