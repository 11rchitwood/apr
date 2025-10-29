test_that("shape functions work", {
  x <- seq_len(12)
  arr <- array(x, c(3, 2, 2))
  expect_equal(apr_shape(arr), c(3, 2, 2))
  expect_equal(apr_reshape(arr, c(2, 3, 2)), array(x, dim = c(2L, 3L, 2L)))
})

test_that("apr_iota generates index vectors", {
  # Scalar input - simple index generation
  expect_equal(apr_iota(5), 1:5)
  expect_equal(apr_iota(1), 1L)
  expect_equal(apr_iota(10), 1:10)
})

test_that("apr_iota generates multi-dimensional index arrays", {
  # 2D case
  result_2d <- apr_iota(c(2, 3))
  expect_equal(dim(result_2d), c(2, 3, 2))

  # Check specific positions
  expect_equal(result_2d[1, 1, ], c(1, 1))
  expect_equal(result_2d[2, 1, ], c(2, 1))
  expect_equal(result_2d[1, 2, ], c(1, 2))
  expect_equal(result_2d[2, 3, ], c(2, 3))

  # 3D case
  result_3d <- apr_iota(c(2, 2, 2))
  expect_equal(dim(result_3d), c(2, 2, 2, 3))
  expect_equal(result_3d[1, 1, 1, ], c(1, 1, 1))
  expect_equal(result_3d[2, 2, 2, ], c(2, 2, 2))
})

test_that("apr_index_of finds first occurrence", {
  # Simple vector case
  expect_equal(
    apr_index_of(c("A", "B", "C", "D", "E"), c("A", "C", "E")),
    c(A = 1, C = 3, E = 5)
  )
  expect_equal(apr_index_of(1:5, c(3, 1, 5)), c(3, 1, 5))

  # Element not found
  expect_equal(apr_index_of(1:5, c(3, 7, 1)), c(3, 6, 1))

  # Duplicate elements - should return first occurrence
  expect_equal(apr_index_of(c(1, 2, 3, 2, 1), c(1, 2)), c(1, 2))
})

test_that("apr_index_of handles different data types", {
  # Numeric
  expect_equal(apr_index_of(c(1.5, 2.5, 3.5), c(2.5, 1.5)), c(2, 1))

  # Character
  expect_equal(
    apr_index_of(c("apple", "banana", "cherry"), c("banana", "apple")),
    c(banana = 2, apple = 1)
  )

  # Logical
  expect_equal(apr_index_of(c(TRUE, FALSE, TRUE), c(FALSE, TRUE)), c(2, 1))
})

test_that("apr_index_of preserves shape of right argument", {
  # When y is an array, result should have same shape
  haystack <- 1:10
  needle <- matrix(c(3, 5, 7, 9), nrow = 2, ncol = 2)
  result <- apr_index_of(haystack, needle)
  expect_equal(dim(result), c(2, 2))
  expect_equal(result[1, 1], 3)
  expect_equal(result[2, 1], 5)
  expect_equal(result[1, 2], 7)
  expect_equal(result[2, 2], 9)
})

test_that("apr_index_of handles edge cases", {
  # All elements not found
  expect_equal(apr_index_of(1:5, c(10, 20, 30)), c(6, 6, 6))

  # Empty right argument
  expect_equal(apr_index_of(1:5, integer(0)), integer(0))

  # Single element
  expect_equal(apr_index_of(1:5, 3), 3L)
})
