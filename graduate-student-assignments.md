# Graduate Student Assignment Modifications — PSY 410

## Overview

PSY 410 is designed for undergraduate psychology majors, but graduate students can enroll and receive credit. Graduate students complete the same core assignments but with additional or modified components that reflect a higher level of technical depth and independent work. This document tracks ideas for those modifications as we develop them.

The general principle: graduate extensions should be **practical and transferable** — things a grad student would actually do in their research workflow — not just "harder for harder's sake."

---

## Assignment-Level Ideas

### Assignment 3: Tidying & Import — Qualtrics API Extension

**Why this one:** Session 6 already touches on "getting data out of Qualtrics," but for undergrads we keep it at the level of working with an exported CSV. Graduate students in psychology are likely running or will run Qualtrics studies. Knowing how to pull data programmatically instead of logging in and downloading by hand is an immediately useful skill.

**Proposed graduate extension:**
- Use the Qualtrics API (via the `qualtRics` R package) to pull survey data directly into R
- Authenticate using an API token
- Pull responses from a provided survey (or a sandbox/demo survey set up for the class)
- Compare the API output to a manually exported CSV — identify any differences in structure or formatting
- Write a short summary (half a page) of when you would use the API vs. a manual export, and what the tradeoffs are

**Why this works as a grad extension:**
- Teaches automation of a task every psych researcher does repeatedly
- The `qualtRics` package is well-documented but requires understanding of API authentication, which is a step up from `read_csv()`
- The comparison task (API vs. manual export) builds critical thinking about data pipelines, not just "make it run"
- Directly applicable to dissertation and lab work

**Notes / open questions:**
- Need to set up a demo Qualtrics survey that grad students can access (or use a shared institutional account)
- Should confirm that the university's Qualtrics plan supports API access for students
- The `qualtRics` package handles most of the heavy lifting — the real learning is in understanding the authentication flow and the data structure that comes back

---

### Assignment 5: EDA — Deeper Analysis Extension

**Potential idea:** Graduate students could be asked to go beyond the 1-page EDA report and produce a more structured exploratory analysis — e.g., framing it as a methods section for a hypothetical paper, or running and interpreting a correlation matrix with corrections for multiple comparisons. (Flesh this out later — the Qualtrics API one is the priority.)

---

### Assignment 8: Reproducible Report — Parameterized Report Extension

**Potential idea:** Graduate students could create a parameterized Quarto report — one that can regenerate with different input data or parameters without rewriting code. This is a natural extension of the reproducibility theme and a skill used in applied settings. (Flesh this out later.)

---

### Final Project — Scope and Depth

**Potential idea:** Graduate students' final projects could require an additional component — perhaps a brief literature-grounded motivation section, or a more formal methods write-up. Or the presentation could be longer. (Discuss with co-instructors if applicable.)

---

## General Notes

- Graduate extensions should not require entirely new skills outside the course — they should extend what's already being taught.
- Where possible, the extension should produce something the student can actually use (a script, a report, a workflow) rather than just a deliverable for the class.
- AI documentation requirements apply equally to graduate extensions.
- We can revisit and expand this document as we build out more of the course.
