# Retrieve the shape of an array

Retrieve the shape of an array

## Usage

``` r
apr_shape()
```

## Value

an integer vector representing the dimensions

## Examples

``` r
arr <- array(1:12, c(3, 2, 2))
apr_shape(arr)  # Returns c(3, 2, 2)
#> [1] 3 2 2
```
