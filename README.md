
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

The following sections group APL glyphs into categories and then list
their corresponding monadic and dyadic function names in the `apr`
package. *Note: “—” indicates that the glyph does not have a standard
monadic or dyadic form in APL.*

### Shape

- ⍴ (`apr_shape()`, `apr_reshape()`)
- ⍳ (`apr_iota()`, `apr_index_of()`)
- ↑ (`apr_first()`, `apr_take()`)
- ↓ (—, `apr_drop()`)

### Structural

- ⍉ (`apr_transpose()`, `apr_transpose_axes()`)
- ⌽ (`apr_reverse()`, `apr_rotate()`)
- ⊖ (`apr_reverse_first()`, `apr_rotate_first()`)
- , (`apr_ravel()`, `apr_catenate()`)
- ⍪ (`apr_table()`, `apr_catenate_first()`)

### Functional

- / (—, `apr_reduce()`)
- ⌿ (—, `apr_reduce_first()`)
- \\ (`apr_expand()`, `apr_scan()`)
- ⍀ (`apr_expand_first()`, `apr_scan_first()`)

### Set Operations

- ∊ (`apr_enlist()`, `apr_membership()`)
- ∩ (—, `apr_intersection()`)
- ∪ (`apr_unique()`, `apr_union()`)

### Sorting

- ⍋ (`apr_grade_up()`, `apr_bins_up()`)
- ⍒ (`apr_grade_down()`, `apr_bins_down()`)

### Nesting

- ⊂ (`apr_enclose()`, `apr_partition()`)
- ⊃ (`apr_disclose()`, `apr_pick()`)
- ≡ (`apr_depth()`, `apr_match()`)
- ≢ (`apr_tally()`, `apr_not_match()`)

### Encoding

- ⊥ (—, `apr_decode()`)
- ⊤ (—, `apr_encode()`)

### Arithmetic

- - (`apr_conjugate()`, `apr_plus()`)
- − (`apr_negate()`, `apr_minus()`)
- × (`apr_signum()`, `apr_times()`)
- ÷ (`apr_reciprocal()`, `apr_divide()`)
- \| (`apr_abs()`, `apr_mod()`)
- - (`apr_exp()`, `apr_power()`)

### Mathematical

- ⌈ (`apr_ceiling()`, `apr_max()`)
- ⌊ (`apr_floor()`, `apr_min()`)
- ○ (`apr_pi_times()`, `apr_circular()`)
- ⍟ (`apr_ln()`, `apr_log()`)
- ? (`apr_roll()`, `apr_deal()`)

### Matrix

- ⌹ (`apr_matrix_inverse()`, `apr_matrix_divide()`)

### Comparison

- \< (—, `apr_less()`)

- ≤ (—, `apr_less_equal()`)

- = (—, `apr_equal()`)

- ≥ (—, `apr_greater_equal()`)

- > (—, `apr_greater()`)

- ≠ (—, `apr_not_equal()`)

### Logic

- ∧ (—, `apr_lcm()`)
- ∨ (—, `apr_gcd()`)
- ⍱ (—, `apr_nand()`)
- ⍲ (—, `apr_nor()`)

### Selection

- ⊣ (`apr_identity()`, `apr_left()`)
- ⊢ (`apr_identity()`, `apr_right()`)
- ⍸ (`apr_where()`, `apr_interval_index()`)

### Formatting

- ⍎ (`apr_execute()`, —)
- ⍕ (`apr_format()`, `apr_format_precision()`)
