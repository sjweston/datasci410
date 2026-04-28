# Assignment 3 — Grades

Total submissions: 22. Graded against the rubric in `files/03-assignment-answer-key.qmd` with lenient scoring: structural issues (code outside chunks, wrong fences, unclosed chunks) penalized only via the knits=0/10 line; task code graded on its merits. All three accepted forms of Task 1.3 are full credit per the answer key callout.

## Summary table

| File | Total | Grad Ext |
|------|------:|---------:|
| 34n6m9km | 99 | — |
| 8y9zo07y | 88 | — |
| e21jkdgo | 94 | — |
| eg0sshg1 | 95 | **28/30** |
| g16chb51 | 100 | — |
| hd85px7o | 73 | — |
| kkptu5bz | 90 | — |
| kp6cqm4y | 87 | — |
| m6qnwbf4 | 38 | — |
| m8iac91d | 95 | — |
| me7tx41b | 93 | — |
| mljx2f5a | 94 | — |
| mpd846zj | 100 | — |
| oanzjard | 100 | — |
| onqcvatu | 100 | — |
| pfscawrv | 70 | — |
| s9df50r1 | 99 | — |
| uqc1w1mt | 74 | — |
| vfa3457p | 99 | — |
| wnnw6rnv | 100 | — |
| wtuptm7b | 45 | — |
| z7n0gpe9 | 100 | **26/30** |

## Distribution

- **Six perfect 100s:** `g16chb51`, `mpd846zj`, `oanzjard`, `onqcvatu`, `wnnw6rnv`, `z7n0gpe9`
- **Mid-90s and above:** ~14 of 22
- **Below 80:** `hd85px7o` (73), `pfscawrv` (70), `uqc1w1mt` (74), `wtuptm7b` (45), `m6qnwbf4` (38)
- **Graduate extensions:** the two enrolled grad students (`eg0sshg1` 28/30, `z7n0gpe9` 26/30)

## Flags worth your attention

### Structural problems (penalized in knits, not in tasks)
- **`pfscawrv` (70/100)** — all assignment code outside R chunks; also never called `pivot_wider` for 2.1
- **`kp6cqm4y` (87/100)** — all assignment code outside R chunks (only the boilerplate `1+1`/`2*2` are real chunks)
- **`wtuptm7b` (45/100)** — whole document inside non-executing ` ```r ` wrapper; multiple invalid functions (`read_xl`, `col_types="?"`)
- **`8y9zo07y` (88/100)** — file ends with an unclosed ` ```{r} ` chunk
- **`m6qnwbf4` (38/100)** — file ends with an unclosed ` ```{r} ` chunk; Part 3 never attempted ("Incomplete: item of sensitive nature")

### Other notable issues
- **`hd85px7o` (73)** — missed Excel import entirely; grouped 1.2 by time only; used `mean()` instead of `sum()` in 2.2
- **`uqc1w1mt` (74)** — missed Excel import; case-mismatch on column names; mean instead of sum
- **`me7tx41b` (93)** — used `mean()` instead of `sum()` in 2.2 (still common cohort error)

### Security flags (grad ext)
- **`eg0sshg1`** and **`z7n0gpe9`** both have hardcoded API keys in their .qmd files — both received G.1 partial (3/5). Recommend reaching out so the keys can be rotated.

## Common error patterns across the cohort

1. **Task 3.3 missing `sheet = 2`** — defaults to sheet 1 (codebook). Affected: `eg0sshg1`, `mljx2f5a`.
2. **Task 2.2: `mean()` instead of `sum()`** — `hd85px7o`, `me7tx41b`, `uqc1w1mt`.
3. **Task 3.1: skipped naive first import** — `e21jkdgo`, `kkptu5bz`, `m8iac91d`, `uqc1w1mt`. Many students went straight to the cleaned `na = "N/A"` import.
4. **Task 1.1: swapped `names_to` / `values_to`** — `m6qnwbf4`. Cascades into broken 1.2 and 1.3.
5. **Task 1.2: grouping by time only, missing condition** — `hd85px7o`, `uqc1w1mt`.

---

## Per-submission detail

### 34n6m9km — 99/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | names_pattern with helper col then dropped — valid |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 9/10  | Used `problems()` instead of narrative note |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |

### 8y9zo07y — 88/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 8/10  | No narrative note about types |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 0/10  | **File ends with unclosed ```{r} chunk** |

### e21jkdgo — 94/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 9/10  | Renamed value col to `anxiety_score` (minor) |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 5/10  | Skipped first exploratory import |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |

### eg0sshg1 — 95/100 (Grad Ext: 28/30)
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 10/10 | Import + problems() + narrative note |
| 3.2  | 15/15 | |
| 3.3  | 5/10  | **Defaulted to sheet 1 (codebook)** |
| Knits | 10/10 | |
| **Grad** | **28/30** | G.1 partial (API key hardcoded); G.2–G.5 full |

### g16chb51 — 100/100
All correct.

### hd85px7o — 73/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 5/10  | Grouped by time only, missing condition |
| 1.3  | 10/10 | geom_smooth + jitter — accepted form |
| 2.1  | 15/15 | |
| 2.2  | 5/10  | mean instead of sum |
| 3.1  | 5/10  | Combined with na/col_types; brief narrative |
| 3.2  | 13/15 | participant_id as character (minor) |
| 3.3  | 0/10  | **Excel import not attempted** |
| Knits | 10/10 | |

### kkptu5bz — 90/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 5/10  | summarize drops wide cols (per key: half) |
| 3.1  | 5/10  | Skipped exploratory first import |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |

### kp6cqm4y — 87/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 7/10  | No narrative |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 0/10  | **All assignment code outside R chunks** |

### m6qnwbf4 — 38/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 5/10  | **Swapped names_to/values_to** |
| 1.2  | 5/10  | Cascaded error |
| 1.3  | 5/10  | Cascaded error |
| 2.1  | 15/15 | |
| 2.2  | 8/10  | rowSums variant works (minor) |
| 3.1  | 0/10  | Not attempted (incomplete) |
| 3.2  | 0/10  | Not attempted |
| 3.3  | 0/10  | Not attempted |
| Knits | 0/10  | Unclosed chunk at end |

### m8iac91d — 95/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 5/10  | Skipped exploratory first import |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |

### me7tx41b — 93/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | mutate variant; values correct |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 5/10  | **mean instead of sum** |
| 3.1  | 8/10  | No narrative |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |

### mljx2f5a — 94/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 9/10  | No glimpse |
| 3.2  | 15/15 | |
| 3.3  | 5/10  | **Defaulted to sheet 1 (codebook)** |
| Knits | 10/10 | |

### mpd846zj — 100/100
All correct.

### oanzjard — 100/100
All correct. Plot uses means + error bars (form 3 of accepted variants).

### onqcvatu — 100/100
All correct. Plot uses geom_smooth + jitter (accepted form 2).

### pfscawrv — 70/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 0/15  | **Never called pivot_wider** — references undefined `emotions_wide` |
| 2.2  | 5/10  | mutate logic correct but inherits missing 2.1 |
| 3.1  | 10/10 | |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 0/10  | **All assignment code outside R chunks** |

### s9df50r1 — 99/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 9/10  | `group = participant_id` — per-participant lines (minor) |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 10/10 | |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |

### uqc1w1mt — 74/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 9/10  | Capitalized column names (minor) |
| 1.2  | 5/10  | Grouped by time only |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 5/10  | **mean instead of sum** |
| 3.1  | 5/10  | Skipped first import |
| 3.2  | 15/15 | |
| 3.3  | 0/10  | **Excel import not attempted** |
| Knits | 10/10 | |

### vfa3457p — 99/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 9/10  | No glimpse/comment |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |

### wnnw6rnv — 100/100
All correct. Detailed observations on column types in 3.1.

### wtuptm7b — 45/100
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 0/10  | Not attempted |
| 1.3  | 5/10  | `group = participant_id` and no points |
| 2.1  | 15/15 | |
| 2.2  | 0/10  | summarize without group_by — sums all rows |
| 3.1  | 7/10  | |
| 3.2  | 8/15  | `col_types = "?"` invalid |
| 3.3  | 0/10  | `read_xl` not a function; no sheet arg |
| Knits | 0/10  | **Whole doc in non-executing ```r block** |

### z7n0gpe9 — 100/100 (Grad Ext: 26/30)
| Task | Score | Notes |
|------|------:|-------|
| 1.1  | 10/10 | |
| 1.2  | 10/10 | |
| 1.3  | 10/10 | |
| 2.1  | 15/15 | |
| 2.2  | 10/10 | |
| 3.1  | 10/10 | |
| 3.2  | 15/15 | |
| 3.3  | 10/10 | |
| Knits | 10/10 | |
| **Grad** | **26/30** | G.1 partial (API key hardcoded); G.4 partial (couldn't find Canvas CSV — partial comparison via values vs labels exports); G.2/G.3/G.5 full |
