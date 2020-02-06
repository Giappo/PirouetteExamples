#' @title run pirouette example
#' @author Giovanni Laudanno
#' @description run pirouette example
#' @inheritParams default_params_doc
#' @return nothing
#' @export
run_pirouette_example <- function(
  example_no,
  project_name = get_pkg_name(),
  account = "p274829",
  session = NA
) {

  # open session
  new_session <- FALSE
  if (!jap::is_session_open(session = session)) {
    new_session <- TRUE
    session <- jap::open_session(account = account)
  }

  bash_file <- file.path(
    project_name,
    "run_pirouette_example.bash"
  )

  ssh::ssh_exec_wait(session = session, command = paste0(
    "sbatch ",
    bash_file,
    " ",
    example_no
  ))

  if (new_session == TRUE) {
    jap::close_session(session = session)
  }
  return()
}

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
