# Data Visualization Principles

Reference guide based on *Storytelling with Data* by Cole Nussbaumer Knaflic.
Use when building dashboards, portfolio visuals, or LinkedIn post graphics.

---

## Choosing the Right Visual

- **Simple text** when you have one or two numbers to communicate. Don't put a single number in a chart — just make it big and prominent.
- **Tables** are good when the audience needs to look up specific values. Not good for storytelling — they engage the verbal system, not the visual one.
- **Heatmaps** layer color onto tables to add visual cues while preserving exact values.
- **Line charts** for continuous data over time (trends, trajectories).
- **Bar charts** (vertical or horizontal) for categorical comparisons. Horizontal bars are easier to read when category labels are long.
- **Stacked bars** to show totals and sub-components. Can show absolute values or sum to 100%.
- **Slopegraphs** for comparing two time points across multiple categories.
- **Scatterplots** for relationships between two variables.
- **Waterfall charts** for showing how components build to a total.
- Avoid: pie charts, 3D charts, secondary y-axes. These make comparison harder.

---

## Clutter Is the Enemy

The core concept: **reduce cognitive load**. Every element on the page that isn't helping your audience understand the data is hurting.

- **Data-ink ratio** (Tufte): maximize the share of ink devoted to data; minimize everything else.
- Remove chart borders, gridlines, and background shading unless they serve a specific purpose.
- Remove axis lines and tick marks when the data labels themselves are sufficient.
- Strip default software elements (Excel/PowerBI borders, legends placed far from data, unnecessary grid).
- Ask: "Would removing this change anything?" If no, remove it.

---

## Gestalt Principles of Visual Perception

Use these to guide how your audience groups and processes information:

- **Proximity**: objects close together are perceived as a group. Use spacing intentionally in tables and layouts.
- **Similarity**: objects that share color, shape, or size are seen as related. Use consistent color within a series to guide the eye across rows, not down columns.
- **Enclosure**: light background shading can visually group elements without heavy borders.
- **Closure**: the brain fills in gaps. You can remove chart borders and axis lines and the eye still perceives the structure — this is why minimal charts work.
- **Continuity**: the eye follows the smoothest path. Remove vertical y-axis lines; the bars or data points themselves create the perceived baseline.
- **Connection**: physically connected elements (lines between dots) are perceived as related. Use lines in graphs to show order and relationship.

---

## Preattentive Attributes

These are visual properties the brain processes almost instantly, before conscious thought. Use them to direct attention:

- **Color** (hue and intensity) — most powerful and most commonly used
- **Size** — bigger = more important. Size denotes relative importance.
- **Bold** in text — preferred over italics, underlining, outline, or size changes for emphasis. Adds minimal noise.
- **Italics** — add moderate noise, don't stand out as much
- **Spatial position** — where something sits on the page matters (top-left gets seen first)

Use sparingly. If everything is highlighted, nothing is highlighted.

---

## Strategic Use of Color

- **Default to grey.** Design most of the visual in shades of grey, then use a single bold color to draw attention to the thing that matters.
- **Use color sparingly.** Too much variety prevents anything from standing out. A rainbow palette is almost always worse than a single-hue saturation scale.
- **Use color consistently.** Once blue means "Region A," keep it blue across all slides/pages. Changing color meanings between visuals forces relearning.
- **A change in color signals a change.** Don't switch colors for novelty or aesthetics — only when the data category actually changes.
- **Design for colorblindness.** ~8% of men are colorblind. Avoid red/green pairings as the sole differentiator. Use blue and orange for positive/negative. Add bold, saturation differences, or +/- symbols as backup cues.
- **Be thoughtful about tone.** Color evokes emotion. Clinical data shouldn't use playful palettes. Match the tone to the context.
- **Brand colors:** use 1-2 brand-appropriate colors as your attention cues, keep everything else muted in grey.

---

## White Space

- White space is the equivalent of pauses in public speaking. It gives the audience room to process.
- Resist the urge to fill every inch of the page. "There's still some space, let's add something" is a bad instinct.
- Never add data just to fill space. Only add data with a thoughtful, specific purpose.
- Margins should remain free of text and visuals.
- White space draws attention to the parts of the page that are *not* white space.

---

## Alignment

- Align elements to create clean vertical and horizontal lines. The eye notices misalignment even when you don't consciously register it.
- Audiences scan in "Z" patterns: top-left, across, down-left, across. Put the most important thing at the top or upper-left.
- Remove diagonal elements. Diagonal text is 26% slower to read than horizontal text (rotated 45-degree labels are the worst offender).
- Use software alignment tools (grids, snap-to, guides). Then remove the gridlines/borders so the alignment does the structural work invisibly.

---

## Non-Strategic Contrast

- Clear contrast helps the audience understand where to focus. Lack of contrast is visual clutter.
- The more things you make different, the fewer things stand out. If everything is emphasized, nothing is.
- When you want one data point to stand out, make it visually distinct and push everything else to the background in grey.

---

## Position on Page

- Top of page = most important. Put the key takeaway or the most critical category there.
- Order categories logically: if there's a natural order (age groups, time), use it. If not, order by value (largest to smallest) to make comparison easy.
- The biggest category goes first when importance ranking is the point.

---

## Affordances (Think Like a Designer)

Three goals:
1. **Highlight the important stuff** — use preattentive attributes (bold, color, size) to direct the eye
2. **Eliminate distractions** — remove clutter, non-data ink, redundant labels
3. **Create a clear visual hierarchy** — the audience should know what to look at first, second, third

Key questions to ask:
- Not all data are equally important. Use space for what matters most.
- When detail isn't needed, summarize. Familiarity with the detail doesn't mean the audience needs it.
- "Would eliminating this change anything?" If not, cut it.

---

## Text and Titles

- **Text is your friend.** It labels, introduces, explains, reinforces, highlights, recommends, and tells a story.
- Every chart needs a title, axis titles, and a data source footnote at minimum.
- **Use action titles, not descriptive titles.** Not "Ticket Volume Over Time" but "Please approve the hire of 2 FTEs" — tell the audience what to conclude and what to do.
- **Make it legible:** use a consistent, easy-to-read font throughout.
- **Keep it clean:** use visual affordances (white space, hierarchy) to make text scannable.
- **Use straightforward language.** No jargon the audience won't know. Define acronyms. Spell out abbreviations on first use.
- **Remove unnecessary complexity.** When choosing between simple and complicated phrasing, favor simple.

---

## Accessibility

- Good design is accessible by default. If the graph is hard to read, the fault is the design, not the audience.
- Don't overcomplicate: fussier fonts and busier layouts reduce comprehension and willingness to engage.
- The onus is on the designer to make the graph understandable — not on the audience to decode it.

---

## Aesthetics Matter

- Aesthetically pleasing designs increase audience patience and willingness to engage.
- Three components: **color**, **alignment**, and **white space**. Thoughtful use of all three makes a visual feel professional. Neglecting any of them makes it feel disorganized.
- Collect examples of effective data visualization. When you see a graph that works well, save it and study what makes it effective. Build a reference library.

---

## Gaining Acceptance for New Designs

- People resist unfamiliar chart types and layouts. Expect pushback.
- **Articulate the benefits** of the new approach — explain *why* the change helps.
- **Show the before-and-after side by side** so the improvement is visible.
- **Provide multiple options and seek input.** Collaboration reduces resistance.
