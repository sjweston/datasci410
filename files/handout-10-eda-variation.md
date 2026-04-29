# Session 10: EDA — Variation — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

**Name:** ______________________________ **Date:** ______________

*No laptop today? Work with a partner who has one and compare answers at the end.*

## The data: `class_survey` (N = 34)

You'll focus on **`social_media_hrs`** — self-reported hours per day on social media.

| Min | Q1 | Median | Mean | Q3 | Max | NAs |
|-----|----|--------|------|----|-----|-----|
| 0.00 | 1.00 | 2.75 | 2.92 | 4.00 | 8.00 | 0 |

A few rows from the data:

| major        | year   | social_media_hrs | sleep_hrs | tabs_open |
|--------------|--------|------------------|-----------|-----------|
| Psychology   | Junior | 7.00             | 8         | 363       |
| Psychology   | Junior | 1.00             | 9         | 2         |
| Psychology   | Other  | 0.33             | 7         | 7         |
| Psychology   | Senior | 8.00             | 7         | 26        |
| Neuroscience | Senior | 4.50             | 7         | 6         |

## The task (same as the slide exercise)

1. Plot the distribution of **`social_media_hrs`** — what shape is it?
2. Check for **outliers**. Are any values suspicious?
3. What does this tell you about our class?

**Step 1: Sketch a histogram.** Using the summary stats, sketch the shape:

```
Count
  ^
  |
  |
  |
  |
  +----|----|----|----|----|--->
       0    2    4    6    8       social_media_hrs
```

**Step 2: What shape do you expect?** Circle one:

Symmetric / bell-shaped • Right-skewed • Left-skewed • Bimodal

Why? (Hint: where do the median and mean sit relative to each other?) ___________________

___________________________________________________________________________________

\newpage

**Step 3: Sketch a boxplot.** Box from Q1 (___) to Q3 (___). Median at ___. Whiskers to min/max (or 1.5 × IQR, whichever is closer).

```
       |    |    |    |    |
  +----|----|----|----|----|--->
       0    2    4    6    8       social_media_hrs
```

**Step 4: Outlier check.** Compute the IQR and fences:

- IQR = Q3 − Q1 = ___ − ___ = ___
- Lower fence = Q1 − 1.5 × IQR = ___      Upper fence = Q3 + 1.5 × IQR = ___

Any values beyond these fences? _____ Suspicious or just honest? _________________________

**Step 5: Write the code.** Fill in the blanks:

```r
# Histogram
ggplot(class_survey, aes(x = ________________)) +
  geom_____________(binwidth = 1, fill = "#2c7fb8", color = "white") +
  theme_minimal()

# Boxplot
ggplot(class_survey, aes(x = ________________)) +
  geom_____________() +
  theme_minimal()
```

**Check your work.** Compare your sketches, fences, and code with your partner's screen. Do your answers match what the actual plots show?
