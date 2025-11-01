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
