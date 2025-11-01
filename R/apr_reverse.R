#' Reverse along a specified axis
#'
#' Reverses the elements along a specified axis of an array. For a vector, this
#' reverses the entire vector. For arrays, you can specify which axis to reverse.
#' By default, reverses along the last axis. This is similar to APL's bracket
#' notation `⌽[K]` which reverses along axis K.
#'
#' @param x an array or vector
#' @param along an integer specifying which axis to reverse along (default: last axis)
#'
#' @return an array with the specified axis reversed
#' @export
#'
#' @examples
#' # Vector reverse
#' apr_reverse(1:5)  # Returns c(5, 4, 3, 2, 1)
#'
#' # Matrix: reverse along last axis (default, reverses each row horizontally)
#' m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
#' apr_reverse(m)
#'
#' # Matrix: reverse along first axis (reverses rows vertically)
#' apr_reverse(m, along = 1)
#'
#' # 3D array: reverse along last axis
#' arr <- array(1:24, c(2, 3, 4))
#' apr_reverse(arr)
#'
#' # 3D array: reverse along second axis
#' apr_reverse(arr, along = 2)
apr_reverse <- function(x, along = NULL) {
  UseMethod("apr_reverse")
}

#' @export
apr_reverse.default <- function(x, along = NULL) {
  # For vectors, simply reverse
  rev(x)
}

#' @export
apr_reverse.matrix <- function(x, along = NULL) {
  # Determine which axis to reverse
  if (is.null(along)) {
    along <- 2 # Default to last axis (columns for matrices)
  }

  # Validate along parameter
  if (along < 1 || along > 2) {
    stop("'along' must be between 1 and 2 (number of dimensions)")
  }

  # Reverse along the specified axis
  if (along == 1) {
    # Reverse rows
    dims <- dim(x)
    x[rev(seq_len(dims[1])), , drop = FALSE]
  } else {
    # Reverse columns
    dims <- dim(x)
    x[, rev(seq_len(dims[2])), drop = FALSE]
  }
}

#' @export
apr_reverse.array <- function(x, along = NULL) {
  # Determine which axis to reverse
  dims <- dim(x)
  ndim <- length(dims)

  if (is.null(along)) {
    along <- ndim # Default to last axis
  }

  # Validate along parameter
  if (along < 1 || along > ndim) {
    stop(sprintf(
      "'along' must be between 1 and %d (number of dimensions)",
      ndim
    ))
  }

  # If reversing along first dimension, do it directly
  if (along == 1) {
    indices <- c(list(rev(seq_len(dims[1]))), rep(list(TRUE), ndim - 1))
    return(do.call(`[`, c(list(x), indices, drop = FALSE)))
  }

  # Otherwise, permute to move 'along' dimension to front
  perm <- c(along, setdiff(seq_len(ndim), along))
  x_perm <- aperm(x, perm)

  # Reverse along first dimension
  dims_perm <- dim(x_perm)
  indices <- c(list(rev(seq_len(dims_perm[1]))), rep(list(TRUE), ndim - 1))
  x_reversed <- do.call(`[`, c(list(x_perm), indices, drop = FALSE))

  # Permute back to original dimension order
  perm_back <- order(perm)
  aperm(x_reversed, perm_back)
}
