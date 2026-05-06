# Fun Challenge 2: Code Prediction

**Due:** Sunday, April 12 at 11:59 PM

Each of the 5 code snippets below uses the `mpg` dataset (loaded with the tidyverse). For each snippet, predict what the resulting plot would look like:

1. What **type of plot** is it? (scatterplot, bar chart, histogram, etc.)
2. What's on the **x-axis**? The **y-axis**?
3. **Sketch or describe** what the plot looks like. (A rough hand-drawn sketch is fine --- take a photo and include it. Or write a sentence or two describing the pattern.)

You do **not** need to run the code. The point is to practice reading code and building a mental picture of what it does.

---

## Snippet 1

```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
```

## Snippet 2

```r
ggplot(mpg, aes(x = class)) +
  geom_bar()
```

## Snippet 3

```r
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
```

## Snippet 4

```r
ggplot(mpg, aes(x = hwy)) +
  geom_histogram(binwidth = 2) +
  facet_wrap(~drv)
```

## Snippet 5

```r
ggplot(mpg, aes(x = class, y = hwy)) +
  geom_boxplot() +
  labs(
    title = "Highway fuel economy by vehicle class",
    x = "Vehicle class",
    y = "Highway MPG"
  )
```

---

**Submit:** One document (PDF, Word, or Google Doc) with your team's answers for all 5 snippets. One submission per team.
