# Session 11: EDA — Covariation — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

**Name:** ______________________________ **Date:** ______________

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

The exercise uses the `condition` variable already in the data.

---

## The task (same as the slide exercise)

1. The `condition` variable is already in `therapy_data` — check its values with `count()`
2. Create a visualization showing depression scores by condition
3. Try at least two different geom types
4. Add appropriate labels

### Your pen-and-paper version

**Step 1: Think about the data.** The `condition` variable has three levels in this dataset. What are they?

1. _____________  2. _____________  3. _____________

**Step 2: Plan two visualizations.** For comparing a continuous variable (`depression_post`) across groups (`condition`), which geom types make sense? List at least 3 options and star the two you'd choose:

- `geom_____________`
- `geom_____________`
- `geom_____________`
- `geom_____________`

**Step 3: Sketch two plots.** Draw two different visualizations of depression scores by condition using the grid below.

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
     CBT     Medication   Waitlist
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
     CBT     Medication   Waitlist
```

**Step 4: Write the code for one of your plots.** Fill in the blanks:

```r
ggplot(therapy_data, aes(x = _______, y = _______________)) +
  geom_____________() +
  labs(
    title = "________________________________",
    x = "____________",
    y = "____________"
  ) +
  theme_minimal()
```

**Step 5: Think about it.** Would you expect to see differences in depression scores across treatment conditions? Why or why not?

Your answer: ___________________________________________________________________

---

## Check your work

Compare your sketches and code with your partner's screen. Do your geom choices and code match?
