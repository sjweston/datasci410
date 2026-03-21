# Claude Project Rules — PSY 410: Data Science for Psychology

This file is the single source of truth for how to work on this course. Read it at the start of every session. Update it whenever something changes — decisions made, conventions established, scope shifts.

---

## Key documents to stay oriented

Always keep these in mind. If something we're about to do would conflict with any of them, flag it.

- **`lecture-outline.md`** — The master map of all 18 sessions: topics, key functions, readings, assignment timing. This is where we plan what goes into lectures. If a session doesn't have content here yet, check here before writing slides or content pages.
- **`syllabus.qmd`** — The student-facing contract. Learning objectives, grading weights, AI policy, assignment schedule. Don't change the scope of the course without updating this too.
- **`schedule.qmd`** — The student-facing timeline. Dates, what's due when, readings. Keep this in sync with lecture-outline.md.
- **`assignments-planning.md`** — Internal planning doc for assignments: task lists, in-class exercises, datasets, grading structure. The in-class exercises listed here should show up in the slides.
- **`graduate-student-assignments.md`** — Planning doc for grad student extensions. Currently the Qualtrics API extension on Assignment 3 is the priority. Add to this as we develop more extensions.
- **`team-challenge-planning.md`** — Design doc for the team-based competition system: team formation, point categories, reward structure, open questions.
- **`instructor-guide.md`** — Comprehensive operations manual for running the course: pre-term setup, weekly workflow, session-by-session guide, grading policies, team challenge operations, data pipeline, and end-of-term checklist.
- **`files/slide-design-principles.md`** — Rhetoric and design principles for slide decks (the Three Laws, Aristotle's modes, narrative structure, visual grammar, MB/MC equivalence, common failures). Reference this when creating or substantially revising any slide deck.

---

## Course at a glance

- **Who:** Undergraduate psychology majors (primary). Graduate students can enroll with additional assignment extensions.
- **What:** R + tidyverse for data science. Primarily visualization, transformation, tidying, reproducibility — plus a one-session intro to correlation and simple regression.
- **When:** Spring 2026, Mon/Wed 12:00–1:20 PM, 10 weeks, 18 sessions.
- **Tools:** R, RStudio, tidyverse, ggplot2, Quarto. All free.
- **Textbook:** R for Data Science (R4DS), 2nd ed. Free online. Plus optional Knaflic *Storytelling with Data*.
- **Grading:** Assignments 35%, Quizzes 15%, Participation 15%, Final Project 35%.

---

## Lecture and slide conventions

**Format:** Slides are Reveal.js built with Quarto (`.qmd` files in `slides/`). Content pages are in `content/`. Both use the same Quarto project but slides are excluded from the site build (`_quarto.yml` has `- "!slides/"`). Render slides individually or with a loop: `for f in slides/*.qmd; do quarto render "$f"; done`.

**Anti-copy-paste policy:** Slides should use `code-copy: false` in the YAML to remove the copy button from code blocks. We want students typing code, not copying it. PDF versions of slides should be exported for students who want them (use `quarto render --to pdf` or browser print-to-PDF).

**Slide structure — every deck should have two practice points:**
1. A **pair coding break** roughly mid-deck, marked with an orange section header (`{background-color="#e67e22"}`) and titled "Pair coding break." These are 10-minute partner exercises. The exercise should use only skills taught earlier in that same deck. Include a hidden solution block (`#| echo: false` + `#| eval: false`) so it can be revealed after time is up.
2. An **end-of-deck exercise** that serves as a head start on the upcoming assignment or a bridge to next session. These are individual and don't need to be finished in class. Also include a hidden solution.

The pair coding exercises should match what's listed in `assignments-planning.md` under "In-Class Exercise" for that session. If we write a new in-class exercise for the slides, update `assignments-planning.md` to match.

**Code in slides:** Global execute settings are `echo: true, eval: true` (with `warning: false, message: false`). Demo code that shouldn't run uses `#| eval: false`. Output goes on its own slide with `#| output-location: slide`. The setup chunk (loading packages) uses `#| include: false`.

**Tone:** Accessible and encouraging. These are undergrads learning to code for the first time. Errors are framed as normal and expected. Psychology examples are woven throughout — survey data, reaction times, scale scores, Qualtrics exports. Don't let it feel like a generic programming class.

**What not to lecture on:** See the "Things that are probably fine to skip" section in `lecture-outline.md`. Short version: no regex, no purrr, no git, no multiple regression or advanced statistics. Simple correlation and `lm()` are in scope (Session 17 only).

---

## Things we've decided (don't relitigate without a reason)

- **Session 1 was revised** (Feb 2026) to open with the replication crisis as motivation and expand file organization using the filing cabinet vs. laundry basket framing (inspired by Scott Cunningham's Gov 51). The old generic "Why data science?" opening was replaced.
- **Quarto moved to Session 7 (Week 4)** so students learn it early and use it for all assignments from A3 onward. Previously it was in Week 9 — too late for students to practice reproducible documents throughout the course.
- **Correlation & simple regression added as Session 17** — a one-session intro to `cor()` and `lm()`. This is a preview, not a stats unit. Motivated by comparison to Scott Cunningham's Gov 51 course at Harvard. Students should leave with a taste of modeling.
- **Old Sessions 17+18 (Practice & Review + Putting It All Together) consolidated** into one Session 18. Two full review sessions in a 10-week course was generous; the freed slot was used for the regression session.
- **Light text analysis added to Session 13** (Strings, Factors & Text). Uses `tidytext::unnest_tokens()` for tokenizing open-ended survey responses and word frequency counts. Natural extension of string skills, directly relevant to psych.
- **Data integrity/replication segment added to Session 16** (Storytelling). A ~15-minute section connecting back to Session 1's opening: the LaCour scandal, p-hacking, and how reproducible workflows help detect and prevent problems.
- **APA figure formatting** is a handout (`files/apa-figure-guidelines.md`), not a lecture topic. Journals have wiggle room; we don't want to spend class time on formatting rules. The handout is distributed in Session 16.
- **Critical evaluation of figures** (misleading figures, boring figures, the "so what?" test) is part of Session 16 (Storytelling with Data). It draws on Knaflic examples. It's in the lecture outline.
- **"How to lie with charts"** is covered under the critical evaluation section in Session 16. It's struck out in the Potential Additions list in lecture-outline.md.
- **Qualtrics API** is not covered in the main undergraduate course. It's an extension for graduate students on Assignment 3. See `graduate-student-assignments.md`.
- **nycflights13** needs to be installed — it's not part of tidyverse. If rendering slides 03 or 04 fails, this is probably why. It should be on whatever package list we give students.
- **tidytext** needs to be installed for Session 13 and Assignment 6. Add to the package list.
- **broom** needs to be installed for Session 17. Add to the package list.
- **Slide pair exercises match the planning doc.** We added mid-deck exercises to slides 02–05 that correspond to the in-class exercises in `assignments-planning.md`. Session 1 didn't need one (it's setup). Keep this alignment going for future decks.
- **Anti-copy-paste:** Slides use `code-copy: false` and CSS to discourage copy-paste. Students should type code to build muscle memory. PDF exports available for students who want them.
- **Team challenge adopted.** 8–10 teams of 5–6 students compete for points across four categories: pair coding completion, assignment submission, quiz performance (highest team average), and weekly fun challenges. Teams are formed via a day-1 survey (stats experience, coding experience, optional friend request) and balanced by prior experience. Teams stay the same all term (no mid-term reshuffle). Reward is non-grade (pizza party). See `team-challenge-planning.md` for full design. Materials in `files/team-challenge-handout.md`, `files/scoreboard.qmd`, and `files/fun-challenges/`.
- **Power Play in Week 7.** After the Week 7 scoreboard reveal (Session 13, Mon May 11), the top 2 teams each get a one-time choice: add +3 points to themselves, or remove -2 points from each of two other teams. Choices announced live. See `team-challenge-planning.md` for full rules.
- **Team challenge point values:** Pair coding = 1 pt, assignment submission = 1 pt, quiz performance = 1 pt (top 2 teams each earn a point), fun challenges = 2 pts each.
- **Quizzes use best-score grading.** 10 weekly quizzes, each pulling 5 random questions from a 50-question bank. Unlimited attempts; highest score counts. This gives students incentive to actually learn the material while keeping stakes low. Quiz scores also matter for the team challenge (top 2 teams by average each earn a point). Question banks are in `quizzes/` with QTI packages for Canvas import.
- **Due dates standardized to 11:59 PM the night before class.** Assignments are due at 11:59 PM the night before the class session where they're listed as "due" (typically Sundays for Monday sessions, Tuesdays for Wednesday sessions). Quizzes due Sundays at 11:59 PM (moved from Tuesdays so students can read after lecture without penalty). This replaced the earlier "before class" / "Monday" scheme.
- **Assignments assigned on Mondays for A3–A6** to give students 2 class sessions of instruction before the due date. A1–A2 are assigned Wednesdays (first week). A7–A8 are assigned Wednesdays (gap weeks make Monday assignment impossible). See the assignment schedule table below.
- **A3 is the first Quarto assignment.** It requires `.qmd` submission. All assignments from A3 onward are Quarto documents. A3 is assigned at Session 7 (the Quarto session) so students learn Quarto before they need it.
- **Speaker notes added to all 18 slide decks.** Notes cover what to emphasize, timing guidance, common student misconceptions, transition cues, and exercise management tips. Access them by pressing S in the browser during a Reveal.js presentation.
- **Late work policy: 48-hour grace period with 10% daily penalty.** Applies to both assignments and quizzes. After 48 hours, no submissions accepted. Final project milestones follow the same policy. Late submissions don't count toward the team challenge "on-time" points.
- **In-class check-in drops.** The 2 lowest in-class check-in scores are dropped, effectively allowing students to miss up to 2 classes with no grade penalty. No drops on assignments or quizzes — the late policy and retake policy handle those.
- **"Life happens" extension token.** Each student gets one free 48-hour extension on any assignment, no penalty, no questions asked. To use it, the student must email Sara within one week of the original due date (i.e., before the next assignment is due). Once the next assignment's due date has passed, the token can no longer be used for the earlier assignment. One token per student for the entire term.
- **Quizzes are points-based, not completion-based.** Students can retake as many times as they want; we always take the best score. This replaced an earlier completion-based policy. All references to "completion-based" quizzes in planning docs have been updated.
- **Final project presentation due Wed Jun 10** (finals week). 5-minute recorded video submitted to Canvas. Same 48-hour late policy applies.
- **Final project dataset minimum is 20 observations** (not 100). Lowered to accommodate students in neuro labs or other fields with small clinical samples.
- **Resource guides created.** Four step-by-step guides in `resource/`: `r-projects.qmd` (R Projects), `r-scripts.qmd` (R scripts for A1–A2), `quarto-docs.qmd` (Quarto docs for A3–A8), `common-errors.qmd` (common R error messages and fixes). Each assignment page links to the relevant guides via a tip callout. The resources sidebar also links to external cheatsheets (ggplot2, dplyr, tidyr, Quarto, RStudio IDE) and learning resources (R4DS, Posit Primers, Cédric Scherer's ggplot2 tutorial, Quarto getting started guide).
- **palmerpenguins** needs to be installed for Assignments 4 and 5. Add to the package list students receive.
- **Assignment schedule (canonical due dates):**

| Asgn | Assigned | Due |
|------|----------|-----|
| A1 | Wed Apr 1 (S2) | Sun Apr 5 |
| A2 | Wed Apr 8 (S4) | Sun Apr 12 |
| A3 | Mon Apr 20 (S7) | Sun Apr 26 |
| A4 | Mon Apr 27 (S9) | Sun May 3 |
| A5 | Mon May 4 (S11) | Sun May 10 |
| A6 | Mon May 11 (S13) | Sun May 17 |
| A7 | Wed May 13 (S14) | Sun May 24 |
| A8 | Wed May 27 (S16) | Sun May 31 |

Note: A6 is due May 17 (Sunday before the May 18 no-class Monday) and A7 is due May 24 (Sunday before Memorial Day). Earlier docs incorrectly listed May 18 and May 25.

- **Data files for A3** are in `files/data/`: `survey_data.csv` (messy CSV with "N/A" strings instead of blank, participant IDs 101–120) and `demographics.xlsx` (two sheets — Sheet 1 is a codebook, Sheet 2 has demographics for participants 101–118). Upload both to Canvas for students to download.

---

## Session-to-calendar mapping (quick reference)

| Session | Date | Topic |
|---------|------|-------|
| 1 | Mon Mar 30 | Introduction & Setup |
| 2 | Wed Apr 1 | Your First Visualization |
| 3 | Mon Apr 6 | Data Transformation I |
| 4 | Wed Apr 8 | Data Transformation II |
| 5 | Mon Apr 13 | Data Tidying |
| 6 | Wed Apr 15 | Data Import |
| 7 | Mon Apr 20 | Quarto & Reproducibility |
| 8 | Wed Apr 22 | Layers & Aesthetics |
| 9 | Mon Apr 27 | Perception & Design |
| 10 | Wed Apr 29 | EDA — Variation |
| 11 | Mon May 4 | EDA — Covariation |
| 12 | Wed May 6 | Data Types Grab Bag |
| 13 | Mon May 11 | Strings, Factors & Text |
| 14 | Wed May 13 | Joins |
| — | Mon May 18 | *No class* |
| 15 | Wed May 20 | Missing Data |
| — | Mon May 25 | *Memorial Day* |
| 16 | Wed May 27 | Storytelling with Data |
| 17 | Mon Jun 1 | Correlation & Simple Regression |
| 18 | Wed Jun 3 | Putting It All Together |
| — | Wed Jun 10 | *Finals Week: Video presentations due* |

---

## Graduate student layer

Graduate students take the same course but need additional or higher-level work to receive credit. We're tracking this in `graduate-student-assignments.md`. The guiding principle: extensions should be **practical and transferable**, not just harder for the sake of it. The Qualtrics API extension (Assignment 3) is the most developed idea so far. Add to that doc as we build out more extensions. Don't add grad extensions to the main assignment files — keep them separate and clearly marked.

---

## Accessibility (WCAG 2.1 AA)

The course website must comply with **WCAG 2.1 Level AA** by **April 24, 2026** (federal requirement for all UO web content). These rules apply to all new and modified content. The full audit is in `accessibility/accessibility-audit.md`.

**Every image needs alt text.** Markdown images use `![Alt text here](path)`. R code chunks that produce plots must include `#| fig-alt: "Description"`. The description should convey the key takeaway of the figure, not just name the chart type. Example:

```r
#| fig-alt: "Scatterplot of engine displacement vs highway mpg showing a negative relationship — larger engines get worse fuel economy"
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
```

**Color contrast must meet 4.5:1** for normal text and 3:1 for large text (18pt+ or 14pt+ bold). Check any new color combinations. The orange exercise backgrounds and text colors have been adjusted for compliance — don't revert them.

**Heading hierarchy:** Don't skip heading levels (e.g., H1 → H3 without H2). In Reveal.js slides, `#` = new slide title, `##` = content heading on a slide.

**Don't rely on color alone** to convey meaning. If color distinguishes items (e.g., "the red line vs. the blue line"), also use labels, patterns, or text.

**Link text must be descriptive.** No "click here" or bare URLs. Use `[descriptive text](url)`.

---

## File and naming conventions

- Slides: `slides/NN-topic.qmd` → renders to `slides/NN-topic.html`
- Content pages: `content/NN-content.qmd`
- Assignments: `assignment/NN-assignment.qmd`
- Resource guides: `resource/*.qmd` (R Projects, R Scripts, Quarto Docs)
- Static assets (images, handouts, bib files): `files/`
- Planning docs (internal, not student-facing): root directory, `.md` files (e.g., `lecture-outline.md`, `assignments-planning.md`, `graduate-student-assignments.md`)
- Student-facing site pages: root directory, `.qmd` files (e.g., `syllabus.qmd`, `schedule.qmd`)

---

## Obsidian vault

Course notes live at:
`/Users/sweston2/Library/Mobile Documents/iCloud~md~obsidian/Documents/brain/uo/03-teaching/data-science-410/`

The index file is `0-data-science-410.md`. Reference notes (e.g., `quarto-commands.md`) live alongside it in the same folder.

---

## What to update in this file

Add or revise entries here whenever:
- A new decision is made about course scope, format, or conventions
- We explicitly decide to skip or defer something
- A new file or document is created that future work should know about
- A package dependency is discovered
- Feedback from Sara changes the direction of something we were working on
