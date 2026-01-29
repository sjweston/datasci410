# Course Website Template

A Quarto-based course website template.

## How to use this template

1. Clone or download this repository
2. Modify the configuration files:
   - `_variables.yml`: Course and instructor information
   - `_quarto.yml`: Site structure and navigation
3. Add your content:
   - `content/`: Lecture materials and readings
   - `assignment/`: Assignment instructions
   - `resource/`: Additional resources
4. Build the site with `quarto render`

## Directory Structure

```
├── _quarto.yml          # Main site configuration
├── _variables.yml       # Course variables (edit this first!)
├── index.qmd            # Homepage
├── syllabus.qmd         # Syllabus page
├── schedule.qmd         # Schedule page
├── content/             # Course content
│   ├── index.qmd
│   └── 01-content.qmd   # Template for content pages
├── assignment/          # Assignments
│   ├── index.qmd
│   └── 01-assignment.qmd # Template for assignments
├── resource/            # Resources
│   └── index.qmd
├── files/               # Static files (images, PDFs, etc.)
│   └── bib/             # Bibliography files
└── html/                # Custom HTML templates and CSS
```

## Building the Site

1. Install [Quarto](https://quarto.org/)
2. Run `quarto render` in the terminal
3. The site will be in the `_site/` folder

## Licenses

**Text and figures:** [CC-BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)

**Code:** [MIT License](LICENSE.md)
