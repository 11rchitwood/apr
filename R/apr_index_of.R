#' Find index of first occurrence
#' Finds the index of the first occurrence of each element in the right argument within the left argument.
#'
#' @param x the haystack (left argument)
#' @param y the needle (right argument)
#'
#' @return An integer vector of the same shape as y, containing the index of
#'   the first occurrence of each element in x. Elements not found return
#'   length(x) + 1.
#' @export
#'
#' @examples
#' apr_index_of(c("A", "B", "C", "D", "E"), c("A", "C", "E"))  # Returns c(1, 3, 5)
#' apr_index_of(1:5, c(3, 7, 1))  # Returns c(3, 6, 1)
apr_index_of <- function(x, y) {
  # Convert to vectors for matching
  x_vec <- as.vector(x)
  y_vec <- as.vector(y)

  # Find first occurrence of each element of y in x
  result <- vapply(
    y_vec,
    function(elem) {
      idx <- which(x_vec == elem)[1]
      if (is.na(idx)) length(x_vec) + 1L else idx
    },
    integer(1)
  )

  # Preserve the shape of y
  if (!is.null(dim(y))) {
    dim(result) <- dim(y)
  }

  result
}
