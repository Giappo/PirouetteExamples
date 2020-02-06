#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param account a peregrine account
#' @param age the age of the phylogeny
#' @param example_no number of the example
#' @param function_name name of the function
#' @param session a ssh session
#' @param lambda speciation rate
#' @param mu extinction rate
#' @param message a message to be print
#' @param n_replicates number of replicates
#' @param t time
#' @param verbose choose if you want to print the output or not
#' @author Documentation by Giovanni Laudanno,
#' @note This is an internal function, so it should be marked with
#'   \code{@noRd}. This is not done, as this will disallow all
#'   functions to find the documentation parameters
default_params_doc <- function(
  account,
  age,
  example_no,
  function_name,
  lambda,
  message,
  mu,
  n_replicates,
  session,
  t,
  verbose
) {
  # Nothing
}
