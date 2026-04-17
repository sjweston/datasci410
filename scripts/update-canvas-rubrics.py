#!/usr/bin/env python3
"""Update Canvas rubrics for assignments 3-8 with per-subtask grading."""

import requests
import json
import sys
import math

API_URL = "https://canvas.uoregon.edu/api/v1"
COURSE_ID = 287793
TOKEN = sys.argv[1] if len(sys.argv) > 1 else ""

HEADERS = {"Authorization": f"Bearer {TOKEN}"}

def make_criterion(description, points, long_desc=""):
    """Create a rubric criterion with 4 rating levels."""
    minus_one = points - 1
    half = math.ceil(points / 2)

    # For small point values (<=3), adjust so levels don't collapse
    if points <= 3:
        half = 1

    return {
        "description": description,
        "long_description": long_desc,
        "points": points,
        "criterion_use_range": False,
        "ratings": [
            {"description": "Full marks", "long_description": "Correct", "points": points},
            {"description": "Minor error", "long_description": "One small error (typo, formatting issue, minor syntax)", "points": minus_one},
            {"description": "Major error", "long_description": "One major error in approach or output", "points": half},
            {"description": "Not attempted", "long_description": "Not attempted or multiple major errors", "points": 0},
        ]
    }

def make_knit_criterion():
    """The QMD-knits criterion (same for all assignments)."""
    return {
        "description": "QMD file knits without errors",
        "long_description": "Quarto document renders successfully to HTML. This is about the document compiling, not whether individual code chunks produce correct output.",
        "points": 10,
        "criterion_use_range": False,
        "ratings": [
            {"description": "Knits cleanly", "long_description": "Document renders without errors", "points": 10},
            {"description": "Minor knit issue", "long_description": "Renders but with warnings or minor formatting problems", "points": 9},
            {"description": "Knit errors", "long_description": "Document fails to render due to code/YAML errors", "points": 5},
            {"description": "Does not knit", "long_description": "No QMD submitted or completely broken", "points": 0},
        ]
    }

# Define rubrics for each assignment
RUBRICS = {
    2018902: {  # A3
        "title": "Assignment 3: Tidying & Importing Data",
        "criteria": [
            make_criterion("Task 1.1: Pivot to long format", 10,
                "Correct use of pivot_longer() producing participant_id, condition, time, and anxiety columns"),
            make_criterion("Task 1.2: Calculate means by time and condition", 10,
                "Correct group_by + summarize producing mean anxiety at each time point per condition"),
            make_criterion("Task 1.3: Create line plot", 10,
                "Line plot showing anxiety over time with separate lines per condition and individual points"),
            make_criterion("Task 2.1: Pivot to wide format", 15,
                "Correct use of pivot_wider() with each emotion as its own column"),
            make_criterion("Task 2.2: Create sum of emotion ratings", 10,
                "New variable summing all three emotion ratings per participant"),
            make_criterion("Task 3.1: Import CSV with read_csv()", 10,
                "Successfully imports survey_data.csv and notes any warnings"),
            make_criterion("Task 3.2: Re-import handling NA values and column types", 15,
                "Uses na argument to handle 'N/A' strings and col_types to fix column types"),
            make_criterion("Task 3.3: Import Excel with readxl", 10,
                "Correctly imports demographics.xlsx from the second sheet"),
            make_knit_criterion(),
        ]
    },
    2018903: {  # A4
        "title": "Assignment 4: Visualization Deep Dive",
        "criteria": [
            make_criterion("Task 1.1: Summary table (mean + SE by species)", 10,
                "Summary table with mean flipper length and standard error for each penguin species"),
            make_criterion("Task 1.2: Bar chart with error bars", 15,
                "Bar chart of mean flipper length by species with SE error bars, clean labels, colorblind-friendly palette"),
            make_criterion("Task 2.1: Histogram with bin width exploration", 8,
                "Histogram of body mass with comment explaining bin width choice"),
            make_criterion("Task 2.2: Overlapping density plots by species", 8,
                "Density plots colored by species with transparency so all distributions are visible"),
            make_criterion("Task 2.3: Boxplot vs. violin plot comparison", 9,
                "Both boxplot and violin plot of body mass by species, with comment comparing what each reveals"),
            make_criterion("Task 3.1: Intentionally bad visualization", 12,
                "Visualization violating 4+ design principles with comments listing each violation"),
            make_criterion("Task 3.2: Good visualization with design justification", 13,
                "Clean visualization of same data with comments explaining design choices"),
            make_criterion("Task 4.1: Import data and convert team to factor", 5,
                "Imports partisan_bias.csv and converts team to labeled factor (Spain, Greece, No Team)"),
            make_criterion("Task 4.2: Recreate Figure 3", 10,
                "Reasonable recreation of the figure with appropriate geom, error bars, labels, and theme"),
            make_knit_criterion(),
        ]
    },
    2018904: {  # A5
        "title": "Assignment 5: Exploratory Data Analysis",
        "criteria": [
            make_criterion("Task 1.1: Histograms for age and personality item", 8,
                "Histograms for age and at least one personality item with observations about distributions"),
            make_criterion("Task 1.2: Outlier detection in age", 8,
                "Programmatic identification of outliers (e.g., 3 SD rule or filter with bounds)"),
            make_criterion("Task 1.3: Missing data summary", 9,
                "Summary showing percentage of NA values for each variable"),
            make_criterion("Task 2.1: Correlation matrix of E1-E5", 10,
                "Correlation matrix visualization for the 5 Extraversion items with observation about patterns"),
            make_criterion("Task 2.2: Scatterplot of two Extraversion items", 10,
                "Scatterplot of two E items chosen from correlation matrix, with trend line and interpretation"),
            make_criterion("Task 2.3: Boxplots by education level", 10,
                "Boxplots showing one Extraversion item by education level with interpretation"),
            make_criterion("Task 3.1: Generate 3 research questions", 8,
                "Three interesting, specific questions that could be investigated with the bfi data"),
            make_criterion("Task 3.2: Visualization + interpretation for one question", 12,
                "Visualization addressing one question with written interpretation of findings"),
            make_criterion("Part 4: EDA report (300-400 words)", 15,
                "Narrative report covering dataset description, key findings, data quality issues, and next steps"),
            make_knit_criterion(),
        ]
    },
    2018905: {  # A6
        "title": "Assignment 6: Data Types & Wrangling",
        "criteria": [
            make_criterion("Task 1.1: Create passed_attention logical variable", 6,
                "Logical variable correctly identifying participants who answered 4 on the attention check, with count"),
            make_criterion("Task 1.2: Reverse-code q3 and q5", 7,
                "New variables q3 and q5 created using 8 - old_value formula"),
            make_criterion("Task 1.3: Create scale_mean", 6,
                "Mean of q1, q2, q3, q4, q5 calculated correctly for each participant"),
            make_criterion("Task 1.4: Create age_group with case_when()", 6,
                "Age group variable with correct cutoffs: young (<30), middle (30-49), older (50+)"),
            make_criterion("Task 2.1: Clean major variable", 10,
                "Major variable standardized to 'Psychology', 'Biology', or 'Sociology' using string functions"),
            make_criterion("Task 2.2: Clean education variable", 10,
                "Education variable standardized to 'High School', 'College', or 'Graduate'"),
            make_criterion("Task 3.1: Convert education to ordered factor", 5,
                "Education converted to factor with levels in order: High School, College, Graduate"),
            make_criterion("Task 3.2: Education bar chart (both versions)", 5,
                "Two bar charts showing education — one with and one without factor levels set"),
            make_criterion("Task 4.1: Age group factor + boxplot", 10,
                "Age group as ordered factor (young, middle, older) with boxplot of scale_mean in correct order"),
            make_criterion("Part 5: Complete data cleaning pipeline", 10,
                "Single piped sequence that filters, recodes, creates scale mean, creates factor, and selects columns"),
            make_criterion("Task 6.1: Tokenize responses", 5,
                "Correct use of unnest_tokens() to split responses into words"),
            make_criterion("Task 6.2: Remove stop words", 5,
                "Stop words removed with anti_join(stop_words), count of unique words remaining"),
            make_criterion("Task 6.3: Word frequency bar chart", 5,
                "Bar chart of 10 most common words with comment about emerging themes"),
            make_knit_criterion(),
        ]
    },
    2018906: {  # A7
        "title": "Assignment 7: Joins & Missing Data",
        "criteria": [
            make_criterion("Task 1.1: Explore datasets and identify overlaps", 7,
                "Counts participants in each dataset and identifies who appears in one but not others"),
            make_criterion("Task 1.2: Use anti_join() to find mismatches", 8,
                "Two anti_joins showing mismatched participants in both directions, with explanation"),
            make_criterion("Task 2.1: inner_join() demographics + survey", 10,
                "Correct inner join with participant count"),
            make_criterion("Task 2.2: left_join() demographics + survey", 10,
                "Correct left join keeping all demographics, with count of missing survey data"),
            make_criterion("Task 2.3: Summarize task data and join", 10,
                "Task data summarized to mean RT and accuracy per participant, then joined with combined dataset"),
            make_criterion("Task 3.1: Missing data summary (counts + percentages)", 7,
                "Summary showing number and percentage of missing values for each variable"),
            make_criterion("Task 3.2: Missingness by condition", 8,
                "Percentage of missing anxiety, depression, and stress scores calculated per condition"),
            make_criterion("Task 3.3: Missingness visualization", 7,
                "Visualization showing the pattern of missingness across variables"),
            make_criterion("Task 3.4: Complete cases vs. available data comparison", 8,
                "Two versions of mean anxiety by condition (complete cases vs na.rm=TRUE) with discussion"),
            make_criterion("Part 4: Reflection (3 questions)", 15,
                "Thoughtful answers to all three reflection questions about missing data risks, exclusion criteria, and reporting"),
            make_knit_criterion(),
        ]
    },
    2018907: {  # A8
        "title": "Assignment 8: Reproducible Report",
        "criteria": [
            make_criterion("YAML header", 5,
                "Includes title, author, date, format with toc and code-fold options"),
            make_criterion("Introduction", 10,
                "Dataset description, research question(s), and motivation"),
            make_criterion("Data import & cleaning", 10,
                "Packages loaded, data imported, cleaning steps with appropriate chunk options"),
            make_criterion("Exploratory analysis", 25,
                "At least 2 visualizations using ggplot2 features with brief interpretation of each"),
            make_criterion("Main analysis", 20,
                "Addresses research question with at least 1 publication-quality figure and summary statistics"),
            make_criterion("Inline code", 10,
                "At least 3 statistics reported using inline R code in narrative text"),
            make_criterion("Conclusion", 10,
                "Summary of key findings, limitations, and future directions"),
            make_knit_criterion(),
        ]
    },
}


def update_rubric(assignment_id, rubric_def):
    """Update a Canvas assignment's rubric."""
    # Build the rubric parameter dict
    params = {
        "rubric_association[association_id]": assignment_id,
        "rubric_association[association_type]": "Assignment",
        "rubric_association[use_for_grading]": 1,
        "rubric_association[purpose]": "grading",
        "rubric[title]": rubric_def["title"],
        "rubric[free_form_criterion_comments]": 1,
    }

    for i, criterion in enumerate(rubric_def["criteria"]):
        prefix = f"rubric[criteria][{i}]"
        params[f"{prefix}[description]"] = criterion["description"]
        params[f"{prefix}[long_description]"] = criterion["long_description"]
        params[f"{prefix}[points]"] = criterion["points"]
        params[f"{prefix}[criterion_use_range]"] = criterion["criterion_use_range"]

        for j, rating in enumerate(criterion["ratings"]):
            rprefix = f"{prefix}[ratings][{j}]"
            params[f"{rprefix}[description]"] = rating["description"]
            params[f"{rprefix}[long_description]"] = rating["long_description"]
            params[f"{rprefix}[points]"] = rating["points"]

    url = f"{API_URL}/courses/{COURSE_ID}/rubrics"
    resp = requests.post(url, headers=HEADERS, data=params)

    if resp.status_code in (200, 201):
        result = resp.json()
        rubric_id = result.get("rubric", {}).get("id") or result.get("id")
        print(f"  OK — rubric ID: {rubric_id}")
        return True
    else:
        print(f"  FAILED ({resp.status_code}): {resp.text[:200]}")
        return False


if __name__ == "__main__":
    if not TOKEN:
        print("Usage: python3 update-canvas-rubrics.py <api_token>")
        sys.exit(1)

    for assignment_id, rubric_def in RUBRICS.items():
        print(f"Updating {rubric_def['title']} (ID: {assignment_id})...")
        update_rubric(assignment_id, rubric_def)
