test_that("apr_transpose works with 2D matrices", {
  # Basic 2x3 matrix
  m <- matrix(1:6, nrow = 2, ncol = 3)
  result <- apr_transpose(m)
  expect_equal(dim(result), c(3, 2))
  expect_equal(result, t(m))

  # Square matrix
  sq <- matrix(1:9, nrow = 3, ncol = 3)
  expect_equal(apr_transpose(sq), t(sq))

  # Single row
  row_mat <- matrix(1:4, nrow = 1, ncol = 4)
  expect_equal(dim(apr_transpose(row_mat)), c(4, 1))

  # Single column
  col_mat <- matrix(1:4, nrow = 4, ncol = 1)
  expect_equal(dim(apr_transpose(col_mat)), c(1, 4))
})

test_that("apr_transpose works with 3D arrays", {
  # 2x3x4 array becomes 4x3x2
  arr <- array(1:24, c(2, 3, 4))
  result <- apr_transpose(arr)
  expect_equal(dim(result), c(4, 3, 2))

  # Check specific values are in correct positions
  # arr[1,1,1] should become result[1,1,1]
  expect_equal(result[1, 1, 1], arr[1, 1, 1])
  # arr[2,3,4] should become result[4,3,2]
  expect_equal(result[4, 3, 2], arr[2, 3, 4])
  # arr[1,2,3] should become result[3,2,1]
  expect_equal(result[3, 2, 1], arr[1, 2, 3])
})

test_that("apr_transpose works with higher dimensional arrays", {
  # 4D array: 2x3x4x5 becomes 5x4x3x2
  arr_4d <- array(1:120, c(2, 3, 4, 5))
  result_4d <- apr_transpose(arr_4d)
  expect_equal(dim(result_4d), c(5, 4, 3, 2))

  # Check corner values
  expect_equal(result_4d[1, 1, 1, 1], arr_4d[1, 1, 1, 1])
  expect_equal(result_4d[5, 4, 3, 2], arr_4d[2, 3, 4, 5])
})

test_that("apr_transpose handles vectors", {
  # Vectors don't have dimensions, so should return unchanged
  v <- 1:5
  expect_equal(apr_transpose(v), v)
})

test_that("apr_transpose and apr_transpose_axes are equivalent", {
  # apr_transpose should be equivalent to apr_transpose_axes with reversed indices
  arr <- array(1:24, c(2, 3, 4))

  result1 <- apr_transpose(arr)
  result2 <- apr_transpose_axes(arr, c(3, 2, 1))

  expect_equal(result1, result2)

  # Test with 4D array
  arr_4d <- array(1:120, c(2, 3, 4, 5))
  result1_4d <- apr_transpose(arr_4d)
  result2_4d <- apr_transpose_axes(arr_4d, c(4, 3, 2, 1))

  expect_equal(result1_4d, result2_4d)
})
