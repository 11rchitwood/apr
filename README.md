
<!-- README.md is generated from README.Rmd. Please edit that file -->

# apr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/apr)](https://CRAN.R-project.org/package=apr)
[![R-CMD-check](https://github.com/11rchitwood/apr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/11rchitwood/apr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/11rchitwood/apr/graph/badge.svg)](https://app.codecov.io/gh/11rchitwood/apr)
<!-- badges: end -->

The goal of apr is to bring the goodness of
[APL](https://en.wikipedia.org/wiki/APL_(programming_language)) to R. R
provides multidimensional arrays out of the box, but many of the table
stakes for array programming are missing. This package seeks to fill
that gap.

## Installation

You can install the development version of apr like so:

``` r
pak::pak("11rchitwood/apr")
```

## APL Glyph Implementation Plan

The following table lists all APL glyphs and their corresponding monadic
and dyadic function names in the `apr` package:

| Category           | Glyph | Monadic Name         | Dyadic Name            |
|--------------------|-------|----------------------|------------------------|
| **Shape**          | ⍴     | `apr_shape`          | `apr_reshape`          |
| **Shape**          | ⍳     | `apr_iota`           | `apr_index_of`         |
| **Shape**          | ↑     | `apr_first`          | `apr_take`             |
| **Shape**          | ↓     | —                    | `apr_drop`             |
| **Structural**     | ⍉     | `apr_transpose`      | `apr_transpose_axes`   |
| **Structural**     | ⌽     | `apr_reverse`        | `apr_rotate`           |
| **Structural**     | ⊖     | `apr_reverse_first`  | `apr_rotate_first`     |
| **Structural**     | ,     | `apr_ravel`          | `apr_catenate`         |
| **Structural**     | ⍪     | `apr_table`          | `apr_catenate_first`   |
| **Reduction/Scan** | /     | —                    | `apr_reduce`           |
| **Reduction/Scan** | ⌿     | —                    | `apr_reduce_first`     |
| **Reduction/Scan** | \\    | `apr_expand`         | `apr_scan`             |
| **Reduction/Scan** | ⍀     | `apr_expand_first`   | `apr_scan_first`       |
| **Set Operations** | ∊     | `apr_enlist`         | `apr_membership`       |
| **Set Operations** | ∩     | —                    | `apr_intersection`     |
| **Set Operations** | ∪     | `apr_unique`         | `apr_union`            |
| **Sorting**        | ⍋     | `apr_grade_up`       | `apr_bins_up`          |
| **Sorting**        | ⍒     | `apr_grade_down`     | `apr_bins_down`        |
| **Nesting**        | ⊂     | `apr_enclose`        | `apr_partition`        |
| **Nesting**        | ⊃     | `apr_disclose`       | `apr_pick`             |
| **Nesting**        | ≡     | `apr_depth`          | `apr_match`            |
| **Nesting**        | ≢     | `apr_tally`          | `apr_not_match`        |
| **Encoding**       | ⊥     | —                    | `apr_decode`           |
| **Encoding**       | ⊤     | —                    | `apr_encode`           |
| **Arithmetic**     | \+    | `apr_conjugate`      | `apr_plus`             |
| **Arithmetic**     | −     | `apr_negate`         | `apr_minus`            |
| **Arithmetic**     | ×     | `apr_signum`         | `apr_times`            |
| **Arithmetic**     | ÷     | `apr_reciprocal`     | `apr_divide`           |
| **Arithmetic**     | \|    | `apr_abs`            | `apr_mod`              |
| **Arithmetic**     | \*    | `apr_exp`            | `apr_power`            |
| **Mathematical**   | ⌈     | `apr_ceiling`        | `apr_max`              |
| **Mathematical**   | ⌊     | `apr_floor`          | `apr_min`              |
| **Mathematical**   | ○     | `apr_pi_times`       | `apr_circular`         |
| **Mathematical**   | ⍟     | `apr_ln`             | `apr_log`              |
| **Mathematical**   | ?     | `apr_roll`           | `apr_deal`             |
| **Matrix**         | ⌹     | `apr_matrix_inverse` | `apr_matrix_divide`    |
| **Comparison**     | \<    | —                    | `apr_less`             |
| **Comparison**     | ≤     | —                    | `apr_less_equal`       |
| **Comparison**     | =     | —                    | `apr_equal`            |
| **Comparison**     | ≥     | —                    | `apr_greater_equal`    |
| **Comparison**     | \>    | —                    | `apr_greater`          |
| **Comparison**     | ≠     | —                    | `apr_not_equal`        |
| **Logic**          | ∧     | —                    | `apr_lcm`              |
| **Logic**          | ∨     | —                    | `apr_gcd`              |
| **Logic**          | ⍱     | —                    | `apr_nand`             |
| **Logic**          | ⍲     | —                    | `apr_nor`              |
| **Selection**      | ⊣     | `apr_identity`       | `apr_left`             |
| **Selection**      | ⊢     | `apr_identity`       | `apr_right`            |
| **Selection**      | ⍸     | `apr_where`          | `apr_interval_index`   |
| **Formatting**     | ⍎     | `apr_execute`        | —                      |
| **Formatting**     | ⍕     | `apr_format`         | `apr_format_precision` |

*Note: “—” indicates that the glyph does not have a standard monadic or
dyadic form in APL.*

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(apr)
arr <- array(seq_len(12), c(3, 2, 2))
apr_shape(arr)
#> [1] 3 2 2
apr_reshape(arr, c(2, 3, 2))
#> , , 1
#> 
#>      [,1] [,2] [,3]
#> [1,]    1    3    5
#> [2,]    2    4    6
#> 
#> , , 2
#> 
#>      [,1] [,2] [,3]
#> [1,]    7    9   11
#> [2,]    8   10   12
```
