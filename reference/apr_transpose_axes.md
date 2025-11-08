# Transpose array axes

Permutes the dimensions of an array according to the specified order.
This is the dyadic form of transpose, similar to R's aperm function.

## Usage

``` r
apr_transpose_axes(x, perm)
```

## Arguments

- x:

  an array

- perm:

  an integer vector specifying the permutation of dimensions

## Value

an array with permuted dimensions

## Examples

``` r
arr <- array(1:24, c(2, 3, 4))
apr_transpose_axes(arr, c(3, 1, 2))  # 4x2x3 array
#> , , 1
#> 
#>      [,1] [,2]
#> [1,]    1    2
#> [2,]    7    8
#> [3,]   13   14
#> [4,]   19   20
#> 
#> , , 2
#> 
#>      [,1] [,2]
#> [1,]    3    4
#> [2,]    9   10
#> [3,]   15   16
#> [4,]   21   22
#> 
#> , , 3
#> 
#>      [,1] [,2]
#> [1,]    5    6
#> [2,]   11   12
#> [3,]   17   18
#> [4,]   23   24
#> 
apr_transpose_axes(arr, c(1, 3, 2))  # 2x4x3 array
#> , , 1
#> 
#>      [,1] [,2] [,3] [,4]
#> [1,]    1    7   13   19
#> [2,]    2    8   14   20
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3] [,4]
#> [1,]    3    9   15   21
#> [2,]    4   10   16   22
#> 
#> , , 3
#> 
#>      [,1] [,2] [,3] [,4]
#> [1,]    5   11   17   23
#> [2,]    6   12   18   24
#> 
```
