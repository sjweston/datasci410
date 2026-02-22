# Session 8: Layers & Aesthetics — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The data: `reaction_data`

This dataset has reaction time (RT) data from a psychology experiment with 40 participants in two conditions. Here are 8 representative rows:

| participant | condition | rt    | accuracy |
|-------------|-----------|-------|----------|
| 1           | Control   | 542.3 | 1        |
| 1           | Treatment | 468.1 | 1        |
| 5           | Control   | 499.7 | 0        |
| 5           | Treatment | 512.4 | 1        |
| 12          | Control   | 580.2 | 1        |
| 12          | Treatment | 445.9 | 1        |
| 20          | Control   | 475.6 | 1        |
| 20          | Treatment | 501.8 | 0        |

**Key:** `rt` = reaction time in milliseconds, `accuracy` = 1 (correct) or 0 (incorrect)

---

## The task (same as the slide exercise)

1. Create a **bar chart with error bars** showing mean RT by condition
2. Add **individual data points** (jittered) behind the bars
3. Color the bars by condition
4. Add a caption noting that error bars show the 95% CI

### Your pen-and-paper version

**Step 1: Compute summary statistics by hand.** Using the 8 rows above, calculate the mean RT for each condition:

| Condition | RT values             | Mean RT |
|-----------|-----------------------|---------|
| Control   |                       |         |
| Treatment |                       |         |

**Step 2: Sketch the plot.** Draw a bar chart on the grid below. Label the x-axis with the two conditions and the y-axis with RT in milliseconds. Draw bars at the mean heights. Scatter the individual data points next to each bar (jittered).

```
rt (ms)
600 |
    |
550 |
    |
500 |
    |
450 |
    |
400 |________________________________
      Control      Treatment
```

**Step 3: Plan the layers.** A ggplot is built in layers. List the layers you'd need, in order:

1. `geom_________()` — for the individual points (with jitter)
2. `stat_________()` — for the bar (using `fun = mean`)
3. `stat_________()` — for the error bars (using `fun.data = mean_cl_normal`)

**Why does order matter?** Which layer should be drawn first so it appears *behind* the bars?

Your answer: ___________________________________________________________________

**Step 4: Write the code.** Fill in the blanks:

```r
reaction_data |>
  ggplot(aes(x = _________, y = _____, fill = _________)) +
  geom_jitter(width = 0.15, alpha = 0.4) +
  stat_summary(fun = _____, geom = "_____", alpha = 0.6, width = 0.5) +
  stat_summary(fun.data = _____________, geom = "________", width = 0.2) +
  labs(
    title = "________________________________",
    x = "____________",
    y = "____________",
    caption = "________________________________"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
```

---

## Check your work

Compare your sketch and code with your partner's screen.

**Mean RT from sample:** Control ≈ 524.5 ms, Treatment ≈ 482.1 ms

**Layer order:** `geom_jitter` is listed first so the individual points are drawn *behind* the bars, not on top of them.

**Expected code:**
```
reaction_data |>
  ggplot(aes(x = condition, y = rt, fill = condition)) +
  geom_jitter(width = 0.15, alpha = 0.4) +
  stat_summary(fun = mean, geom = "bar", alpha = 0.6, width = 0.5) +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", width = 0.2) +
  labs(
    title = "Mean Reaction Time by Condition",
    x = "Condition",
    y = "Reaction time (ms)",
    caption = "Error bars represent 95% confidence intervals."
  ) +
  theme_minimal() +
  theme(legend.position = "none")
```
