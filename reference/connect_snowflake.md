# Set up a Snowflake connection object to the specified database & schema

Requires several environment variables

## Usage

``` r
connect_snowflake(dbname = "SALESFORCE", schema = "RAW", warehouse = "WH_XS")
```

## Arguments

- dbname:

  Database name. Will have DB_PREFIX and DB_SUFFIX added from global
  environment

- schema:

  Schema name

- warehouse:

  Warehouse name. Default is "WH_XS"

## Value

Silently returns a connection object

## Examples

``` r
if (FALSE) { # \dontrun{
connect_snowflake()

connect_snowflake(dbname = "RAMP", schema = "CLEAN")

} # }
```
