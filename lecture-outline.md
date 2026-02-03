# PSY 410: Lecture Outline

## Course Philosophy
This outline maps every lecture with specific topics, functions, and readings. The goal is to build confident, independent data analysts who can wrangle real psychology data and communicate findings effectively.

---

## Session 1: Introduction & Setup
**Monday, March 30**

### Topics
- Welcome & introductions
- **[PLACEHOLDER] Teaching philosophy** — how I approach this class, what to expect, how to succeed
- Why data science for psychology?
  - Reproducibility crisis
  - Data is everywhere in modern research
  - These skills transfer to industry, grad school, everywhere
- **[PLACEHOLDER] AI in data science & this class** — AI is a powerful tool in professional settings, but building fundamentals requires struggle; explain the AI policy
- The R ecosystem: R vs RStudio vs tidyverse
- Installing R and RStudio (should be done before class)
- The RStudio interface: four panes
- **Project-oriented workflow** (Jenny Bryan's philosophy)
  - Why `setwd()` is a bad habit
  - Why `rm(list=ls())` doesn't actually clean your environment
  - RStudio Projects as the solution
  - Relative paths, not absolute paths
- Creating your first project

### Key Functions/Concepts
- `install.packages()`, `library()`
- RStudio Projects (`.Rproj` files)
- Console vs Script
- `<-` assignment operator
- Comments with `#`

### Readings (before class)
- R4DS Ch 2: Workflow basics
- R4DS Ch 6: Workflow: scripts and projects
- Jenny Bryan: [Project-oriented workflow](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/)

---

## Session 2: Your First Visualization
**Wednesday, April 1**

### Topics
- Why visualize? (Anscombe's Quartet, Datasaurus Dozen)
- The grammar of graphics philosophy
- ggplot2 basics: the template
- Three essential components: data, aesthetics, geoms
- Mapping variables to aesthetics (x, y, color, size, shape)
- Setting vs mapping aesthetics
- Faceting with `facet_wrap()`
- Adding labels with `labs()`
- Saving plots with `ggsave()`

### Key Functions/Concepts
- `ggplot()`, `aes()`
- `geom_point()`, `geom_smooth()`
- `facet_wrap()`
- `labs()` — title, subtitle, x, y, caption
- `ggsave()`

### Readings (before class)
- R4DS Ch 1: Data visualization

### Assignment
- **Assigned:** Assignment 1 (Getting Started)

---

## Session 3: Data Transformation I
**Monday, April 6**

### Topics
- The dplyr philosophy: verbs for data manipulation
- Working with rows
  - `filter()` — pick rows by condition
  - Comparison operators: `==`, `!=`, `<`, `>`, `<=`, `>=`
  - Logical operators: `&`, `|`, `!`
  - The `%in%` operator
  - `arrange()` — sort rows
  - `desc()` for descending order
- Working with columns
  - `select()` — pick columns by name
  - Select helpers: `starts_with()`, `ends_with()`, `contains()`
  - `mutate()` — create new columns
- The pipe operator `|>`
  - Reading piped code as "then"
  - Keyboard shortcut

### Key Functions/Concepts
- `filter()`, `arrange()`, `desc()`
- `select()`, `starts_with()`, `ends_with()`, `contains()`
- `mutate()`
- `|>` (pipe)
- `NA` and `is.na()`

### Readings (before class)
- R4DS Ch 3: Data transformation (sections 3.1–3.4)

### Assignment
- **Due:** Assignment 1

---

## Session 4: Data Transformation II
**Wednesday, April 8**

### Topics
- Working with groups
  - `group_by()` — define groups
  - `summarize()` — calculate group statistics
  - Common summary functions: `mean()`, `sd()`, `median()`, `min()`, `max()`, `n()`, `n_distinct()`
  - The `na.rm = TRUE` argument
  - `.groups` argument in summarize
- `count()` as a shortcut
- `ungroup()` when needed
- Combining multiple operations in pipelines
- Code style best practices
  - Spacing, line breaks, naming conventions
  - Writing code for your future self

### Key Functions/Concepts
- `group_by()`, `summarize()`, `ungroup()`
- `n()`, `n_distinct()`
- `count()`
- `mean()`, `sd()`, `median()`, `sum()`

### Readings (before class)
- R4DS Ch 3: Data transformation (section 3.5)
- R4DS Ch 4: Workflow: code style

### Assignment
- **Assigned:** Assignment 2 (Data Transformation)

---

## Session 5: Data Tidying
**Monday, April 13**

### Topics
- What is "tidy data"? The three rules:
  1. Each variable is a column
  2. Each observation is a row
  3. Each value is a cell
- Why tidy data matters (works with tidyverse tools)
- Wide vs long format
- Common untidy patterns in psychology data
  - Repeated measures spread across columns
  - Multiple variables in one column
- `pivot_longer()` — wide to long
  - `cols`, `names_to`, `values_to`
  - `names_prefix`, `names_pattern`
- `pivot_wider()` — long to wide
  - `names_from`, `values_from`
  - When to use (summary tables, some analyses)

### Key Functions/Concepts
- `pivot_longer()`, `pivot_wider()`
- Understanding column selection in pivots
- Tidy data principles

### Readings (before class)
- R4DS Ch 5: Data tidying

### Assignment
- **Due:** Assignment 2

---

## Session 6: Data Import
**Wednesday, April 15**

### Topics
- The data science workflow: import → tidy → transform → visualize → communicate
- Reading CSV files with `read_csv()`
  - Why `read_csv()` not `read.csv()`
  - Column type specification
  - Handling messy headers, skipping rows
  - Common encoding issues
- Writing CSV files with `write_csv()`
- Working with Excel files
  - `readxl::read_excel()`
  - Specifying sheets, ranges
  - When Excel is the problem (merged cells, colors as data)
- Importing from other statistical software
  - Brief mention: `haven::read_sav()` (SPSS), `haven::read_sas()` (SAS)
- Getting data out of Qualtrics (practical tips)

### Key Functions/Concepts
- `read_csv()`, `write_csv()`
- `readxl::read_excel()`
- `haven::read_sav()` (mention)
- `problems()` for debugging imports
- `spec()` for column specifications

### Readings (before class)
- R4DS Ch 7: Data import
- R4DS Ch 20: Spreadsheets

### Assignment
- **Assigned:** Assignment 3 (Tidying & Import)

---

## Session 7: Layers & Aesthetics
**Monday, April 20**

### Topics
- Review: the grammar of graphics
- Geoms for different data types
  - One variable: `geom_histogram()`, `geom_density()`, `geom_bar()`
  - Two continuous: `geom_point()`, `geom_smooth()`, `geom_line()`
  - One continuous, one categorical: `geom_boxplot()`, `geom_violin()`
- Statistical transformations (stats)
  - `stat_summary()` for means, error bars
- Position adjustments
  - `position = "dodge"`, `"stack"`, `"fill"`, `"jitter"`
- Scales
  - `scale_x_continuous()`, `scale_y_continuous()`
  - `scale_color_manual()`, `scale_fill_viridis_d()`
- Coordinate systems
  - `coord_flip()`, `coord_cartesian()`

### Key Functions/Concepts
- `geom_histogram()`, `geom_density()`, `geom_bar()`
- `geom_boxplot()`, `geom_violin()`
- `stat_summary()`
- `position_dodge()`, `position_jitter()`
- `scale_*` functions

### Readings (before class)
- R4DS Ch 9: Layers

### Assignment
- **Due:** Assignment 3

---

## Session 8: Perception & Design
**Wednesday, April 22**

### Topics
- Visual perception principles
  - Preattentive attributes: color, size, position, shape
  - What the eye sees first
  - Gestalt principles: proximity, similarity, enclosure
- Color theory
  - Sequential, diverging, qualitative palettes
  - When to use which
  - Colorblind-friendly palettes (`viridis`, `ColorBrewer`)
- Psychology-specific visualizations
  - Bar charts with error bars (SEM, CI)
  - Interaction plots
  - Raincloud plots (combining box + violin + jitter)
- Themes
  - Built-in themes: `theme_minimal()`, `theme_bw()`, `theme_classic()`
  - Customizing with `theme()`

### Key Functions/Concepts
- `scale_fill_viridis_d()`, `scale_color_brewer()`
- `theme_minimal()`, `theme_bw()`, `theme_classic()`
- `theme()` for customization
- `geom_errorbar()`, `geom_linerange()`

### Readings (before class)
- Supplementary: Visual perception principles (TBD)
- Optional: Knaflic, Storytelling with Data, Ch 1-3

### Assignment
- **Assigned:** Assignment 4 (Visualization Deep Dive)

---

## Session 9: EDA — Variation
**Monday, April 27**

### Topics
- What is Exploratory Data Analysis?
  - EDA vs confirmatory analysis
  - Asking questions, generating hypotheses
- Exploring variation (single variables)
  - Visualizing distributions
  - Typical values: center and spread
  - Unusual values: outliers
  - What to do with outliers (document, investigate, decide)
- Exploring categorical variables
  - Counts and proportions
  - Which categories are most common?
- The EDA mindset
  - Curiosity over confirmation
  - Let the data surprise you

### Key Functions/Concepts
- `geom_histogram()`, `geom_freqpoly()`, `geom_density()`
- `geom_bar()` for categorical
- `summary()`, `glimpse()`
- `count()`, `n()`

### Readings (before class)
- R4DS Ch 10: Exploratory data analysis (sections 10.1–10.4)

### Assignment
- **Due:** Assignment 4

---

## Session 10: EDA — Covariation
**Wednesday, April 29**

### Topics
- Exploring covariation (relationships)
- Categorical + continuous
  - Boxplots, violin plots
  - `geom_freqpoly()` with color
- Categorical + categorical
  - `geom_count()`
  - `geom_tile()` with counts
- Continuous + continuous
  - Scatterplots
  - Dealing with overplotting: alpha, jitter, binning
  - Adding trend lines
- Patterns and models
  - What patterns suggest
  - Correlation vs causation reminder
- Hands-on: Explore a real psychology dataset

### Key Functions/Concepts
- `geom_boxplot()`, `geom_violin()`
- `geom_count()`, `geom_tile()`
- Overplotting solutions: `alpha`, `geom_jitter()`, `geom_bin2d()`
- `cor()` for correlation

### Readings (before class)
- R4DS Ch 10: Exploratory data analysis (sections 10.5–10.6)

### Assignments
- **Assigned:** Assignment 5 (EDA)
- **Due:** Final Project Proposal

---

## Session 11: Data Types Grab Bag
**Monday, May 4**

### Topics
- Logical vectors
  - TRUE/FALSE values
  - Comparisons and Boolean operations
  - `any()`, `all()`
  - Using logicals in `filter()` and `mutate()`
  - `if_else()` and `case_when()` for conditional values
- Numbers
  - Integer vs double
  - Rounding: `round()`, `floor()`, `ceiling()`
  - Summarizing: `sum()`, `mean()`, `median()`, `sd()`, `var()`
  - Handling `NA` in calculations
- Practical application: Computing scale scores
  - Summing items
  - Averaging items
  - `rowSums()` and `rowMeans()` (brief mention)

### Key Functions/Concepts
- `if_else()`, `case_when()`
- `any()`, `all()`
- `round()`, `floor()`, `ceiling()`
- `sum()`, `mean()`, `sd()` with `na.rm = TRUE`

### Readings (before class)
- R4DS Ch 12: Logical vectors
- R4DS Ch 13: Numbers

### Assignment
- **Due:** Assignment 5

---

## Session 12: Strings & Factors
**Wednesday, May 6**

### Topics
- Strings (light coverage)
  - Creating and combining strings
  - Basic cleaning: `str_to_lower()`, `str_to_upper()`, `str_trim()`
  - Simple pattern matching: `str_detect()`, `str_replace()`
  - When you need more: mention regex exists, point to resources
- Factors (deeper coverage)
  - What are factors? Categorical data with levels
  - When R creates factors automatically
  - Creating factors: `factor()`, `as_factor()`
  - Why factor order matters for plots and models
  - Reordering: `fct_relevel()`, `fct_reorder()`, `fct_infreq()`
  - Recoding: `fct_recode()`, `fct_collapse()`
- Practical application: Cleaning demographic variables

### Key Functions/Concepts
- `str_to_lower()`, `str_trim()`, `str_detect()`, `str_replace()`
- `factor()`, `as_factor()`
- `fct_relevel()`, `fct_reorder()`, `fct_infreq()`
- `fct_recode()`, `fct_collapse()`

### Readings (before class)
- R4DS Ch 14: Strings (sections 14.1–14.3 only)
- R4DS Ch 16: Factors

### Assignment
- **Assigned:** Assignment 6 (Data Types)

---

## Session 13: Joins
**Monday, May 11**

### Topics
- Why join data?
  - Data often lives in multiple tables
  - Participant info + survey responses
  - Longitudinal data across timepoints
- Keys
  - Primary keys (unique identifier in a table)
  - Foreign keys (reference to another table's primary key)
  - Checking for unique keys
- Mutating joins (add columns)
  - `left_join()` — keep all rows from left
  - `right_join()` — keep all rows from right
  - `inner_join()` — keep only matching rows
  - `full_join()` — keep all rows from both
- Filtering joins (filter rows)
  - `semi_join()` — keep rows that have a match
  - `anti_join()` — keep rows that DON'T have a match
- Common issues
  - Many-to-many relationships
  - Missing keys
  - Duplicate keys

### Key Functions/Concepts
- `left_join()`, `right_join()`, `inner_join()`, `full_join()`
- `semi_join()`, `anti_join()`
- `by` argument for specifying keys

### Readings (before class)
- R4DS Ch 19: Joins

### Assignment
- **Due:** Assignment 6

---

## Session 14: Missing Data
**Wednesday, May 13**

### Topics
- Why missing data matters in psychology
  - Attrition, non-response, skip patterns
  - Missing data can bias results
- Types of missing data
  - Explicit: `NA` values
  - Implicit: rows that don't exist
- Exploring missingness
  - Counting missing values
  - Patterns of missingness
  - Visualizing missingness (mention `naniar` package)
- Handling missing data
  - Complete case analysis (listwise deletion)
  - `drop_na()` and `na.omit()`
  - Filling missing values: `replace_na()`, `fill()`
  - When NOT to fill (don't make up data!)
- Explicit vs implicit missing
  - `complete()` to make implicit missing explicit
- Brief mention: more sophisticated approaches exist (multiple imputation) — beyond this course

### Key Functions/Concepts
- `is.na()`, `!is.na()`
- `drop_na()`, `na.omit()`
- `replace_na()`, `fill()`
- `complete()`
- Counting with `sum(is.na(x))`

### Readings (before class)
- R4DS Ch 18: Missing values

### Assignment
- **Assigned:** Assignment 7 (Joins & Missing Data)

---

## Session 15: Storytelling with Data
**Wednesday, May 20**

### Topics
- Why storytelling? (Dykes article)
  - Data storytelling = data + visuals + narrative
  - Data + narrative → explain
  - Data + visuals → enlighten
  - Narrative + visuals → engage
  - All three → **change**
  - Stories are memorable (63% remember stories vs 5% remember stats)
  - Stories are persuasive (charity brochure study)
  - Decisions are emotional, not just logical
- The storytelling process (Knaflic framework)
  1. Understand the context — Who is your audience? What do they need?
  2. Choose appropriate visuals — Match plot type to data and message
  3. Eliminate clutter — Less is more; Gestalt principles
  4. Focus attention — Use preattentive attributes strategically
  5. Think like a designer — Visual hierarchy, accessibility
- Applying to your final project
  - What's the one thing you want your audience to remember?
  - Building a narrative arc with data
- **Critical evaluation of figures** (Knaflic examples)
  - Misleading figures — how visuals can deceive
    - Truncated y-axes inflating differences
    - Dual axes with mismatched scales
    - Cherry-picked time ranges
    - 3D charts that distort perception
    - Area/bubble charts where size is hard to compare
  - Boring or ineffective figures — why they fail to communicate
    - Default plots with no title, labels, or context
    - Too many colors, no visual hierarchy
    - Wrong plot type for the data (e.g., pie chart for many categories)
    - Figures that require reading the caption to understand
  - The "so what?" test applied to real examples
    - A figure should answer a question — if you can't say what it answers, it's not working
  - Handout: APA figure formatting guidelines (for reference, not tested)

### Key Concepts
- Data storytelling triad: data, visuals, narrative
- Audience-first thinking
- Decluttering visualizations
- Strategic use of color and emphasis
- The "so what?" test
- Recognizing misleading vs. just ineffective figures

### Readings (before class)
- R4DS Ch 11: Communication
- Dykes: [Data Storytelling: The Essential Data Science Skill](https://www.forbes.com/sites/brentdykes/2016/03/31/data-storytelling-the-essential-data-science-skill-everyone-needs/) (PDF provided)

### Assignments
- **Due:** Assignment 7
- **Due:** Final Project Draft

---

## Session 16: Quarto
**Wednesday, May 27**

### Topics
- What is literate programming?
  - Code + narrative in one document
  - Why this matters for reproducibility
- Quarto basics
  - YAML header (metadata)
  - Markdown for text (headers, bold, italic, lists, links)
  - Code chunks for R
- Code chunk options
  - `echo`, `eval`, `include`, `message`, `warning`
  - `fig-width`, `fig-height`, `fig-cap`
  - `code-fold` for interactive documents
- Inline code
  - Embedding results in text
  - Never hard-code statistics!
- Output formats
  - HTML (interactive, web-friendly)
  - PDF (print-ready, requires LaTeX)
  - Word (for collaborators who need it)
- Tables
  - `knitr::kable()` for simple tables
  - Mention `gt` package for fancier tables

### Key Functions/Concepts
- YAML: `title`, `author`, `date`, `format`
- Code chunks: `{r}`
- Chunk options: `#| echo: false`, `#| fig-cap: "..."`
- Inline code: `` `r expression` ``
- `knitr::kable()`

### Readings (before class)
- R4DS Ch 28: Quarto

### Assignment
- **Assigned:** Assignment 8 (Reproducible Report)

---

## Session 17: Practice & Review
**Monday, June 1**

### Topics
- Guided practice: A complete workflow
  - Import a messy dataset
  - Clean and tidy
  - Explore and visualize
  - Create a polished figure
  - Document in Quarto
- Common errors and how to read them
  - "Object not found"
  - "Could not find function"
  - "Unexpected symbol"
  - "Non-numeric argument to binary operator"
- Debugging strategies
  - Read the error message (really read it)
  - Check your spelling and capitalization
  - Run code line by line
  - Google the error (everyone does this)
  - Minimal reproducible examples
- Getting help effectively
  - How to ask a good question
  - Stack Overflow, Posit Community, R4DS Slack
- Q&A for final projects

### Key Concepts
- Error message interpretation
- Debugging workflow
- How to Google effectively
- Creating reprex (reproducible examples)

### Readings (before class)
- R4DS Ch 8: Workflow: getting help

### Assignment
- **Due:** Assignment 8

---

## Session 18: Putting It All Together
**Wednesday, June 3**

### Topics
- The complete data science workflow (review)
  - Import → Tidy → Transform → Visualize → Model → Communicate
- Live demonstration: Real psychology analysis start to finish
- What you've learned (celebrate!)
- Where to go from here
  - Statistics in R: t-tests, ANOVA, regression
  - Advanced R: functions, iteration, packages
  - Version control: Git and GitHub
  - Interactive visualizations: Shiny
  - Machine learning: tidymodels
- Resources for continued learning
  - R4DS book
  - Posit primers
  - #TidyTuesday community
  - R-Ladies, local meetups
- Final project work time
- Course evaluations

### Key Concepts
- The full workflow
- Growth mindset for continued learning
- Community resources

### Assignment
- **Due:** Final Project Report

---

## Finals Week
- **Final Presentations** (5 minutes each)

---

# Potential Additions to Consider

## Things I'd recommend adding:

1. **Common errors session content** — Already in Session 17, but could be woven throughout. Students need to see errors early and often so they're not scared of them.

2. **Dates and times (lubridate)** — Very common in psychology data (response timestamps, longitudinal studies). Could be a 15-minute addition to Session 11 or 12, but might be too much.

3. ~~**A few slides on "how to lie with charts"**~~ — Incorporated into Session 15 as a critical evaluation of figures section.

## Things that are probably fine to skip:

1. **Regular expressions** — Too advanced for this audience. The basic string functions are enough.

2. **Functions and iteration (purrr)** — You already cut this. Good call.

3. **Git/GitHub** — Would be great but is a whole other course. Mention it as "where to go next."

4. **Statistical modeling in R** — This is a data science / visualization course, not a stats course. They'll get that elsewhere.

## Psychology-specific additions to consider:

1. **Getting data from Qualtrics** — Already mentioned in Session 6, but could be more explicit.

2. **Reverse coding scale items** — Already in Session 11, good.

3. **Computing reliability (Cronbach's alpha)** — Could mention `psych::alpha()` briefly, but might be scope creep.

4. ~~**APA-style figures**~~ — Covered via a student handout distributed in Session 15. Not a lecture focus; journals have significant wiggle room in practice.
