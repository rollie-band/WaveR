# Loads secrets from Inifisical during interactive sessions

Requires several environment variables for Infisical (CLIENT_ID,
CLIENT_SECRET, and PROJECT_ID)

## Usage

``` r
get_secrets(path = "/", env = "dev", verbose = TRUE)
```

## Arguments

- path:

  Set the desired subdirectory that contains the secret(s). Defaults to
  '/', which returns all secrets

- env:

  Infisical secrets environment. Defaults to 'dev'.

- verbose:

  Toggles the display of the Infisical export command. Default is FALSE

## Value

Silently adds secrets to the environment

## Examples

``` r
if (FALSE) { # \dontrun{
get_secrets()

get_secrets(path = "Service_Account/ETL")

} # }
```
