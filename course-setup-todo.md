# Course Setup To-Do List

Master to-do list for getting PSY 410 ready on Canvas and implementing the team challenge. Internal only.

---

## Team Challenge Setup

### Before the term starts
- [x] Finalize day-1 survey questions and choose platform → Canvas ungraded survey (`files/team-formation-survey.md`)
- [x] Write the R script for team sorting → `scripts/team-sort.R` (tested with 25 fake students)
- [x] Design scoreboard slide template → `files/scoreboard.qmd` (horizontal bar chart + breakdown table, update the tribble each week)
- [x] Write student-facing explanation of the team challenge → `files/team-challenge-handout.md` (rules, point categories, FAQ — distribute Session 2)
- [x] Design all 10 weekly fun challenges → detailed in `team-challenge-planning.md` (icebreaker, code prediction, relay, bug hunt, plot makeover, data detective, trivia, missing data mystery, figure courtroom, final prediction)
- [x] Create fun challenge materials → `files/fun-challenges/` (all 10 challenges have instruction docs + datasets/code/images)
- [ ] Plan reward logistics (pizza pub, budget, timing — last day of class?)

### Canvas setup for the challenge
- [x] Create Canvas group set → "Team Challenge Teams" (empty shell, populate after Session 1 survey)
- [x] Create Canvas assignments for fun challenge group submissions → 10 weekly, group submission via "Team Challenge Teams" group set, in "Team Challenges" assignment group (0% weight)
- [x] Create Canvas assignments for pair coding submissions → 17 sessions (Sessions 2–18), individual, in "In-Class Check-ins" assignment group (15% weight)
- [ ] Decide how to track pair coding completion by team (manual spreadsheet? Canvas analytics export?)
- [ ] Set up a tracking spreadsheet: columns for each point category, rows for each team, updated weekly

---

## Canvas Setup — General Course Infrastructure

### Gradebook & policies
- [x] Set up gradebook categories and weights → Assignments 35%, Reading Quizzes 15%, In-Class Check-ins 15%, Project 35%, Team Challenges 0%. Weighted grading enabled.
- [x] Configure late policy → 48-hour grace period, 10% daily penalty, applies to assignments and quizzes
- [x] Decide how to handle quiz grading → points-based, unlimited retakes, best score counts

### Assignments (8 total)
- [x] Create all 8 assignment shells on Canvas (due dates and submission types configured)
- [x] Create rubrics for each assignment

### Quizzes (10 total — one per week, due Sunday at 11:59 PM)
- [x] Create all 10 reading quiz shells on Canvas (one per week, Weeks 1–10)
- [x] Set due dates: each Sunday at 11:59 PM (Sun Apr 5, Apr 12, Apr 19, Apr 26, May 3, May 10, May 17, May 24, May 31, Jun 7)
- [x] Configure quiz settings — best score (unlimited attempts, 5 random questions from bank, highest score counts)
- [x] Build question bank for each quiz → `quizzes/` directory, 50 MC questions per quiz + QTI packages (.zip) for Canvas import
  - [x] Quiz 1: R4DS Ch 1, 2, 6 (85 questions — expanded from original 50)
  - [x] Quiz 2: R4DS Ch 3, 4
  - [x] Quiz 3: R4DS Ch 5, 7, 20
  - [x] Quiz 4: R4DS Ch 28, 9
  - [x] Quiz 5: R4DS Ch 10 (§10.1–10.4), perception
  - [x] Quiz 6: R4DS Ch 10 (§10.5–10.6), Ch 12, 13
  - [x] Quiz 7: R4DS Ch 14, 16, 19
  - [x] Quiz 8: R4DS Ch 18
  - [x] Quiz 9: R4DS Ch 11
  - [x] Quiz 10: R4DS Ch 8, correlation & regression
- [x] ~~Set drop policy~~ — no drops on assignments or quizzes; 2 lowest in-class check-in scores dropped; "life happens" extension token added

### Final Project (3 checkpoints + presentation)
- [x] Create submission points for each project milestone (due dates configured)
- [x] Create rubrics for each project milestone

### Course pages & content
- [x] Upload syllabus page
- [x] Set up weekly modules → 10 modules (Week 1–10), unpublished, ready to populate with content links
- [x] Upload schedule / calendar
- [x] Upload handouts to Files (APA figure guidelines, etc.)
- [x] Create or link to content pages for each session
- [x] Add links to R4DS readings for each week
- [x] Create first-day announcement → scheduled for Mar 27 at 9:00 AM (Thu before first class)

### Housekeeping
- [x] Set course start/end dates (set by admin)
- [x] ~~Configure navigation menu~~ — skipped; not needed
- [x] Test student view to make sure everything looks right

---

## Syllabus Updates

- [x] Add team challenge description → added to `syllabus.qmd` and `slides/01-intro-setup.qmd`
- [x] Update quiz grading language → points-based (unlimited retakes, best score counts), updated in `syllabus.qmd` and slides
- [x] Review grading breakdown — Participation 15% comes from individual pair coding submissions; challenge points are separate and don't affect grades
- [x] Add collaboration policy → discuss freely, write your own code
- [x] Add final project dataset requirements → real data, 20+ rows, no reuse from previous courses
- [x] Remove academic integrity placeholder → covered by university-wide policies
- [x] Add late work policy → 48-hour grace, 10% daily penalty

---

## Slide Materials

- [x] Add detailed speaker notes to all 18 slide decks — completed March 2026

---

## For-Fun Survey (class dataset)

- [ ] Finish building the for-fun survey (Qualtrics)
- [ ] Put the survey on Canvas and the course website
- [ ] Plan how to incorporate the survey data into lectures (which sessions reference it, how it's introduced)
- [ ] Write R script to scrape (qualtRics package) and clean the survey data
- [ ] Upload cleaned dataset to `files/data/` and reference it in relevant slide decks / assignments

---

## Syllabus PDF

- [ ] Create a PDF version of the syllabus

---

## Dependencies & Open Questions

- Final enrollment count determines number of teams (8–10)
- Survey must go out Session 1, teams announced Session 2
- ~~Quizzes changing to completion-based~~ — resolved; quizzes are points-based with unlimited retakes, syllabus updated
