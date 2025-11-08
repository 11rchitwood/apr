# Reverse along a specified axis

Reverses the elements along a specified axis of an array. For a vector,
this reverses the entire vector. For arrays, you can specify which axis
to reverse. By default, reverses along the last axis. This is similar to
APL's bracket notation `⌽[K]` which reverses along axis K.

## Usage

``` r
apr_reverse(x, along = NULL)
```

## Arguments

- x:

  an array or vector

- along:

  an integer specifying which axis to reverse along (default: last axis)

## Value

an array with the specified axis reversed

## Examples

``` r
# Vector reverse
apr_reverse(1:5)  # Returns c(5, 4, 3, 2, 1)
#> [1] 5 4 3 2 1

# Matrix: reverse along last axis (default, reverses each row horizontally)
m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
apr_reverse(m)
#>      [,1] [,2] [,3]
#> [1,]    3    2    1
#> [2,]    6    5    4

# Matrix: reverse along first axis (reverses rows vertically)
apr_reverse(m, along = 1)
#>      [,1] [,2] [,3]
#> [1,]    4    5    6
#> [2,]    1    2    3

# 3D array: reverse along last axis
arr <- array(1:24, c(2, 3, 4))
apr_reverse(arr)
#> , , 1
#> 
#>      [,1] [,2] [,3]
#> [1,]   19   21   23
#> [2,]   20   22   24
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3]
#> [1,]   13   15   17
#> [2,]   14   16   18
#> 
#> , , 3
#> 
#>      [,1] [,2] [,3]
#> [1,]    7    9   11
#> [2,]    8   10   12
#> 
#> , , 4
#> 
#>      [,1] [,2] [,3]
#> [1,]    1    3    5
#> [2,]    2    4    6
#> 

# 3D array: reverse along second axis
apr_reverse(arr, along = 2)
#> , , 1
#> 
#>      [,1] [,2] [,3]
#> [1,]    5    3    1
#> [2,]    6    4    2
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3]
#> [1,]   11    9    7
#> [2,]   12   10    8
#> 
#> , , 3
#> 
#>      [,1] [,2] [,3]
#> [1,]   17   15   13
#> [2,]   18   16   14
#> 
#> , , 4
#> 
#>      [,1] [,2] [,3]
#> [1,]   23   21   19
#> [2,]   24   22   20
#> 
```
