# PSY 410/510: Data Science for Psychology

Course website and materials for **PSY 410/510: Data Science for Psychology** at the University of Oregon, Spring 2026.

**Website:** [sarajweston.com/datasci410](https://sarajweston.com/datasci410/)

## For instructors

If you're teaching or taking over this course, start here:

**[Instructor Guide](instructor-guide.md)** — Complete operational manual covering pre-term setup, weekly workflow, session-by-session guide, team challenge operations, grading policies, website management, and everything else you need to run the course.

**[CLAUDE.md](CLAUDE.md)** — Project rules and decision log. Read this to understand *why* things are set up the way they are.

## Quick start

1. Install [R](https://cloud.r-project.org/), [RStudio](https://posit.co/download/rstudio-desktop/), and [Quarto](https://quarto.org/)
2. Clone this repository
3. Update `_variables.yml` with your course information
4. Run `quarto render` to build the site
5. Render slides individually: `quarto render slides/02-first-visualization.qmd`

## Directory structure

```
├── _quarto.yml              # Site configuration
├── _variables.yml           # Course metadata (instructor, dates, CRN)
├── CLAUDE.md                # Project rules and decision log
├── instructor-guide.md      # Complete instructor manual
├── syllabus.qmd             # Student-facing syllabus
├── schedule.qmd             # Student-facing schedule
│
├── slides/                  # Reveal.js slide decks (18 sessions)
├── content/                 # Session content pages (18 sessions)
├── assignment/              # Assignment instructions (8 assignments)
├── project/                 # Final project milestones (4 stages)
├── resource/                # Student resource guides
├── quizzes/                 # Quiz question banks + QTI packages
│
├── files/                   # Static assets
│   ├── data/                # Assignment data files
│   ├── fun-challenges/      # Team challenge materials
│   ├── scoreboard.qmd       # Weekly team scoreboard
│   └── syllabus-print.pdf   # Printable syllabus
│
├── scripts/                 # Instructor scripts
│   ├── team-sort.R          # Sort students into teams
│   ├── update-team-points.R # Compute team points from Canvas
│   └── clean-class-survey.R # Pull + clean Qualtrics survey data
│
├── data/                    # Student data (gitignored)
└── html/                    # Custom CSS
```

## Key documents

| Document | Purpose |
|----------|---------|
| [Instructor Guide](instructor-guide.md) | How to run the course (operational) |
| [CLAUDE.md](CLAUDE.md) | Why things are the way they are (decisions) |
| [lecture-outline.md](lecture-outline.md) | Session-by-session topic map |
| [assignments-planning.md](assignments-planning.md) | Assignment design notes |
| [team-challenge-planning.md](team-challenge-planning.md) | Team competition design |

## Licenses

**Text and figures:** [CC-BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)

**Code:** [MIT License](LICENSE.md)
