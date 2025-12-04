test_that("apr_last works with vectors", {
  # Basic vector - returns last element
  expect_equal(apr_last(1:5), 5)

  # Single element
  expect_equal(apr_last(7), 7)

  # Character vector
  expect_equal(apr_last(c("a", "b", "c")), "c")

  # Numeric vector
  expect_equal(apr_last(c(10.5, 20.3, 30.1)), 30.1)

  # Logical vector
  expect_equal(apr_last(c(TRUE, FALSE, TRUE)), TRUE)
})

test_that("apr_last works with 2D matrices", {
  # Basic matrix - returns last row
  m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
  # m is:
  #   [,1] [,2] [,3]
  # [1,]    1    2    3
  # [2,]    4    5    6
  expect_equal(apr_last(m), c(4, 5, 6))

  # Square matrix
  sq <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
  expect_equal(apr_last(sq), c(7, 8, 9))

  # Single row matrix - returns the row as a vector
  row_mat <- matrix(1:4, nrow = 1, ncol = 4)
  expect_equal(apr_last(row_mat), c(1, 2, 3, 4))

  # Single column matrix - returns the last element
  col_mat <- matrix(1:4, nrow = 4, ncol = 1)
  expect_equal(apr_last(col_mat), 4)

  # Character matrix
  char_mat <- matrix(letters[1:6], nrow = 2, ncol = 3)
  expect_equal(apr_last(char_mat), c("b", "d", "f"))
})

test_that("apr_last works with 3D arrays", {
  # 2x3x4 array - returns last 2D slice (3x4 matrix)
  arr <- array(1:24, c(2, 3, 4))
  result <- apr_last(arr)

  expect_equal(dim(result), c(3, 4))
  expect_true(is.matrix(result))

  # Check that it's the last slice
  expect_equal(result, arr[2, , ])

  # Check specific values
  expect_equal(result[1, 1], arr[2, 1, 1])
  expect_equal(result[3, 4], arr[2, 3, 4])

  # 3x2x5 array
  arr2 <- array(1:30, c(3, 2, 5))
  result2 <- apr_last(arr2)
  expect_equal(dim(result2), c(2, 5))
  expect_equal(result2, arr2[3, , ])
})

test_that("apr_last works with 4D arrays", {
  # 2x3x4x5 array - returns last 3D slice
  arr_4d <- array(1:120, c(2, 3, 4, 5))
  result_4d <- apr_last(arr_4d)

  expect_equal(dim(result_4d), c(3, 4, 5))
  expect_true(is.array(result_4d))

  # Check that it's the last slice
  expect_equal(result_4d, arr_4d[2, , , ])

  # Check specific values
  expect_equal(result_4d[1, 1, 1], arr_4d[2, 1, 1, 1])
  expect_equal(result_4d[3, 4, 5], arr_4d[2, 3, 4, 5])
})

test_that("apr_last uses correct S3 method dispatch", {
  # Vector should use default method
  v <- 1:5
  expect_equal(class(v), "integer")
  result_v <- apr_last(v)
  expect_equal(result_v, 5)

  # Matrix should use matrix method
  m <- matrix(1:6, nrow = 2, ncol = 3)
  expect_true("matrix" %in% class(m))
  result_m <- apr_last(m)
  expect_equal(result_m, c(2, 4, 6))
  expect_false(is.matrix(result_m))

  # Array should use array method
  arr <- array(1:24, c(2, 3, 4))
  expect_true("array" %in% class(arr))
  result_arr <- apr_last(arr)
  expect_equal(dim(result_arr), c(3, 4))
})

test_that("apr_last preserves data types", {
  # Integer
  int_vec <- 1:5
  expect_type(apr_last(int_vec), "integer")

  # Double
  dbl_vec <- c(1.5, 2.5, 3.5)
  expect_type(apr_last(dbl_vec), "double")

  # Character
  char_vec <- c("a", "b", "c")
  expect_type(apr_last(char_vec), "character")

  # Logical
  log_vec <- c(TRUE, FALSE, TRUE)
  expect_type(apr_last(log_vec), "logical")
})
