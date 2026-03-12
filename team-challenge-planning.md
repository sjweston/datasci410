# Team Challenge — Planning Document

Internal planning doc for the team-based competition system. Not student-facing.

---

## Design Summary

Students are assigned to **8–10 teams of 5–6 students** at the start of the term. Teams earn points across four categories throughout the term. A scoreboard is shown at the start of each week. The winning team earns a non-grade reward (pizza party or similar).

**Motivation:** Draws on minimal group paradigm research — even arbitrary group formation creates in-group preference and motivation. Goal is to increase engagement, participation, and peer accountability without adding grade pressure.

---

## Team Formation

Teams are formed using a **day-1 survey** administered in Session 1. Teams are announced in Session 2.

### Survey Questions

1. Have you taken a statistics course? (No / Yes, intro level / Yes, beyond intro)
2. Have you written code in any language? (No / A little / Yes, regularly)
3. (Optional) Is there someone in this class you'd like to be on a team with? *(Name one person)*

### Sorting Algorithm

1. Honor friend-pair requests first (guarantee one request per student, not mutual placement of entire friend clusters)
2. Balance teams by prior experience (distribute stats + coding experience evenly)
3. Fill remaining spots to even out team sizes

A script will handle the sorting. Input: survey responses. Output: team rosters.

---

## Point Categories

| Category | Points | How earned | How tracked | Frequency |
|----------|--------|-----------|-------------|-----------|
| Pair coding completion | 1 | All (or all but one) team members submit on Canvas | Individual Canvas submissions (same ones used for the 15% participation grade) | ~16 sessions |
| Assignment submission | 1 | All team members submit on time | Individual Canvas submissions, check timestamps | 8 assignments |
| Quiz performance | 1 | Top 2 teams by average quiz score each earn a point | Canvas quiz scores, compute team averages | ~10 quizzes |
| Fun challenge | 2 | Weekly challenge, group submission | Canvas group assignment | ~10 weeks |

### Design Principles

- **No grade overlap:** Pair coding submissions serve double duty — they feed the individual participation grade (15%) and are also checked for team completion for the challenge. Same data, different purposes. The challenge itself never affects course grades.
- **Effort over performance:** 3 of 4 categories reward showing up and doing the work, not getting the right answer
- **Quiz performance:** Quizzes are points-based with unlimited retakes (best score counts) for the course grade (15%). The top 2 teams by average score each earn a challenge point, adding competitive incentive.
- **Threshold for attendance-type points:** "All but one" member submitting still counts, so one absence doesn't punish the whole team

### Grading Note

Quizzes are **points-based with unlimited retakes** — students' best score counts toward their course grade. The top 2 teams by quiz average each earn a challenge point.

---

## Fun Challenges

Weekly challenges done outside of class. Group submission on Canvas. Due **Sunday at 11:59 PM** each week. One member submits for the group. Each challenge should take **~30 minutes or less** and is graded on completion (submitted = point earned).

**No late submissions.** The 48-hour grace period that applies to assignments and quizzes does **not** apply to fun challenges. If a team misses the deadline, they don't get the points. These are low-stakes and meant to be fun — no need for late-work logistics.

Materials for each challenge go in `files/fun-challenges/` (one subfolder per week).

---

### Challenge 1: Team Bio (Week 1)
**Assigned:** Session 2 (Wed Apr 1) | **Due:** Sun Apr 5
**Skills:** None (icebreaker)

Your team's first mission: introduce yourselves. Submit a short document (PDF, Word, or Google Doc) with:

- Your **team name** (choose wisely — it'll be on the scoreboard all quarter)
- A **team logo or mascot** (hand-drawn, AI-generated, or a meme — just make it yours)
- A **one-sentence fun fact** from each team member

No R required. This is about getting your team talking.

**Format:** Any document format. One submission per team.

---

### Challenge 2: Code Prediction (Week 2)
**Assigned:** Mon Apr 6 | **Due:** Sun Apr 12
**Skills:** ggplot2 basics, aes(), geoms (Sessions 2–3)

Given 5 short ggplot2 code snippets (each 3–5 lines), predict what the resulting plot would look like. For each snippet:

1. What type of plot is it? (scatterplot, bar chart, etc.)
2. What's on the x-axis? The y-axis?
3. Sketch or describe the plot (rough sketch on paper is fine — take a photo)

Uses the `mpg` dataset. Tests code *reading*, not writing.

**Format:** PDF or Word with answers for all 5. Sketches can be photos of hand-drawn plots.
**Materials needed:** Code snippet handout (`files/fun-challenges/02-code-prediction.md`)

---

### Challenge 3: Data Transformation Relay (Week 3)
**Assigned:** Mon Apr 13 | **Due:** Sun Apr 19
**Skills:** filter, select, mutate, summarize, pipe (Sessions 3–4)

Given a dataset about fictional psychology experiment participants, answer 5 questions. Each answer requires a pipe chain. Example questions:

1. How many participants scored above 80 on the anxiety measure?
2. What's the mean reaction time for each experimental condition?
3. Create a new variable that categorizes participants as "fast" or "slow" based on median RT. How many are in each group?

Submit the code and answers.

**Format:** R script or Quarto doc with code and printed output.
**Materials needed:** Dataset (`files/fun-challenges/03-relay-data.csv`) and question sheet

---

### Challenge 4: Bug Hunt (Week 4)
**Assigned:** Mon Apr 20 | **Due:** Sun Apr 26
**Skills:** All R basics through Session 7 (Quarto, import, tidy, transform, ggplot2)

An R script (~25 lines) that's supposed to load a dataset, clean it, and make a plot. But it has **8 bugs**. Find and fix them all.

Bug types include:
- Typos in function names (e.g., `read_CSV` instead of `read_csv`)
- Missing or extra commas/parentheses
- Wrong variable names
- Logic errors (filtering the wrong direction)
- ggplot aesthetic mapped when it should be set (or vice versa)

Submit the corrected script and a list of what you fixed.

**Format:** Corrected `.R` file + a brief list of the 8 fixes.
**Materials needed:** Buggy script (`files/fun-challenges/04-bug-hunt.R`) and dataset

---

### Challenge 5: Plot Makeover (Week 5)
**Assigned:** Mon Apr 27 | **Due:** Sun May 3
**Skills:** ggplot2 layers, perception & design (Sessions 8–9)

Given an ugly default plot and the code that made it. The plot uses the right geom but has:
- No title or axis labels
- Default gray theme
- Hard-to-read colors
- No legend title
- Overlapping points with no transparency

Your mission: make it good. Improve the plot using what you've learned about perception and design. Change at least 5 things.

Submit your improved code and a screenshot of the new plot, plus a brief note explaining what you changed and why.

**Format:** R script + screenshot + brief explanation (1–2 sentences per change).
**Materials needed:** Ugly plot code (`files/fun-challenges/05-plot-makeover.R`) and dataset

---

### Challenge 6: Data Detective (Week 6)
**Assigned:** Mon May 4 | **Due:** Sun May 10
**Skills:** EDA, distributions, covariation (Sessions 10–11)

You're given a dataset from a (fictional) psychology study on the relationship between sleep, stress, and exam performance. Something is weird about this data. Your job:

1. Make at least 3 plots exploring the variables
2. Identify the **two unusual things** hidden in the data (e.g., impossible values, suspicious distributions, unexpected patterns)
3. Explain what you found and what might have gone wrong in the study

This is EDA in practice — let the data surprise you.

**Format:** Quarto doc (or R script + written answers) with plots and explanations.
**Materials needed:** Dataset with planted anomalies (`files/fun-challenges/06-data-detective.csv`)

---

### Challenge 7: R Trivia (Week 7)
**Assigned:** Mon May 11 | **Due:** Sun May 17
**Skills:** Everything through Session 13 (strings, factors, data types)

15 trivia questions covering everything from Weeks 1–7. Mix of formats:

- **What does this return?** (short code snippet → predict the output)
- **Name that function** (description → what function does this?)
- **Spot the difference** (`read_csv` vs `read.csv`, `=` vs `==`, `|>` vs `%>%`)
- **Fix this** (one-line code with an error → what's wrong?)
- **Grab bag** (what package is `fct_reorder()` from? What does `NA` stand for?)

**Format:** Numbered answers in any document format.
**Materials needed:** Trivia question sheet (`files/fun-challenges/07-r-trivia.md`)

---

### Challenge 8: Missing Data Mystery (Week 8)
**Assigned:** Wed May 20 | **Due:** Sun May 24
**Skills:** Missing data, joins (Sessions 14–15)

A fictional research lab ran a 3-wave longitudinal study on stress and coping in college students. You're given the data from all 3 waves, but there's substantial missing data. Your job:

1. How much data is missing at each wave? Which variables?
2. Is the missingness random, or is there a pattern? (Hint: look at whether missingness is related to other variables)
3. What does this mean for the study's conclusions?
4. What would you recommend the researchers do?

**Format:** Quarto doc or written answers with supporting code/output.
**Materials needed:** Three-wave dataset (`files/fun-challenges/08-missing-mystery.csv`)

---

### Challenge 9: Figure Courtroom (Week 9)
**Assigned:** Wed May 27 | **Due:** Sun May 31
**Skills:** Storytelling, critical evaluation (Session 16)

You are the jury. Five figures are on trial. For each one, deliver a verdict:

- **Guilty** (misleading — identify the specific problem)
- **Boring** (technically correct but ineffective — explain why it fails)
- **Not guilty** (effective — explain what makes it work)

The figures include: a truncated y-axis bar chart, a pie chart with 12 slices, a well-designed small multiples plot, a dual-axis chart, and a cluttered scatterplot with too many colors.

Write a 2–3 sentence verdict for each figure.

**Format:** Written verdicts in any document format.
**Materials needed:** Five figure images (`files/fun-challenges/09-figure-courtroom/`)

---

### Challenge 10: The Final Prediction (Week 10)
**Assigned:** Mon Jun 1 | **Due:** Tue Jun 2 (short turnaround — keep it quick!)
**Skills:** Correlation & regression (Session 17)

You're shown a scatterplot with ~50 data points. No axis numbers, no regression line — just the cloud of points. Your team predicts:

1. The **correlation coefficient** *r* (to one decimal place)
2. The **direction** of the relationship (positive, negative, or none)
3. The **R-squared** value (to one decimal place)

After submissions close, the actual values are revealed in Session 18. The team closest to the true values (summed absolute error across all three) earns a **bonus point**.

This one's quick — just look and guess. Trust your visual intuition.

**Format:** Three numbers submitted on Canvas.
**Materials needed:** Scatterplot image (`files/fun-challenges/10-prediction.png`)

---

## Reward

Non-grade reward for the winning team. Current idea: **pizza party** (campus pizza pub or similar). All teams participate; only the winning team gets the reward. Consider whether to also do something small for all teams to keep it celebratory.

---

## Scoreboard

Standalone Quarto revealjs slide: `files/scoreboard.qmd`. Shows a horizontal bar chart of total points by team and a breakdown table by category. Leading team highlighted in orange.

**Workflow:** Update the `scoreboard` tibble at the top of the file each week, then render (`quarto render files/scoreboard.qmd`). Show at the start of each Monday session (or first session of the week).

Teams name themselves in Session 2 when teams are announced → update scoreboard team names at that point.

---

## Student Handout

`files/team-challenge-handout.md` — Distributed in Session 2 when teams are announced. Covers rules, point categories, fun challenges, FAQ.

---

## Power Play (Week 7)

At the start of **Session 13 (Mon May 11)**, after the Week 7 scoreboard is revealed, the **top 2 teams** each get a one-time strategic choice:

- **Option A — Boost:** Add **+3 points** to your own team's total
- **Option B — Sabotage:** Remove **-2 points** from each of **two other teams** of your choice (4-point swing in the standings)

Both options have the same net effect on the gap between the choosing team and the field, but sabotage is more disruptive — it can close gaps between rivals or knock a rising team back. Choices are announced live in class for maximum drama.

**Rules:**
- The two top teams choose in order (1st place picks first)
- A team that is targeted by both top teams loses 4 points total (the penalties stack)
- Teams cannot go below 0 points
- Choices are final — no take-backs

**Rationale:** Adds a strategic twist two-thirds through the term. Keeps trailing teams in contention (a well-placed sabotage can shake up the standings) and gives leaders a meaningful decision. Also a fun excuse to talk game theory for 5 minutes.

---

## Open Questions

- Exact number of teams (8? 9? 10?) — depends on final enrollment
