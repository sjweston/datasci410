# Slide Revision To-Do List

Working document for tracking rhetorical and consistency improvements across all 18 lecture decks. Check items off or delete them as changes are made.

---

## Structural note: File numbering vs CLAUDE.md session order

The slide files are still numbered in the **pre-Quarto-move** order. CLAUDE.md says Quarto moved to Session 7 (Apr 20), but `16-quarto.qmd` is dated May 27 and its footer says "Session 16." The slide files from 07 onward are all offset by one session from the CLAUDE.md calendar mapping. Additionally, no slide deck exists yet for **Session 17: Correlation & Simple Regression** — the file `17-practice-review.qmd` is the old Practice & Review session (mapped to Session 18 in CLAUDE.md). This renumbering is a separate task from the rhetoric changes below and should be handled deliberately.

---

## Cross-deck patterns to fix

These issues appear across many or all decks. Fix them systematically.

### A. Replace every "Questions?" closing

Almost every deck ends with a slide like:

```
## Questions?

Next time: **[Topic]**

We'll learn to [preview]!
```

The rhetoric framework calls this out explicitly as a weak close. Replace with a single memorable takeaway — the one sentence you'd reduce the lecture to.

**Proposed replacement closings (one per deck):**

- [x] **01 (Intro):** ~~Current close is "Questions?" + image.~~ → *"Every skill you learn in this course is a brick in a wall between you and the replication crisis."*
- [x] **02 (Visualization):** → *"Never trust a summary statistic you haven't plotted."*
- [x] **03 (Transformation I):** → *"The pipe turns a wall of nested code into a sentence you can read aloud."*
- [x] **04 (Transformation II):** → *"group_by() + summarize() is how you go from raw data to the descriptive statistics table in every published paper."*
- [x] **05 (Tidying):** → *"If your data isn't tidy, your analysis can't start. pivot_longer() is the bridge."*
- [x] **06 (Import):** → *"Your analysis is only as good as your import. Check it before you trust it."*
- [x] **07 (Layers & Aesthetics):** → *"The difference between a chart and a figure is intention — every layer should earn its place."*
- [x] **08 (Perception & Design):** → *"You're not designing for yourself. You're designing for a reader who will look at your figure for five seconds."*
- [x] **09 (EDA Variation):** → *"EDA isn't a step you finish. It's the habit of looking at your data before you believe anything about it."*
- [x] **10 (EDA Covariation):** → *"Relationships hide in data. Your job is to make them visible — carefully, honestly."*
- [x] **11 (Data Types):** → *"Scoring a scale correctly is the most common data task in psychology — and the easiest place to introduce errors."*
- [x] **12 (Strings & Factors):** → *"Messy categories turn into messy results. str_to_lower() and factor() are your first line of defense."*
- [x] **13 (Joins):** → *"If your data lives in separate files, joins are how you ask a question that spans all of them."*
- [x] **14 (Missing Data):** → *"Missing data isn't a problem to solve — it's information about your study. Treat it that way."*
- [x] **15 (Storytelling):** → *"A figure without a story is just a picture. Ask 'so what?' until you have the answer."*
- [x] **16 (Quarto):** → *"Quarto means your analysis and your report are the same document. Change one, the other updates. That's reproducibility."*
- [x] **17 (Practice & Review):** → *"The only difference between you and someone who's 'good at R' is time spent being frustrated and pushing through."*
- [x] **18 (Putting It Together):** Already strong — no change needed.

**Implementation:** For each deck, delete the `## Questions?` slide. Move the "Before next class" / reading assignments to the final content slide or a handout. End on the takeaway.

---

### B. Strengthen openings (Sessions 3–14)

Sessions 1 and 2 have excellent openings (replication crisis, Anscombe's Quartet). Most others open with a recap table or "Real data rarely comes in the form you need." The rhetoric framework says you win or lose in the first 60 seconds.

**Proposed replacement openings:**

- [x] **03 (Transformation I):** Replaced generic bullet list with concrete question: *"You collected survey data from 500 participants. You only want women over 25 who passed the attention check. How do you get to just those rows?"*
- [x] **04 (Transformation II):** Replaced recap table with backward-link: *"Your advisor doesn't want rows — they want a number: 'What's the average depression score by condition?'"*
- [x] **05 (Tidying):** Added "Can you plot this?" slide before the Wickham quote — shows a messy wide dataset and lets students feel the gap before learning the fix.
- [x] **06 (Import):** Replaced workflow tracker table with *"Your data isn't inside a package"* — CSV on desktop, Excel from advisor, Qualtrics with 200 columns.
- [x] **07 (Layers & Aesthetics):** Replaced "We covered the basics" with a side-by-side comparison of a bar chart vs a layered boxplot+jitter+mean figure. *"Both use the same data. The difference is layers."*
- [x] **08 (Perception & Design):** Replaced text-only opening with a deliberately bad figure (red-green bars, no title, tiny text). *"What's wrong with this?"* + reveal.
- [x] **09 (EDA Variation):** Added *"Know your data before you test it"* slide before the existing comparison table. Reframes EDA as "no surprises."
- [x] **10 (EDA Covariation):** Replaced recap bullet list with *"Psychology is about relationships"* — backward-links to variation, forward to today's focus.
- [x] **11 (Data Types):** Added reverse-coding puzzle: *"A participant scores 4, 3, 2, 5, 1... Item 3 is reverse-coded. What's their total?"* Connects to real published errors.
- [x] **12 (Strings & Factors):** Added *"How many genders are in this dataset?"* — shows messy gender column, R says 7, you meant 2.
- [x] **13 (Joins):** Replaced generic list with concrete scenario: *"Three files, one question"* — survey, task, demographics, and the question they can't answer yet.
- [x] **14 (Missing Data):** Replaced bullet list with striking statistic: *"30–50% of participants drop out... if you just delete their data, you might be throwing away the most important part of the story."*

---

### C. Add `code-copy: false` to 4 decks

Per CLAUDE.md's anti-copy-paste policy:

- [x] `04-data-transformation-2.qmd` — add `code-copy: false` to the YAML `revealjs:` block
- [x] `05-data-tidying.qmd` — add `code-copy: false`
- [x] `06-data-import.qmd` — add `code-copy: false`
- [x] `07-layers-aesthetics.qmd` — add `code-copy: false`

---

### D. Rewrite label-style section titles as assertions

This doesn't need to happen on every slide — code-demo slides with titles like `filter() picks rows` are functional and fine. Focus on **section headers** (the `{background-color}` slides) and **conceptual slides** where the title carries the argument.

**Highest-priority rewrites per deck:**

- [x] **02:** "What is ggplot2?" → *"ggplot2 builds plots in layers, like a grammar"*
- [x] **02:** "Geoms" (section header) → *"Different data types need different geoms"*
- [x] **03:** "Why transform data?" → replaced by new opening (Section B)
- [x] **03:** "The pipe: |>" (section header) → *"The pipe makes your code read like a sentence"*
- [x] **04:** "Review" (section) → replaced by new opening (Section B): *"From rows to statistics"*
- [x] **05:** "The tidyverse philosophy" → kept; new "Can you plot this?" slide inserted before it (Section B)
- [x] **05:** "Common pitfalls" (section header) → *"pivot_longer() trips everyone up the first time"*
- [x] **06:** "Where we are" / "What importing looks like" → replaced by new opening (Section B)
- [x] **07:** "Back to the grammar of graphics" → replaced by new opening (Section B): *"Same data, two stories"*
- [x] **08:** "Preattentive attributes" → *"Your brain processes some visual features before you even think"*
- [x] **09:** "The EDA mindset" → *"Good EDA means looking before you test"*
- [x] **10:** "Recap: Variation" → replaced by new opening (Section B)
- [x] **11:** "Everything is a type" → replaced by new opening (Section B): reverse-coding puzzle
- [x] **12:** "What are strings?" → replaced by new opening (Section B): messy gender column
- [x] **13:** "Example scenario" → *"Two tables, one question"*
- [x] **14:** "Today's agenda" → removed via new opening (Section B)
- [x] **16:** "Traditional workflow" → *"Copy-paste workflows break when anything changes"*
- [x] **17:** "Today's plan" (section header) → *"You already know more than you think"*

---

## Deck-specific items

### Session 01: Introduction & Setup
- [ ] **Bullet-heavy AI section (lines ~489–545):** The "Why no AI?" section has 5 dense slides with nested bullets. Consider condensing to 3 slides: (1) the bicycle/motorcycle framing, (2) the metacognition trap, (3) the helmet metaphor with the course structure payoff. Cut "The future: When do we use AI?" — it's speculative and can be mentioned verbally.

### Session 02: Your First Visualization
- [ ] **No psychology data:** This is the only deck that uses no psychology examples (all `mpg`). The opening Anscombe's Quartet is discipline-neutral, which is fine, but the first plot students build could use psychology data. Consider adding one slide after the `mpg` demo that shows the same `ggplot()` template with a simple psych dataset (e.g., `condition` vs `score`), even if brief.
- [ ] **End-of-deck exercise has no hidden solution:** Add a solution block to the "Get a head start: Assignment 1" section (line 539) for consistency with other decks.

### Session 04: Data Transformation II
- [ ] **Code style section (lines ~408–466):** Multiple text-heavy slides listing spacing rules and naming conventions. Consider replacing with 2 before/after code examples — one messy, one clean — and letting the contrast teach the rules rather than listing them.

### Session 05: Data Tidying
- [x] **End-of-deck exercise section header color:** Changed from `#2c3e50` (dark blue) to `#e67e22` (orange) to match exercise convention.

### Session 06: Data Import
- [x] **"Where we are" tracker table opening:** Replaced with new opening in Section B.
- [ ] **End-of-deck exercise is conceptual, not code:** The "Get a head start: Assignment 3" section (line 350) asks students to think about questions rather than write code. Consider adding a small coding task (e.g., import a provided messy CSV and run `problems()` on it).

### Session 08: Perception & Design
- [x] **Incomplete TODO (lines 323–337):** Replaced placeholder with 3 actual bad graph examples using `reaction_data`: (1) truncated y-axis bar chart, (2) red-green boxplot with label-style title and clutter, (3) pie chart of binned continuous data. Each includes a reveal explaining the problems.

### Session 10: EDA — Covariation
- [x] **Recap slide is a full repeat:** Replaced with backward-link opening in Section B.

### Session 15: Storytelling with Data
- [ ] **"Boring or ineffective figures" section (lines ~386–393):** This is a bulleted list of problems. More powerful as actual examples — show a boring figure, then a compelling one with the same data. The deck already does this well with the cluttered-vs-decluttered comparison; extend the pattern here.
- [ ] **External image dependency (line 48):** The data storytelling triad loads from a Forbes URL. This could break. Save a local copy in `files/` or `slides/img/`.

### Session 16: Quarto
- [x] **Callback to Session 1 is now explicit:** Opening rewritten to: *"Remember Session 1? We opened this course with a striking finding: only 36% of psychology studies replicated..."* then connects directly to Quarto as part of the solution.

### Session 17: Practice & Review
- [x] **Section header rewritten:** "Today's plan" → "You already know more than you think" (Section D).
- [x] **"Questions?" slide replaced** with takeaway closing (Section A).
- [ ] **Opening checklist could still be stronger:** "Over 17 sessions, you've learned: [checklist]" is reflective but doesn't open with tension. Consider replacing with: *"You're two days from turning in your final project. Let's make sure you have every tool you need — and know what to do when something breaks."*

### Session 18: Putting It All Together
- [ ] **Opening recap slides (lines 41–78):** Three slides of "What you've learned" bullet lists. These are the weakest part of a strong deck. Consider replacing with a single slide showing the R4DS workflow diagram (already present at line 35) and one sentence: *"Ten weeks ago, you couldn't do any of this. Now you can do all of it."* The detailed list can be a handout or verbal.
- [ ] **Closing is strong — no changes needed.** The "You can learn hard things" callout and the learning journey curve are good rhetorical closes.

---

## Lower-priority polish

These are worth doing but less urgent than the items above.

- [ ] **Add breathing slides between dense code stretches.** Several decks (03, 04, 07, 11) have long runs of code slide → code slide → code slide. The rhetoric framework says the deck should "breathe" — a lighter conceptual or visual slide between dense technical ones. Identify spots where a quick "Why does this matter?" or psychology-motivation slide could break up the code.
- [ ] **Bullet slides that could be visual.** The rhetoric framework says bullets are "a confession of defeat." A few specific candidates:
  - Session 01, "Why R specifically?" (lines 109–116) → comparison table or visual
  - Session 08, "What to remove" / "What to keep" (lines 235–249) → before/after figure pair
  - Session 14, "Today's agenda" (lines 44–49) → delete entirely; agenda slides are flagged as a common failure
- [ ] **Consistent exercise header colors.** Most pair exercises use `{background-color="#e67e22"}` (orange). Verify all end-of-deck exercises also use orange consistently. Session 05's "Get a head start" uses dark blue.

---

## presentations/ folder consistency

- [ ] **`deck_generation_prompt.md` references Beamer/LaTeX throughout** but the course uses Quarto/Reveal.js. The entire document — including the LaTeX warnings section, the multi-agent review process targeting `.tex` compilation, and the example output structure showing `.tex`/`.sty` files — needs a Quarto-native version or a clear note that it was written for a different context.
- [ ] **`README.md` "Silent Killers" section** is about LaTeX hbox/vbox warnings. Not applicable to Quarto/Reveal.js HTML output. Should be revised or labeled as Beamer-specific.
- [ ] **The rhetoric principles themselves** (`rhetoric_of_decks.md`, `rhetoric_of_decks_full_essay.md`) are fully consistent with the course and don't need changes.
