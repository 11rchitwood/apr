# Find index of first occurrence Finds the index of the first occurrence of each element in the right argument within the left argument.

Find index of first occurrence Finds the index of the first occurrence
of each element in the right argument within the left argument.

## Usage

``` r
apr_index_of(x, y)
```

## Arguments

- x:

  the haystack (left argument)

- y:

  the needle (right argument)

## Value

An integer vector of the same shape as y, containing the index of the
first occurrence of each element in x. Elements not found return
length(x) + 1.

## Examples

``` r
apr_index_of(c("A", "B", "C", "D", "E"), c("A", "C", "E"))  # Returns c(1, 3, 5)
#> A C E 
#> 1 3 5 
apr_index_of(1:5, c(3, 7, 1))  # Returns c(3, 6, 1)
#> [1] 3 6 1
```
