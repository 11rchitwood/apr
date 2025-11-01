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

#' Transpose array axes
#'
#' Permutes the dimensions of an array according to the specified order.
#' This is the dyadic form of transpose, similar to R's aperm function.
#'
#' @param x an array
#' @param perm an integer vector specifying the permutation of dimensions
#'
#' @return an array with permuted dimensions
#' @export
#'
#' @examples
#' arr <- array(1:24, c(2, 3, 4))
#' apr_transpose_axes(arr, c(3, 1, 2))  # 4x2x3 array
#' apr_transpose_axes(arr, c(1, 3, 2))  # 2x4x3 array
apr_transpose_axes <- function(x, perm) {
  aperm(x, perm)
}

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

  # Build index list: all dimensions get full range except specified which is reversed
  indices <- lapply(seq_len(ndim), function(i) {
    if (i == along) {
      rev(seq_len(dims[i]))
    } else {
      TRUE # Select all elements along this dimension
    }
  })

  # Use do.call to handle variable number of dimensions
  do.call(`[`, c(list(x), indices, drop = FALSE))
}

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

  # Build index list for rotation along specified axis
  indices <- lapply(seq_len(ndim), function(i) {
    if (i == along) {
      # Rotate this dimension's indices
      n <- dims[i]
      c((n - k + 1):n, 1:(n - k))
    } else {
      TRUE # Select all elements along this dimension
    }
  })

  # Use do.call to handle variable number of dimensions
  do.call(`[`, c(list(x), indices, drop = FALSE))
}
