# Session 11: EDA — Covariation — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

**Name:** ______________________________ **Date:** ______________

*No laptop today? Work with a partner who has one and compare answers at the end.*

## The data: `therapy_data` (N = 150)

Post-treatment depression (BDI-II) for 50 participants in each of three conditions. *Lower scores = less depression.*

| condition   | n  | mean | sd  | min | max |
|-------------|----|------|-----|-----|-----|
| Control     | 50 | 18.0 | 5.0 | 6   | 30  |
| CBT         | 50 | 12.0 | 5.0 | 1   | 24  |
| Mindfulness | 50 | 14.0 | 5.0 | 3   | 26  |

## The task (same as the slide exercise)

Build a **raincloud plot** of `depression_post` by `condition` using `ggrain::geom_rain()`.

**Step 1: Recall the layers.** A raincloud combines three views of the same data:

1. ____________________ — distribution shape
2. ____________________ — 5-number summary
3. ____________________ — individual data points

**Step 2: Sketch it.** Using the summary stats above, draw all three layers for each condition (half-density on top, boxplot middle, jittered dots underneath). Mark each group's **mean** with an "X".

```
depression
  30 |
  20 |
  10 |
   0 |____________________________________
        Control     CBT       Mindfulness
```

Which condition has the lowest median? _____________

\newpage

**Step 3: Fill in the code.**

```r
library(ggrain)

ggplot(therapy_data, aes(x = ______, y = ______, fill = ______)) +
  geom_______________(alpha = 0.6) +
  labs(title = "________________________________",
       x = NULL, y = "Depression score (BDI-II)") +
  theme_minimal()
```

**Step 4: Why this plot?** Name two things a raincloud shows that a boxplot does not:

1. ___________________________________________________________________

2. ___________________________________________________________________

## Check your work

Compare your sketch and code with your partner's screen. Does your raincloud show the same overall pattern (CBT lowest, Control highest)?
