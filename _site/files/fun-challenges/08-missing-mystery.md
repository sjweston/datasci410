# Fun Challenge 8: Missing Data Mystery

**Due:** Sunday, May 25 at 11:59 PM

A fictional research lab ran a 3-wave longitudinal study on stress and coping in college students. Participants were surveyed at the start of the term (Wave 1), midterms (Wave 2), and finals (Wave 3).

The dataset (`08-missing-mystery.csv`) contains all three waves. But there's a lot of missing data, and it's not random.

**Variables:**

- `participant_id` — Unique ID
- `wave` — Survey wave (1, 2, or 3)
- `stress` — Perceived stress score (1--10)
- `coping` — Coping effectiveness score (1--10)
- `sleep_hours` — Average hours of sleep per night
- `gpa` — Current GPA (0.0--4.0)

---

## Your task

1. **How much data is missing** at each wave? Which variables have the most missing values?
2. **Is the missingness random**, or is there a pattern? (Hint: compare the characteristics of participants who have complete data vs. those with missing values. Is missingness related to stress, GPA, or wave?)
3. **What does this mean** for the study's conclusions? If the researchers just dropped all incomplete cases, how would that bias the results?
4. **What would you recommend** the researchers do about the missing data?

---

**Submit:** A Quarto document or R script with your code, output, and written answers to the four questions. One submission per team.
