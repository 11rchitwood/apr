#' Transpose an array
#'
#' Reverses all dimensions of an array. For a 2D matrix, this is the standard
#' transpose. For higher dimensional arrays, it reverses the order of dimensions.
#'
#' @param x an array
#'
#' @return an array with reversed dimensions
#' @export
#'
#' @examples
#' # 2D matrix transpose
#' m <- matrix(1:6, nrow = 2, ncol = 3)
#' apr_transpose(m)  # 3x2 matrix
#'
#' # 3D array transpose
#' arr <- array(1:24, c(2, 3, 4))
#' apr_transpose(arr)  # 4x3x2 array
apr_transpose <- function(x) {
  if (is.null(dim(x))) {
    # For vectors, return as-is (or as a column vector if needed)
    return(x)
  }
  aperm(x, rev(seq_along(dim(x))))
}

#' Transpose array axes
#'
#' Permutes the dimensions of an array according to the specified order.
#' This is the dyadic form of transpose, similar to R's aperm function.
#'
#' @param x an array
#' @param perm an integer vector specifying the permutation of dimensions
#'
#' @return an array with permuted dimensions
#' @export
#'
#' @examples
#' arr <- array(1:24, c(2, 3, 4))
#' apr_transpose_axes(arr, c(3, 1, 2))  # 4x2x3 array
#' apr_transpose_axes(arr, c(1, 3, 2))  # 2x4x3 array
apr_transpose_axes <- function(x, perm) {
  aperm(x, perm)
}

#' Reverse along a specified axis
#'
#' Reverses the elements along a specified axis of an array. For a vector, this
#' reverses the entire vector. For arrays, you can specify which axis to reverse.
#' By default, reverses along the last axis. This is similar to APL's bracket
#' notation `⌽[K]` which reverses along axis K.
#'
#' @param x an array or vector
#' @param along an integer specifying which axis to reverse along (default: last axis)
#'
#' @return an array with the specified axis reversed
#' @export
#'
#' @examples
#' # Vector reverse
#' apr_reverse(1:5)  # Returns c(5, 4, 3, 2, 1)
#'
#' # Matrix: reverse along last axis (default, reverses each row horizontally)
#' m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
#' apr_reverse(m)
#'
#' # Matrix: reverse along first axis (reverses rows vertically)
#' apr_reverse(m, along = 1)
#'
#' # 3D array: reverse along last axis
#' arr <- array(1:24, c(2, 3, 4))
#' apr_reverse(arr)
#'
#' # 3D array: reverse along second axis
#' apr_reverse(arr, along = 2)
apr_reverse <- function(x, along = NULL) {
  dims <- dim(x)

  if (is.null(dims)) {
    # For vectors, simply reverse
    return(rev(x))
  }

  # Determine which axis to reverse
  ndim <- length(dims)
  if (is.null(along)) {
    along <- ndim  # Default to last axis
  }

  # Validate along parameter
  if (along < 1 || along > ndim) {
    stop(sprintf("'along' must be between 1 and %d (number of dimensions)", ndim))
  }

  # Build index list: all dimensions get full range except specified which is reversed
  indices <- lapply(seq_len(ndim), function(i) {
    if (i == along) {
      rev(seq_len(dims[i]))
    } else {
      TRUE # Select all elements along this dimension
    }
  })

  # Use do.call to handle variable number of dimensions
  do.call(`[`, c(list(x), indices, drop = FALSE))
}

#' Rotate a vector
#'
#' @param x a vector
#' @param k an integer, the position to rotate
#'
#' @return a vector
#'
#' @examples
#' apr_rotate(1:12, 3)
#'
#' @export
apr_rotate <- function(x, k) {
  n <- length(x)

  # Handle edge cases
  if (n == 0) {
    return(x)
  }
  if (k == 0) {
    return(x)
  }

  # Normalize k to be within range [0, n)
  k <- k %% n
  if (k == 0) {
    return(x)
  }

  # Perform rotation: move last k elements to the front
  c(x[(n - k + 1):n], x[1:(n - k)])
}
