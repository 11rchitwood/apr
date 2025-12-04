test_that("apr_deshape removes dimensions from 2D array", {
  x <- array(1:12, c(3, 4))
  result <- apr_deshape(x)
  expect_equal(result, 1:12)
  expect_null(dim(result))
})

test_that("apr_deshape removes dimensions from 3D array", {
  x <- array(1:24, c(2, 3, 4))
  result <- apr_deshape(x)
  expect_equal(result, 1:24)
  expect_null(dim(result))
})

test_that("apr_deshape works on vectors (no-op)", {
  x <- 1:10
  result <- apr_deshape(x)
  expect_equal(result, x)
  expect_null(dim(result))
})

test_that("apr_deshape works on matrices", {
  x <- matrix(1:6, nrow = 2)
  result <- apr_deshape(x)
  expect_equal(result, 1:6)
  expect_null(dim(result))
})
