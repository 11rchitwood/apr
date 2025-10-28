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
