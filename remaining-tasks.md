# PSY 410 — Remaining Tasks Before Spring 2026

Organized by category. Cross-referenced with `lecture-outline.md`, `assignments-planning.md`, and the current state of all course files.

**Legend:** `[ ]` = not started · `[~]` = partial/in progress · `[x]` = done

---

## 1. Slide Review & Polish

Decks 01–13 have been reviewed. Resume at deck 14.

| File | Session | Topic | Review | Speaker Notes |
|------|---------|-------|--------|---------------|
| `slides/01-intro-setup.qmd` | 1 | Introduction & Setup | `[x]` | `[ ]` |
| `slides/02-first-visualization.qmd` | 2 | First Visualization | `[x]` | `[ ]` |
| `slides/03-data-transformation-1.qmd` | 3 | Transformation I | `[x]` | `[ ]` |
| `slides/04-data-transformation-2.qmd` | 4 | Transformation II | `[x]` | `[ ]` |
| `slides/05-data-tidying.qmd` | 5 | Data Tidying | `[x]` | `[ ]` |
| `slides/06-data-import.qmd` | 6 | Data Import | `[x]` | `[ ]` |
| `slides/16-quarto.qmd` | 7 | Quarto & Reproducibility | `[x]` | `[ ]` |
| `slides/07-layers-aesthetics.qmd` | 8 | Layers & Aesthetics | `[x]` | `[ ]` |
| `slides/08-perception-design.qmd` | 9 | Perception & Design | `[x]` | `[ ]` |
| `slides/09-eda-variation.qmd` | 10 | EDA — Variation | `[x]` | `[ ]` |
| `slides/10-eda-covariation.qmd` | 11 | EDA — Covariation | `[x]` | `[ ]` |
| `slides/11-data-types.qmd` | 12 | Data Types Grab Bag | `[x]` | `[ ]` |
| `slides/12-strings-factors.qmd` | 13 | Strings, Factors & Text | `[x]` | `[ ]` |
| `slides/13-joins.qmd` | 14 | Joins | `[x]` | `[ ]` |
| `slides/14-missing-data.qmd` | 15 | Missing Data | `[ ]` | `[ ]` |
| `slides/15-storytelling.qmd` | 16 | Storytelling with Data | `[ ]` | `[ ]` |
| `slides/17-correlation-regression.qmd` | 17 | Correlation & Regression | `[ ]` | `[ ]` |
| `slides/18-putting-it-together.qmd` | 18 | Putting It All Together | `[ ]` | `[ ]` |

**Speaker notes note:** Should be detailed enough that a GE who knows R but hasn't seen the slides can step in with minimal notice. Include: the main point of each slide, what to say during live coding demos, what to watch for during pair exercises.

---

## 2. Reading Quizzes

9 quizzes total (no quiz before the first day of class), drop lowest 2. Administered on Canvas (Lockdown Browser, 10 min, 5–10 questions drawn randomly from a 50-question bank). Files live in `quizzes/`.

| Quiz | File | Reading | Due Before | Written |
|------|------|---------|------------|---------|
| Q1 | `quiz-01-data-visualization.txt` | R4DS Ch 1 (Data visualization) | Session 2 | `[x]` |
| Q2 | `quiz-02-transformation-1.txt` | R4DS Ch 3.1–3.4 (Transformation: rows & columns) | Session 3 | `[ ]` |
| Q3 | `quiz-03-transformation-2.txt` | R4DS Ch 3.5 + 4 (Transformation: groups; Code style) | Session 4 | `[ ]` |
| Q4 | `quiz-04-tidying.txt` | R4DS Ch 5 (Data tidying) | Session 5 | `[ ]` |
| Q5 | `quiz-05-import.txt` | R4DS Ch 7 + 20 (Import; Spreadsheets) | Session 6 | `[ ]` |
| Q6 | `quiz-06-layers.txt` | R4DS Ch 9 (Layers) | Session 8 | `[ ]` |
| Q7 | `quiz-07-eda.txt` | R4DS Ch 10 (EDA) | Session 10 | `[ ]` |
| Q8 | `quiz-08-data-types.txt` | R4DS Ch 12–14 + 16 (Logicals; Numbers; Strings; Factors) | Session 12 | `[ ]` |
| Q9 | `quiz-09-missing-joins.txt` | R4DS Ch 18–19 (Missing values; Joins) | Session 14 | `[ ]` |

Note: No quiz on Ch 28 (Quarto) — students practice it through A3. No quiz on Ch 11 (Communication) — covered via A8 and Session 16.

### text2qti format rules (learned the hard way)

- **Quiz title:** Use `Quiz title: Title here` on line 1 — NOT a markdown `#` heading
- **Code blocks:** Use 4-space indentation, NOT triple backticks (` ```r ` causes an error)
- **Question text + code:** The question (the sentence ending in `?`) must come **before** the code block — text2qti can't handle prose that follows an indented code block
- **Convert and import:** `text2qti quiz-NN-name.txt` → uploads the resulting `.zip` to Canvas via Settings → Import Course Content → QTI
- **Random selection:** In New Quizzes, add a "Random Set" from the Item Bank and set how many questions each student sees

---

## 3. Assignment Rubrics & Answer Keys

All 8 assignments exist and are polished. None have rubrics or answer keys yet.

| Assignment | Rubric | Answer Key |
|------------|--------|------------|
| A1: Getting Started | `[ ]` | `[ ]` |
| A2: Data Transformation | `[ ]` | `[ ]` |
| A3: Tidying, Import & Quarto | `[ ]` | `[ ]` |
| A4: Visualization Deep Dive | `[ ]` | `[ ]` |
| A5: EDA | `[ ]` | `[ ]` |
| A6: Data Types & Wrangling | `[ ]` | `[ ]` |
| A7: Joins & Missing Data | `[ ]` | `[ ]` |
| A8: Storytelling Report | `[ ]` | `[ ]` |

### Final Project Rubrics

| Milestone | Rubric | Notes |
|-----------|--------|-------|
| Proposal (M1) | `[ ]` | Approve dataset + research questions |
| Draft Analysis (M2) | `[ ]` | Working code, 2+ prelim figures |
| Final Report (M3) | `[~]` | Grading table already in `project/03-final-report.qmd` — needs full rubric doc |
| Presentation (M4) | `[ ]` | 5-min share-out rubric |

---

## 4. Data Files for Assignments

Several assignments reference "provided" datasets that need to be created or sourced and uploaded to Canvas.

| Assignment | Data Needed | Status |
|------------|-------------|--------|
| A2 | "Provided survey dataset" for scale score practice | `[ ]` |
| A3 | CSV file + Excel file to import (messy, realistic) | `[ ]` |
| A3 Grad | `survey_data.csv` + `demographics.xlsx` from shared Qualtrics survey | `[ ]` |
| A4 | Published psychology figure to recreate (+ source info) | `[ ]` |
| A6 | Set of open-ended survey responses for text analysis | `[ ]` |

---

## 5. Supplementary Readings (TBD in Lecture Outline)

| Session | Reading Status |
|---------|---------------|
| Session 9 | "Visual perception principles" listed as TBD — consider Franconeri et al. (2021) in *Psych Science in the Public Interest*, or a short excerpt from Cairo's *The Functional Art* |
| Session 17 | "Brief intro to correlation and regression in R" listed as TBD — consider excerpt from *ModernDive* (Ch 5) or *OpenIntro Statistics*; both are free online |

---

## 6. Pre-Semester Admin

| Task | Notes | Done |
|------|-------|------|
| Create shared Qualtrics practice survey | Needed for A3 graduate extension (`qualtRics` API). Confirm UO Qualtrics plan supports student API tokens. | `[ ]` |
| Post all data files to Canvas | See section 4 above | `[ ]` |
| Set up Canvas quiz shells | 10 quizzes, Lockdown Browser, 10 min. Set up the structure even before questions are written. | `[ ]` |
| Set up Canvas assignment shells | Confirm due dates, submission types (.qmd + .html), point values match rubrics | `[ ]` |
| Confirm `nycflights13`, `tidytext`, `broom`, `naniar`, `ggcorrplot`/`corrplot` on student package install list | Not part of tidyverse; easy to miss | `[ ]` |
| Prepare "Day 1" package install instructions | Students should install before first class if possible | `[ ]` |

---

## 7. Nice-to-Have (Lower Priority)

- `[ ]` **Overflow audit** — run overflow detection on decks 14–18 after rhetoric review is done
- `[ ]` **PDF exports of slides** — for students who want printable versions (policy: available on request)
- `[ ]` **Handout for Session 1** — only session without one; may not be needed (setup session)
- `[ ]` **Slide file renumbering** — file numbers diverge from session numbers starting at file 07 (documented in `MEMORY.md`). Low priority but could cause confusion. Consider renaming after semester.
- `[ ]` **Cronbach's alpha mention** — `psych::alpha()` in Session 12, flagged as possible scope addition in `lecture-outline.md`

---

## 8. Add resources

Add resources to the resources tab, including instructions for downloading and installing R and RStudio (maybe also Positron for those interested.
We can also add a summary of Gentzkow and Shapiro's rules for code and link to their handbook (https://web.stanford.edu/~gentzkow/research/CodeAndData.xhtml)
there's more we can add here too: posit especially has a lot of resources including a youtube series of interviews with people in the industry space

---


## Summary Counts

| Category | Not Started | In Progress | Done |
|----------|-------------|-------------|------|
| Slide review | 4 | 0 | 14 |
| Speaker notes | 18 | 0 | 0 |
| Quizzes | 10 | 0 | 0 |
| Assignment rubrics | 8 | 0 | 0 |
| Assignment answer keys | 8 | 0 | 0 |
| Project rubrics | 3 | 1 | 0 |
| Data files | 5 | 0 | 0 |
| Pre-semester admin | 6 | 0 | 0 |
