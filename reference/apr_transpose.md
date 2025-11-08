# Transpose an array

Reverses all dimensions of an array. For a 2D matrix, this is the
standard transpose. For higher dimensional arrays, it reverses the order
of dimensions.

## Usage

``` r
apr_transpose(x)
```

## Arguments

- x:

  an array

## Value

an array with reversed dimensions

## Examples

``` r
# 2D matrix transpose
m <- matrix(1:6, nrow = 2, ncol = 3)
apr_transpose(m)  # 3x2 matrix
#>      [,1] [,2]
#> [1,]    1    2
#> [2,]    3    4
#> [3,]    5    6

# 3D array transpose
arr <- array(1:24, c(2, 3, 4))
apr_transpose(arr)  # 4x3x2 array
#> , , 1
#> 
#>      [,1] [,2] [,3]
#> [1,]    1    3    5
#> [2,]    7    9   11
#> [3,]   13   15   17
#> [4,]   19   21   23
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3]
#> [1,]    2    4    6
#> [2,]    8   10   12
#> [3,]   14   16   18
#> [4,]   20   22   24
#> 
```
