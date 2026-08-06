# Connect to Subabase

#' Set up a Supbabase connection object to the specified CapeGlobal App
#'
#' Requires several environment variables for Supabase (HOST, USER, & PASSWORD)
#'
#' @param app Specify the CapeGlobal Application in Supabase ("SCARF", "CLOAK")
#'
#' @returns Silently returns a connection object
#'
#' @export
#'
#'@examples
#' \dontrun{
#' connect_supabase()
#'
#' connect_supabase(app = "CLOAK")
#'
#' connect_supabase(app = "SCARF")
#'
#' }

connect_supabase <- function(app = NA) {

    if (interactive() && Sys.getenv(glue::glue("SUPABASE_HOST_{app}")) == "" ) {
        get_secrets("Supabase", config$env)
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
    #if (!api %in% c("odbc")) {
    #j    cli::cli_abort(c("Database API can only be ODBC"))
    #}

    #if (api == "odbc") {
        conn <- connections::connection_open(
            #DBI::dbConnect(
            RPostgres::Postgres(),
            host     = host, #Sys.getenv(glue::glue("SUPABASE_HOST_{app}")),
            port     = 5432,
            dbname   = "postgres",
            user     = user, #Sys.getenv(glue("SUPABASE_USER_{app}")),
            password = password, #Sys.getenv(glue("SUPABASE_PASSWORD_{app}")),
            sslmode  = "require"
        )
    #}

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

    invisible(conn)
}
