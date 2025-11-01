x <- seq_len(12)
arr <- array(x, c(3, 2, 2))

test_that("apr_reshape works", {
  expect_equal(apr_reshape(arr, c(2, 3, 2)), array(x, dim = c(2L, 3L, 2L)))
})

test_that("apr_reshape stops with incorrect dimensions", {
  expect_error(apr_reshape(arr, c(2, 2, 2)))
})
