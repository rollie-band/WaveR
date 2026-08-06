
#' Use the default Wave settings
#'
#' Loads config.yml settings and default options for a Wave project.
#'
#' Specifically, reads the config.yml file if present, displays the addresses in
#' config$emails_errors, and sets the working directory.
#'
#' @param quiet Toggles the display of each setting. Default is FALSE
#'
#' @returns Silently adds configuration settings to the environment
#' @export
#'
#' @examples
#' \dontrun{
#' use_wave()
#'
#' use_wave(quiet = TRUE)
#' }

use_wave <- function(quiet = FALSE) {


    is_wave_project <- rprojroot::has_file("config.yml")
    is_shiny_app <- rprojroot::has_file("server.R")

    config_env <- Sys.getenv("R_CONFIG_ACTIVE")

    if(!quiet) cli::cli_rule(left = "Wave setup")

    if(file.exists("config.yml")) {

        rlang::env_bind(
            .env = rlang::global_env(),

            # Bind multiple variables explicitly
            config =  config::get()
        )

        if (!quiet) {
            cli::cli_bullets(c(
            "*" = "{.file config.yml} loaded using { Sys.getenv('R_CONFIG_ACTIVE') }",
            "*" = "{.field emails_errors}: {config$emails_error}"
            ))
        }
    }

    # Set working directory to project root
    wd <-
        rprojroot::find_root(
            is_wave_project | rprojroot::is_r_package | is_shiny_app
        )

    setwd(wd)

    if (!quiet) {
        cli::cli_bullets(c(
        "*" = "{.field working_directory}: {wd}"
        ))
    }

    # Load Gmail SMTP variables
    WaveR::connect_gmail()
    if (!quiet) {
            cli::cli_bullets(c(
            "*" = "SMTP variables for Gmail loaded"
            ))
    }

}
