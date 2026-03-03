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
- [ ] Create Canvas group sets (8–10 teams, populated after Session 1 survey)
- [ ] Create Canvas assignments for fun challenge group submissions (10 weekly, group submission enabled)
- [ ] Create Canvas assignments for pair coding submissions (~16 sessions, individual submission)
- [ ] Decide how to track pair coding completion by team (manual spreadsheet? Canvas analytics export?)
- [ ] Set up a tracking spreadsheet: columns for each point category, rows for each team, updated weekly

---

## Canvas Setup — General Course Infrastructure

### Gradebook & policies
- [ ] Set up gradebook categories and weights (Assignments 35%, Quizzes 15%, Participation 15%, Final Project 35%)
- [x] Configure late policy → 48-hour grace period, 10% daily penalty, applies to assignments and quizzes
- [x] Decide how to handle quiz grading → completion-based, no drop policy

### Assignments (8 total)
- [ ] Create all 8 assignment shells on Canvas
- [ ] Set due dates for each assignment (check schedule.qmd for dates)
- [ ] Upload assignment guidelines / rubrics for each
- [ ] Configure submission types (file upload? Quarto doc?)

### Quizzes (10 total — one per week, due Tuesday at 11:59 PM)
- [x] Create all 10 reading quiz shells on Canvas (one per week, Weeks 1–10)
- [x] Set due dates: each Tuesday at 11:59 PM (Tue Mar 31, Apr 7, Apr 14, Apr 21, Apr 28, May 5, May 12, May 19, May 26, Jun 2)
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
- [x] ~~Set drop policy~~ — removed; 48-hour late policy replaces drop policy

### Final Project (3 checkpoints + presentation)
- [ ] Create submission points for each project milestone
- [ ] Upload project guidelines and rubric
- [ ] Set milestone due dates

### Course pages & content
- [ ] Upload syllabus page
- [ ] Set up weekly modules (or topic-based modules)
- [ ] Upload schedule / calendar
- [ ] Upload handouts to Files (APA figure guidelines, etc.)
- [ ] Create or link to content pages for each session
- [ ] Add links to R4DS readings for each week
- [ ] Create first-day announcement

### Housekeeping
- [ ] Set course start/end dates
- [ ] Configure navigation menu (which pages are visible to students)
- [ ] Test student view to make sure everything looks right

---

## Syllabus Updates

- [x] Add team challenge description → added to `syllabus.qmd` and `slides/01-intro-setup.qmd`
- [x] Update quiz grading language to reflect completion-based grading → updated in `syllabus.qmd` and slides
- [x] Review grading breakdown — Participation 15% comes from individual pair coding submissions; challenge points are separate and don't affect grades
- [x] Add collaboration policy → discuss freely, write your own code
- [x] Add final project dataset requirements → real data, 20+ rows, no reuse from previous courses
- [x] Remove academic integrity placeholder → covered by university-wide policies
- [x] Add late work policy → 48-hour grace, 10% daily penalty

---

## Dependencies & Open Questions

- Final enrollment count determines number of teams (8–10)
- Survey must go out Session 1, teams announced Session 2
- Quizzes changing to completion-based is a grading policy change — make sure syllabus reflects it clearly
