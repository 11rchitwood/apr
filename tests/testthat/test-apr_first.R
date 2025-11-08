test_that("apr_first works with vectors", {
  # Basic vector - returns first element
  expect_equal(apr_first(1:5), 1)

  # Single element
  expect_equal(apr_first(7), 7)

  # Character vector
  expect_equal(apr_first(c("a", "b", "c")), "a")

  # Numeric vector
  expect_equal(apr_first(c(10.5, 20.3, 30.1)), 10.5)

  # Logical vector
  expect_equal(apr_first(c(TRUE, FALSE, TRUE)), TRUE)
})

test_that("apr_first works with 2D matrices", {
  # Basic matrix - returns first row
  m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
  # m is:
  #   [,1] [,2] [,3]
  # [1,]    1    2    3
  # [2,]    4    5    6
  expect_equal(apr_first(m), c(1, 2, 3))

  # Square matrix
  sq <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
  expect_equal(apr_first(sq), c(1, 2, 3))

  # Single row matrix - returns the row as a vector
  row_mat <- matrix(1:4, nrow = 1, ncol = 4)
  expect_equal(apr_first(row_mat), c(1, 2, 3, 4))

  # Single column matrix - returns the first element
  col_mat <- matrix(1:4, nrow = 4, ncol = 1)
  expect_equal(apr_first(col_mat), 1)

  # Character matrix
  char_mat <- matrix(letters[1:6], nrow = 2, ncol = 3)
  expect_equal(apr_first(char_mat), c("a", "c", "e"))
})

test_that("apr_first works with 3D arrays", {
  # 2x3x4 array - returns first 2D slice (3x4 matrix)
  arr <- array(1:24, c(2, 3, 4))
  result <- apr_first(arr)

  expect_equal(dim(result), c(3, 4))
  expect_true(is.matrix(result))

  # Check that it's the first slice
  expect_equal(result, arr[1, , ])

  # Check specific values
  expect_equal(result[1, 1], arr[1, 1, 1])
  expect_equal(result[3, 4], arr[1, 3, 4])

  # 3x2x5 array
  arr2 <- array(1:30, c(3, 2, 5))
  result2 <- apr_first(arr2)
  expect_equal(dim(result2), c(2, 5))
  expect_equal(result2, arr2[1, , ])
})

test_that("apr_first works with 4D arrays", {
  # 2x3x4x5 array - returns first 3D slice
  arr_4d <- array(1:120, c(2, 3, 4, 5))
  result_4d <- apr_first(arr_4d)

  expect_equal(dim(result_4d), c(3, 4, 5))
  expect_true(is.array(result_4d))

  # Check that it's the first slice
  expect_equal(result_4d, arr_4d[1, , , ])

  # Check specific values
  expect_equal(result_4d[1, 1, 1], arr_4d[1, 1, 1, 1])
  expect_equal(result_4d[3, 4, 5], arr_4d[1, 3, 4, 5])
})

test_that("apr_first uses correct S3 method dispatch", {
  # Vector should use default method
  v <- 1:5
  expect_equal(class(v), "integer")
  result_v <- apr_first(v)
  expect_equal(result_v, 1)

  # Matrix should use matrix method
  m <- matrix(1:6, nrow = 2, ncol = 3)
  expect_true("matrix" %in% class(m))
  result_m <- apr_first(m)
  expect_equal(result_m, c(1, 4))
  expect_false(is.matrix(result_m))

  # Array should use array method
  arr <- array(1:24, c(2, 3, 4))
  expect_true("array" %in% class(arr))
  result_arr <- apr_first(arr)
  expect_equal(dim(result_arr), c(3, 4))
})

test_that("apr_first preserves data types", {
  # Integer
  int_vec <- 1:5
  expect_type(apr_first(int_vec), "integer")

  # Double
  dbl_vec <- c(1.5, 2.5, 3.5)
  expect_type(apr_first(dbl_vec), "double")

  # Character
  char_vec <- c("a", "b", "c")
  expect_type(apr_first(char_vec), "character")

  # Logical
  log_vec <- c(TRUE, FALSE, TRUE)
  expect_type(apr_first(log_vec), "logical")
})
