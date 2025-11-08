# Generate index vector or array

Generates indices from 1 to n for a scalar, or an array of index
combinations for a vector shape.

## Usage

``` r
apr_range(x)
```

## Arguments

- x:

  an integer scalar or vector representing the shape

## Value

For a scalar n, returns 1:n. For a vector shape, returns an array where
each element contains the indices at that position.

## Examples

``` r
apr_range(5)  # Returns 1:5
#> [1] 1 2 3 4 5
apr_range(c(3, 4))  # Returns a 3x4 array with index combinations
#> , , 1
#> 
#>      [,1] [,2] [,3] [,4]
#> [1,]    1    1    1    1
#> [2,]    2    2    2    2
#> [3,]    3    3    3    3
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3] [,4]
#> [1,]    1    2    3    4
#> [2,]    1    2    3    4
#> [3,]    1    2    3    4
#> 
```
