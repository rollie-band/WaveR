# Get secrets from Infisical

#' Loads secrets from Inifisical during interactive sessions
#'
#' Requires several environment variables for Infisical (CLIENT_ID, CLIENT_SECRET, and PROJECT_ID)
#'
#' @param path Set the desired subdirectory that contains the secret(s). Defaults to '/', which returns all secrets
#' @param env Infisical secrets environment. Defaults to 'dev'.
#' @param verbose Toggles the display of the Infisical export command. Default is FALSE
#'
#' @returns Silently adds secrets to the environment
#' @export
#'
#'@examples
#' \dontrun{
#' get_secrets()
#'
#' get_secrets(path = "Service_Account/ETL")
#'
#' }

get_secrets <- function(
        path = "/",
        env = "dev",
        verbose = TRUE
        ) {

    client_id <- Sys.getenv("BAND_INFISICAL_CLIENT_ID")
    client_secret <- Sys.getenv("BAND_INFISICAL_CLIENT_SECRET")
    project_id <- Sys.getenv("BAND_INFISICAL_PROJECT_ID")

    # Check for required environment variables
    if (client_id == "" || client_secret == "" || project_id == "") {
        cli::cli_abort(c(
            "One or more Infisical environment variables are not set: ",
            "Read more in the help for {.fun WaveR::get_secrets}."
        ))
    }

    token <- system2(
        "infisical",
        args = glue::glue(
            "login ",
            "--method=universal-auth ",
            "--client-id={client_id} ",
            "--client-secret={client_secret} ",
            "--plain ",
            "--silent"
        ),
        stdout = TRUE
    )

    Sys.setenv(INFISICAL_TOKEN = token)

    # load the secrets
    .temp <- tempfile()

    results <- system2(
        "infisical",
        args = glue::glue(
            "export ",
            "--path={path} ",
            "--silent ",
            "--env={env} ",
            "--projectId={project_id} ",
            "--silent "
        ),
        stdout = .temp
    )

    if(verbose) {
        num_lines <- length(readLines(.temp, warn = FALSE))
        cli::cli_inform("{num_lines} secrets loaded from Infisical://{path}?env={env}")
    }

    readRenviron(.temp)

    unlink(.temp)
}
