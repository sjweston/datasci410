# Session 8: Layers & Aesthetics — Pair Exercise

**PSY 410 | Data Science for Psychology** &nbsp;&nbsp;&nbsp; **Name:** ______________________________ **Date:** ______________

*No laptop? Work with a partner who has one and compare at the end.*

---

## Data: `reaction_data`

Reaction time data from 40 participants in two conditions (8 representative rows):

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

`rt` = reaction time (ms) &nbsp; `accuracy` = 1 (correct) or 0 (incorrect)

---

## Task

Build a bar chart with error bars showing mean RT by condition, with jittered individual points behind the bars, colored by condition, and a caption noting error bars show the 95% CI.

**Step 1: Compute means.** Using the 8 rows above, calculate mean RT for each condition:

| Condition | RT values | Mean RT |
|-----------|-----------|---------|
| Control   |           |         |
| Treatment |           |         |

**Step 2: Sketch the plot.** Label axes and draw bars at the mean heights. Add jittered individual points.

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
 400 |________________________
       Control     Treatment
```

**Step 3: Plan the layers** (in drawing order — bottom layer first):

1. `geom_________()` — individual points (jittered)
2. `stat_________()` — bar (using `fun = mean`)
3. `stat_________()` — error bars (using `fun.data = mean_cl_normal`)

Why does order matter? ___________________________________________________________________

**Step 4: Fill in the blanks:**

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

**Check:** Compare your means, layer order, and code with your partner's screen.
