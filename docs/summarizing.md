# Summarizing data



Having loaded and thoroughly explored a data set, we are ready to distill it down to concise conclusions. At its simplest, this involves calculating summary statistics like counts, means, and standard deviations. Beyond this is the fitting of models, and hypothesis testing and confidence interval calculation. R has a huge number of packages devoted to these tasks and this is a large part of its appeal, but is beyond the scope of today.

Loading the data as before, if you have not already done so:


```r
library(tidyverse)

geo <- read_csv("r-intro-2-files/geo.csv")
geo$income2017 <- factor(geo$income2017, levels=c("low","lower_mid","upper_mid","high"))

gap <- read_csv("r-intro-2-files/gap-minder.csv")
gap_geo <- left_join(gap, geo, by="name")
```


## Summary functions

R has a variety of functions for summarizing a vector, including: `sum`, `mean`, `min`, `max`, `median`, `sd`.


```r
mean( c(1,2,3,4) )
```

```
     [1] 2.5
```

We can use these on the Gapminder data.


```r
gap2010 <- filter(gap_geo, year == 2010)
sum(gap2010$population)
```

```
     [1] 6949495061
```

```r
mean(gap2010$life_exp)
```

```
     [1] NA
```


## Missing values

Why did `mean` fail? The reason is that `life_exp` contains missing values (`NA`).


```r
gap2010$life_exp
```

```
       [1] 56.20 76.31 76.55 82.66 60.08 76.85 75.82 73.34 81.98 80.50 69.13
      [12] 73.79 76.03 70.39 76.68 70.43 79.98 71.38 61.82 72.13 71.64 76.75
      [23] 57.06 74.19 77.08 73.86 57.89 57.73 66.12 57.25 81.29 72.45 47.48
      [34] 56.49 79.12 74.59 76.44 65.93 57.53 60.43 80.40 56.34 76.33 78.39
      [45] 79.88 77.47 79.49 63.69 73.04 74.60 76.72 70.52 74.11 60.93 61.66
      [56] 76.00 61.30 65.28 80.00 81.42 62.86 65.55 72.82 80.09 62.16 80.41
      [67] 71.34 71.25 57.99 55.65 65.49 32.11 71.58 82.61 74.52 82.03 66.20
      [78] 69.90 74.45 67.24 80.38 81.42 81.69 74.66 82.85 75.78 68.37 62.76
      [89] 60.73 70.10 80.13 78.20 68.45 63.80 73.06 79.85 46.50 60.77 76.10
     [100]    NA 73.17 81.35 74.01 60.84 53.07 74.46 77.91 59.46 80.28 63.72
     [111] 68.23 73.42 75.47 65.38 69.74    NA 66.18 76.36 73.55 54.48 66.84
     [122] 58.60    NA 68.26 80.73 80.90 77.36 58.78 60.53 81.04 76.09 65.33
     [133]    NA 77.85 58.70 74.07 77.92 69.03 76.30 79.84 79.52 73.66 69.24
     [144] 64.59    NA 75.48 71.64 71.46    NA 68.91 75.13 64.01 74.65 73.38
     [155] 55.05 82.69 75.52 79.45 61.71 53.13 54.27 81.94 74.42 66.29 70.32
     [166] 46.98 81.52 82.21 76.15 79.19 69.61 59.30 76.57 71.10 58.74 69.86
     [177] 72.56 76.89 78.21 67.94    NA 56.81 70.41 76.51 80.34 78.74 76.36
     [188] 68.77 63.02 75.41 72.27 73.07 67.51 52.02 49.57 58.13
```

R will not ignore these unless we explicitly tell it to with `na.rm=TRUE`.


```r
mean(gap2010$life_exp, na.rm=TRUE)
```

```
     [1] 70.34005
```

Ideally we should also use `weighted.mean` here, to take population into account.


```r
weighted.mean(gap2010$life_exp, gap2010$population, na.rm=TRUE)
```

```
     [1] 70.96192
```

`NA` is a special value. If we try to calculate with `NA`, the result is `NA`


```r
NA + 1
```

```
     [1] NA
```

`is.na` can be used to detect `NA` values, or `na.omit` can be used to directly remove rows of a data frame containing them.


```r
is.na( c(1,2,NA,3) )
```

```
     [1] FALSE FALSE  TRUE FALSE
```

```r
cleaned <- filter(gap2010, !is.na(life_exp))
weighted.mean(cleaned$life_exp, cleaned$population)
```

```
     [1] 70.96192
```

## Grouped summaries

The `summarize` function in `dplyr` allows summary functions to be applied to data frames.


```r
summarize(gap2010, mean_life_exp=weighted.mean(life_exp, population, na.rm=TRUE))
```

```
     # A tibble: 1 x 1
       mean_life_exp
               <dbl>
     1          71.0
```

So far unremarkable, but `summarize` comes into its own when the `group_by` "adjective" is used.


```r
summarize(
    group_by(gap_geo, year), 
    mean_life_exp=weighted.mean(life_exp, population, na.rm=TRUE))
```

```
     # A tibble: 22 x 2
         year mean_life_exp
        <int>         <dbl>
      1  1800          30.9
      2  1810          31.1
      3  1820          31.2
      4  1830          31.4
      5  1840          31.4
      6  1850          31.6
      7  1860          30.3
      8  1870          31.5
      9  1880          32.0
     10  1890          32.5
     # ... with 12 more rows
```


### Challenge: summarizing {- .challenge}

What is the total population for each year? Plot the result.

Advanced: What is the total GDP for each year? For this you will first need to calculate GDP per capita times the population of each country.


### {-}

`group_by` can be used to group by multiple columns, much like `count`. We can use this to see how the rest of the world is catching up to OECD nations in terms of life expectancy.


```r
result <- summarize(
    group_by(gap_geo,year,oecd), 
    mean_life_exp=weighted.mean(life_exp, population, na.rm=TRUE))
result
```

```
     # A tibble: 44 x 3
     # Groups:   year [?]
         year oecd  mean_life_exp
        <int> <lgl>         <dbl>
      1  1800 FALSE          29.9
      2  1800 TRUE           34.7
      3  1810 FALSE          29.9
      4  1810 TRUE           35.2
      5  1820 FALSE          30.0
      6  1820 TRUE           35.9
      7  1830 FALSE          30.0
      8  1830 TRUE           36.2
      9  1840 FALSE          30.0
     10  1840 TRUE           36.2
     # ... with 34 more rows
```

```r
ggplot(result, aes(x=year,y=mean_life_exp,color=oecd)) + geom_line()
```

<img src="summarizing_files/figure-html/unnamed-chunk-12-1.png" width="576" style="display: block; margin: auto;" />



## t-test

We will finish this section by demonstrating a t-test as an example of statistical tests available in R.

Has life expectancy increased from 2000 to 2010?


```r
gap2000 <- filter(gap_geo, year == 2000)
gap2010 <- filter(gap_geo, year == 2010)

t.test(gap2010$life_exp, gap2000$life_exp)
```

```
     
     	Welch Two Sample t-test
     
     data:  gap2010$life_exp and gap2000$life_exp
     t = 3.0341, df = 374.98, p-value = 0.002581
     alternative hypothesis: true difference in means is not equal to 0
     95 percent confidence interval:
      1.023455 4.792947
     sample estimates:
     mean of x mean of y 
      70.34005  67.43185
```

This can actually be considered a paired sample t-test. We can specify `paired=TRUE` to `t.test` to perform a paired sample t-test (check this by looking at the help page with `?t.test`). It's important to first check that both data frames are in the same order.


```r
all(gap2000$name == gap2010$name)
```

```
     [1] TRUE
```

```r
t.test(gap2010$life_exp, gap2000$life_exp, paired=TRUE)
```

```
     
     	Paired t-test
     
     data:  gap2010$life_exp and gap2000$life_exp
     t = 13.371, df = 188, p-value < 2.2e-16
     alternative hypothesis: true difference in means is not equal to 0
     95 percent confidence interval:
      2.479153 3.337249
     sample estimates:
     mean of the differences 
                    2.908201
```

When performing a statistical test, it's good practice to visualize the data to make sure there is nothing funny going on.


```r
plot(gap2000$life_exp, gap2010$life_exp, xlim=c(0,90),ylim=c(0,90))
abline(0,1)
```

<img src="summarizing_files/figure-html/unnamed-chunk-15-1.png" width="384" style="display: block; margin: auto;" />


# Thinking in R

The result of a t-test is actually a value we can manipulate further. Two functions help us here. `class` gives the "public face" of a value, and `typeof` gives its underlying type, the way R thinks of it internally. For example numbers are "numeric" and have some representation in computer memory, either "integer" for whole numbers only, or "double" which can hold fractional numbers (stored in memory in a base-2 version of scientific notation).


```r
class(42)
```

```
     [1] "numeric"
```

```r
typeof(42)
```

```
     [1] "double"
```

Let's look at the result of a t-test:


```r
result <- t.test(gap2010$life_exp, gap2000$life_exp, paired=TRUE)

class(result)
```

```
     [1] "htest"
```

```r
typeof(result)
```

```
     [1] "list"
```

```r
names(result)
```

```
     [1] "statistic"   "parameter"   "p.value"     "conf.int"    "estimate"   
     [6] "null.value"  "alternative" "method"      "data.name"
```

```r
result$p.value
```

```
     [1] 4.301261e-29
```

In R, a t-test is just another function returning just another type of data, so it can also be a building block. The value it returns is a special type of vector called a "list", but with a public face that presents itself nicely. This is a common pattern in R. Besides printing to the console nicely, this public face may alter the behaviour of generic functions such as `plot` and `summary`.

Similarly a data frame is a list of vectors that is able to present itself nicely.

## Lists

Lists are vectors that can hold anything as elements (even other lists!). It's possible to create lists with the `list` function. This becomes especially useful once you get into the programming side of R. For example writing your own function that needs to return multiple values, it could do so in the form of a list.


```r
mylist <- list(hello=c("Hello","world"), numbers=c(1,2,3,4))
mylist
```

```
     $hello
     [1] "Hello" "world"
     
     $numbers
     [1] 1 2 3 4
```

```r
class(mylist)
```

```
     [1] "list"
```

```r
typeof(mylist)
```

```
     [1] "list"
```

```r
names(mylist)
```

```
     [1] "hello"   "numbers"
```

Accessing lists can be done by name with `$` or by position with `[[ ]]`. 


```r
mylist$hello
```

```
     [1] "Hello" "world"
```

```r
mylist[[2]]
```

```
     [1] 1 2 3 4
```


## Other types not covered here

Matrices are another tabular data type. These come up when doing more mathematical tasks in R. They are also commonly used in bioinformatics, for example to represent RNA-Seq count data. A matrix, as compared to a data frame:

* contains only one type of data, usually numeric (rather than different types in different columns).
* commonly has `rownames` as well as `colnames`. (Base R data frames can have `rownames` too, but it is easier to have any sort of ID as a normal column instead.)
* has individual cells as the unit of observation (rather than rows).

Matrices can be created using `as.matrix` from a data frame, `matrix` from a single vector, or using `rbind` or `cbind` with several vectors.

You may also encounter "S4 objects", especially if you use [Bioconductor](http://bioconductor.org/) packages. The syntax for using these is different again, and uses `@` to access elements.


## Programming

Once you have a useful data analysis, you may want to do it again with different data. You may have some task that needs to be done many times over. This is where programming comes in:

* Writing your own [functions](http://r4ds.had.co.nz/functions.html).
* [For-loops](http://r4ds.had.co.nz/iteration.html) to do things multiple times.
* [If-statements](http://r4ds.had.co.nz/functions.html#conditional-execution) to make decisions.

The ["R for Data Science" book](http://r4ds.had.co.nz/) is an excellent source to learn more. The Monash Bioinformatics Platform ["R more" course](https://monashbioinformaticsplatform.github.io/r-more/) also covers this.









