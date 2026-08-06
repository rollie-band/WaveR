# Connect to Gmail

#' Load the SMTP connection variables for sending email via Gmail.
#'
#' This function is called from WaveR::use_wave()
#'
#' @export
#'
#'@examples
#' \dontrun{
#' connect_gmail()
#'
#' }#'

connect_gmail <- function() {

    if (interactive() &&
        Sys.getenv(glue::glue("SMTP_HOST")) == "") {
        get_secrets("Service_Account/ETL", "dev")
    }

    parent_env <- rlang::global_env()

    rlang::env_bind(
        .env = parent_env,

        # Bind multiple variables explicitly
        SMTP_USER =  Sys.getenv("SMTP_USERNAME"),
        SMTP_PASS = Sys.getenv("SMTP_APP_PASSWORD"),
        SMTP_SERVER =  Sys.getenv("SMTP_HOST")
    )
}
