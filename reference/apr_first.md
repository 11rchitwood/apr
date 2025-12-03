# Get first element(s) along the first axis

Returns the first element along the first axis of an array. For a
vector, this returns the first element (scalar). For a matrix, this
returns the first row. For higher-dimensional arrays, this returns the
first slice along the first axis.

## Usage

``` r
apr_first(x)
```

## Arguments

- x:

  an array or vector

## Value

For a vector, returns the first element (scalar). For arrays with more
than one dimension, returns the first slice along the first axis with
dimensions reduced by one.

## Examples

``` r
# Vector: returns first element
apr_first(1:5)  # Returns 1
#> [1] 1

# Matrix: returns first row
m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
apr_first(m)  # Returns c(1, 2, 3)
#> [1] 1 2 3

# 3D array: returns first 2D slice
arr <- array(1:24, c(2, 3, 4))
apr_first(arr)  # Returns a 3x4 matrix
#>      [,1] [,2] [,3] [,4]
#> [1,]    1    7   13   19
#> [2,]    3    9   15   21
#> [3,]    5   11   17   23
```
