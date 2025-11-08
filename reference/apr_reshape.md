# Change the shape of an array

Change the shape of an array

## Usage

``` r
apr_reshape(x, value)
```

## Arguments

- x:

  an array or vector

- value:

  an integer vector representing the new dimensions

## Value

an array with the specified dimensions

## Examples

``` r
x <- 1:12
apr_reshape(x, c(3, 4))  # Returns a 3x4 matrix
#>      [,1] [,2] [,3] [,4]
#> [1,]    1    4    7   10
#> [2,]    2    5    8   11
#> [3,]    3    6    9   12
apr_reshape(x, c(2, 2, 3))  # Returns a 2x2x3 array
#> , , 1
#> 
#>      [,1] [,2]
#> [1,]    1    3
#> [2,]    2    4
#> 
#> , , 2
#> 
#>      [,1] [,2]
#> [1,]    5    7
#> [2,]    6    8
#> 
#> , , 3
#> 
#>      [,1] [,2]
#> [1,]    9   11
#> [2,]   10   12
#> 
```
