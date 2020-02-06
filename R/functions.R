#' @title Export cluster scripts
#' @author Giovanni Laudanno
#' @description Export cluster scripts
#' @inheritParams default_params_doc
#' @return nothing
upload_scripts <- function(
  project_name = "pirouette_examples",
  account = "p274829",
  session = NA
) {
  
  # open session
  new_session <- FALSE
  if (!jap::is_session_open(session = session)) {
    new_session <- TRUE
    session <- jap::open_session(account = account)
  }
  
  local_folder <- file.path(getwd(), "scripts")
  remote_folder <- file.path(project_name)
  ssh::ssh_exec_wait(session, command = paste0("mkdir -p ", project_name))
  
  system.time(
    ssh::scp_upload(
      session = session,
      files = paste0(
        local_folder,
        "/",
        list.files(local_folder, pattern = ".bash")
      ),
      to = remote_folder
    )
  )
  
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
run_pirouette_example <- function(
  project_name = "pirouette_examples",
  example_no,
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
    "run_pirouette_example"
  )

  ssh::ssh_exec_wait(session = session, command = paste0(
    "sbatch ",
    "run_pirouette_example",
    " ",
    example_no
  ))

  if (new_session == TRUE) {
    jap::close_session(session = session)
  }
  return()
}