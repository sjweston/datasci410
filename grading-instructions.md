# Grading Instructions — PSY 410: Data Science for Psychology

General guidelines for grading all assignments in this course. These apply regardless of which assignment is being graded or who is doing the grading.

---

## Point allocation

The rubric gives totals per section (e.g., "Part 1: 25 pts") but not per task. When dividing points across tasks within a section:

- **Divide roughly equally** across subtasks. If a section has 3 tasks worth 30 points total, start with 10 pts each and adjust slightly for complexity.
- **Weight by task complexity.** A task that requires only filtering gets fewer points than one that requires filtering + summarizing + interpreting a result.
- **Be consistent across all submissions.** Decide on the per-task breakdown before you start grading and apply it uniformly.

---

## Partial credit

Apply partial credit within a subtask when the student shows meaningful understanding but makes a specific, identifiable error:

| Situation | Credit |
|-----------|--------|
| Correct approach, correct formula, result not saved/assigned | ~75% |
| Correct approach, wrong column or variable name | ~50–75% depending on severity |
| Right answer reported in a comment but code is wrong | ~50% |
| Correct code but no written answer when one is required | ~75% |
| Conceptual explanation present but no worked example when both are required | ~60–70% |
| Task entirely missing | 0% |
| Code produces an error that prevents the task from running | 0–50% depending on how close the approach is |

**Do not give partial credit for the wrong answer with no evidence of understanding.** If a student gets a wrong result and doesn't notice or comment, that's 0.

---

## Code quality (the "Code runs without errors" criterion)

- Deduct **1 point per distinct error**, down to 0. Do not deduct all 10 points for a single typo.
- Count errors at the level of distinct mistakes, not lines. A copy-pasted error appearing in 3 places is 1 error, not 3.
- Common things that count as errors: wrong function arguments that cause a crash, broken pipe syntax, comparing to `"NA"` as a string instead of using `is.na()`, calling a function that doesn't exist.
- Common things that **don't** count as errors: minor stylistic inconsistencies, using a slightly different variable name that still works, adding `install.packages()` at the top of a script.

---

## Ambiguous instructions

When the assignment wording could reasonably be interpreted multiple ways:

- **Accept any interpretation that is internally consistent.** If a student computes a difference in the opposite direction but explains it correctly relative to their own formula, give full credit.
- **Don't penalize for a reasonable alternate approach** that produces a correct result (e.g., combining two tasks into one pipeline, using `slice_max` vs `arrange + head`).
- If you're unsure whether an interpretation should be accepted, err on the side of the student and make a note.

---

## What to note in comments

Each submission should have a 1–2 sentence comment that:

- Identifies the most significant error(s), if any
- Notes anything particularly strong if the submission is excellent
- Is specific enough that the student can act on it (e.g., "Task 1.3 only filters for SFO, not LAX+SFO" rather than "Part 1 incomplete")

Comments are returned to students, so keep them constructive and matter-of-fact.

---

## Edge cases

- **Duplicate submission / wrong file:** Score 0 and flag for Sara to follow up with the student.
- **Script produces correct output but via an unusual method:** Give full credit. We care about the result and the understanding, not the specific functions used (unless the task explicitly requires a particular function like `n_distinct()`).
- **Student uses a more advanced approach than taught:** Give full credit.
- **Student comments out working code and writes a note:** If the commented code is correct, give full credit. If the note says they couldn't get it working, give partial credit based on how close the commented code is.
