test_that("everything works", {
  x <- seq_len(12)
  arr <- array(x, c(3, 2, 2))
  expect_equal(apr_shape(arr), c(3, 2, 2))
  expect_equal(apr_reshape(arr, c(2, 3, 2)), array(x, dim = c(2L, 3L, 2L)))
  expect_equal(apr_rotate(x, 3), c(10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9))
})
