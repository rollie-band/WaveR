# Connect to Gmail


#' Title
#'
#'

# TODO Finish connect_gmail() Help page
# - [ ] function parameters
# - [ ] Required environment variables
# - [ ] Examples
# assignees: rollie-band


#' @export
#'

connect_gmail <- function() {

    if (interactive() &&
        Sys.getenv(glue::glue("SMTP_HOST")) == "") {
        get_secrets("Service_Account/ETL", "dev")
    }

    parent_env <- rlang::caller_env()

    rlang::env_bind(
        .env = parent_env,

        # Bind multiple variables explicitly
        SMTP_USER =  Sys.getenv("SMTP_USERNAME"),
        SMTP_PASS = Sys.getenv("SMTP_APP_PASSWORD"),
        SMTP_SERVER =  Sys.getenv("SMTP_HOST")
    )
}
