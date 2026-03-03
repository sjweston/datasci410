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

| Category | How earned | How tracked | Frequency |
|----------|-----------|-------------|-----------|
| Pair coding completion | All (or all but one) team members submit on Canvas | Individual Canvas submissions (same ones used for the 15% participation grade) | ~16 sessions |
| Assignment submission | All team members submit on time | Individual Canvas submissions, check timestamps | 8 assignments |
| Quiz performance | Team with highest average earns a point | Canvas quiz scores, compute team averages | ~10 quizzes |
| Fun challenge | Weekly challenge, group submission | Canvas group assignment | ~10 weeks |

### Design Principles

- **No grade overlap:** Pair coding submissions serve double duty — they feed the individual participation grade (15%) and are also checked for team completion for the challenge. Same data, different purposes. The challenge itself never affects course grades.
- **Effort over performance:** 3 of 4 categories reward showing up and doing the work, not getting the right answer
- **Quiz performance is the one exception:** Quizzes are completion-based for the course grade (15%) but the team with the highest average gets a challenge point. This keeps quizzes low-stakes for grades while adding a competitive incentive to try.
- **Threshold for attendance-type points:** "All but one" member submitting still counts, so one absence doesn't punish the whole team

### Grading Note

Quizzes are **completion-based for the course grade** — students get full credit for completing them. This is a change from scored quizzes. The quiz performance competition is entirely separate from the course grade. Update the syllabus to reflect this.

---

## Fun Challenges

Weekly challenges done outside of class. Group submission on Canvas. Ideas to develop:

- R trivia (what does this function do?)
- Bug hunt (find the error in this code)
- Prediction challenge (what will this code produce?)
- Data detective (answer a question using a provided dataset)
- Visualization challenge (recreate this plot)

Need to develop 10 challenges, one per week.

---

## Reward

Non-grade reward for the winning team. Current idea: **pizza party** (campus pizza pub or similar). All teams participate; only the winning team gets the reward. Consider whether to also do something small for all teams to keep it celebratory.

---

## Scoreboard

A slide shown at the start of each Monday session with current team standings. Keep it simple — team names, point totals, maybe a bar chart. Could be a recurring slide template added to each deck or a standalone display.

Teams name themselves in Session 2 when teams are announced.

---

## Open Questions

- Exact number of teams (8? 9? 10?) — depends on final enrollment
- What happens with ties?
- What if a student drops and a team shrinks?
- Should there be a mid-term team reshuffle or keep teams stable all term?
- Fun challenge format details — how long should they take? Are they graded for completion?
