# Assignments Planning Document

This document outlines the assessment structure for PSY 410. Use this to iterate on assignment content and timing.

---

## Overview

| Component | Weight | Quantity |
|-----------|--------|----------|
| Weekly Coding Assignments | 35% | 8 |
| Reading Quizzes | 15% | 10 (unlimited retakes, best score) |
| In-Class Participation | 15% | Ongoing |
| Final Project | 35% | 3 checkpoints + presentation |

---

## Class Session Structure

Each 75-minute class follows this general structure:

| Time | Activity |
|------|----------|
| 0:00 – 0:05 | Settle in, announcements |
| 0:05 – 0:30 | Lecture Part 1 (concepts + live coding demo) |
| 0:30 – 0:45 | **Pair Coding Break** — students work on in-class exercise |
| 0:45 – 1:05 | Lecture Part 2 (deeper concepts + more examples) |
| 1:05 – 1:15 | **Work Time** — start assignment, ask questions |

---

## Weekly Assignments

### Assignment 1: Getting Started with R
**Assigned:** Session 2 (Wed Week 1)
**Due:** Sunday, April 5 at 11:59 PM
**Topics:** RStudio basics, running code, installing packages, basic ggplot

**Tasks:**
- [ ] Create an RStudio project
- [ ] Install tidyverse
- [ ] Create 3 plots using the `mpg` dataset:
  - Scatterplot of displacement vs highway mpg
  - Same plot, colored by vehicle class
  - Same plot, faceted by drive type
- [ ] Add appropriate labels to each plot
- [ ] Save plots using `ggsave()`

**In-Class Exercise (Session 2):**
Pair up: Create a scatterplot of `cty` vs `hwy` from `mpg`. Who can make it look the nicest in 10 minutes?

---

### Assignment 2: Data Transformation Basics
**Assigned:** Session 4 (Wed Week 2)
**Due:** Sunday, April 12 at 11:59 PM
**Topics:** filter, arrange, select, mutate, pipe

**Tasks:**
- [ ] Using `nycflights13::flights`:
  - Filter to flights departing in June from JFK
  - Select only carrier, destination, and delay columns
  - Create a new variable for delay in hours
  - Arrange by delay (longest first)
- [ ] Using a provided survey dataset:
  - Filter to complete cases
  - Create scale scores using `mutate()`
  - Practice piping multiple operations together

**In-Class Exercise (Session 3):**
Find all United Airlines flights that were more than 2 hours late arriving in Los Angeles.

**In-Class Exercise (Session 4):**
Calculate the average departure delay for each carrier. Which airline is the worst?

---

### Assignment 3: Tidying, Import & Quarto
**Assigned:** Session 7 (Mon Week 4, after Quarto)
**Due:** Sunday, April 26 at 11:59 PM
**Topics:** pivot_longer, pivot_wider, read_csv, readxl, Quarto documents
**Format:** Submit as a rendered Quarto document (HTML). This is the first Quarto assignment — all subsequent assignments should also be Quarto.

**Tasks:**
- [ ] Create a Quarto document with YAML header and section headings
- [ ] Import a provided CSV file and an Excel file
- [ ] Tidy a provided "wide" repeated-measures dataset using pivots
- [ ] Calculate descriptive statistics from the tidied data
- [ ] Create a visualization from the tidied data
- [ ] Include narrative text explaining what you did and what you found
- [ ] Render to HTML and verify it looks correct

**In-Class Exercise (Session 5):**
Pivot this wide survey data to long format, then calculate mean scores per participant.

**In-Class Exercise (Session 6):**
Import the provided CSV. Fix the column types and handle the missing values coded as "N/A".

**In-Class Exercise (Session 7):**
Convert this messy R script into a clean Quarto document with sections and narrative.

---

### Assignment 4: Visualization Deep Dive
**Assigned:** Session 9 (Mon Week 5, after Perception & Design)
**Due:** Sunday, May 3 at 11:59 PM
**Topics:** geoms, scales, themes, color, perception
**Format:** Quarto document

**Tasks:**
- [ ] Recreate a published figure from a psychology paper (provided)
- [ ] Create three versions of the same data:
  - A "bad" version violating design principles
  - A "good" version following best practices
  - A colorblind-accessible version
- [ ] Write a brief reflection on what makes visualizations effective

**In-Class Exercise (Session 8):**
Create a bar chart with error bars showing mean reaction time by condition.

**In-Class Exercise (Session 9):**
Take this cluttered graph and apply the "declutter" principles. Remove at least 5 unnecessary elements.

---

### Assignment 5: Exploratory Data Analysis
**Assigned:** Session 11 (Mon Week 6, after EDA — Covariation)
**Due:** Sunday, May 10 at 11:59 PM
**Topics:** distributions, outliers, covariation, asking questions
**Format:** Quarto document

**Tasks:**
- [ ] Using a provided psychology dataset (e.g., Big Five personality data):
  - Explore distributions of all continuous variables
  - Identify and investigate any outliers
  - Explore relationships between variables
  - Generate 3 interesting questions from your exploration
  - Create visualizations that help answer those questions
- [ ] Write a 1-page EDA report summarizing your findings

**In-Class Exercise (Session 10):**
Explore the distribution of this variable. What do you notice? Any concerns?

**In-Class Exercise (Session 11):**
What's the relationship between these two variables? Does it differ by group?

---

### Assignment 6: Data Types & Wrangling
**Assigned:** Session 13 (Mon Week 7, after Strings, Factors & Text)
**Due:** Sunday, May 17 at 11:59 PM
**Topics:** logicals, numbers, strings, factors, recoding, light text analysis
**Format:** Quarto document

**Tasks:**
- [ ] Recode survey items (reverse-scoring, binning)
- [ ] Create composite scores with proper missing data handling
- [ ] Clean string variables (fix typos, standardize formatting)
- [ ] Create and relevel factors for analysis
- [ ] Demonstrate how factor levels affect ggplot output
- [ ] Tokenize a set of open-ended survey responses and create a word frequency visualization

**In-Class Exercise (Session 12):**
Reverse-code these items and calculate the scale mean for each participant.

**In-Class Exercise (Session 13):**
Fix the messy "gender" column (has "M", "Male", "male", "MALE", etc.) and convert to a factor. Then: tokenize these open-ended responses and find the 10 most common words.

---

### Assignment 7: Joins & Missing Data
**Assigned:** Session 14 (Wed Week 8, after Joins)
**Due:** Sunday, May 24 at 11:59 PM
**Topics:** joins, keys, missing values, complete cases
**Format:** Quarto document

**Tasks:**
- [ ] Merge two related datasets (e.g., participant demographics + survey responses)
- [ ] Identify participants who are in one dataset but not the other
- [ ] Analyze patterns of missingness
- [ ] Create a complete-case analysis vs. a missing-handled analysis
- [ ] Reflect on implications for your conclusions

**In-Class Exercise (Session 14):**
Join these two tables. Why are some rows missing? How would you handle this?

---

### Assignment 8: Storytelling Report
**Assigned:** Session 16 (Wed Week 9, after Storytelling)
**Due:** Sunday, May 31 at 11:59 PM
**Topics:** Data storytelling, communication, Knaflic principles, polished Quarto reports
**Format:** Quarto document

**Tasks:**
- [ ] Choose a dataset (provided options or your own)
- [ ] Create a polished Quarto report that tells a data story:
  - Clear narrative arc with a "Big Idea"
  - 2-3 publication-ready figures following design principles
  - Strategic use of color, emphasis, and decluttering
  - Inline code for statistics (no hard-coded numbers)
  - Audience-appropriate language
- [ ] Apply the "so what?" test to every figure — explain what the reader should take away
- [ ] Render to HTML

**In-Class Exercise (Session 16):**
Take this default ggplot and redesign it as a "storytelling" figure. What's the message? What should you emphasize, mute, or cut?

---

## Final Project

### Proposal (Week 5, Due Session 10)
- Dataset selection (must be approved)
- 2-3 research questions
- Initial plan for visualizations
- 1 paragraph justification

### Draft Analysis (Week 8, Due Session 15)
- Working code that imports and cleans data
- At least 2 preliminary visualizations
- Bullet-point outline of findings
- List of remaining tasks

### Final Submission (Week 10, Due Session 18)
- Polished Quarto report (HTML)
- 4-6 publication-ready visualizations
- Clear narrative connecting visualizations to research questions
- Optional: include a correlation or simple regression if appropriate for your data
- Process documentation (code diary showing AI use if any)

### Presentation (Wed Jun 10)
- 5-minute share-out
- Show 2-3 key visualizations
- Explain one interesting finding or challenge

---

## In-Class Participation Tracking

Each session, students complete a brief in-class exercise with a partner. Graded on:
- [ ] Present and engaged
- [ ] Made good-faith attempt at exercise
- [ ] Submitted/showed work (can be incomplete)

**Not graded on correctness** — this is practice time!

---

## Reading Quizzes

One quiz per week (10 total), administered on Canvas. Each quiz draws 5 random questions from a 50-question bank. Due **Tuesday at 11:59 PM** each week. Graded on completion (full credit for finishing), but the team with the highest average earns a challenge point.

Question banks are in `quizzes/` with QTI packages (.zip) for Canvas import.

| Quiz | Week | Reading | Due |
|------|------|---------|-----|
| 1 | 1 | R4DS Ch 1, 2, 6 | Tue Mar 31 |
| 2 | 2 | R4DS Ch 3, 4 | Tue Apr 7 |
| 3 | 3 | R4DS Ch 5, 7, 20 | Tue Apr 14 |
| 4 | 4 | R4DS Ch 28, 9 | Tue Apr 21 |
| 5 | 5 | R4DS Ch 10 (§10.1–10.4), perception | Tue Apr 28 |
| 6 | 6 | R4DS Ch 10 (§10.5–10.6), 12, 13 | Tue May 5 |
| 7 | 7 | R4DS Ch 14 (§14.1–14.3), 16, 19 | Tue May 12 |
| 8 | 8 | R4DS Ch 18 | Tue May 19 |
| 9 | 9 | R4DS Ch 11 | Tue May 26 |
| 10 | 10 | R4DS Ch 8, correlation & regression | Tue Jun 2 |

---

## Notes for Iteration

### Questions to consider:
- Are assignments appropriately scoped for 1-2 hours outside class?
- Do in-class exercises naturally lead into the assignments?
- Is there enough scaffolding for struggling students?
- Are advanced students challenged enough?

### Potential datasets to use:
- `nycflights13::flights` — great for dplyr practice
- `palmerpenguins::penguins` — good for viz
- `psych::bfi` — Big Five personality data
- Custom Qualtrics export (simulate messy real data)
- Open datasets from OSF psychology papers

### Ideas for personalization (AI mitigation):
- Random seed per student for simulated data
- Different subsets of large datasets
- Different research questions from same dataset
- Require "code diary" documenting errors and debugging

### Package dependencies:
- `tidyverse` (core)
- `nycflights13` (Sessions 3-4, Assignments 1-2)
- `readxl` (Session 6, Assignment 3)
- `tidytext` (Session 13, Assignment 6)
- `broom` (Session 17)
- `corrplot` or `ggcorrplot` (Session 17, optional)
- `naniar` (Session 15, mention only)
