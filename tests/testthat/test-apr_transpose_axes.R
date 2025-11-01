test_that("apr_transpose_axes works with 2D matrices", {
  m <- matrix(1:6, nrow = 2, ncol = 3)

  # Identity permutation
  expect_equal(apr_transpose_axes(m, c(1, 2)), m)

  # Transpose
  expect_equal(apr_transpose_axes(m, c(2, 1)), t(m))
})

test_that("apr_transpose_axes works with 3D arrays", {
  arr <- array(1:24, c(2, 3, 4))

  # Identity
  expect_equal(apr_transpose_axes(arr, c(1, 2, 3)), arr)

  # Various permutations
  result1 <- apr_transpose_axes(arr, c(3, 2, 1))
  expect_equal(dim(result1), c(4, 3, 2))

  result2 <- apr_transpose_axes(arr, c(2, 1, 3))
  expect_equal(dim(result2), c(3, 2, 4))

  result3 <- apr_transpose_axes(arr, c(3, 1, 2))
  expect_equal(dim(result3), c(4, 2, 3))

  result4 <- apr_transpose_axes(arr, c(1, 3, 2))
  expect_equal(dim(result4), c(2, 4, 3))

  result5 <- apr_transpose_axes(arr, c(2, 3, 1))
  expect_equal(dim(result5), c(3, 4, 2))
})

test_that("apr_transpose_axes preserves values correctly", {
  arr <- array(1:24, c(2, 3, 4))

  # Test that specific values are in correct positions after permutation
  result <- apr_transpose_axes(arr, c(3, 1, 2))
  # arr[2, 3, 4] = 24 should be at result[4, 2, 3]
  expect_equal(result[4, 2, 3], arr[2, 3, 4])
  # arr[1, 1, 1] = 1 should be at result[1, 1, 1]
  expect_equal(result[1, 1, 1], arr[1, 1, 1])
  # arr[1, 2, 3] should be at result[3, 1, 2]
  expect_equal(result[3, 1, 2], arr[1, 2, 3])
})

test_that("apr_transpose_axes works with 4D arrays", {
  arr_4d <- array(1:120, c(2, 3, 4, 5))

  # Test a few permutations
  result1 <- apr_transpose_axes(arr_4d, c(4, 3, 2, 1))
  expect_equal(dim(result1), c(5, 4, 3, 2))

  result2 <- apr_transpose_axes(arr_4d, c(2, 4, 1, 3))
  expect_equal(dim(result2), c(3, 5, 2, 4))
})
