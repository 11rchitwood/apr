arr <- array(seq_len(12), c(3, 2, 2))

test_that("apr_shape works", {
  expect_equal(apr_shape(arr), c(3, 2, 2))
})
