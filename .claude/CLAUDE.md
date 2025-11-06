# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Project

apr brings the power of array programming languages to R, enabling concise and efficient data manipulation and analysis using multi-dimensional arrays.

## Key development commands

General advice:
* When running R from the console, always run it with `--quiet --vanilla`
* Always run `air format .` after generating code

### Testing

- Use `devtools::test()` to run all tests
- Use `devtools::test_file("tests/testthat/test-filename.R")` to run tests in a specific file
- DO NOT USE `devtools::test_active_file()`
- All testing functions automatically load code; you don't needs to.

- All new code should have an accompanying test.
- Tests for `R/{name}.R` go in `tests/testthat/test-{name}.R`. 
- If there are existing tests, place new tests next to similar existing tests.

### Documentation

- Run `devtools::document()` after changing any roxygen2 docs.
- Every user facing function should be exported and have roxygen2 documentation.
- Whenever you add a new documentation file, make sure to also add the topic name to `_pkgdown.yml`. 
- Run `pkgdown::check_pkgdown()` to check that all topics are included in the reference index.
- Use sentence case for all headings

## Core Architecture

### File Organization

- `R/` - All R source code, organized by functionality
- `tests/testthat/` - Package's own comprehensive test suite
