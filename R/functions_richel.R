#' @title run pirouette example
#' @author Giovanni Laudanno
#' @description run pirouette example
#' @inheritParams default_params_doc
#' @return nothing
#' @export
open_example_script <- function(
  example_no
) {
  github_folder <- dirname(getwd())
  example_folder <- file.path(
    github_folder,
    paste0("pirouette_example_", example_no)
  )
  r_file <- file.path(
    example_folder,
    paste0("example_GL_", example_no, ".R")
  )
  if (!file.exists(r_file)) {
    stop("File doesn't exist")
  }
  file.edit(r_file)
  return()
}
