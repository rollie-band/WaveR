# Use the default Wave settings

Loads config.yml settings and default options for a Wave project.

## Usage

``` r
use_wave(quiet = FALSE)
```

## Arguments

- quiet:

  Toggles the display of each setting. Default is FALSE

## Value

Silently adds configuration settings to the environment

## Details

Specifically, reads the config.yml file if present, displays the
addresses in config\$emails_errors, and sets the working directory.

## Examples

``` r
if (FALSE) { # \dontrun{
use_wave()

use_wave(quiet = TRUE)
} # }
```
