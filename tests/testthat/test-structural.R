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

test_that("apr_reverse works with vectors", {
  # Basic vector reverse
  expect_equal(apr_reverse(1:5), c(5, 4, 3, 2, 1))

  # Single element
  expect_equal(apr_reverse(7), 7)

  # Empty vector
  expect_equal(apr_reverse(integer(0)), integer(0))

  # Character vector
  expect_equal(apr_reverse(c("a", "b", "c")), c("c", "b", "a"))
})

test_that("apr_reverse works with 2D matrices", {
  # Basic matrix - reverses each row
  m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
  # m is:
  #   [,1] [,2] [,3]
  # [1,]    1    2    3
  # [2,]    4    5    6
  expected <- matrix(c(3, 2, 1, 6, 5, 4), nrow = 2, ncol = 3, byrow = TRUE)
  expect_equal(apr_reverse(m), expected)

  # Square matrix
  sq <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
  result <- apr_reverse(sq)
  expect_equal(dim(result), c(3, 3))
  expect_equal(result[1, ], c(3, 2, 1))
  expect_equal(result[2, ], c(6, 5, 4))
  expect_equal(result[3, ], c(9, 8, 7))

  # Single row matrix
  row_mat <- matrix(1:4, nrow = 1, ncol = 4)
  expect_equal(apr_reverse(row_mat), matrix(c(4, 3, 2, 1), nrow = 1, ncol = 4))

  # Single column matrix (reversing along last axis does nothing for single column)
  col_mat <- matrix(1:4, nrow = 4, ncol = 1)
  expect_equal(apr_reverse(col_mat), col_mat)
})

test_that("apr_reverse works with 3D arrays", {
  # 2x3x4 array - reverses along last axis (4th dimension)
  arr <- array(1:24, c(2, 3, 4))
  result <- apr_reverse(arr)

  expect_equal(dim(result), c(2, 3, 4))

  # Check that values are reversed along the last axis
  # arr[1,1,] should become reversed
  expect_equal(result[1, 1, ], rev(arr[1, 1, ]))
  expect_equal(result[2, 2, ], rev(arr[2, 2, ]))

  # Check specific values
  expect_equal(result[1, 1, 1], arr[1, 1, 4])
  expect_equal(result[1, 1, 4], arr[1, 1, 1])
  expect_equal(result[2, 3, 1], arr[2, 3, 4])
})

test_that("apr_reverse works with 4D arrays", {
  # 2x3x4x5 array - reverses along last axis (5th dimension)
  arr_4d <- array(1:120, c(2, 3, 4, 5))
  result_4d <- apr_reverse(arr_4d)

  expect_equal(dim(result_4d), c(2, 3, 4, 5))

  # Check that values are reversed along the last axis
  expect_equal(result_4d[1, 1, 1, ], rev(arr_4d[1, 1, 1, ]))
  expect_equal(result_4d[2, 2, 3, ], rev(arr_4d[2, 2, 3, ]))

  # Check corner values
  expect_equal(result_4d[1, 1, 1, 1], arr_4d[1, 1, 1, 5])
  expect_equal(result_4d[2, 3, 4, 5], arr_4d[2, 3, 4, 1])
})

test_that("apr_rotate works with basic vectors", {
  # Original test
  expect_equal(apr_rotate(1:12, 3), c(10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9))

  # Rotate by 1
  expect_equal(apr_rotate(1:5, 1), c(5, 1, 2, 3, 4))

  # Rotate by 0 (should return unchanged)
  expect_equal(apr_rotate(1:5, 0), 1:5)

  # Rotate by full length (should return original unchanged)
  expect_equal(apr_rotate(1:5, 5), c(1, 2, 3, 4, 5))

  # Rotate small vector
  expect_equal(apr_rotate(1:3, 1), c(3, 1, 2))
  expect_equal(apr_rotate(1:3, 2), c(2, 3, 1))

  # Rotate by more than length (should wrap around)
  expect_equal(apr_rotate(1:5, 6), c(5, 1, 2, 3, 4)) # 6 %% 5 = 1
  expect_equal(apr_rotate(1:5, 7), c(4, 5, 1, 2, 3)) # 7 %% 5 = 2
})

test_that("apr_rotate edge cases", {
  # Single element
  expect_equal(apr_rotate(5, 1), 5)

  # Two elements
  expect_equal(apr_rotate(c(1, 2), 1), c(2, 1))

  # Empty vector
  expect_equal(apr_rotate(integer(0), 1), integer(0))
})
