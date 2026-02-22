# Pen-and-Paper Pair Exercise: Handout Template

> **Instructions for the instructor:** Use this template to create pen-and-paper versions of in-class pair coding exercises. Print a few copies before each class to have on hand for students without laptops.

---

## How to build a handout for a session

Each handout follows the same four-section structure:

### Section 1: Header
- Session number, title, and date
- A note explaining this is the pen-and-paper version of the pair exercise
- Reminder that the student should work with a partner who has a laptop

### Section 2: The data
- Print the first 8–10 rows of the dataset used in the exercise
- Include only the columns relevant to the task (don't overwhelm the page)
- If the exercise uses a built-in dataset, note the full dataset name so the partner can pull it up

### Section 3: The task
- Use the exact same prompt from the slides
- Below the prompt, add a "pen-and-paper version" that translates each step into something the student can do by hand:
  - **Filtering** → circle or highlight rows that match the condition
  - **Selecting columns** → draw a box around the relevant columns
  - **Mutating** → add a new column to the printed table and fill in values
  - **Grouping + summarizing** → draw group boundaries, then compute the summary stat for each group
  - **Plotting** → sketch the plot by hand on the grid provided (axes labeled)
  - **Pivoting** → redraw the table in the new shape
  - **Joining** → draw lines connecting matching rows between two tables
  - **Code prediction** → fill in blanks in a partially-written pipeline
- Include a workspace: blank lines, a grid for sketching plots, or an empty table to fill in

### Section 4: Check your work
- A brief answer key (or "compare with your partner's screen") so the student can self-check
- For code-tracing exercises, include the expected output

---

## Design principles

1. **Same learning goal, different medium.** The student should practice the same thinking as the coding version — deciding which rows to keep, which summary to compute, what a plot should look like. They just record it on paper instead of in R.

2. **Keep the pair dynamic.** The handout student works on paper while their partner works on screen. They compare answers at the end. This is better than isolating the no-laptop student with a totally different task.

3. **No new content.** The handout should never require knowledge beyond what's been taught up to that point in the deck — same rule as the coding version.

4. **Fits on one page (front and back).** Keep it tight. A dataset printout, the prompt, workspace, and a brief answer key. No multi-page handouts.

5. **Low prep cost.** These should take ~10 minutes to prepare once the slide exercise exists. The template handles the structure; you just fill in the data and task.

---

## Checklist for each new handout

- [ ] Dataset rows printed (8–10 rows, relevant columns only)
- [ ] Task prompt matches the slide exercise exactly
- [ ] Pen-and-paper translation added for each step
- [ ] Workspace provided (blank table, grid, or writing space)
- [ ] Answer key included
- [ ] Fits on one page (front and back)
- [ ] Filename follows convention: `files/handout-NN-topic.md`
