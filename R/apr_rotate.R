#' Rotate along a specified axis
#'
#' Rotates elements along a specified axis of an array. For a vector, this rotates
#' the entire vector by k positions. For arrays, you can specify which axis to rotate.
#' By default, rotates along the last axis. This is similar to APL's bracket
#' notation `k⌽[I]X` which rotates X by k positions along axis I.
#'
#' @param x an array or vector
#' @param k an integer, the number of positions to rotate
#' @param along an integer specifying which axis to rotate along (default: last axis)
#'
#' @return an array with the specified axis rotated
#' @export
#'
#' @examples
#' # Vector rotation
#' apr_rotate(1:12, 3)  # Rotate by 3 positions
#'
#' # Matrix: rotate along last axis (default, rotates each row)
#' m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
#' apr_rotate(m, 1)
#'
#' # Matrix: rotate along first axis (rotates the rows themselves)
#' apr_rotate(m, 1, along = 1)
#'
#' # 3D array: rotate along last axis
#' arr <- array(1:24, c(2, 3, 4))
#' apr_rotate(arr, 2)
#'
#' # 3D array: rotate along second axis
#' apr_rotate(arr, 1, along = 2)
apr_rotate <- function(x, k, along = NULL) {
  UseMethod("apr_rotate")
}

#' @export
apr_rotate.default <- function(x, k, along = NULL) {
  # For vectors
  n <- length(x)
  if (n == 0) {
    return(x)
  }
  if (k == 0) {
    return(x)
  }

  # Normalize k to be within range [0, n)
  k <- k %% n
  if (k == 0) {
    return(x)
  }

  # Perform rotation: move last k elements to the front
  c(x[(n - k + 1):n], x[1:(n - k)])
}

#' @export
apr_rotate.matrix <- function(x, k, along = NULL) {
  # Determine which axis to rotate
  if (is.null(along)) {
    along <- 2 # Default to last axis (columns for matrices)
  }

  # Validate along parameter
  if (along < 1 || along > 2) {
    stop("'along' must be between 1 and 2 (number of dimensions)")
  }

  # Normalize k for the dimension we're rotating
  dims <- dim(x)
  k <- k %% dims[along]
  if (k == 0) {
    return(x)
  }

  # Rotate along the specified axis
  if (along == 1) {
    # Rotate rows
    n <- dims[1]
    new_indices <- c((n - k + 1):n, 1:(n - k))
    x[new_indices, , drop = FALSE]
  } else {
    # Rotate columns
    n <- dims[2]
    new_indices <- c((n - k + 1):n, 1:(n - k))
    x[, new_indices, drop = FALSE]
  }
}

#' @export
apr_rotate.array <- function(x, k, along = NULL) {
  # Determine which axis to rotate
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

  # Normalize k for the dimension we're rotating
  k <- k %% dims[along]
  if (k == 0) {
    return(x)
  }

  # If rotating along first dimension, do it directly
  if (along == 1) {
    n <- dims[1]
    new_indices <- c((n - k + 1):n, 1:(n - k))
    indices <- c(list(new_indices), rep(list(TRUE), ndim - 1))
    return(do.call(`[`, c(list(x), indices, drop = FALSE)))
  }

  # Otherwise, permute to move 'along' dimension to front
  perm <- c(along, setdiff(seq_len(ndim), along))
  x_perm <- aperm(x, perm)

  # Rotate along first dimension
  dims_perm <- dim(x_perm)
  n <- dims_perm[1]
  new_indices <- c((n - k + 1):n, 1:(n - k))
  indices <- c(list(new_indices), rep(list(TRUE), ndim - 1))
  x_rotated <- do.call(`[`, c(list(x_perm), indices, drop = FALSE))

  # Permute back to original dimension order
  perm_back <- order(perm)
  aperm(x_rotated, perm_back)
}
