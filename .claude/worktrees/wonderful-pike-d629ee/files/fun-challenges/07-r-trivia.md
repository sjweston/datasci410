# Fun Challenge 7: R Trivia

**Due:** Sunday, May 17 at 11:59 PM

15 questions covering everything you've learned so far. Work together as a team. No running code --- this is a knowledge check, not a coding exercise!

---

## What does this return?

**1.** What does the following code print?

```r
x <- c(3, 7, NA, 5)
mean(x)
```

**2.** What does the following code print?

```r
c(TRUE, FALSE, TRUE, TRUE) |> sum()
```

**3.** What does the following code produce?

```r
tibble(name = c("Ana", "Bo", "Cal"), score = c(85, 92, 78)) |>
  filter(score > 80) |>
  nrow()
```

---

## Name that function

**4.** What tidyverse function would you use to reshape data from wide format to long format?

**5.** What function reads a CSV file into R? (Give the tidyverse version, not base R.)

**6.** What function would you use to create a new column in a data frame based on existing columns?

---

## Spot the difference

**7.** What is the difference between `=` and `==` in R?

**8.** What is the difference between `read_csv()` and `read.csv()`? Name one practical difference.

**9.** What is the difference between `|>` and `+` when building a ggplot?

---

## Fix this

**10.** What's wrong with this code?

```r
mpg |>
  filter(class == "suv")
  select(manufacturer, model, hwy)
```

**11.** What's wrong with this code?

```r
ggplot(mpg, aes(x = displ, y = hwy)) |>
  geom_point()
```

---

## Grab bag

**12.** What package is `fct_reorder()` from?

**13.** What does `NA` stand for?

**14.** You want to remove rows with missing values in the `age` column. Write one line of code using a tidyverse function.

**15.** In ggplot2, what's the difference between putting `color = "blue"` inside `aes()` vs. outside `aes()`?

---

**Submit:** Numbered answers (1--15) in any document format. One submission per team.
