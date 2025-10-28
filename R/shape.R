#' Retreive the shape of an array
#'
#' @return an integer vector
#' @export
apr_shape <- dim

#' Change the shape of an array
#'
#' @param x an array
#' @param value an integer vector
#'
#' @return an array
#' @export
apr_reshape <- function(x, value) {
  dim(x) <- value
  x
}
