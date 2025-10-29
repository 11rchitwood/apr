#' Retrieve the shape of an array
#'
#' @param x an array or object
#'
#' @return an integer vector representing the dimensions
#' @export
#'
#' @examples
#' arr <- array(1:12, c(3, 2, 2))
#' apr_shape(arr)  # Returns c(3, 2, 2)
apr_shape <- dim

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
  dim(x) <- value
  x
}

#' Generate index vector or array
#'
#' The monadic form of APL's iota (⍳). Generates indices from 1 to n for a
#' scalar, or an array of index combinations for a vector shape.
#'
#' @param x an integer scalar or vector representing the shape
#'
#' @return For a scalar n, returns 1:n. For a vector shape, returns an array
#'   where each element contains the indices at that position.
#' @export
#'
#' @examples
#' apr_iota(5)  # Returns 1:5
#' apr_iota(c(3, 4))  # Returns a 3x4 array with index combinations
apr_iota <- function(x) {
  if (length(x) == 1) {
    # Simple case: scalar input
    seq_len(x)
  } else {
    # Multi-dimensional case: generate array of index combinations
    dims <- as.integer(x)
    n_dims <- length(dims)
    # Generate all index combinations
    idx_grid <- do.call(expand.grid, lapply(dims, seq_len))
    # Convert to matrix for easier manipulation
    idx_mat <- as.matrix(idx_grid)
    # Reshape into array: each position contains its index vector
    result <- array(t(idx_mat), dim = c(n_dims, dims))
    # Permute dimensions so that the last dimension is the index vector
    result <- aperm(result, c(2:(n_dims + 1), 1))
    result
  }
}

#' Find index of first occurrence
#'
#' The dyadic form of APL's iota (⍳). Finds the index of the first occurrence
#' of each element in the right argument within the left argument.
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
