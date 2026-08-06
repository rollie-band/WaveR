
# WaveR

<!-- badges: start -->
[![R-CMD-check](https://github.com/rollie-band/WaveR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rollie-band/WaveR/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of WaveR is to facilitate code-reuse between Wave projects using standardized functions.

## Installation

You can install the development version of WaveR from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("StudioBandLLC/WaveR")
```

## Example


``` r
library(WaveR)

# Runs at the start of a project to load the common configurations and 
# settings 

use_wave()

# Connect to the RAMP database in Snowflake
conSnow <- connect_snowflake("RAMP", "CLEAN")

# Connect to the SCARF database in Supabase
conScarf <- connect_supabase("SCARF")

```

