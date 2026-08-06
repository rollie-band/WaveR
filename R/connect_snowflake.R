# Connect to Snowflake


#' Title
#'
#' @param dbname Database name
#' @param schema Schema name
#' @param api ODBC or ADBC

# TODO Finish connect_snowflake() Help page
# - [ ] function parameters
# - [ ] Required environment variables
# - [ ] Examples
# assignees: rollie-band

#' @returns connection object
#' @export
#'

connect_snowflake <- function(dbname = "SCARF",
                              schema = "RAW",
                              api = "odbc") {
    config <- list()
    config$snowflake_role <- "DEVELOPER"

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
    if (!api %in% c("odbc")) {
        cli::cli_abort(c("Database API can only be odbc"))
    }

    if (api == "odbc") {
        conn <- DBI::dbConnect(
            #connections::connection_open(
            odbc::odbc(),
            dsn = "SnowflakeDSII",
            account = snowflake_account,
            uid = Sys.getenv("SNOWFLAKE_SVC_USERNAME"),
            pwd = Sys.getenv("SNOWFLAKE_SVC_PASSWORD"),
            authenticator = "SNOWFLAKE_JWT",
            PRIV_KEY_FILE = private_key_path,
            PRIV_KEY_FILE_PWD = private_key_pwd,
            warehouse = "WH_XS",
            Database = database_name,
            Schema = schema
        )
    }

    # if (api == "adbc") {
    #     #snowflake_uri = glue::glue("{snowflake_user}:{private_key_pwd}@{snowflake_host}/{database_name}/RAW?role={snowflake_role}")
    #
    #     drv = drv <- adbc_driver("snowflake")
    #
    #     db <- adbcdrivermanager::adbc_database_init(
    #         drv,
    #
    #         adbc.snowflake.sql.auth_type = "auth_jwt",
    #         #adbc.snowflake.sql.client_option.jwt_private_key = private_key_path,
    #         #adbc.snowflake.sql.client_option.jwt_private_key_pkcs8_password = private_key_pwd,
    #         adbc.snowflake.sql.client_option.jwt_private_key = '/home/rollie/.ssh/snowflake_rsa_key.p8',
    #         adbc.snowflake.sql.client_option.jwt_private_key_pkcs8_password = "NoCapes",
    #
    #         adbc.snowflake.sql.account = snowflake_account,
    #         #adbc.snowflake.sql.warehouse = ,
    #         adbc.snowflake.sql.role = config$snowflake_role,
    #         adbc.snowflake.sql.db = database_name,
    #         adbc.snowflake.sql.schema = "RAW"
    #     )
    #
    #     conn <-
    #         adbcdrivermanager::adbc_connection_init(db)
    # }

    conn

}
