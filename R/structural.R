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
  x <- rev(x)
  x[1:k] <- rev(x[1:k])
  x[(k + 1):n] <- rev(x[(k + 1):n])
  x
}
