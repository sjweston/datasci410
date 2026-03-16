# WCAG 2.1 AA Accessibility Audit — PSY 410 Course Website

**Date:** March 16, 2026
**Deadline:** April 24, 2026 (federal compliance date for UO web content)
**Standard:** WCAG 2.1 Level AA
**Scope:** Course website (sarajweston.com/datasci410/), all Reveal.js slide decks, content pages, assignment pages, resource pages, and any linked PDFs

---

## Reference Documents

- **UO Federal Rules page** (`2026 Federal Web Accessibility Regulations _ Digital Accessibility @ UO.pdf`) — Confirms that as a UO course website, we must meet WCAG 2.1 AA by April 24, 2026. Covers the website, slides, PDFs, and Canvas materials.
- **WCAG 2.2 Understanding doc** (`Introduction to Understanding WCAG 2.2 _ WAI _ W3C.pdf`) — Background on the four principles (Perceivable, Operable, Understandable, Robust). Useful reference but not itself a checklist.

Both documents are the right references. The UO page tells us *what* applies to us; the WCAG doc explains *how* the criteria work.

---

## Summary of Findings

| Category | Issues Found | Severity |
|----------|-------------|----------|
| Missing `fig-alt` on R-generated plots | ~100+ code chunks across 16 slide decks | **Critical** |
| Missing alt text on markdown images | 6 images in slides | **Critical** |
| Orange exercise backgrounds — low contrast | All 18 slide decks | **High** |
| No `lang="en"` on HTML output | Site-wide | **High** |
| No `prefers-reduced-motion` support | All 18 slide decks | **Medium** |
| No keyboard focus indicators in slide CSS | All 18 slide decks | **Medium** |
| Sidebar active link color may fail contrast | Site-wide (html/custom.scss) | **Medium** |
| Heading hierarchy skip (H1 → H3) | 1 slide deck | **Low** |
| Font Awesome icons lack explicit aria roles | index.qmd | **Low** |

---

## Critical Issues

### 1. R-generated plots have no `fig-alt` text (~100+ instances)

**What:** Every ggplot/base R code chunk that produces a figure should have a `#| fig-alt:` comment describing what the plot shows. Currently, **none** of the ~100+ plot-producing code chunks across 16 slide decks include this.

**Why it matters:** Screen readers will either skip these images entirely or read the file name, which is meaningless. Plots are central to the course content.

**WCAG criterion:** 1.1.1 Non-text Content (Level A)

**How to fix:** Add `#| fig-alt: "Description of what the plot shows"` to every code chunk that produces a figure. The description should convey the key takeaway, not just "a scatterplot." For example:

```r
#| fig-alt: "Scatterplot of engine displacement vs highway mpg showing a negative relationship — larger engines get worse fuel economy"
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
```

**Files affected (all in `slides/`):**
- `02-first-visualization.qmd` — ~22 plots (highest count)
- `07-layers-aesthetics.qmd` — ~15 plots
- `08-perception-design.qmd` — ~12 plots
- `09-eda-variation.qmd` — ~18 plots
- `10-eda-covariation.qmd` — ~15 plots
- `17-correlation-regression.qmd` — ~8 plots
- `03-data-transformation-1.qmd`, `04-data-transformation-2.qmd`, `05-data-tidying.qmd`, `06-data-import.qmd`, `11-data-types.qmd`, `12-strings-factors.qmd`, `13-joins.qmd`, `14-missing-data.qmd`, `15-storytelling.qmd`, `18-putting-it-together.qmd` — various counts

**Note:** Content pages, assignment pages, and resource pages do **not** have this problem — only slides.

---

### 2. Markdown images missing alt text (6 images)

**What:** Six images use empty alt text (`![](path)`).

**WCAG criterion:** 1.1.1 Non-text Content (Level A)

**Files and suggested fixes:**

| File | Line | Image | Suggested alt text |
|------|------|-------|-------------------|
| `slides/01-intro-setup.qmd` | 326 | `file_cabinet.png` | "Filing cabinet representing organized project file structure" |
| `slides/01-intro-setup.qmd` | 333 | `laundry-basket.jpg` | "Laundry basket representing disorganized files scattered without structure" |
| `slides/11-data-types.qmd` | 306 | `rosenberg.png` | "Rosenberg Self-Esteem Scale questionnaire showing Likert-type response options" |
| `slides/15-storytelling.qmd` | 851 | `class-identity.jpg` | Needs context — describe what the figure shows for the critique exercise |
| `slides/15-storytelling.qmd` | 855 | `truth-sensitivity.jpg` | Needs context — describe what the figure shows for the critique exercise |
| `slides/18-putting-it-together.qmd` | 39 | `whole-game.png` (R4DS) | "R4DS data science workflow diagram: Import, Tidy, Transform, Visualize, Model, Communicate" |

**Good news:** `slides/01-intro-setup.qmd` line 250 already has a proper `fig-alt` on the RStudio screenshot, so the pattern is established.

---

## High Priority Issues

### 3. Orange exercise backgrounds fail contrast (~3.2:1)

**What:** All 18 slide decks use `{background-color="#e67e22"}` (orange) for pair coding breaks and end-of-deck exercises. The text on these slides inherits `#2c3e50` (dark blue-gray), producing a contrast ratio of approximately **3.2:1** — below the 4.5:1 requirement for normal text.

**WCAG criterion:** 1.4.3 Contrast (Minimum) (Level AA)

**How to fix (pick one):**
- **Option A:** Change the text color to white (`#ffffff`) on orange backgrounds. White on `#e67e22` = ~3.0:1 — still fails for normal text but passes for large text (headings). Since these slides are typically just a heading, this may be sufficient.
- **Option B:** Darken the orange to `#c0600a` or similar. Darker orange with white text can hit 4.5:1.
- **Option C:** Switch to a different accent color entirely. A dark background with white text (like the section headers using `#2c3e50`) always passes.

**Other backgrounds that pass:**
- `#2c3e50` (dark teal-gray) with white text: ~12:1 ✅
- Link color `#CF4446` on white: ~5.8:1 ✅
- Code blocks `#2e3440` with white text: ~10:1 ✅

**Also check:**
- Sidebar active link `#FFC361` (warm yellow) on light background — estimated ~2.8:1, likely **fails**. Consider darkening to a gold/amber.

---

### 4. No `lang` attribute set

**What:** Neither `_quarto.yml` nor individual `.qmd` files set `lang: en`. Without this, screen readers may guess the language incorrectly, affecting pronunciation.

**WCAG criterion:** 3.1.1 Language of Page (Level A)

**How to fix:** Add one line to the `format: html:` section in `_quarto.yml`:

```yaml
format:
  html:
    lang: en
    theme:
      - litera
      - html/custom.scss
```

---

## Medium Priority Issues

### 5. No `prefers-reduced-motion` support in slides

**What:** The slide CSS includes fragment transitions (`transition: all 0.3s ease`) but no media query to disable them for users who've enabled reduced motion in their OS.

**WCAG criterion:** 2.3.3 Animation from Interactions (Level AAA, but best practice for AA)

**How to fix:** Add to `slides/custom.scss`:

```scss
@media (prefers-reduced-motion: reduce) {
  .reveal .slides section .fragment {
    transition: none !important;
  }
}
```

---

### 6. No keyboard focus indicators in slide CSS

**What:** `slides/custom.scss` defines no `:focus` or `:focus-visible` styles. Keyboard users navigating slides won't see which element has focus.

**WCAG criterion:** 2.4.7 Focus Visible (Level AA)

**How to fix:** Add to `slides/custom.scss`:

```scss
.reveal *:focus-visible {
  outline: 3px solid #e74c3c;
  outline-offset: 2px;
}
```

---

## Low Priority Issues

### 7. Heading hierarchy skip

**File:** `slides/01-intro-setup.qmd`
**Lines:** 648 → 652 — jumps from `#` (H1, slide title) to `###` (H3), skipping H2.

**WCAG criterion:** 1.3.1 Info and Relationships (Level A)

**Note:** In Reveal.js, `#` creates a new slide and `##` creates a sub-slide, so heading hierarchy works differently than in a normal document. This is a minor concern in the slide context but worth fixing if convenient.

---

### 8. Font Awesome icons on index.qmd

**What:** 12 Font Awesome icons (`{{< fa user >}}`, `{{< fa envelope >}}`, etc.) are used decoratively next to descriptive text. They don't have explicit `aria-hidden="true"` attributes, but Quarto's FA shortcode may handle this automatically.

**Action:** Verify in rendered HTML that icons have `aria-hidden="true"` or equivalent. If not, this is a minor issue since the adjacent text provides the same information.

---

## Things That Are Fine

- **Link text quality:** No "click here" or bare URLs — all links use descriptive text ✅
- **Tables:** All 34 markdown tables have proper header rows ✅
- **Content/assignment/resource pages:** No missing alt text (only slides have issues) ✅
- **Font sizes:** Minimum ~16px in slides (footer), root 32px, code 22px — all adequate ✅
- **No auto-advancing slides or autoplay media** ✅
- **No embedded videos or iframes** (avoids caption requirements) ✅
- **Code blocks:** Use syntax highlighting that doesn't rely on color alone ✅
- **Callout boxes:** Distinguish by type label + color, not color alone ✅
- **Speaker notes:** Instructor-only content; slides are self-contained without them ✅
- **Incremental reveals:** User-controlled via keyboard, not automatic ✅

---

## Recommended Fix Order

Given the April 24 deadline (~5 weeks away):

**Week 1: Quick structural fixes**
- [ ] Add `lang: en` to `_quarto.yml` (1 minute)
- [ ] Add `prefers-reduced-motion` media query to `slides/custom.scss` (2 minutes)
- [ ] Add `:focus-visible` styles to `slides/custom.scss` (2 minutes)
- [ ] Fix orange background contrast (choose approach, update `slides/custom.scss` or individual files)
- [ ] Fix sidebar active link color in `html/custom.scss`
- [ ] Add alt text to 6 markdown images in slides

**Weeks 2–4: fig-alt on all plots (biggest task)**
- [ ] `02-first-visualization.qmd` (~22 plots)
- [ ] `07-layers-aesthetics.qmd` (~15 plots)
- [ ] `08-perception-design.qmd` (~12 plots)
- [ ] `09-eda-variation.qmd` (~18 plots)
- [ ] `10-eda-covariation.qmd` (~15 plots)
- [ ] `17-correlation-regression.qmd` (~8 plots)
- [ ] All remaining slide decks (03, 04, 05, 06, 11, 12, 13, 14, 15, 16, 18)

**Week 5: Verification**
- [ ] Verify Font Awesome icons render with `aria-hidden="true"` in HTML output
- [ ] Run automated accessibility checker (e.g., WAVE, axe, pa11y) on rendered site
- [ ] Spot-check keyboard navigation through slides
- [ ] Verify PDF exports (if distributed) are tagged/accessible
