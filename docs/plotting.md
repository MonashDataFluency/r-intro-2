# Plotting with ggplot2


```r
library(tidyverse)
```

```
## Warning: package 'tibble' was built under R version 3.4.3
```

```
## Warning: package 'tidyr' was built under R version 3.4.3
```

```
## Warning: package 'forcats' was built under R version 3.4.3
```

```r
geo <- read_csv("r-intro-2-files/geo.csv")
geo$income2017 <- factor(geo$income2017, levels=c("low","lower_mid","upper_mid","high"))
```



## A larger data set

Let's move on to a larger data set.


```r
gap <- read_csv("r-intro-2-files/gapminder.csv")
```

```
## Parsed with column specification:
## cols(
##   name = col_character(),
##   year = col_double(),
##   population = col_double(),
##   gdp_percap = col_integer(),
##   life_exp = col_double()
## )
```

```
## Warning in rbind(names(probs), probs_f): number of columns of result is not
## a multiple of vector length (arg 1)
```

```
## Warning: 54 parsing failures.
## row # A tibble: 5 x 5 col     row col        expected               actual file                      expected   <int> <chr>      <chr>                  <chr>  <chr>                     actual 1  1152 gdp_percap no trailing characters e3     'r-intro-2-files/gapmind… file 2  3086 gdp_percap no trailing characters e3     'r-intro-2-files/gapmind… row 3  5666 gdp_percap no trailing characters e3     'r-intro-2-files/gapmind… col 4  6192 gdp_percap no trailing characters e3     'r-intro-2-files/gapmind… expected 5  7333 gdp_percap no trailing characters e3     'r-intro-2-files/gapmind…
## ... ................. ... .......................................................................... ........ .......................................................................... ...... .......................................................................... .... .......................................................................... ... .......................................................................... ... .......................................................................... ........ ..........................................................................
## See problems(...) for more details.
```


```r
gap_geo <- left_join(gap, geo, by="name")
```
