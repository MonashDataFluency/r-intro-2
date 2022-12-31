# Next steps



## Deepen your understanding

**Our number one recommendation is to read the book ["R for Data Science"](http://r4ds.had.co.nz/) by Garrett Grolemund and Hadley Wickham.**

Statistical tasks such as model fitting, hypothesis testing, confidence interval calculation, and prediction are a large part of R, and one we haven't demonstrated fully today. 

For any standard statistical test, there will usually be an R function to perform it. Examples include `t.test` from the previous sections, and also `wilcox.test`, `fisher.test`, `chisq.test`, and `cor.test`. Before applying these functions, you may need to use the methods we've learned today to subset and transform your data, or perform some preliminary summarization such as averaging technical replicates. To make sure there are no problems that might invalidate the results from these tests, always visualize your data. If you are performing many tests, adjust for multiple testing with `p.adjust`.

Going beyond this, linear models and the linear model formula syntax `~` are core to much of what R has to offer statistically. Many statistical techniques take linear models as their starting point, including [limma](https://bioconductor.org/packages/release/bioc/html/limma.html) for differential gene expression, `glm` for logistic regression (etc), survival analysis with `coxph`, and mixed models to characterize variation within populations.

* "Statistical Models in S" by J.M. Chambers and T.J. Hastie is the primary reference for this, although there are some small differences between R and its predecessor S.

* ["An Introduction to Statistical Learning"](http://www-bcf.usc.edu/~gareth/ISL/) by G. James, D. Witten, T. Hastie and R. Tibshirani can be seen as further development of the ideas in "Statistical Models in S", and is available online. It has more of a machine learning than a statistics flavour to it. (The distinction is fuzzy!)

* "Modern Applied Statistics with S" by W.N. Venable and B.D. Ripley is a well respected reference covering R and S. 

* "Linear Models with R" and "Extending the Linear Model with R" by [J. Faraway](http://www.maths.bath.ac.uk/~jjf23/) cover linear models, with many practical examples.

* Many further resources and tutorials exist online.


## Expand your vocabulary

Have a look at these cheat sheets to see what is possible with R.

* [RStudio's collection of cheat sheets](https://www.rstudio.com/resources/cheatsheets/) cover newer packages in R.
* [An old-school cheat sheet](https://cran.r-project.org/doc/contrib/Short-refcard.pdf) for dinosaurs and people wishing to go deeper.
* [A Bioconductor cheat sheet](https://github.com/mikelove/bioc-refcard) for biological data.

[The R Manuals](https://cran.r-project.org/manuals.html) are the place to look if you need a precise definition of how R behaves.


## Join the community

Join the [Data Fluency community at Monash](https://www.monash.edu/data-fluency).

 * Mailing list for workshop and event announcements.
 * Slack for discussion.
 * Drop-in sessions on Friday afternoon.

[Attend further Data Fluency R workshops.](https://www.monash.edu/data-fluency/toolkit/r) The material for our workshops is also available at this link for self-study.

Meetups in Melbourne:

* [MelbURN](https://www.meetup.com/en-AU/MelbURN-Melbourne-Users-of-R-Network/)
* [R-Ladies](https://www.meetup.com/en-AU/R-Ladies-Melbourne/)

[The Carpentries](https://carpentries.org/) run intensive two day workshops on scientific computing and data science topics worldwide. The style of this present workshop is very much based on theirs.

For bioinformatics, the [Monash Bioinformatics Platform](https://www.monash.edu/researchinfrastructure/bioinformatics/training) runs bioinformatics-specific workshops. Also [COMBINE](https://combine.org.au/) is an Australian bioinformatics student and early career researcher organization, and runs Carpentries workshops and similar.
