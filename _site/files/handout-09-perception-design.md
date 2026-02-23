# Session 9: Perception & Design — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The task (same as the slide exercise)

Your partner's screen shows a cluttered graph. **Rewrite it** to follow the design principles covered in today's lecture. Remove at least 5 unnecessary elements and make it tell a clear story.

Here's the cluttered code (your partner will have it on screen):

```r
reaction_data |>
  ggplot(aes(x = condition, y = rt, fill = condition,
             color = condition, size = accuracy)) +
  geom_point() +
  geom_boxplot(alpha = 0.3) +
  scale_fill_manual(values = c("Control" = "red",
                                "Treatment" = "green")) +
  scale_color_manual(values = c("Control" = "red",
                                 "Treatment" = "green")) +
  labs(x = "condition", y = "rt") +
  ggtitle("data") +
  theme_gray()
```

### Your pen-and-paper version

**Step 1: Identify the problems.** Read through the code above and list every design problem you can spot. Aim for at least 5:

| # | Problem | Design principle it violates |
|---|---------|----------------------------|
| 1 |         |                            |
| 2 |         |                            |
| 3 |         |                            |
| 4 |         |                            |
| 5 |         |                            |
| 6 |         |                            |
| 7 |         |                            |

**Step 2: Plan your fixes.** For each problem, write what you'd change:

| Problem | Fix |
|---------|-----|
|         |     |
|         |     |
|         |     |
|         |     |
|         |     |

**Step 3: Rewrite the code.** Write a clean version on paper. Use the space below:

```r
reaction_data |>
  ggplot(aes(x = _________, y = _____, fill = _________)) +










```

---

## Check your work

Compare your problem list and rewritten code with your partner's screen.

**Problems you should have found:**
1. **Red/green colors** — inaccessible to colorblind viewers
2. **`size = accuracy` mapping** — maps a binary variable to point size (meaningless)
3. **Redundant `color` and `fill` aesthetics** — both do the same thing
4. **Title says "data"** — uninformative, should convey a message
5. **Axis labels are variable names** — `"condition"` and `"rt"` instead of readable labels
6. **`theme_gray()`** — adds unnecessary visual clutter (gray background, gridlines)
7. **Points drawn under boxplots** — geom order makes points hard to see

**Expected clean version:**
```
reaction_data |>
  ggplot(aes(x = condition, y = rt, fill = condition)) +
  geom_jitter(width = 0.15, alpha = 0.3, size = 2, color = "gray50") +
  geom_boxplot(alpha = 0.5, width = 0.4, outlier.shape = NA) +
  scale_fill_manual(values = c("Control" = "#0072B2",
                                "Treatment" = "#E69F00")) +
  labs(
    title = "Treatment Reduces Reaction Time",
    x = "Condition",
    y = "Reaction time (ms)",
    caption = "N = 40 per condition. Points = individual observations."
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    panel.grid = element_blank()
  )
```
