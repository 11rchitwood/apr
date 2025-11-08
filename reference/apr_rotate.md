# Rotate along a specified axis

Rotates elements along a specified axis of an array. For a vector, this
rotates the entire vector by k positions. For arrays, you can specify
which axis to rotate. By default, rotates along the last axis. This is
similar to APL's bracket notation `k⌽[I]X` which rotates X by k
positions along axis I.

## Usage

``` r
apr_rotate(x, k, along = NULL)
```

## Arguments

- x:

  an array or vector

- k:

  an integer, the number of positions to rotate

- along:

  an integer specifying which axis to rotate along (default: last axis)

## Value

an array with the specified axis rotated

## Examples

``` r
# Vector rotation
apr_rotate(1:12, 3)  # Rotate by 3 positions
#>  [1] 10 11 12  1  2  3  4  5  6  7  8  9

# Matrix: rotate along last axis (default, rotates each row)
m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
apr_rotate(m, 1)
#>      [,1] [,2] [,3]
#> [1,]    3    1    2
#> [2,]    6    4    5

# Matrix: rotate along first axis (rotates the rows themselves)
apr_rotate(m, 1, along = 1)
#>      [,1] [,2] [,3]
#> [1,]    4    5    6
#> [2,]    1    2    3

# 3D array: rotate along last axis
arr <- array(1:24, c(2, 3, 4))
apr_rotate(arr, 2)
#> , , 1
#> 
#>      [,1] [,2] [,3]
#> [1,]   13   15   17
#> [2,]   14   16   18
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3]
#> [1,]   19   21   23
#> [2,]   20   22   24
#> 
#> , , 3
#> 
#>      [,1] [,2] [,3]
#> [1,]    1    3    5
#> [2,]    2    4    6
#> 
#> , , 4
#> 
#>      [,1] [,2] [,3]
#> [1,]    7    9   11
#> [2,]    8   10   12
#> 

# 3D array: rotate along second axis
apr_rotate(arr, 1, along = 2)
#> , , 1
#> 
#>      [,1] [,2] [,3]
#> [1,]    5    1    3
#> [2,]    6    2    4
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3]
#> [1,]   11    7    9
#> [2,]   12    8   10
#> 
#> , , 3
#> 
#>      [,1] [,2] [,3]
#> [1,]   17   13   15
#> [2,]   18   14   16
#> 
#> , , 4
#> 
#>      [,1] [,2] [,3]
#> [1,]   23   19   21
#> [2,]   24   20   22
#> 
```
