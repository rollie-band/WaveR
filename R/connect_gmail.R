# Connect to Gmail


#' Title
#'
#' @export
#'

connect_gmail <- function() {
    if (interactive() &&
        Sys.getenv(glue::glue("SUPABASE_HOST_{app}")) == "") {
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
