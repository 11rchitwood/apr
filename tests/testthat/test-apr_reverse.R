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

  # Basic matrix - reverses along first axis (flips rows vertically)
  expected_vertical <- matrix(
    c(4, 5, 6, 1, 2, 3),
    nrow = 2,
    ncol = 3,
    byrow = TRUE
  )
  expect_equal(apr_reverse(m, along = 1), expected_vertical)

  # Basic matrix - reverses along second axis (flips columns horizontally, same as default)
  expected_horizontal <- matrix(
    c(3, 2, 1, 6, 5, 4),
    nrow = 2,
    ncol = 3,
    byrow = TRUE
  )
  expect_equal(apr_reverse(m, along = 2), expected_horizontal)

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
  # 2x3x4 array - reverses along last axis (3rd dimension) by default
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

  # Reverse along first axis
  result1 <- apr_reverse(arr, along = 1)
  expect_equal(dim(result1), c(2, 3, 4))
  expect_equal(result1[1, , ], arr[2, , ])
  expect_equal(result1[2, , ], arr[1, , ])

  # Reverse along second axis
  result2 <- apr_reverse(arr, along = 2)
  expect_equal(dim(result2), c(2, 3, 4))
  expect_equal(result2[, 1, ], arr[, 3, ])
  expect_equal(result2[, 2, ], arr[, 2, ])
  expect_equal(result2[, 3, ], arr[, 1, ])

  # Reverse along third axis (same as default)
  result3 <- apr_reverse(arr, along = 3)
  expect_equal(result3, result)
})

test_that("apr_reverse works with 4D arrays", {
  # 2x3x4x5 array - reverses along last axis (4th dimension)
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

test_that("apr_reverse validates along parameter", {
  m <- matrix(1:6, nrow = 2, ncol = 3)

  # along must be within valid range
  expect_error(apr_reverse(m, along = 0), "'along' must be between")
  expect_error(apr_reverse(m, along = 3), "'along' must be between")
  expect_error(apr_reverse(m, along = -1), "'along' must be between")

  # Valid along values should work
  expect_no_error(apr_reverse(m, along = 1))
  expect_no_error(apr_reverse(m, along = 2))
})

test_that("apr_reverse uses correct S3 method dispatch", {
  # Vector should use default method
  v <- 1:5
  expect_equal(class(v), "integer")
  result_v <- apr_reverse(v)
  expect_equal(result_v, c(5, 4, 3, 2, 1))

  # Matrix should use matrix method
  m <- matrix(1:6, nrow = 2, ncol = 3)
  expect_true("matrix" %in% class(m))
  result_m <- apr_reverse(m)
  expect_equal(dim(result_m), c(2, 3))

  # Array should use array method
  arr <- array(1:24, c(2, 3, 4))
  expect_true("array" %in% class(arr))
  result_arr <- apr_reverse(arr)
  expect_equal(dim(result_arr), c(2, 3, 4))
})
