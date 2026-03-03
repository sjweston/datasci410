# Fun Challenge 3: Data Transformation Relay

**Due:** Sunday, April 19 at 11:59 PM

You've been given a dataset (`03-relay-data.csv`) from a fictional experiment on how background noise affects reading comprehension. Each row is one participant.

**Variables:**

- `participant_id` — Unique ID
- `condition` — Experimental condition: "silence", "white_noise", or "music"
- `age` — Age in years
- `reading_score` — Comprehension score (0--100)
- `reaction_time_ms` — Average reaction time in milliseconds
- `completed` — Whether they finished the study ("yes" or "no")

**Answer each question below using R code.** Write a pipe chain for each. Submit your code and the answers.

---

## Question 1

How many participants are in each experimental condition? (Use `count()`.)

## Question 2

Filter to only participants who completed the study. What is the **mean reading score** for each condition?

## Question 3

Among completed participants, who had the **fastest** (lowest) reaction time? What condition were they in?

## Question 4

Create a new variable called `score_category` that labels participants as `"high"` (reading score >= 75), `"medium"` (50--74), or `"low"` (below 50). How many participants fall into each category? (Hint: `case_when()`)

## Question 5

Among completed participants aged 20 or older, what is the **median reaction time** for each condition? Which condition has the lowest median?

---

**Submit:** An R script (`.R`) or Quarto document (`.qmd`) with your code and printed output. One submission per team.
