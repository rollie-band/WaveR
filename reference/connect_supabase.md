# Set up a Supbabase connection object to the specified CapeGlobal App

Requires several environment variables for Supabase (HOST, USER, &
PASSWORD)

## Usage

``` r
connect_supabase(app = NA)
```

## Arguments

- app:

  Specify the CapeGlobal Application in Supabase ("SCARF", "CLOAK")

## Value

Silently returns a connection object

## Examples

``` r
if (FALSE) { # \dontrun{
connect_supabase()

connect_supabase(dbname = "CLOAK")

connect_supabase(dbname = "SCARF")

} # }
```
