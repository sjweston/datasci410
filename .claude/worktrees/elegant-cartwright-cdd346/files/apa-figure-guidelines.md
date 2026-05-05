# APA Figure Guidelines — Quick Reference

**PSY 410 Handout | Session 15**

This is a practical reference for formatting figures when you need them to look publication-ready — for papers, posters, or reports. APA 7th edition provides guidelines, but journals vary in how strictly they enforce them. The conventions below are the ones that actually matter most.

---

## The Basics

- **Figure number and title are required.** The figure number (e.g., *Figure 1*) goes on its own line above the title. The title goes on the next line, in italics, in sentence case (only capitalize the first word and proper nouns).
- **Caption goes below the figure.** The caption (starting with *Note.* in italics) provides additional context — what abbreviations mean, how the data were derived, statistical details, etc. A caption is not the same as a title.
- **Black and white is the default assumption.** Not all journals print in color, and not all readers can perceive color differences. Design your figure so it's readable in grayscale. Use shape, pattern, or line style as a backup to color.

---

## Size and Layout

| Element | Guideline |
|---|---|
| Single-column figure width | ~3.25 inches |
| Full-page figure width | ~6.5 inches |
| Height | Varies — use what the content needs. Avoid very tall, narrow figures. |
| Resolution | 300 DPI for print; 150 DPI is acceptable for online-only |

In ggplot2, set width and height in `ggsave()`:

```r
ggsave("my_figure.png", width = 6.5, height = 4, dpi = 300)
```

---

## Typography

- Use a sans-serif font (e.g., Arial, Calibri) at **8–12 pt** for axis labels and tick marks.
- Axis labels should be in plain text (not bold), unless the journal style requires otherwise.
- Titles and legends should be legible at the printed size — don't assume people will zoom in.

In ggplot2, adjust font sizes with `theme()`:

```r
theme(
  axis.text  = element_text(size = 9),
  axis.title = element_text(size = 10),
  legend.text = element_text(size = 9)
)
```

---

## What to Include and What to Remove

**Keep:**
- Axis labels (always — every axis needs a label)
- A legend, if you have more than one group (but see below)
- Gridlines only if they aid readability — horizontal lines only, light gray

**Remove:**
- The default ggplot2 gray background
- Unnecessary gridlines (especially vertical ones)
- A legend when there is only one group
- Tick marks that don't correspond to meaningful values
- Borders/boxes around the plot area (unless your journal requires them)

A good starting point in ggplot2 is `theme_classic()` or `theme_minimal()`, then tweak from there.

---

## Color and Accessibility

- If using color to distinguish groups, choose a colorblind-friendly palette. `viridis` (the ggplot2 default for continuous) is fine. For categorical data, consider `ggthemes::scale_color_colorblind()` or manually set colors.
- Label groups directly on or near the data when possible, rather than relying on a legend. This reduces the reader's cognitive load.
- Avoid using red and green together as the only distinguishing colors.

---

## Error Bars

- **Always state what the error bars represent.** Options: standard error (SE), standard deviation (SD), or 95% confidence interval (CI). Put this in the figure caption or note.
- Error bars should be simple vertical lines with caps (horizontal end marks). Avoid fancy styles.
- If you are showing means + error bars for a between-subjects comparison, SE is common in psychology. For within-subjects designs, confidence intervals require adjustment (see Morey, 2008).

---

## Common Mistakes

| Mistake | Fix |
|---|---|
| No axis labels | Always label both axes with the variable name and units (if applicable) |
| Legend says "group1", "group2" | Use meaningful labels |
| Y-axis doesn't start at zero | Usually fine for continuous DVs — just don't truncate to exaggerate an effect |
| Too many categories in a single plot | Split into panels with `facet_wrap()` or use a different plot type |
| Pie chart with more than ~5 slices | Switch to a bar chart |
| Figure is too small to read | Check your `ggsave()` dimensions and DPI |

---

## Putting It Together — Checklist

Before submitting a figure for a paper or poster, run through this:

- [ ] Figure number and title (title in italics, sentence case)
- [ ] Both axes labeled
- [ ] Legend present only if needed, with meaningful labels
- [ ] Error bars labeled in caption or note (if present)
- [ ] Readable in grayscale
- [ ] Font sizes are at least 8 pt at final printed size
- [ ] No unnecessary visual clutter
- [ ] Resolution is appropriate (300 DPI for print)
- [ ] Caption/note explains anything non-obvious

---

*Note: APA 7th edition guidelines are in Chapter 7 of the APA Publication Manual. Different journals will have their own figure preparation guidelines — always check the journal's author instructions before formatting.*
