#' Get last element(s) along the first axis
#'
#' Returns the last element along the first axis of an array. For a vector, this
#' returns the last element (scalar). For a matrix, this returns the last row.
#' For higher-dimensional arrays, this returns the last slice along the first axis.
#'
#' @param x an array or vector
#'
#' @return For a vector, returns the last element (scalar). For arrays with more
#'   than one dimension, returns the last slice along the first axis with dimensions
#'   reduced by one.
#' @export
#'
#' @examples
#' # Vector: returns last element
#' apr_last(1:5)  # Returns 5
#'
#' # Matrix: returns last row
#' m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
#' apr_last(m)  # Returns c(4, 5, 6)
#'
#' # 3D array: returns last 2D slice
#' arr <- array(1:24, c(2, 3, 4))
#' apr_last(arr)  # Returns a 3x4 matrix
apr_last <- function(x) {
  UseMethod("apr_last")
}

#' @export
apr_last.default <- function(x) {
  # For vectors, return the last element
  x[length(x)]
}

#' @export
apr_last.matrix <- function(x) {
  # For matrices, return the last row as a vector
  n <- nrow(x)
  x[n, , drop = TRUE]
}

#' @export
apr_last.array <- function(x) {
  # For arrays, return the last slice along the first axis
  dims <- dim(x)
  ndim <- length(dims)

  if (ndim == 1) {
    # This shouldn't happen for array class, but handle it
    return(x[length(x)])
  }

  # Get the last index of the first dimension
  last_idx <- dims[1]

  # Create index list: last element of first dimension, all others
  indices <- c(
    list(last_idx),
    replicate(ndim - 1, quote(expr = ), simplify = FALSE)
  )
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
