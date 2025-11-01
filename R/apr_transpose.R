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
