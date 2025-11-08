test_that("apr_range generates index vectors", {
  # Scalar input - simple index generation
  expect_equal(apr_range(5), 1:5)
  expect_equal(apr_range(1), 1L)
  expect_equal(apr_range(10), 1:10)
})

test_that("apr_range generates multi-dimensional index arrays", {
  # 2D case
  result_2d <- apr_range(c(2, 3))
  expect_equal(dim(result_2d), c(2, 3, 2))

  # Check specific positions
  expect_equal(result_2d[1, 1, ], c(1, 1))
  expect_equal(result_2d[2, 1, ], c(2, 1))
  expect_equal(result_2d[1, 2, ], c(1, 2))
  expect_equal(result_2d[2, 3, ], c(2, 3))

  # 3D case
  result_3d <- apr_range(c(2, 2, 2))
  expect_equal(dim(result_3d), c(2, 2, 2, 3))
  expect_equal(result_3d[1, 1, 1, ], c(1, 1, 1))
  expect_equal(result_3d[2, 2, 2, ], c(2, 2, 2))
})
