# Graduate Student Assignment Modifications — PSY 410/510

## Overview

PSY 410 is designed for undergraduate psychology majors, but graduate students can enroll as PSY 510 and receive credit. Graduate students complete the same core assignments but with additional components that reflect a higher level of technical depth and independent work.

The general principle: graduate extensions should be **practical and transferable** — things a grad student would actually do in their research workflow — not just "harder for harder's sake."

All extensions are implemented directly in the assignment `.qmd` files under a `## Graduate Extension` section, clearly marked with a `{.callout-note}` callout: **PSY 510 (Graduate Students)**.

---

## Implemented Extensions

### Assignment 3: Qualtrics API
**File:** `assignment/03-assignment.qmd`

Use the `qualtRics` package to authenticate with the Qualtrics API and pull the anonymous start-of-term course survey programmatically. Compare the API output to a manually exported CSV of the same survey. Write a half-page reflection on the tradeoffs between the two approaches.

**Survey setup:** The course uses two surveys at the start of term:
1. **Canvas quiz** (required, identity-linked) — collects team formation info (prior experience, friend requests). Responses are tied to student names via Canvas; not shared with students.
2. **Qualtrics fun survey** (optional, anonymous) — collects personality items, habits, and attitudes used in lecture demos. This is the survey used in the grad extension. Students verify completion via a code word entered on Canvas. Survey ID is in `qualtrics_config.R`.

**Why it works:** Every psych grad student downloads Qualtrics data repeatedly. The API eliminates manual steps that introduce error and enables automation. Because the fun survey is anonymous by design, no data masking is required to use it as a teaching dataset.

**Package:** `qualtRics`. Credentials and survey ID are stored in `qualtrics_config.R` (gitignored). Students will need to obtain their own API token from Qualtrics → Account Settings → Qualtrics IDs.

**Note:** Confirm that UO's Qualtrics plan supports student API tokens before spring.

---

### Assignment 4: Publication-Ready Figure
**File:** `assignment/04-assignment.qmd`

Take one figure from the assignment and bring it to manuscript-submission quality: correct dimensions and resolution for a specific target journal (student chooses one), APA-formatted caption, and a written justification of design choices tied to Session 9 principles.

**Why it works:** Students regularly create figures for papers but never get explicit instruction in meeting journal specifications.

---

### Assignment 5: Preliminary Analysis Write-Up
**File:** `assignment/05-assignment.qmd`

**Replaces** the 1-page EDA report (Part 4). Write a 500–700 word preliminary analysis section in manuscript style: dataset description, exclusion decisions, descriptive statistics table, key patterns with figure references, and a forward-looking analysis plan.

**Why it works:** Writing code and prose together as a unit is the core skill of reproducible research. This forces that integration earlier than the Quarto assignment does.

---

### Assignment 7: Formal Missing Data Report
**File:** `assignment/07-assignment.qmd`

Use `naniar::vis_miss()` to visualize the missingness pattern. Classify the mechanism (MCAR/MAR/MNAR) with justification. Write a 3–5 sentence missing data paragraph in the style of a manuscript Method section.

**Why it works:** Reviewers ask about missing data in almost every submission. This gives students a reusable script and ready-made language for it.

**Package dependency:** `naniar` (already on the package list).

---

### Assignment 8: Parameterized Quarto Report
**File:** `assignment/08-assignment.qmd`

Add a `params` block to the Quarto YAML. Use the parameter to filter data or choose an input. Render the report for two different parameter values and submit both outputs. Write a brief prose section describing a real use case from the student's research area.

**Why it works:** A parameterized report that regenerates for different subgroups or time points is immediately useful for anyone running repeated studies with the same measures.

---

### Final Project (Milestone 3): Open Science Supplement
**File:** `project/03-final-report.qmd`

Write a `README.md` that meets data-sharing standards: project description, file inventory, variable codebook, reproduction instructions (including `sessionInfo()` output), and a license statement. Add a `sessionInfo()` chunk to the `.qmd`.

**Why it works:** Open science documentation is increasingly required by journals and funders. This gives students a template they can reuse.

---

## General Notes

- Extensions should not require entirely new skills outside the course — they extend what's already being taught.
- Where possible, the extension should produce something the student can actually use (a script, a paragraph, a file) rather than just a deliverable for a grade.
- AI documentation requirements apply equally to graduate extensions.
- The Qualtrics API extension (A3) uses the anonymous fun survey (not the Canvas team formation quiz). Survey ID goes in `qualtrics_config.R` once the survey is built. Confirm UO Qualtrics supports student API tokens before spring.
