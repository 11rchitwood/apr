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

test_that("apr_rotate works with 2D matrices", {
  # Create a test matrix
  m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
  # m is:
  #   [,1] [,2] [,3]
  # [1,]    1    2    3
  # [2,]    4    5    6

  # Rotate along last axis (default) - rotates each row
  result_default <- apr_rotate(m, 1)
  expected_default <- matrix(
    c(3, 1, 2, 6, 4, 5),
    nrow = 2,
    ncol = 3,
    byrow = TRUE
  )
  expect_equal(result_default, expected_default)

  # Rotate along second axis (same as default)
  result_axis2 <- apr_rotate(m, 1, along = 2)
  expect_equal(result_axis2, expected_default)

  # Rotate along first axis - rotates the rows themselves
  result_axis1 <- apr_rotate(m, 1, along = 1)
  expected_axis1 <- matrix(
    c(4, 5, 6, 1, 2, 3),
    nrow = 2,
    ncol = 3,
    byrow = TRUE
  )
  expect_equal(result_axis1, expected_axis1)

  # Rotate by 2 along last axis
  result_2 <- apr_rotate(m, 2)
  expected_2 <- matrix(c(2, 3, 1, 5, 6, 4), nrow = 2, ncol = 3, byrow = TRUE)
  expect_equal(result_2, expected_2)

  # Square matrix
  sq <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
  result_sq <- apr_rotate(sq, 1)
  expected_sq <- matrix(
    c(3, 1, 2, 6, 4, 5, 9, 7, 8),
    nrow = 3,
    ncol = 3,
    byrow = TRUE
  )
  expect_equal(result_sq, expected_sq)
})

test_that("apr_rotate works with 3D arrays", {
  # 2x3x4 array
  arr <- array(1:24, c(2, 3, 4))

  # Rotate along last axis (default)
  result_default <- apr_rotate(arr, 1)
  expect_equal(dim(result_default), c(2, 3, 4))
  expect_equal(result_default, arr[,, c(4, 1, 2, 3)])

  # Rotate by 2
  result_by2 <- apr_rotate(arr, 2)
  expect_equal(dim(result_by2), c(2, 3, 4))
  expect_equal(result_by2, arr[,, c(3, 4, 1, 2)])

  # Rotate along first axis
  result_axis1 <- apr_rotate(arr, 1, along = 1)
  expect_equal(dim(result_axis1), c(2, 3, 4))
  expect_equal(result_axis1, arr[c(2, 1), , ])

  # Rotate along second axis
  result_axis2 <- apr_rotate(arr, 1, along = 2)
  expect_equal(dim(result_axis2), c(2, 3, 4))
  expect_equal(result_axis2, arr[, c(3, 1, 2), ])
})

test_that("apr_rotate validates along parameter", {
  m <- matrix(1:6, nrow = 2, ncol = 3)

  # along must be within valid range
  expect_error(apr_rotate(m, 1, along = 0), "'along' must be between")
  expect_error(apr_rotate(m, 1, along = 3), "'along' must be between")
  expect_error(apr_rotate(m, 1, along = -1), "'along' must be between")

  # Valid along values should work
  expect_no_error(apr_rotate(m, 1, along = 1))
  expect_no_error(apr_rotate(m, 1, along = 2))
})

test_that("apr_rotate uses correct S3 method dispatch", {
  # Vector should use default method
  v <- 1:5
  expect_equal(class(v), "integer")
  result_v <- apr_rotate(v, 1)
  expect_equal(result_v, c(5, 1, 2, 3, 4))

  # Matrix should use matrix method
  m <- matrix(1:6, nrow = 2, ncol = 3)
  expect_true("matrix" %in% class(m))
  result_m <- apr_rotate(m, 1)
  expect_equal(dim(result_m), c(2, 3))

  # Array should use array method
  arr <- array(1:24, c(2, 3, 4))
  expect_true("array" %in% class(arr))
  result_arr <- apr_rotate(arr, 1)
  expect_equal(dim(result_arr), c(2, 3, 4))
})
