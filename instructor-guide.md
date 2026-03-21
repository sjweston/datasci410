# Instructor Guide — PSY 410/510: Data Science for Psychology

This document explains everything a new instructor needs to run this course from start to finish. It assumes familiarity with R, tidyverse, and university course administration, but no prior knowledge of this specific course's setup.

---

## Table of contents

1. [Course overview](#course-overview)
2. [Pre-term setup (2–4 weeks before)](#pre-term-setup)
3. [Week-by-week instructor workflow](#weekly-workflow)
4. [Session-by-session guide](#session-guide)
5. [Team challenge operations](#team-challenge)
6. [Assignments](#assignments)
7. [Quizzes](#quizzes)
8. [Final project](#final-project)
9. [Grading policies and edge cases](#grading-policies)
10. [Website and slides](#website-and-slides)
11. [Class survey data pipeline](#class-survey-data)
12. [Key files and directories](#key-files)
13. [TA responsibilities](#ta-responsibilities)
14. [Common student issues](#common-student-issues)
15. [Accessibility requirements](#accessibility)
16. [End-of-term checklist](#end-of-term)

---

## 1. Course overview <a name="course-overview"></a>

**Who:** ~45 undergraduate psychology/neuroscience majors (juniors/seniors), plus ~2 graduate students. No prior coding experience expected.

**What:** R + tidyverse for data science. Visualization, transformation, tidying, import, EDA, reproducibility, and a one-session intro to correlation and simple regression.

**When:** Spring term, Mon/Wed 12:00–1:20 PM, 10 weeks, 18 sessions.

**Where:** Gerlinger 242 (or update in `_variables.yml`).

**Philosophy:** Accessible, encouraging, psych-first. Errors are normal. Students type code (no copy-paste). Class data from an anonymous survey makes demos personal and engaging.

**Textbook:** R for Data Science (R4DS), 2nd ed. Free at [r4ds.hadley.nz](https://r4ds.hadley.nz/).

**Grading:** Assignments 35%, Quizzes 15%, Participation 15%, Final Project 35%. The team challenge is not part of grades.

---

## 2. Pre-term setup <a name="pre-term-setup"></a>

Complete these tasks 2–4 weeks before the first class.

### Canvas setup

- [ ] Create Canvas course shell (or copy from previous term)
- [ ] Import quiz QTI packages: Canvas → Settings → Import Course Content → upload each `.zip` from `quizzes/`. There are 10 quizzes, one per week.
- [ ] Configure quizzes: 5 random questions per attempt, unlimited attempts, best score counts, due Sundays at 11:59 PM
- [ ] Create 8 assignment submissions (Assignments 1–8) with due dates per the schedule below
- [ ] Create 17 in-class pair coding submissions (Sessions 2–18), completion-graded
- [ ] Create 10 fun challenge group assignments (one per week), due Sundays at 11:59 PM
- [ ] Create the Team Formation Survey as an **Ungraded Survey** in Canvas (see below for questions)
- [ ] Create a Canvas group set called "Team Challenge Teams" (leave empty until teams are formed)
- [ ] Upload data files to Canvas Files: `files/data/survey_data.csv` and `files/data/demographics.xlsx` (for Assignment 3)
- [ ] Upload the A4 figure and data file (from the published paper) to Canvas Files
- [ ] Post the printable syllabus PDF (`files/syllabus-print.pdf`)

### Team Formation Survey (Canvas Ungraded Survey)

**Q1:** Have you taken a statistics course?
- No
- Yes, at the introductory level (e.g., PSY 302)
- Yes, beyond the introductory level (e.g., regression, research methods)

**Q2:** Have you written code in any language (R, Python, MATLAB, etc.)?
- No, never
- A little — I've tried it but I'm still a beginner
- Yes — I'm comfortable writing basic code on my own

**Q3:** How comfortable are you with spreadsheets (Excel, Google Sheets)?
- Not at all — I rarely use them
- Somewhat — I can do things like sorting or simple formulas
- Very — I regularly use features like pivot tables or complex formulas

**Q4 (optional, short answer):** Is there someone in this class you'd like to be on a team with? Enter their name below.

**Settings:** Available from Day 1, due Wednesday of Week 1 at 11:59 PM. No anonymous submissions (you need names).

### Qualtrics fun survey

Build the anonymous class survey in Qualtrics. This is optional for students and used for in-class demos throughout the term. Survey design details are in `CLAUDE.md` under the Qualtrics section. Key points:

- 14 questions (demographics, daily habits, coding attitudes, personality, one open-ended)
- Set export tags to match variable names in `qualtrics_config.R`
- Add a completion code at the end (e.g., "OCTOPUS") that students enter on Canvas for team points
- Custom CSS to match the course site is documented in the planning docs
- After students complete it, run `scripts/clean-class-survey.R` to pull and clean the data

### Qualtrics API credentials

Your API key and survey ID go in `qualtrics_config.R` (this file is gitignored and never committed):

```r
library(qualtRics)
qualtrics_api_credentials(
  api_key  = "YOUR_KEY_HERE",
  base_url = "oregon.yul1.qualtrics.com"
)
SURVEY_ID_WEEK1 <- "YOUR_SURVEY_ID_HERE"
```

Find your API key at: Qualtrics → Account Settings → Qualtrics IDs → API Token.

### Website

- Update `_variables.yml` with your name, email, office, dates, CRN, etc.
- Update dates in all 18 slide decks (the `date:` field in each YAML header)
- Update dates in `schedule.qmd` if the calendar changes
- Render the site: `quarto render`
- Deploy to your hosting (the site builds to `_site/`)

### Software

Ensure you have installed:
- R (latest version)
- RStudio
- Quarto CLI
- R packages: `tidyverse`, `nycflights13`, `palmerpenguins`, `tidytext`, `broom`, `quarto`, `ggrain`, `ggforce`, `patchwork`, `psych`, `qualtRics`

### Pre-term announcement

Send a Canvas announcement the week before classes start:
- Welcome students
- Link to syllabus on the course website
- Link to R and RStudio installation instructions (`/resource/installation.qmd` on the site)
- Ask students to bring laptops (or contact you if they don't have one)
- Link to the Team Formation Survey (Canvas) and Fun Survey (Qualtrics)
- Deadline: both surveys due before Wednesday of Week 1

---

## 3. Week-by-week instructor workflow <a name="weekly-workflow"></a>

### Before each Monday class

1. **Update the scoreboard:** Export Canvas gradebook → save as `data/canvas_gradebook.csv` → run `source("scripts/update-team-points.R")` → copy the printed `tribble()` code into `files/scoreboard.qmd` → render: `quarto render files/scoreboard.qmd`
2. **Review slides:** Open the slide deck for today's session. Press `S` to read the speaker notes. Note any timing guidance.
3. **Check Canvas:** Make sure any new assignments or quizzes are published and visible.

### During each class

1. **Show scoreboard** (Mondays): Open `files/scoreboard.html` in the browser. Show standings, announce any fun challenge results.
2. **Present slides:** Open `slides/NN-topic.html` in the browser. Press `S` for presenter view with notes.
3. **Pair coding break (~halfway):** Set a 10-minute timer. Circulate and help. Students submit code on Canvas for participation.
4. **End-of-deck exercise (~last 10 min):** Students start the next assignment or do a bridge exercise.

### After each Wednesday class

1. **Grade pair coding submissions:** Completion-based — if something was submitted, full credit. Can be delegated to TA.
2. **Post any new materials:** Upload fun challenge instructions, data files, etc.
3. **Check quiz submissions:** Spot-check that the quiz is working correctly (especially Weeks 1–2).

### Weekend

1. **Grade assignments:** Use the rubric. TA can handle first pass.
2. **Check for late submissions:** Apply 10% per day penalty for anything in the 48-hour window.
3. **Monitor email:** Watch for "life happens" extension requests.

---

## 4. Session-by-session guide <a name="session-guide"></a>

| Session | Date | Topic | Slide file | Key prep |
|---------|------|-------|-----------|----------|
| 1 | Mon Mar 30 | Introduction & Setup | `01-intro-setup.qmd` | Print syllabus copies; have installation guide URL ready |
| 2 | Wed Apr 1 | Your First Visualization | `02-first-visualization.qmd` | Announce teams (run `scripts/team-sort.R` after survey closes); distribute team handout (`files/team-challenge-handout.md`); assign A1 |
| 3 | Mon Apr 6 | Data Transformation I | `03-data-transformation-1.qmd` | Scoreboard reveal (first one); install `nycflights13` if needed |
| 4 | Wed Apr 8 | Data Transformation II | `04-data-transformation-2.qmd` | Assign A2 |
| 5 | Mon Apr 13 | Data Tidying | `05-data-tidying.qmd` | Scoreboard |
| 6 | Wed Apr 15 | Data Import | `06-data-import.qmd` | Ensure A3 data files are on Canvas |
| 7 | Mon Apr 20 | Quarto & Reproducibility | `07-quarto.qmd` | Assign A3 |
| 8 | Wed Apr 22 | Layers & Aesthetics | `08-layers-aesthetics.qmd` | |
| 9 | Mon Apr 27 | Perception & Design | `09-perception-design.qmd` | Scoreboard; assign A4; ensure A4 figure + data on Canvas |
| 10 | Wed Apr 29 | EDA — Variation | `10-eda-variation.qmd` | Class survey data used — run `scripts/clean-class-survey.R` if not done yet |
| 11 | Mon May 4 | EDA — Covariation | `11-eda-covariation.qmd` | Scoreboard; assign A5; class survey data used |
| 12 | Wed May 6 | Data Types Grab Bag | `12-data-types.qmd` | |
| 13 | Mon May 11 | Strings, Factors & Text | `13-strings-factors.qmd` | Scoreboard + **Power Play** (top 2 teams choose boost or sabotage); assign A6; class survey `data_words` used for text analysis |
| 14 | Wed May 13 | Joins | `14-joins.qmd` | Assign A7 |
| — | Mon May 18 | *No class* | — | — |
| 15 | Wed May 20 | Missing Data | `15-missing-data.qmd` | |
| — | Mon May 25 | *Memorial Day* | — | — |
| 16 | Wed May 27 | Storytelling with Data | `16-storytelling.qmd` | Assign A8; distribute APA figure handout (`files/apa-figure-guidelines.md`) |
| 17 | Mon Jun 1 | Correlation & Simple Regression | `17-correlation-regression.qmd` | Scoreboard; class survey data used for live correlation/regression demos |
| 18 | Wed Jun 3 | Putting It All Together | `18-putting-it-together.qmd` | Final scoreboard; announce winning team; celebrate |
| — | Wed Jun 10 | *Finals week* | — | Video presentations due on Canvas |

### Slide file numbering

Slide file numbers now match session numbers (e.g., `07-quarto.qmd` = Session 7). The renumbering was completed in March 2026.

---

## 5. Team challenge operations <a name="team-challenge"></a>

### Forming teams (Week 1)

1. Team Formation Survey closes Wednesday of Week 1 at 11:59 PM
2. Export results from Canvas: Quiz → Quiz Statistics → Student Analysis → Download CSV
3. Save as `data/team-formation-survey.csv`
4. Run `source("scripts/team-sort.R")`
5. Review output — check that friend pairs were honored and experience is balanced
6. Save roster output (`data/team_rosters.csv`)
7. Announce teams in Session 2. Distribute the team challenge handout.
8. Create Canvas groups matching the team assignments

### Scoring (weekly)

Run `source("scripts/update-team-points.R")` before each Monday. The script reads the Canvas gradebook export and computes points automatically. See the script header for detailed instructions.

**Point values:**
- Pair coding completion: 1 pt per session (team earns it if all-but-one members submitted)
- Assignment submission: 1 pt per assignment (same threshold)
- Quiz performance: 1 pt (top 2 teams by average score each earn a point per quiz)
- Fun challenge: 2 pts each (group submission — any member submitting counts)

### Scoreboard

Update `files/scoreboard.qmd` with the output from the scoring script, then render:
```bash
quarto render files/scoreboard.qmd
```
Open `files/scoreboard.html` in the browser at the start of each Monday session.

After Session 2, update the `team_names` vector in `scripts/update-team-points.R` and the `scoreboard` tribble in `files/scoreboard.qmd` with the names students chose.

### Power Play (Session 13, Mon May 11)

After showing the Week 7 scoreboard, the top 2 teams each choose one option:
- **Boost:** +3 points to their own team
- **Sabotage:** Remove 2 points from each of two other teams

First place picks first. Choices are final. Teams can't go below 0. Update the scoreboard immediately.

### Fun challenges

Materials are in `files/fun-challenges/`. One per week, due Sundays at 11:59 PM. Group submission — one member submits for the team. No late submissions on fun challenges (unlike assignments).

| Week | Challenge | Materials |
|------|-----------|-----------|
| 1 | Team Bio | (No materials — icebreaker) |
| 2 | Code Prediction | `02-code-prediction.md` |
| 3 | Data Transformation Relay | `03-relay-data.csv` |
| 4 | Bug Hunt | `04-bug-hunt.R`, `04-bug-hunt-data.csv` |
| 5 | Plot Makeover | `05-plot-makeover.R`, `05-makeover-data.csv` |
| 6 | Data Detective | `06-data-detective.csv` |
| 7 | R Trivia | `07-r-trivia.md` |
| 8 | Missing Data Mystery | `08-missing-mystery.csv` |
| 9 | Figure Courtroom | `09-figure-courtroom/` |
| 10 | The Final Prediction | `10-prediction.png` |

### Reward

The winning team gets a non-grade reward (pizza party or equivalent). Budget and logistics are up to you. Announce the winner in Session 18.

---

## 6. Assignments <a name="assignments"></a>

### Schedule

| Asgn | Assigned | Due | Topic | Format |
|------|----------|-----|-------|--------|
| A1 | Wed Apr 1 (S2) | Sun Apr 5 | RStudio, ggplot2 basics | `.R` script |
| A2 | Wed Apr 8 (S4) | Sun Apr 12 | dplyr verbs, pipe | `.R` script |
| A3 | Mon Apr 20 (S7) | Sun Apr 26 | Tidying & import | `.qmd` + rendered HTML |
| A4 | Mon Apr 27 (S9) | Sun May 3 | Visualization deep dive | `.qmd` + rendered HTML |
| A5 | Mon May 4 (S11) | Sun May 10 | EDA | `.qmd` + rendered HTML |
| A6 | Mon May 11 (S13) | Sun May 17 | Data types, strings, factors | `.qmd` + rendered HTML |
| A7 | Wed May 13 (S14) | Sun May 24 | Joins & missing data | `.qmd` + rendered HTML |
| A8 | Wed May 27 (S16) | Sun May 31 | Reproducible report | `.qmd` + rendered HTML |

- A1–A2 are R scripts. A3–A8 are Quarto documents (`.qmd` submission required).
- A3 requires external data files (`survey_data.csv` and `demographics.xlsx`) uploaded to Canvas.
- A4 requires a published figure and dataset uploaded to Canvas.
- All other assignments use built-in R packages (tidyverse, nycflights13, palmerpenguins, psych::bfi).

### Data files to upload to Canvas

| Assignment | File(s) | Location in repo |
|------------|---------|------------------|
| A3 | `survey_data.csv`, `demographics.xlsx` | `files/data/` |
| A4 | Published figure PDF + dataset CSV | You supply these |

### Grading

Create rubrics in Canvas SpeedGrader. No rubric templates exist in this repo — build them based on the assignment requirements. General approach: allocate points per task, deduct for errors that show misunderstanding (not typos).

### Graduate student extensions

Graduate students (PSY 510) complete the same assignments plus extensions documented in `graduate-student-assignments.md`. Currently the main extension is a Qualtrics API task on Assignment 3. Keep grad extensions separate from the main assignment pages.

---

## 7. Quizzes <a name="quizzes"></a>

- **10 weekly quizzes**, one per week, due Sundays at 11:59 PM
- Each quiz pulls **5 random questions** from a question bank
- **Unlimited attempts**, best score counts
- Question banks are in `quizzes/` as both `.txt` (human-readable) and `.zip` (QTI for Canvas import)
- Import QTI packages via Canvas → Settings → Import Course Content
- Quizzes also feed the team challenge: top 2 teams by average score each earn a point

---

## 8. Final project <a name="final-project"></a>

### Milestones

| Milestone | Due | What students submit |
|-----------|-----|---------------------|
| Proposal | Wed Apr 29 | Dataset choice, 2–3 research questions, planned visualizations |
| Draft | Wed May 20 | Working code, 2+ preliminary figures |
| Final Report | Wed Jun 3 | Polished Quarto report |
| Presentation | Wed Jun 10 | 5-minute recorded video on Canvas |

### Requirements

- Real dataset (not simulated), minimum 20 observations
- Cannot reuse a dataset from another course
- Final report must be a Quarto document with code, output, and narrative
- Same 48-hour late policy applies to all milestones

### Suggested datasets

Students can use `palmerpenguins`, `psych::bfi`, `nycflights13`, or find their own. Encourage students in research labs to use their own lab data.

---

## 9. Grading policies and edge cases <a name="grading-policies"></a>

### Late work

- **48-hour grace period** with 10% penalty per calendar day
- After 48 hours, no submissions accepted
- Applies to assignments, quizzes, and final project milestones
- Does **not** apply to fun challenges (no late submissions)

### "Life happens" extension

- Each student gets **one free 48-hour extension**, no penalty, no questions asked
- Student must email you within one week of the original due date
- Once the *next* assignment's due date has passed, the token can no longer be used for the earlier assignment
- One token per student for the entire term

### In-class participation

- Completion-based (submitted = full credit)
- **2 lowest scores dropped** — effectively allows 2 absences without penalty
- Late pair coding submissions don't count toward team challenge points

### Quizzes

- Points-based, not completion-based
- Unlimited retakes, best score counts
- Late submissions within 48 hours get the daily penalty; after that, no credit

---

## 10. Website and slides <a name="website-and-slides"></a>

### Rendering the site

```bash
quarto render
```

This builds everything in `_site/`. Slides are excluded from the site build (configured in `_quarto.yml`) but their pre-rendered HTML files are included as static resources.

### Rendering slides

Slides must be rendered individually:

```bash
# One deck
quarto render slides/02-first-visualization.qmd

# All decks
for f in slides/*.qmd; do quarto render "$f"; done
```

### Rendering slides to PDF

For students who want printable versions:

```bash
# Using Quarto's built-in PDF export (requires Chrome/Chromium)
quarto render slides/02-first-visualization.qmd --to pdf

# Or open the HTML in a browser and print to PDF (Cmd+P / Ctrl+P)
```

### Presenter view

During class, open the slide HTML in a browser and press `S` to open the presenter view with speaker notes, timer, and next-slide preview. All 18 decks have speaker notes.

### Anti-copy-paste

All slide decks use `code-copy: false` in their YAML header to remove the copy button from code blocks. This is intentional — students learn better by typing code. Provide PDF exports for students who want to reference code outside of class.

### Updating course info

Edit `_variables.yml` to change instructor name, email, office, course dates, CRN, etc. These variables are used throughout the site via `{{< var instructor.name >}}` shortcodes.

---

## 11. Class survey data pipeline <a name="class-survey-data"></a>

An anonymous Qualtrics survey is administered in Week 1. The data is used in lecture demos throughout the term (Sessions 2, 10, 11, 13, 17).

### Setup (once)

1. Build the survey in Qualtrics with the variable names documented in `qualtrics_config.R`
2. Add your API key and survey ID to `qualtrics_config.R`
3. After students complete the survey, run `scripts/clean-class-survey.R`
4. This pulls data from the Qualtrics API, cleans it, and saves to `data/class_survey.csv`

### Updating with real data

After Week 1, re-run the cleaning script to replace test data with real responses:

```bash
Rscript scripts/clean-class-survey.R
```

Then re-render any slides that use class data:

```bash
quarto render slides/02-first-visualization.qmd
quarto render slides/10-eda-variation.qmd
quarto render slides/11-eda-covariation.qmd
quarto render slides/13-strings-factors.qmd
quarto render slides/17-correlation-regression.qmd
```

### Variables collected

| Variable | Type | Used in |
|----------|------|---------|
| `major` | categorical | — |
| `year` | categorical | — |
| `chronotype` | categorical | Sessions 10, 11 |
| `sleep_hrs` | numeric | Sessions 10, 17 |
| `caffeine_per_day` | numeric | Session 11 |
| `social_media_hrs` | numeric | — |
| `tabs_open` | numeric | Sessions 2, 10 |
| `stress` | numeric (1–10) | Sessions 11, 17 |
| `coding_excited` | numeric (1–10) | Session 11 |
| `coding_anxious` | numeric (1–10) | Session 11 |
| `personality_neur` | numeric (1–10) | Session 17 |
| `personality_extra` | numeric (1–10) | Session 17 |
| `personality_consc` | numeric (1–10) | Session 17 |
| `data_words` | text | Session 13 |

---

## 12. Key files and directories <a name="key-files"></a>

### Student-facing (on the website)

| Path | Purpose |
|------|---------|
| `syllabus.qmd` | Syllabus page |
| `schedule.qmd` | Session-by-session schedule with dates and readings |
| `content/NN-content.qmd` | Content page per session (readings, slides, tasks) |
| `assignment/NN-assignment.qmd` | Assignment instructions |
| `project/NN-milestone.qmd` | Final project milestone instructions |
| `resource/installation.qmd` | R/RStudio installation guide |
| `resource/r-projects.qmd` | R Projects guide |
| `resource/r-scripts.qmd` | R scripts guide (A1–A2) |
| `resource/quarto-docs.qmd` | Quarto documents guide (A3–A8) |
| `resource/common-errors.qmd` | Common R error messages and fixes |

### Instructor-only (not on the website)

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Master project rules — decisions, conventions, scope |
| `lecture-outline.md` | Session-by-session topic map with readings and timing |
| `assignments-planning.md` | Internal assignment planning with in-class exercises |
| `graduate-student-assignments.md` | Grad student extensions |
| `team-challenge-planning.md` | Team challenge design and rules |
| `instructor-guide.md` | This document |
| `files/slide-design-principles.md` | Rhetoric and design principles for slide decks |

### Slides

| Path | Purpose |
|------|---------|
| `slides/NN-topic.qmd` | Reveal.js slide decks (18 total) |
| `slides/custom.scss` | Slide theme customization |
| `files/scoreboard.qmd` | Team challenge scoreboard (update weekly) |

### Scripts

| Path | Purpose |
|------|---------|
| `scripts/team-sort.R` | Sorts students into balanced teams from survey data |
| `scripts/update-team-points.R` | Computes team points from Canvas gradebook export |
| `scripts/clean-class-survey.R` | Pulls and cleans Qualtrics survey data |
| `qualtrics_config.R` | API credentials (gitignored) |

### Data (all gitignored — contains student info)

| Path | Purpose |
|------|---------|
| `data/team-formation-survey.csv` | Raw survey responses with student names |
| `data/team_rosters.csv` | Student → team mapping |
| `data/canvas_gradebook.csv` | Canvas grade export |
| `data/team_points.csv` | Computed team points |
| `data/class_survey.csv` | Cleaned anonymous survey for lecture demos |

### Static assets

| Path | Purpose |
|------|---------|
| `files/data/` | Assignment data files for students |
| `files/fun-challenges/` | Fun challenge materials (10 weeks) |
| `files/apa-figure-guidelines.md` | APA figure formatting handout |
| `files/team-challenge-handout.md` | Student-facing team challenge rules |
| `files/syllabus-print.pdf` | Printable syllabus |
| `quizzes/` | Quiz question banks (`.txt`) and QTI packages (`.zip`) |

---

## 13. TA responsibilities <a name="ta-responsibilities"></a>

The TA (currently Amala Someshwar, `asomeshw@uoregon.edu`) handles:

- **Grading pair coding submissions:** Completion check — if something was submitted, full credit. ~17 sessions × ~45 students, but it's binary.
- **First-pass assignment grading:** Grade using the rubric, flag anything unclear for the instructor.
- **Office hours:** Hold regular office hours for coding help.
- **Monitoring discussion forum:** Answer student questions about R, assignments, and course logistics.
- **Fun challenge grading:** Completion check — submitted = points earned.

The instructor handles:
- Final project grading (all milestones)
- Grade disputes
- Extension requests
- Any academic integrity issues

---

## 14. Common student issues <a name="common-student-issues"></a>

| Issue | Solution |
|-------|----------|
| "R won't install" | Direct to `resource/installation.qmd`. Most issues are Mac Command Line Tools or Windows Rtools warnings. |
| "My code worked yesterday but not today" | They probably didn't load packages. Remind them: `install.packages()` once, `library()` every session. |
| "`could not find function`" error | They forgot `library(tidyverse)` or need to install the package. |
| "I can't find my file" | They're not using an R Project, or the file isn't in the project folder. Direct to `resource/r-projects.qmd`. |
| Quarto won't render | Check for unclosed code chunks, missing YAML header, or errors in code that stop execution. |
| "The plot looks different from yours" | `set.seed()` — simulated data varies. Their plot being different is fine if the structure is right. |
| Student needs a laptop | UO Libraries lends laptops. Or use Posit Cloud (free tier). |
| Student wants to use Python instead | No. The course is R-based. Everything is designed around tidyverse. |
| Grad student asks about the extension | Direct to `graduate-student-assignments.md`. They need a Qualtrics API token from their UO account. |

---

## 15. Accessibility requirements <a name="accessibility"></a>

The course website must comply with **WCAG 2.1 Level AA** (federal requirement for all UO web content, deadline April 24, 2026). Key rules:

- Every image needs alt text (`![Alt text](path)` for Markdown, `#| fig-alt:` for code chunks)
- Color contrast must meet 4.5:1 for normal text, 3:1 for large text
- Don't skip heading levels
- Don't rely on color alone to convey meaning
- Link text must be descriptive (no "click here")

The full audit is in `accessibility/accessibility-audit.md`. All current slide decks have alt text and meet contrast requirements.

---

## 16. End-of-term checklist <a name="end-of-term"></a>

### Finals week (Wed Jun 10)

- [ ] Collect video presentations on Canvas
- [ ] Grade final reports and presentations
- [ ] Announce team challenge winner in Session 18 (or via Canvas if after the last class)
- [ ] Celebrate winning team (pizza or equivalent)
- [ ] Submit final grades to registrar

### After the term

- [ ] Archive Canvas course
- [ ] Update `CLAUDE.md` with any decisions made during the term
- [ ] Note what worked and what to change in a post-mortem (consider adding to this guide)
- [ ] If re-running the course: update dates in `_variables.yml`, `schedule.qmd`, and all 18 slide YAML headers
- [ ] Regenerate the Qualtrics survey (or reset it) for new responses
- [ ] Clear `data/` files (student data from the old term)
