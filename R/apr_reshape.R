#' Change the shape of an array
#'
#' @param x an array or vector
#' @param value an integer vector representing the new dimensions
#'
#' @return an array with the specified dimensions
#' @export
#'
#' @examples
#' x <- 1:12
#' apr_reshape(x, c(3, 4))  # Returns a 3x4 matrix
#' apr_reshape(x, c(2, 2, 3))  # Returns a 2x2x3 array
apr_reshape <- function(x, value) {
  stopifnot(length(x) == prod(value))
  dim(x) <- value
  x
}
