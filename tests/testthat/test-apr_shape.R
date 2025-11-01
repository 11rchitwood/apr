x <- seq_len(12)
arr <- array(x, c(3, 2, 2))

test_that("apr_shape works", {
  expect_equal(apr_shape(arr), c(3, 2, 2))
})
