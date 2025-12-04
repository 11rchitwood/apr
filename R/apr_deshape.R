#' Remove the shape of an array
#'
#' @param x an array or vector
#'
#' @return a vector with dimensions removed
#' @export
#'
#' @examples
#' x <- array(1:12, c(3, 4))
#' apr_deshape(x)  # Returns vector 1:12
#'
#' x <- array(1:24, c(2, 3, 4))
#' apr_deshape(x)  # Returns vector 1:24
apr_deshape <- function(x) {
  as.vector(x)
}
