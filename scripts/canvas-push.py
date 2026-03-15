#!/usr/bin/env python3
"""
Canvas batch setup script for PSY 410/510.
Creates rubrics (assignments + project milestones), syllabus page,
schedule page, and uploads handouts.

Usage:
    python3 scripts/canvas-push.py YOUR_API_TOKEN
"""

import sys
import os
import json
import urllib.request
import urllib.parse
import urllib.error

if len(sys.argv) < 2:
    print("Usage: python3 scripts/canvas-push.py YOUR_API_TOKEN")
    sys.exit(1)

TOKEN = sys.argv[1]
COURSE_ID = 287793
BASE = f"https://canvas.uoregon.edu/api/v1/courses/{COURSE_ID}"
SITE = "https://sarajweston.com/datasci410"
C = f"https://canvas.uoregon.edu/courses/{COURSE_ID}/assignments"


def api_post(url, data):
    """POST form data to Canvas API."""
    encoded = urllib.parse.urlencode(data).encode("utf-8")
    req = urllib.request.Request(url, data=encoded, method="POST")
    req.add_header("Authorization", f"Bearer {TOKEN}")
    try:
        with urllib.request.urlopen(req) as resp:
            return resp.status, json.loads(resp.read())
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")[:200]
        return e.code, body


def create_rubric(assignment_id, title, criteria, points_total):
    """Create a rubric and associate it with an assignment."""
    data = {
        "rubric[title]": title,
        "rubric[points_possible]": str(points_total),
        "rubric_association[association_id]": str(assignment_id),
        "rubric_association[association_type]": "Assignment",
        "rubric_association[use_for_grading]": "true",
        "rubric_association[purpose]": "grading",
    }
    for i, (desc, pts) in enumerate(criteria):
        data[f"rubric[criteria][{i}][description]"] = desc
        data[f"rubric[criteria][{i}][points]"] = str(pts)
        data[f"rubric[criteria][{i}][ratings][0][description]"] = "Full Marks"
        data[f"rubric[criteria][{i}][ratings][0][points]"] = str(pts)
        data[f"rubric[criteria][{i}][ratings][1][description]"] = "Partial"
        data[f"rubric[criteria][{i}][ratings][1][points]"] = str(round(pts * 0.5))
        data[f"rubric[criteria][{i}][ratings][2][description]"] = "No Marks"
        data[f"rubric[criteria][{i}][ratings][2][points]"] = "0"

    status, resp = api_post(f"{BASE}/rubrics", data)
    if status in (200, 201):
        print(f"  ✓ Rubric: {title}")
    else:
        print(f"  ✗ Rubric FAILED: {title} — {status}: {resp}")


def create_page(title, body):
    """Create a Canvas wiki page."""
    data = {
        "wiki_page[title]": title,
        "wiki_page[body]": body,
        "wiki_page[published]": "true",
    }
    status, resp = api_post(f"{BASE}/pages", data)
    if status in (200, 201):
        print(f"  ✓ Page: {title}")
    else:
        print(f"  ✗ Page FAILED: {title} — {status}: {resp}")


def upload_file(filepath, folder_path="course files"):
    """Upload a file to Canvas Files using multipart form."""
    filename = os.path.basename(filepath)
    filesize = os.path.getsize(filepath)

    # Step 1: Notify Canvas
    data = {
        "name": filename,
        "size": str(filesize),
        "parent_folder_path": folder_path,
    }
    status, resp = api_post(f"{BASE}/files", data)
    if status not in (200, 201):
        print(f"  ✗ Upload init FAILED: {filename} — {status}")
        return

    upload_url = resp["upload_url"]
    upload_params = resp["upload_params"]

    # Step 2: Multipart upload
    boundary = "----CanvasUploadBoundary"
    body_parts = []
    for key, val in upload_params.items():
        body_parts.append(f"--{boundary}\r\n")
        body_parts.append(f'Content-Disposition: form-data; name="{key}"\r\n\r\n')
        body_parts.append(f"{val}\r\n")

    with open(filepath, "rb") as f:
        file_data = f.read()

    body_bytes = "".join(body_parts).encode("utf-8")
    file_header = f'--{boundary}\r\nContent-Disposition: form-data; name="file"; filename="{filename}"\r\nContent-Type: application/octet-stream\r\n\r\n'.encode("utf-8")
    end_boundary = f"\r\n--{boundary}--\r\n".encode("utf-8")
    full_body = body_bytes + file_header + file_data + end_boundary

    req = urllib.request.Request(upload_url, data=full_body, method="POST")
    req.add_header("Content-Type", f"multipart/form-data; boundary={boundary}")

    try:
        with urllib.request.urlopen(req) as resp2:
            print(f"  ✓ Uploaded: {filename}")
    except urllib.error.HTTPError as e:
        if e.code in (301, 302, 303):
            location = e.headers.get("Location", "")
            req3 = urllib.request.Request(location)
            req3.add_header("Authorization", f"Bearer {TOKEN}")
            try:
                with urllib.request.urlopen(req3) as resp3:
                    print(f"  ✓ Uploaded: {filename}")
            except Exception:
                print(f"  ✗ Upload confirm FAILED: {filename}")
        else:
            print(f"  ✗ Upload FAILED: {filename} — {e.code}")


# ============================================================
# RUBRICS — Assignments
# ============================================================
print("\n=== ASSIGNMENT RUBRICS ===")

assignment_rubrics = [
    (
        2018900,
        "Assignment 1: Getting Started with R",
        [
            ("Task 1: Data exploration — use glimpse(), describe variables in comments", 10),
            ("Task 2: Basic scatterplot — displacement vs hwy, clear title and labeled axes", 20),
            ("Task 3: Color mapping — points colored by class, legend has clear title", 20),
            ("Task 4: Faceting — facet_wrap by drv, panels clearly labeled", 25),
            ("Task 5: Saving plot — ggsave creates PNG, file exists in project folder", 15),
            ("Task 6: Reflection — thoughtful answers about patterns in comments", 10),
        ],
        100,
    ),
    (
        2018901,
        "Assignment 2: Data Transformation",
        [
            ("Part 1: Filtering & Arranging — correct filters, arrange with desc(), answers in comments", 30),
            ("Part 2: Selecting & Mutating — flights_subset created, delay_diff and dep_delay_hrs correct, interpretation in comments", 35),
            ("Part 3: Grouped Summaries — correct group_by/summarize, carrier/airport/month breakdowns, final piped sequence works", 35),
        ],
        100,
    ),
    (
        2018902,
        "Assignment 3: Tidying & Importing Data",
        [
            ("Part 1: Pivoting wide to long — correct pivot_longer, summary by condition/time, line plot with points", 35),
            ("Part 2: Pivoting long to wide — correct pivot_wider, sum of emotion ratings", 25),
            ("Part 3: Importing data — read_csv with na/col_types handled, read_excel from correct sheet, join by participant ID", 40),
        ],
        100,
    ),
    (
        2018903,
        "Assignment 4: Visualization Deep Dive",
        [
            ("Part 1: Bar charts with error bars — summary table with SE, clear labels, clean theme, colorblind-friendly palette", 30),
            ("Part 2: Distributions — histogram with appropriate bins, overlapping densities with alpha, boxplot vs violin comparison in comments", 25),
            ("Part 3: Bad and Good graph — bad graph violates 4+ design principles (listed), good graph with justified design choices", 30),
            ("Part 4: Recreate a figure — reasonable reproduction of provided image, attention to geoms/colors/labels/theme", 15),
        ],
        100,
    ),
    (
        2018904,
        "Assignment 5: Exploratory Data Analysis",
        [
            ("Part 1: Exploring distributions — histograms for age and personality items, outlier identification, missing data summary", 30),
            ("Part 2: Exploring relationships — scatterplot with trend line, boxplots by gender, correlation matrix for E1-E5", 35),
            ("Part 3: Generating questions — 3 interesting questions, one visualization addressing a question", 20),
            ("Part 4: EDA report — ~300-400 word narrative covering data, findings, quality issues, next steps", 15),
        ],
        100,
    ),
    (
        2018905,
        "Assignment 6: Data Types & Wrangling",
        [
            ("Part 1: Logical vectors & recoding — attention check variable, reverse coding correct, scale mean computed, age groups via case_when", 30),
            ("Part 2: Strings — gender and education variables cleaned and standardized", 25),
            ("Part 3: Factors — education factor in logical order, bar charts showing ordered vs unordered, age_group boxplot in correct order", 30),
            ("Part 4: Complete pipeline — single piped sequence that filters, recodes, computes, and selects", 15),
        ],
        100,
    ),
    (
        2018906,
        "Assignment 7: Joins & Missing Data",
        [
            ("Part 1: Understanding data — dataset exploration, anti_join to find mismatches, explanation of discrepancies", 15),
            ("Part 2: Joining data — inner_join, left_join, task_data summarized then joined correctly", 35),
            ("Part 3: Missing data analysis — missingness summary, missingness by condition, visualization, complete cases vs available data comparison", 35),
            ("Part 4: Reflection — thoughtful answers about risks of complete cases, when to exclude, how to report", 15),
        ],
        100,
    ),
    (
        2018907,
        "Assignment 8: Reproducible Report",
        [
            ("YAML header — title, author, date, toc, code-fold all present and correct", 5),
            ("Introduction — clear description of dataset, research question(s), motivation", 10),
            ("Data import & cleaning — packages loaded, data imported, cleaning documented in code chunks", 15),
            ("Exploratory analysis — at least 2 visualizations, appropriate ggplot2 features, brief interpretation", 25),
            ("Main analysis — addresses research question, at least 1 publication-quality figure, summary stats with kable", 25),
            ("Inline code — at least 3 statistics reported with inline R code in narrative", 10),
            ("Conclusion — summary of findings, limitations, next steps", 10),
        ],
        100,
    ),
]

for aid, title, criteria, total in assignment_rubrics:
    create_rubric(aid, title, criteria, total)

# ============================================================
# RUBRICS — Project Milestones
# ============================================================
print("\n=== PROJECT MILESTONE RUBRICS ===")

project_rubrics = [
    (
        2019054,
        "Final Project: Proposal",
        [
            ("Dataset description — clear, complete, viable, includes source link", 3),
            ("Research questions — 2-3 questions that are specific, visual, and interesting", 3),
            ("Visualization plan — reasonable match of plot type to each question", 2),
            ("Justification — thoughtful paragraph connecting dataset to psychology interests", 2),
        ],
        10,
    ),
    (
        2019055,
        "Final Project: Draft Analysis",
        [
            ("Working code — imports, cleans, tidies; runs without errors from fresh session", 5),
            ("Preliminary visualizations — at least 2 plots, appropriate geoms, labeled axes and titles", 5),
            ("Outline of findings — patterns observed, surprises, whether questions evolved", 3),
            ("Remaining tasks — specific, realistic plan for what still needs to be done", 2),
        ],
        15,
    ),
    (
        2019056,
        "Final Project: Final Report",
        [
            ("Introduction — clear, well-motivated, 2-3 paragraphs", 5),
            ("Data description — complete, includes summary table with kable", 5),
            ("Visualizations — 4-6 figures, polished, appropriate geoms, titles, captions, colorblind-friendly", 20),
            ("Narrative — interpretation is clear, connected to research questions, uses inline code", 10),
            ("Discussion — thoughtful reflection on findings and limitations", 5),
            ("Reflection — honest, thoughtful about challenges and growth", 5),
            ("Reproducibility — renders cleanly, relative paths, inline code, setup chunk", 5),
            ("Code quality — organized, readable, well-commented, uses pipe appropriately", 5),
        ],
        60,
    ),
    (
        2019057,
        "Final Project: Presentation",
        [
            ("Clear introduction of dataset and questions", 3),
            ("Figures are well-chosen and clearly explained", 5),
            ("Narrative is engaging and easy to follow", 3),
            ("Reflection shows genuine thought", 2),
            ("Within 5-minute time limit", 2),
        ],
        15,
    ),
]

for aid, title, criteria, total in project_rubrics:
    create_rubric(aid, title, criteria, total)

# ============================================================
# SYLLABUS PAGE
# ============================================================
print("\n=== SYLLABUS PAGE ===")

syllabus_body = """
<h2>Course Information</h2>
<table>
<tr><td><strong>Course</strong></td><td>PSY 410/510: Data Science for Psychology (CRN: 35882)</td></tr>
<tr><td><strong>Instructor</strong></td><td>Dr. Sara Weston (<a href="mailto:sweston2@uoregon.edu">sweston2@uoregon.edu</a>)</td></tr>
<tr><td><strong>TA</strong></td><td>Amala Someshwar (<a href="mailto:asomeshw@uoregon.edu">asomeshw@uoregon.edu</a>)</td></tr>
<tr><td><strong>Meetings</strong></td><td>Mondays &amp; Wednesdays, 12:00\u20131:20 PM</td></tr>
<tr><td><strong>Dates</strong></td><td>March 30 \u2013 June 3, 2026</td></tr>
</table>

<h2>Course Description</h2>
<p>This course introduces psychology majors to modern data science tools and techniques using R and the tidyverse. Students will learn to import, tidy, transform, visualize, and communicate data effectively. The course emphasizes practical skills for working with real psychological data, reproducible research practices, and creating publication-ready visualizations.</p>

<h2>Learning Objectives</h2>
<ol>
<li><strong>Import and tidy data</strong> from various sources (CSV, Excel) into analysis-ready formats</li>
<li><strong>Transform data</strong> using dplyr verbs (filter, select, mutate, summarize, join)</li>
<li><strong>Create effective visualizations</strong> using ggplot2, applying principles of visual perception and design</li>
<li><strong>Conduct exploratory data analysis</strong> to understand patterns and relationships in data</li>
<li><strong>Produce reproducible reports</strong> using Quarto that integrate code, results, and narrative</li>
<li><strong>Communicate findings</strong> through well-designed figures that tell a clear story</li>
</ol>

<h2>Required Materials</h2>
<h3>Textbook (Free Online)</h3>
<p>Wickham, H., \u00c7etinkaya-Rundel, M., &amp; Grolemund, G. (2023). <em>R for Data Science</em> (2nd ed.). Available free at <a href="https://r4ds.hadley.nz/">r4ds.hadley.nz</a></p>
<h3>Software (Free)</h3>
<ul>
<li><strong>R:</strong> <a href="https://cloud.r-project.org/">cloud.r-project.org</a></li>
<li><strong>RStudio Desktop:</strong> <a href="https://posit.co/download/rstudio-desktop/">posit.co/downloads</a></li>
</ul>

<h2>Grading</h2>
<table>
<thead><tr><th>Component</th><th>Weight</th><th>Details</th></tr></thead>
<tbody>
<tr><td>Weekly Coding Assignments</td><td>35%</td><td>8 assignments</td></tr>
<tr><td>Reading Quizzes</td><td>15%</td><td>10 quizzes, unlimited retakes, best score counts</td></tr>
<tr><td>In-Class Participation</td><td>15%</td><td>Completion-based coding exercises</td></tr>
<tr><td>Final Project</td><td>35%</td><td>Proposal, draft, final report, presentation</td></tr>
</tbody>
</table>

<h3>Weekly Coding Assignments (35%)</h3>
<p>Short, focused exercises reinforcing each session\u2019s content. Due <strong>Sundays at 11:59 PM</strong>. Designed to take 1\u20132 hours outside of class.</p>

<h3>Reading Quizzes (15%)</h3>
<p>Weekly Canvas quizzes covering assigned readings. Due <strong>Sundays at 11:59 PM</strong>. Each quiz draws 5 random questions from a larger bank. <strong>Unlimited attempts; best score counts.</strong></p>

<h3>In-Class Participation (15%)</h3>
<p>During each class, you\u2019ll work with a partner on coding exercises. Graded on completion and good-faith effort, not correctness.</p>

<h3>Final Project (35%)</h3>
<p>A capstone project analyzing a dataset of your choosing. Four milestones: Proposal (Week 5), Draft (Week 8), Final Report (Week 10), and Presentation (Finals Week).</p>

<h3>Team Challenge (Not Part of Your Grade)</h3>
<p>Teams of 5\u20136 students earn points across four categories: pair coding completion, assignment submission, quiz performance, and weekly fun challenges. The winning team earns a celebration at the end of the term.</p>

<h2>Course Policies</h2>

<h3>Late Work</h3>
<p>Assignments and quizzes can be submitted up to <strong>48 hours</strong> past the deadline with a <strong>10% penalty per day</strong>. After 48 hours, late submissions are not accepted.</p>

<h3>Collaboration</h3>
<p>You are encouraged to discuss approaches with classmates. However, all code you submit must be your own. Do not copy code from another student or share your code for others to copy.</p>

<h3>AI Tools Policy</h3>
<p><strong>No AI tools in this course.</strong> AI tools like ChatGPT, Claude, and GitHub Copilot are prohibited on all assessments. The goal is to build foundational skills through practice \u2014 using AI before you have these foundations creates an illusion of competence. By building a strong foundation now, you\u2019ll be in a far better position to leverage AI as a collaborator in your future work.</p>
"""

create_page("Syllabus", syllabus_body)

# ============================================================
# SCHEDULE PAGE
# ============================================================
print("\n=== SCHEDULE PAGE ===")

schedule_body = f"""
<p><strong>All readings should be completed before the class session.</strong> R4DS = <a href="https://r4ds.hadley.nz/">R for Data Science (2nd ed.)</a></p>

<h2>Week 1: Mar 30 \u2013 Apr 5</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>1</td><td>Mon Mar 30</td><td><a href="{SITE}/slides/01-intro-setup.html">Introduction &amp; Setup</a></td><td>R4DS Ch 2, 6</td><td></td></tr>
<tr><td>2</td><td>Wed Apr 1</td><td><a href="{SITE}/slides/02-first-visualization.html">Your First Visualization</a></td><td>R4DS Ch 1</td><td>Quiz 1 (Tue); A1 assigned</td></tr>
</tbody></table>

<h2>Week 2: Apr 6 \u2013 Apr 12</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>3</td><td>Mon Apr 6</td><td><a href="{SITE}/slides/03-data-transformation-1.html">Data Transformation I</a></td><td>R4DS Ch 3 (3.1\u20133.4)</td><td>A1 (Sun Apr 5)</td></tr>
<tr><td>4</td><td>Wed Apr 8</td><td><a href="{SITE}/slides/04-data-transformation-2.html">Data Transformation II</a></td><td>R4DS Ch 3 (3.5), Ch 4</td><td>Quiz 2 (Tue); A2 assigned</td></tr>
</tbody></table>

<h2>Week 3: Apr 13 \u2013 Apr 19</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>5</td><td>Mon Apr 13</td><td><a href="{SITE}/slides/05-data-tidying.html">Data Tidying</a></td><td>R4DS Ch 5</td><td>A2 (Sun Apr 12)</td></tr>
<tr><td>6</td><td>Wed Apr 15</td><td><a href="{SITE}/slides/06-data-import.html">Data Import</a></td><td>R4DS Ch 7, 20</td><td>Quiz 3 (Tue)</td></tr>
</tbody></table>

<h2>Week 4: Apr 20 \u2013 Apr 26</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>7</td><td>Mon Apr 20</td><td><a href="{SITE}/slides/16-quarto.html">Quarto &amp; Reproducibility</a></td><td>R4DS Ch 28</td><td>A3 assigned</td></tr>
<tr><td>8</td><td>Wed Apr 22</td><td><a href="{SITE}/slides/07-layers-aesthetics.html">Layers &amp; Aesthetics</a></td><td>R4DS Ch 9</td><td>Quiz 4 (Tue)</td></tr>
</tbody></table>

<h2>Week 5: Apr 27 \u2013 May 3</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>9</td><td>Mon Apr 27</td><td><a href="{SITE}/slides/08-perception-design.html">Perception &amp; Design</a></td><td>Knaflic Ch 1\u20133 (optional)</td><td>A3 (Sun Apr 26); A4 assigned</td></tr>
<tr><td>10</td><td>Wed Apr 29</td><td><a href="{SITE}/slides/09-eda-variation.html">EDA \u2014 Variation</a></td><td>R4DS Ch 10 (10.1\u201310.4)</td><td>Quiz 5 (Tue); Proposal (Tue)</td></tr>
</tbody></table>

<h2>Week 6: May 4 \u2013 May 10</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>11</td><td>Mon May 4</td><td><a href="{SITE}/slides/10-eda-covariation.html">EDA \u2014 Covariation</a></td><td>R4DS Ch 10 (10.5\u201310.6)</td><td>A4 (Sun May 3); A5 assigned</td></tr>
<tr><td>12</td><td>Wed May 6</td><td><a href="{SITE}/slides/11-data-types.html">Data Types Grab Bag</a></td><td>R4DS Ch 12, 13</td><td>Quiz 6 (Tue)</td></tr>
</tbody></table>

<h2>Week 7: May 11 \u2013 May 17</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>13</td><td>Mon May 11</td><td><a href="{SITE}/slides/12-strings-factors.html">Strings, Factors &amp; Text</a></td><td>R4DS Ch 14 (14.1\u201314.3), Ch 16</td><td>A5 (Sun May 10); A6 assigned</td></tr>
<tr><td>14</td><td>Wed May 13</td><td><a href="{SITE}/slides/13-joins.html">Joins</a></td><td>R4DS Ch 19</td><td>Quiz 7 (Tue); A7 assigned</td></tr>
</tbody></table>

<h2>Week 8: May 18 \u2013 May 24</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>\u2014</td><td>Mon May 18</td><td><em>No class</em></td><td></td><td>A6 (Sun May 17)</td></tr>
<tr><td>15</td><td>Wed May 20</td><td><a href="{SITE}/slides/14-missing-data.html">Missing Data</a></td><td>R4DS Ch 18</td><td>Quiz 8 (Tue); Draft (Wed)</td></tr>
</tbody></table>

<h2>Week 9: May 25 \u2013 May 31</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>\u2014</td><td>Mon May 25</td><td><em>Memorial Day \u2014 No class</em></td><td></td><td>A7 (Sun May 24)</td></tr>
<tr><td>16</td><td>Wed May 27</td><td><a href="{SITE}/slides/15-storytelling.html">Storytelling with Data</a></td><td>R4DS Ch 11</td><td>Quiz 9 (Tue); A8 assigned</td></tr>
</tbody></table>

<h2>Week 10: Jun 1 \u2013 Jun 7</h2>
<table>
<thead><tr><th>Session</th><th>Date</th><th>Topic</th><th>Readings</th><th>Due</th></tr></thead>
<tbody>
<tr><td>17</td><td>Mon Jun 1</td><td><a href="{SITE}/slides/17-correlation-regression.html">Correlation &amp; Simple Regression</a></td><td></td><td>A8 (Sun May 31)</td></tr>
<tr><td>18</td><td>Wed Jun 3</td><td><a href="{SITE}/slides/18-putting-it-together.html">Putting It All Together</a></td><td>R4DS Ch 8</td><td>Quiz 10 (Tue); Final Report (Wed)</td></tr>
</tbody></table>

<h2>Finals Week</h2>
<table>
<thead><tr><th>Date</th><th>Due</th></tr></thead>
<tbody>
<tr><td>Wed Jun 10</td><td>Final Project Presentation (5-min recorded video)</td></tr>
</tbody></table>
"""

create_page("Schedule", schedule_body)

# ============================================================
# UPLOAD HANDOUTS
# ============================================================
print("\n=== UPLOADING HANDOUTS ===")

script_dir = os.path.dirname(os.path.abspath(__file__))
handout_dir = os.path.join(os.path.dirname(script_dir), "files")

handouts_to_upload = [
    "apa-figure-guidelines.md",
    "team-challenge-handout.md",
    "data-viz-principles.md",
    "team-formation-survey.md",
]

# Add session handouts
for f in sorted(os.listdir(handout_dir)):
    if f.startswith("handout-") and f.endswith(".md"):
        handouts_to_upload.append(f)

for filename in handouts_to_upload:
    filepath = os.path.join(handout_dir, filename)
    if os.path.exists(filepath):
        upload_file(filepath, "handouts")
    else:
        print(f"  ! File not found: {filename}")

print("\n=== DONE ===")
print("Don't forget to delete your API token!")
