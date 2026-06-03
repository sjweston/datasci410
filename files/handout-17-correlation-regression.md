# Session 17: Correlation & Simple Regression — Pen-and-Paper Pair Exercise

**PSY 410 | Data Science for Psychology**

**Name:** ______________________________ &nbsp;&nbsp; **Date:** ______________

*No laptop today? No problem. Work with a partner who has one — you do the paper version, they run the code, you compare at the end.*

## The data

Eight students, daily hours of social media use, and GAD-7 anxiety score:

| student | hours | gad7 | &nbsp; | student | hours | gad7 |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| 1 | 2.1 | 5  | | 5 | 6.2 | 14 |
| 2 | 5.3 | 12 | | 6 | 4.5 | 8  |
| 3 | 1.0 | 3  | | 7 | 0.5 | 4  |
| 4 | 3.8 | 9  | | 8 | 3.0 | 7  |

## Step 1: Sketch a scatterplot

Plot the 8 points on the grid.

```
gad7
 15 |
 12 |
  9 |
  6 |
  3 |
  0 |___________________________
     0   1   2   3   4   5   6   7
              hours_social_media
```

Pattern: positive / negative / none? &nbsp; Strong / moderate / weak?

Your read: _____________________________________________________

## Step 2: Predict r

Based on the shape, circle your best guess:

&nbsp;&nbsp; ~0 &nbsp;•&nbsp; 0.3 &nbsp;•&nbsp; 0.6 &nbsp;•&nbsp; 0.9 &nbsp;•&nbsp; −0.6 &nbsp;•&nbsp; −0.9

## Step 3: Read your partner's output

Your partner runs `lm(gad7_score ~ hours_social_media, data = student_data)` and `summary(model)`. Record what they see:

| Component | Value | What it means |
|---|:-:|---|
| Intercept (b0) | ______ | Predicted GAD-7 when hours = 0 |
| Slope (b1)     | ______ | Change in GAD-7 per +1 hour of social media |
| R-squared      | ______ | Proportion of variation in GAD-7 *predictable from* hours |
| p (slope)      | ______ | Significant at *p* < .05? &nbsp; Y / N |

## Step 4: Make a prediction

Using b0 and b1 from Step 3, predict the GAD-7 score for a student who uses social media 4 hours per day:

&nbsp;&nbsp; Predicted = ______ + ______ × 4 = ______

## Step 5: Reconstruct the code

Fill in the blanks from memory before checking your partner's screen:

```r
cor(student_data$________________, student_data$________________)

model <- lm(__________ ~ __________________, data = student_data)
summary(model)

ggplot(student_data, aes(x = __________________, y = __________)) +
  geom_point() +
  geom_smooth(method = "____") +
  labs(title = "________________________________",
       x = "________________", y = "________________")
```

## Step 6: Correlation vs. causation

Does this analysis prove that social media *causes* anxiety? Why or why not? Name at least one alternative explanation for the pattern.

_______________________________________________________________________

_______________________________________________________________________

---

**Done?** Compare your sketch, your r prediction, and your code with your partner's screen. Do the numbers match what you expected?
