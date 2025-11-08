#' Generate index vector or array
#'
#' Generates indices from 1 to n for a scalar, or an array of index combinations for a vector shape.
#'
#' @param x an integer scalar or vector representing the shape
#'
#' @return For a scalar n, returns 1:n. For a vector shape, returns an array
#'   where each element contains the indices at that position.
#' @export
#'
#' @examples
#' apr_range(5)  # Returns 1:5
#' apr_range(c(3, 4))  # Returns a 3x4 array with index combinations
apr_range <- function(x) {
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
