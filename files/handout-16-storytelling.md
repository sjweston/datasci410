# Session 16: Storytelling with Data — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

**Name:** ______________________________ **Date:** ______________

*No laptop today? No problem. This handout walks you through the same exercise on paper. Work with a partner who has a laptop and compare your sketches with their figures at the end.*

---

## The task (same as the slide exercise)

Take **one finding** and produce **two versions** of a figure:

1. **For your professor** — what would go in your final written report
2. **For your roommate** — a single image you'd text them with the takeaway

Use at least one annotation technique from today on each version.

---

## Step 1: Pick a finding

Write down **one finding** in a single sentence. Use your final project if you can picture it; if not, use the fallback below.

**Your finding:** _______________________________________________________

> **Fallback:** *"College students who sleep 7+ hours per night have a cumulative GPA about 0.5 points higher than students who sleep less than 6 hours."*

What variables are involved? **x:** _______________  **y:** _______________

What kind of chart fits this finding (circle one)?
**scatterplot · bar chart · line chart · histogram · big-number card**

---

## Step 2: Plan Version A — For your professor

**Audience profile.** Your professor reads carefully, wants statistical detail, and expects an APA-style figure.

- Title style (circle one): **descriptive** ("Figure 1: GPA by sleep group") or **assertion** ("Short sleepers earn lower grades")? _____________
- One statistic to include in-plot (r, β, N, p, mean): _____________
- Theme (circle one): **theme_classic** · **theme_minimal** · **theme_void**
- Highlight one group? **yes / no.** If yes, which? _____________

**Sketch it.** Draw axes, data, title, and any annotation. Label the axes with units.

```
  y |
    |
    |
    |________________________ x
```

**Title you'd write:** _____________________________________________________

**One annotation move you'd use** (e.g., `annotate("text", parse = TRUE)` for stats, `geom_smooth()` with CI, caption with N):

________________________________________________________________________

---

## Step 3: Plan Version B — For your roommate

**Audience profile.** Your roommate is scrolling their phone, knows nothing about your study, and gives you 2 seconds before swiping away.

- The figure should fit on a phone screen. Shape (circle one): **square · tall · wide**
- One number they should remember: _____________
- Do you need axes at all? **yes / no**
- Title style: **assertion only.** Write the headline as if it were a text message.

**Sketch it.** This figure is mostly typography — a big number and a short sentence. Don't draw a full chart unless you need one.

```
  +---------------------------------+
  |                                 |
  |                                 |
  |                                 |
  |                                 |
  +---------------------------------+
```

**Headline (≤ 8 words):** ________________________________________________

**Annotation move you'd use** (e.g., `theme_void()` + `annotate("text")` for big number, `annotate("segment")` for a decorative underline, dark `plot.background`):

________________________________________________________________________

---

## Step 4: Compare the two versions

| Question | Version A (professor) | Version B (roommate) |
|----------|----------------------|----------------------|
| What's dropped from the data? |  |  |
| What's emphasized? |  |  |
| Is the title a description or an assertion? |  |  |
| Could it mislead? How? |  |  |

**The honest-framing question:** Version B drops a lot of detail. Is it still **honest**? Why or why not? ________________________________________________

---

## Step 5: Skeleton code

Fill in the blanks for **Version B** (the social-card style). You don't need real data — `ggplot()` can draw a canvas with no data at all.

```r
ggplot() +
  annotate("text", x = 0.5, y = 0.7,
           label = "__________",          # the big number
           size = 38, fontface = "bold",
           color = "__________") +        # text color
  annotate("text", x = 0.5, y = 0.4,
           label = "__________",          # your headline (≤ 8 words)
           size = 5, color = "white") +
  xlim(0, 1) + ylim(0, 1) +
  coord_fixed() +
  theme______() +                          # which theme strips everything?
  theme(plot.background = element_rect(fill = "__________"))
```

---

## Check your work

Trade handouts with your partner. For each version, ask:

- Could a reader from that audience tell what the finding is in **5 seconds**?
- Is the title doing the work, or is the chart doing the work? (Both should align.)
- What annotation from today shows up in each sketch?
