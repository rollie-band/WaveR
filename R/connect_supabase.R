# Connect to Subabase


#' Title
#'
#' @param app Specify the StudioBand Application in Supabase ("SCARF", "CLOAK")
#' @param api Specify the database driver (ODBC, ADBC). Default is 'odbc'
#'
#' @returns conn
#'
#' @export
#'
# @examples
#'
#'

connect_supabase <- function(app = NA, api = "odbc") {

    if (interactive() && Sys.getenv(glue::glue("SUPABASE_HOST_{app}")) == "" ) {
        get_secrets("Supabase", "dev")
    }

    host     <- Sys.getenv(glue::glue("SUPABASE_HOST_{app}"))
    user     <-  Sys.getenv(glue::glue("SUPABASE_USER_{app}"))
    password <-  Sys.getenv(glue::glue("SUPABASE_PASSWORD_{app}"))
    dbname   <- "postgres"

    # test that this is a valid App name
    if (is.na(app) || !app %in% c("SCARF", "CLOAK")) {
        cli::cli_abort(c("app must be SCARF or CLOAK"))
    }


    # test that this is a valid api
    if (!api %in% c("odbc")) {
        cli::cli_abort(c("Database API can only be ODBC"))
    }

    if (api == "odbc") {
        conn <- #connections::connection_open(
            DBI::dbConnect(
            RPostgres::Postgres(),
            host     = host, #Sys.getenv(glue::glue("SUPABASE_HOST_{app}")),
            port     = 5432,
            dbname   = "postgres",
            user     = user, #Sys.getenv(glue("SUPABASE_USER_{app}")),
            password = password, #Sys.getenv(glue("SUPABASE_PASSWORD_{app}")),
            sslmode  = "require"
        )
    }

    # TODO Enable ADBC Connections
    # Currently blocked because the SCARF password includes an `@` character,
    # which breaks the URI path.
    # assignees: rollie-band


    # if (api == "adbc" & app == "CLOAK") {
    #     uri = glue::glue("postgresql://{user}:{password}@{host}:5432/postgres")
    #
    #     db <- adbcdrivermanager::adbc_database_init(
    #         adbcpostgresql::adbcpostgresql(),
    #         uri = uri
    #     )
    #
    #     conn <-
    #         adbc_connection_init(db)
    # }

    conn
}
