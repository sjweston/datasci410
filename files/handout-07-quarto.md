# Session 7: Quarto & Reproducibility — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

*No laptop today? No problem. This handout lets you practice the same skills on paper. Work with a partner who has a laptop and compare your work at the end.*

---

## The task (same as the slide exercise)

Create a Quarto document that:

1. Has a YAML header with your name and title
2. Includes a short introduction (2–3 sentences)
3. Has a code chunk that loads `tidyverse` and a dataset
4. Creates a visualization
5. Uses inline code to report a summary statistic
6. Renders to HTML

### Your pen-and-paper version

Since Quarto is about *document structure*, this exercise translates well to paper. Write out the document by hand.

**Step 1: Write the YAML header.** Fill in the blanks:

```
---
title: "____________________________"
author: "____________________________"
date: "____________________________"
format: ______
---
```

**Step 2: Write an introduction section.** Use markdown heading syntax. Write 2–3 sentences about what the report will cover. (Use the `mpg` dataset as your topic.)

```
## ____________________________

____________________________________________________________
____________________________________________________________
____________________________________________________________
```

**Step 3: Write a code chunk.** What's the correct syntax to start and end a code chunk in Quarto?

````
```{__}
library(___________)

ggplot(mpg, aes(x = _______, y = _______)) +
  geom_point() +
  labs(
    x = "______________",
    y = "______________"
  )
```
````

**Step 4: Write a sentence with inline code.** Fill in the blank to report the mean highway MPG:

```
The mean highway fuel economy is `r ______(______(mpg$hwy), 1)` miles per gallon.
```

**Step 5: Label the parts.** In the margin of your handwritten document, label each section:
- [ ] YAML header
- [ ] Markdown text (narrative)
- [ ] Code chunk (executable R code)
- [ ] Inline code (embedded in text)

---

## Check your work

Compare your handwritten document with your partner's rendered version.

**Expected YAML:**
```
---
title: "Car Fuel Efficiency Analysis"
author: "Your Name"
date: "2026-04-20"
format: html
---
```

**Expected code chunk:**
````
```{r}
library(tidyverse)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  labs(
    x = "Engine size (L)",
    y = "Highway MPG"
  )
```
````

**Expected inline code:**
```
The mean highway fuel economy is `r round(mean(mpg$hwy), 1)` miles per gallon.
```

The answer is 23.4 miles per gallon. When the document renders, the inline code is replaced with the computed number — no hard-coded values.
