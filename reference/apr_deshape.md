# Remove the shape of an array

Remove the shape of an array

## Usage

``` r
apr_deshape(x)
```

## Arguments

- x:

  an array or vector

## Value

a vector with dimensions removed

## Examples

``` r
x <- array(1:12, c(3, 4))
apr_deshape(x)  # Returns vector 1:12
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12

x <- array(1:24, c(2, 3, 4))
apr_deshape(x)  # Returns vector 1:24
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
```
