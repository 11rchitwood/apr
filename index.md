# apr

The goal of apr is to bring the goodness of [Iversonian array
languages](https://github.com/codereport/array-language-comparisons) to
R. R provides multidimensional arrays out of the box, but many of the
table stakes for array programming are missing. This package seeks to
fill that gap while still adhering to R idioms and conventions.

## Installation

You can install the development version of apr like so:

``` r
pak::pak("11rchitwood/apr")
```

## Functions

I chose to use the function names from [Uiua](https://uiua.org/)
because, unlike other Iversonian array programming languages, Uiua does
not have monadic and dyadic versions of each glyph.

| apr                                                                               | base                                                                                          | arity   |
|-----------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|---------|
| `apr_length()`                                                                    | [`length()`](https://rdrr.io/r/base/length.html)                                              | monadic |
| [`apr_shape()`](https://11rchitwood.github.io/apr/reference/apr_shape.md)         | [`dim()`](https://rdrr.io/r/base/dim.html)                                                    | monadic |
| [`apr_range()`](https://11rchitwood.github.io/apr/reference/apr_range.md)         | [`seq_len()`](https://rdrr.io/r/base/seq.html)                                                | monadic |
| `apr_first()`                                                                     | [`head()`](https://rdrr.io/r/utils/head.html)                                                 | monadic |
| `apr_last()`                                                                      | [`tail()`](https://rdrr.io/r/utils/head.html)                                                 | monadic |
| [`apr_reverse()`](https://11rchitwood.github.io/apr/reference/apr_reverse.md)     | [`rev()`](https://rdrr.io/r/base/rev.html)                                                    | monadic |
| `apr_deshape()`                                                                   | [`as.vector()`](https://rdrr.io/r/base/vector.html)                                           | monadic |
| `apr_fix()`                                                                       | `dim<-`                                                                                       | monadic |
| [`apr_transpose()`](https://11rchitwood.github.io/apr/reference/apr_transpose.md) | [`t()`](https://rdrr.io/r/base/t.html)                                                        | monadic |
| `apr_sort()`                                                                      | [`sort()`](https://rdrr.io/r/base/sort.html)                                                  | monadic |
| `apr_rise()`                                                                      |                                                                                               | monadic |
| `apr_fall()`                                                                      |                                                                                               | monadic |
| `apr_where()`                                                                     | [`which()`](https://rdrr.io/r/base/which.html)                                                | monadic |
| `apr_deduplicate()`                                                               | [`unique()`](https://rdrr.io/r/base/unique.html)                                              | monadic |
| `apr_classify()`                                                                  |                                                                                               | monadic |
| `apr_occurrences()`                                                               |                                                                                               | monadic |
| `apr_unique()`                                                                    |                                                                                               | monadic |
| `apr_match()`                                                                     | [`all.equal()`](https://rdrr.io/r/base/all.equal.html)                                        | dyadic  |
| `apr_couple()`                                                                    | [`rbind()`](https://rdrr.io/r/base/cbind.html)/[`cbind()`](https://rdrr.io/r/base/cbind.html) | dyadic  |
| `apr_join()`                                                                      | [`c()`](https://rdrr.io/r/base/c.html)                                                        | dyadic  |
| `apr_select()`                                                                    | bracket indexing                                                                              | dyadic  |
| `apr_pick()`                                                                      | bracket indexing                                                                              | dyadic  |
| [`apr_reshape()`](https://11rchitwood.github.io/apr/reference/apr_reshape.md)     | `dim<-`                                                                                       | dyadic  |
| `apr_take()`                                                                      | bracket indexing                                                                              | dyadic  |
| `apr_drop()`                                                                      | negative bracket indexing                                                                     | dyadic  |
| [`apr_rotate()`](https://11rchitwood.github.io/apr/reference/apr_rotate.md)       |                                                                                               | dyadic  |
| `apr_orient()`                                                                    | [`aperm()`](https://rdrr.io/r/base/aperm.html)                                                | dyadic  |
| `apr_keep()`                                                                      | indexing                                                                                      | dyadic  |
| `apr_find()`                                                                      | [`which()`](https://rdrr.io/r/base/which.html)                                                | dyadic  |
| `apr_mask()`                                                                      | [`which()`](https://rdrr.io/r/base/which.html)                                                | dyadic  |
| `apr_memberof()`                                                                  | `%in%`                                                                                        | dyadic  |
| `apr_indexin()`                                                                   | [`which()`](https://rdrr.io/r/base/which.html)                                                | dyadic  |
