#' Get first element(s) along the first axis
#'
#' Returns the first element along the first axis of an array. For a vector, this
#' returns the first element (scalar). For a matrix, this returns the first row.
#' For higher-dimensional arrays, this returns the first slice along the first axis.
#'
#' @param x an array or vector
#'
#' @return For a vector, returns the first element (scalar). For arrays with more
#'   than one dimension, returns the first slice along the first axis with dimensions
#'   reduced by one.
#' @export
#'
#' @examples
#' # Vector: returns first element
#' apr_first(1:5)  # Returns 1
#'
#' # Matrix: returns first row
#' m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
#' apr_first(m)  # Returns c(1, 2, 3)
#'
#' # 3D array: returns first 2D slice
#' arr <- array(1:24, c(2, 3, 4))
#' apr_first(arr)  # Returns a 3x4 matrix
apr_first <- function(x) {
  UseMethod("apr_first")
}

#' @export
apr_first.default <- function(x) {
  # For vectors, return the first element
  x[1]
}

#' @export
apr_first.matrix <- function(x) {
  # For matrices, return the first row as a vector
  x[1, , drop = TRUE]
}

#' @export
apr_first.array <- function(x) {
  # For arrays, return the first slice along the first axis
  dims <- dim(x)
  ndim <- length(dims)

  if (ndim == 1) {
    # This shouldn't happen for array class, but handle it
    return(x[1])
  }

  # Create index list: first element of first dimension, all others
  indices <- c(list(1L), rep(list(TRUE), ndim - 1))
  result <- do.call(`[`, c(list(x), indices, drop = FALSE))

  # Drop the first dimension
  new_dims <- dims[-1]
  if (length(new_dims) == 1) {
    # Result should be a vector
    as.vector(result)
  } else if (length(new_dims) == 2) {
    # Result should be a matrix
    matrix(result, nrow = new_dims[1], ncol = new_dims[2])
  } else {
    # Result should be an array with reduced dimensions
    array(result, dim = new_dims)
  }
}
