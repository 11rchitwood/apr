# Get last element(s) along the first axis

Returns the last element along the first axis of an array. For a vector,
this returns the last element (scalar). For a matrix, this returns the
last row. For higher-dimensional arrays, this returns the last slice
along the first axis.

## Usage

``` r
apr_last(x)
```

## Arguments

- x:

  an array or vector

## Value

For a vector, returns the last element (scalar). For arrays with more
than one dimension, returns the last slice along the first axis with
dimensions reduced by one.

## Examples

``` r
# Vector: returns last element
apr_last(1:5)  # Returns 5
#> [1] 5

# Matrix: returns last row
m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
apr_last(m)  # Returns c(4, 5, 6)
#> [1] 4 5 6

# 3D array: returns last 2D slice
arr <- array(1:24, c(2, 3, 4))
apr_last(arr)  # Returns a 3x4 matrix
#>      [,1] [,2] [,3] [,4]
#> [1,]    2    8   14   20
#> [2,]    4   10   16   22
#> [3,]    6   12   18   24
```
