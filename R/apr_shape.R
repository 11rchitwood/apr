#' Retrieve the shape of an array
#'
#' @return an integer vector representing the dimensions
#' @export
#'
#' @examples
#' arr <- array(1:12, c(3, 2, 2))
#' apr_shape(arr)  # Returns c(3, 2, 2)
apr_shape <- dim
