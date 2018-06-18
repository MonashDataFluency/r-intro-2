# Thinking in R

## Lists



## Matrices (optional section)

Matrices are another tabular data type. These come up when doing more mathematical tasks in R. They are also commonly used in bioinformatics, for example to represent RNA-Seq count data.

A matrix, as compared to a data frame:

* contains only one type of data, usually numeric (rather than different types in different columns).
* commonly has `rownames` as well as `colnames`. (Base R data frames can have `rownames` too, but it is easier to have any sort of ID as a normal column instead.)
* has individual cells as the unit of observation (rather than rows).

Matrices can be created using `as.matrix` from a data frame, `matrix` from a single vector, or using `rbind` or `cbind` with several vectors.

