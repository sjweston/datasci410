# Session 11: EDA — Covariation — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The data: `therapy_data`

This dataset has post-treatment depression scores (BDI-II) for 150 participants across three conditions. Here are 12 representative rows:

| condition    | depression_post |
|-------------|-----------------|
| Control      | 20.3            |
| Control      | 15.8            |
| Control      | 22.1            |
| Control      | 18.6            |
| CBT          | 11.4            |
| CBT          | 14.2            |
| CBT          | 9.8             |
| CBT          | 13.5            |
| Mindfulness  | 16.1            |
| Mindfulness  | 12.7            |
| Mindfulness  | 14.9            |
| Mindfulness  | 11.3            |

The exercise also asks you to add a `gender` variable using `sample()`.

---

## The task (same as the slide exercise)

1. Add a `gender` variable to the data (use `sample()` to randomly assign "Male", "Female", "Non-binary")
2. Create a visualization showing depression scores by gender
3. Try at least two different geom types
4. Add appropriate labels

### Your pen-and-paper version

**Step 1: Think about the `mutate` + `sample` step.** What would this code do?

```r
therapy_data |>
  mutate(gender = sample(c("Male", "Female", "Non-binary"),
                         size = n(), replace = TRUE))
```

Why do we need `replace = TRUE`? _____________________________________________

Why are we using `sample()` instead of real gender data? _______________________

**Step 2: Plan two visualizations.** For comparing a continuous variable (`depression_post`) across groups (`gender`), which geom types make sense? List at least 3 options and star the two you'd choose:

- `geom_____________`
- `geom_____________`
- `geom_____________`
- `geom_____________`

**Step 3: Sketch two plots.** Draw two different visualizations of depression scores by gender using the grid below.

**Plot A** (geom type: ______________)

```
depression
25 |
   |
20 |
   |
15 |
   |
10 |
   |
 5 |_________________________________
     Male    Female   Non-binary
```

**Plot B** (geom type: ______________)

```
depression
25 |
   |
20 |
   |
15 |
   |
10 |
   |
 5 |_________________________________
     Male    Female   Non-binary
```

**Step 4: Write the code for one of your plots.** Fill in the blanks:

```r
ggplot(therapy_data_gender, aes(x = _______, y = _______________)) +
  geom_____________() +
  labs(
    title = "________________________________",
    x = "____________",
    y = "____________"
  ) +
  theme_minimal()
```

**Step 5: Think about it.** Since we randomly assigned gender (it's not real data), would you expect to see a real difference between groups? Why or why not?

Your answer: ___________________________________________________________________

---

## Check your work

Compare your sketches and code with your partner's screen.

**Why `replace = TRUE`:** We have 150 participants but only 3 gender categories. Without replacement, `sample()` can only draw 3 values.

**Good geom choices:** `geom_boxplot()`, `geom_violin()`, `geom_jitter()`, `geom_point()`. Boxplot and violin are the most informative for group comparisons.

**Expected code (boxplot version):**
```
ggplot(therapy_data_gender, aes(x = gender, y = depression_post)) +
  geom_boxplot() +
  labs(
    title = "Depression scores by gender",
    x = "Gender",
    y = "Depression score (BDI-II)"
  ) +
  theme_minimal()
```

**Expected finding:** No meaningful difference between genders — because we randomly assigned the labels, there's no real relationship. Any small differences are just random noise. This is a nice preview of the concept of a null effect.
