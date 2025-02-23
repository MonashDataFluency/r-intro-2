# r-intro-resbazvic2024

Introduction to R workshop material for RezBaz Victoria 2024

This workshop material is written in [Quarto](https://quarto.org/). You will need to install Quarto, R, and the `tidyverse` R package to build this workshop material.

To build the html and pdf documents and zip file, use:

```
make
```

To recreate the .csv files from files downloaded from Gapminder, use:

```
make ingest
```


## Typical schedule for a one day workshop

```
10:00am   Welcome overview, Starting out in R, Data frames 
12.30pm   Lunch Break 
1.30pm    Data frames, Plotting with ggplot2 
3.00pm    Tea break 
3.15pm    Plotting with ggplot2, Summarizing data, Thinking in R 
5.00pm    End Workshop
```

`opening_slides_template.pptx` can be used as a template for an opening slideshow. It's traditional to use etherpad in Carpentries-style workshops. Fill in instructor names and the location of your workshop etherpad. An alternative to etherpad that we have used in recent years is a Google Doc plus a Slack channel. Or you can simply make the Google Doc editable by everyone. The workshop etherpad or the Google Doc serves as the central jumping off point for the workshop, and should list at the top:

* schedule
* link to this workshop material
* link to RStudio Cloud


## Teaching advice

* The general style is to type code into an R script and then send it to the console with Ctrl/Command-Enter.

* We don't copy and paste code from the notes, but many of the examples build on previous examples and you should copy and paste from code you've previously written, to save time and to emphasize what is changing.

