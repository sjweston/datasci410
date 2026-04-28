# Grading Rubrics — PSY 410: Data Science for Psychology

Detailed rubrics for each assignment, used by Sara, the GE, and Claude when grading. Companion to `grading-instructions.md` (general grading guidance) and the student-facing assignment files in `assignment/`.

**Scale (applies to every criterion):**

| Level | Meaning |
|-------|---------|
| **Full** | Correct and complete. All requirements met. |
| **−1** | One minor slip — typo, missing label, small formatting issue, slightly off variable name. The student understood the task. |
| **Half** | One major error — wrong geom, missing a required component, ran a different analysis than asked, or only partially attempted. Approach is on the right track but the result is meaningfully wrong. |
| **None** | Not attempted, or multiple major errors stacked together, or completely wrong approach. |

Half-credit values are kept as decimals (e.g., 7.5) so totals add cleanly. Canvas accepts decimals in rubric ratings.

When uncertain between two levels, default to the higher one and leave a comment. See `grading-instructions.md` for partial credit nuances within a level.

---

## Assignment 4: Visualization Deep Dive (100 points)

### Task 1.1 — Summary table (mean, SD, N by species)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 10  | Uses `group_by(species)` + `summarize()`; produces mean flipper length, SD, and N for each species; handles NAs (e.g., `na.rm = TRUE` in `mean()` and `sd()`, or `drop_na()` upstream). |
| −1    | 9   | All three statistics present but with one minor issue — column named oddly, NAs not removed but result still numeric, or `n()` returning total instead of per-group (still calculated, just labeled imprecisely). |
| Half  | 5   | Only one or two of the three statistics computed (e.g., mean only), OR groups by the wrong variable, OR uses the wrong functions (`length()` instead of `n()`, etc.). |
| None  | 0   | No grouping, or table missing entirely. |

### Task 1.2 — Bar chart with error bars (15 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 15  | Bar chart of mean flipper length by species using `stat_summary()` for both the bar (`fun = mean, geom = "bar"`) and the error bars (`fun.data = mean_cl_normal, geom = "errorbar"`) — i.e., 95% CI; title, caption, or labels make clear what the error bars represent; plain-English axis labels; viridis palette; clean theme like `theme_minimal()`. |
| −1    | 14  | Correct `stat_summary()` + `mean_cl_normal` pattern but missing one polish item — variable names left on axes, no title, default grey theme, default colors instead of viridis, or the error-bar type isn't named anywhere on the plot. |
| Half  | 7.5 | Plot exists but is missing error bars entirely, OR error bars use the wrong statistic (`mean_se`, SD, or unspecified), OR uses a hand-built `geom_col()` + `geom_errorbar()` instead of `stat_summary()` (accept the result if the math is right, but the assignment asked for `stat_summary()`), OR not grouped by species. |
| None  | 0   | No plot, or plot has neither species grouping nor any summary statistic. |

### Task 2.1 — Histogram with bin width exploration (8 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 8   | Histogram of `body_mass_g` with an explicit `binwidth = ...`; comment naming the chosen bin width and giving a reason ("captures the shape without too much noise" or similar). |
| −1    | 7   | Histogram present and correct but comment is missing the *why*, or chose a clearly suboptimal bin width with no rationale. |
| Half  | 4   | Histogram exists but uses default 30 bins with no `binwidth`, OR no comment at all about choice. |
| None  | 0   | No histogram. |

### Task 2.2 — Overlapping density plots by species (8 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 8   | `geom_density()` with `aes(fill = species)` (or `color = species`) and `alpha < 1` so overlap is visible. |
| −1    | 7   | Density plots colored by species but transparency missing or set so high all distributions look opaque. |
| Half  | 4   | Single density plot with no species coloring, OR three separate facet panels instead of overlapping. |
| None  | 0   | No density plot. |

### Task 2.3 — Boxplot vs. violin plot comparison (9 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 9   | Both plots present (boxplot then violin, body mass by species); comment explicitly contrasts what each shows — boxplot shows median/quartiles/outliers cleanly, violin shows distribution shape (bimodality, skew). |
| −1    | 8   | Both plots present, comment present but vague ("they look different") or only describes one. |
| Half  | 4.5 | Only one plot, OR two plots but no comparison comment. |
| None  | 0   | Neither plot. |

### Task 3.1 — Intentionally bad visualization (12 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 12  | Plot exists; lists ≥4 specific design violations in a comment; violations are real (truncated axis, rainbow palette, missing labels, chartjunk, wrong geom, etc.) and visible in the plot. |
| −1    | 11  | All of the above but lists only 3 violations, or one listed violation isn't actually visible in the plot. |
| Half  | 6   | Plot exists but is only mildly bad (1–2 issues), OR the comment is missing/generic ("this is bad because it looks bad"). |
| None  | 0   | No plot, or plot is fine and comment claims it's bad. |

### Task 3.2 — Good visualization with design justification (13 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 13  | Clean, readable plot of the same data; appropriate geom for the data type; clear labels and title; comment explains design choices grounded in perception/design principles from Session 9. |
| −1    | 12  | Good plot but design justification is brief or doesn't reference principles from Session 9. |
| Half  | 6.5 | Plot is OK but has visible polish issues (variable names on axes, default theme used uncritically), OR no design comment at all. |
| None  | 0   | No plot, or plot is no better than the "bad" version from 3.1. |

### Task 4.1 — Import data and convert team to factor (5 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 5   | Uses `read_csv()` (or equivalent) with a sensible path; converts `team` to a factor with labels `"Spain"`, `"Greece"`, `"No Team"` in that order, using `levels = c(1,2,3), labels = c(...)` or equivalent. |
| −1    | 4   | Imported and converted but order of labels is wrong (e.g., alphabetical), OR uses `as.factor()` without setting labels. |
| Half  | 2.5 | Data imported but `team` left as numeric, OR factor created with default levels that don't match Spain/Greece/No Team. |
| None  | 0   | Data not imported. |

### Task 4.2 — Recreate Figure 3 (10 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 10  | Pivots `SP_c` and `GR_c` to long format; plots acceptance threshold by team and statement type; uses an appropriate geom (bar with error bars, or point + error); has axis labels and legend title; theme is reasonable. Result is recognizably the same figure as Hubeny et al.'s Figure 3. |
| −1    | 9   | Above but with one polish issue — legend title missing, axis labels left as variable names, theme default. |
| Half  | 5   | Plot attempted but didn't pivot the data (so SP and GR are plotted as separate plots instead of combined), OR error bars missing, OR teams not labeled. |
| None  | 0   | No plot, or plot is unrelated to the assignment data. |

### QMD file knits without errors (10 pts)

| Level | Pts | Looks like |
|-------|:---:|------------|
| Full  | 10  | The submitted `.qmd` renders to HTML without errors. |
| −1    | 9   | Renders, but with one easily-fixed warning or a single broken inline reference. |
| Half  | 5   | Renders only after manually setting `eval: false` on one chunk, OR the rendered HTML is missing one task's output. |
| None  | 0   | Does not render at all; no HTML file submitted; or the HTML doesn't match the submitted `.qmd`. |

This criterion grades the *file*, not individual task correctness. A student whose Task 1.2 code is wrong but who set `#| eval: false` on it so the file renders should still get Full here.

### Graduate Extension (PSY 510 only) — pass/fail per task

The grad extension is graded on whether each piece is present and reasonable, not against the same 4-level scale.

- **G.1 Publication-ready figure file:** Saved at 300 dpi with journal-spec dimensions named in a comment. Pass = file submitted, dimensions stated. Fail = no file or no spec.
- **G.2 APA caption:** Includes figure number + title, description, abbreviation definitions, error bar definition, *N*. Pass = all five present. Fail = three or more missing.
- **G.3 Design justification:** 3–5 sentences referencing Session 9 perception/design principles. Pass = within length, references at least one principle by name. Fail = missing or generic.

Grad extension is reported separately in Canvas; the main 100-point rubric is the same as for undergrads.
