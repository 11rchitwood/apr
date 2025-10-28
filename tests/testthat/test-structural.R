test_that("shape functions work", {
  expect_equal(apr_rotate(1:12, 3), c(10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9))
})
