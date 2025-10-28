test_that("shape functions work", {
  x <- seq_len(12)
  arr <- array(x, c(3, 2, 2))
  expect_equal(apr_shape(arr), c(3, 2, 2))
  expect_equal(apr_reshape(arr, c(2, 3, 2)), array(x, dim = c(2L, 3L, 2L)))
})
