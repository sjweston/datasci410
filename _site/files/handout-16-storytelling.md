# Session 16: Storytelling with Data — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The data: `stress_data`

Mean stress and burnout ratings (0–10 scale) by profession:

| profession | stress | burnout |
|-----------|--------|---------|
| Teacher    | 7.2    | 6.8     |
| Nurse      | 8.1    | 7.9     |
| Engineer   | 5.5    | 4.8     |
| Retail     | 6.8    | 6.5     |
| Admin      | 6.2    | 5.9     |

Your partner has a default bar chart on screen that needs improvement.

---

## The task (same as the slide exercise)

The original code produces a basic, unpolished bar chart:

```r
ggplot(stress_data, aes(x = profession, y = stress, fill = profession)) +
  geom_col() +
  labs(title = "Stress by Profession") +
  theme_gray()
```

Improve it by:

1. Removing the unnecessary legend
2. Reordering professions by stress level
3. Highlighting the profession with highest stress
4. Adding a clear, message-driven title
5. Cleaning up the theme

### Your pen-and-paper version

**Step 1: Reorder the data.** Rank the professions from lowest to highest stress:

| Rank | Profession | Stress |
|------|-----------|--------|
| 1    |           |        |
| 2    |           |        |
| 3    |           |        |
| 4    |           |        |
| 5    |           |        |

**Step 2: Write a message-driven title.** The current title is "Stress by Profession" — this describes the axes but says nothing about the finding. Write a title that tells the reader what to take away:

Your title: ___________________________________________________________________

**Step 3: Plan the highlighting.** Which profession should be highlighted? ___________

What color would you use for the highlight? _____________

What color for the non-highlighted bars? _____________

**Step 4: Horizontal vs. vertical?** Should the bars be horizontal or vertical? Why?

Your answer: ___________________________________________________________________

**Step 5: Sketch the improved figure.** Draw it by hand below, incorporating all your improvements:

```
              |
              |
              |
              |
              |
              |
              |
              |
              |________________________________
```

**Step 6: Write the improved code.** Fill in the blanks:

```r
stress_data <- stress_data |>
  mutate(
    profession = fct_reorder(profession, _______),
    highlight = if_else(profession == "________", "yes", "no")
  )

ggplot(stress_data, aes(x = stress, y = profession,
                         fill = __________)) +
  geom_col() +
  scale_fill_manual(values = c("yes" = "___________",
                                "no" = "___________")) +
  labs(
    title = "________________________________",
    subtitle = "________________________________",
    x = "____________",
    y = ______
  ) +
  theme___________() +
  theme(legend.position = "________")
```

---

## Check your work

Compare your sketch and code with your partner's screen.

**Ranked professions:** Engineer (5.5), Admin (6.2), Retail (6.8), Teacher (7.2), Nurse (8.1)

**Good title examples:** "Nurses report highest stress levels" or "Healthcare workers bear the heaviest stress burden"

**Highlight:** Nurse — use a distinct color (e.g., steelblue) against gray for the rest.

**Horizontal bars:** Better for categorical labels — profession names are easier to read horizontally than rotated 45 degrees.

**Expected code:**
```
stress_data <- stress_data |>
  mutate(
    profession = fct_reorder(profession, stress),
    highlight = if_else(profession == "Nurse", "yes", "no")
  )

ggplot(stress_data, aes(x = stress, y = profession, fill = highlight)) +
  geom_col() +
  scale_fill_manual(values = c("yes" = "steelblue", "no" = "gray70")) +
  labs(
    title = "Nurses report highest stress levels",
    subtitle = "Mean stress ratings on 0-10 scale",
    x = "Stress level",
    y = NULL
  ) +
  theme_minimal() +
  theme(legend.position = "none")
```
