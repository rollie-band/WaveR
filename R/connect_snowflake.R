# Connect to Snowflake

#' Set up a Snowflake connection object to the specified database & schema
#'
#' Requires several environment variables
#'
#' @param dbname Database name. Will have DB_PREFIX and DB_SUFFIX added from global environment
#' @param schema Schema name
#' @param warehouse Warehouse name. Default is "WH_XS"
#'
#' @returns Silently returns a connection object
#' @export
#'
#'@examples
#' \dontrun{
#' connect_snowflake()
#'
#' connect_snowflake(dbname = "RAMP", schema = "CLEAN")
#'
#' }

connect_snowflake <- function(dbname = "SALESFORCE",
                              schema = "RAW",
                              warehouse = "WH_XS"
                              #api = "odbc"
                              ) {
    # test that config.yml is active
    #if (!api %in% c("odbc")) {
    #    cli::cli_abort(c("Database API can only be odbc"))
    #}

    if (!exists("config")) {
        cli::cli_abort(c(
            "x" = "{.file config.yml} must be loaded",
            "i" = "Recommend calling {.fun WaveR::use_wave} before using this function"))
    }

    if (interactive() && Sys.getenv(glue::glue("SNOWFLAKE_HOST")) == "" ) {
        get_secrets("Snowflake_SVC", config$env)
        get_secrets("Snowflake", config$env)
    }

    # Set objects
    database_name <- glue::glue("{Sys.getenv('DB_PREFIX')}{dbname}{Sys.getenv('DB_SUFFIX')}")
    snowflake_host <- Sys.getenv("SNOWFLAKE_HOST")
    snowflake_account <- Sys.getenv("SNOWFLAKE_ACCOUNT")
    snowflake_user <- Sys.getenv("SNOWFLAKE_SVC_USERNAME")
    snowflake_role <- config$snowflake_role  # set in .bashrc, .Renviron, and/or config.yaml
    private_key_path <- paste0(Sys.getenv("HOME"),
                               Sys.getenv("SNOWFLAKE_SVC_KEY_PRIVATE"))
    private_key_pwd <- Sys.getenv("SNOWFLAKE_SVC_KEY_PASSWORD")


    # test that this is a valid api
    #if (!api %in% c("odbc")) {
    #    cli::cli_abort(c("Database API can only be odbc"))
    #}

    #if (api == "odbc") {
        conn <-
            DBI::dbConnect(
            #connections::connection_open(
            odbc::snowflake(),
            dsn = "SnowflakeDSII",
            account = snowflake_account,
            uid = Sys.getenv("SNOWFLAKE_SVC_USERNAME"),
            pwd = Sys.getenv("SNOWFLAKE_SVC_PASSWORD"),
            authenticator = "SNOWFLAKE_JWT",
            PRIV_KEY_FILE = private_key_path,
            PRIV_KEY_FILE_PWD = private_key_pwd,
            warehouse = warehouse,
            Database = database_name,
            Schema = schema
        )
    #}

    # if (api == "adbc") {
    #     #snowflake_uri = glue::glue("{snowflake_user}:{private_key_pwd}@{snowflake_host}/{database_name}/RAW?role={snowflake_role}")
    #
    #     drv = drv <- adbc_driver("snowflake")
    #
    #     db <- adbcdrivermanager::adbc_database_init(
    #         drv,
    #
    #         adbc.snowflake.sql.auth_type = "auth_jwt",
    #         adbc.snowflake.sql.client_option.jwt_private_key = private_key_path,
    #         adbc.snowflake.sql.client_option.jwt_private_key_pkcs8_password = private_key_pwd,
    #
    #         adbc.snowflake.sql.account = snowflake_account,
    #         adbc.snowflake.sql.role = config$snowflake_role,
    #         adbc.snowflake.sql.db = database_name,
    #         adbc.snowflake.sql.schema = "RAW"
    #     )
    #
    #     conn <-
    #         adbcdrivermanager::adbc_connection_init(db)
    # }

    invisible(conn)

}
