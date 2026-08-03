# Justfile for WaveR Package Development

# Display all recipes
[default]
_list:
    @ {{just_executable()}} --list --justfile {{justfile()}} --unsorted

# Run all primary development tasks at once
all: document test build

# Generate package documentation and update NAMESPACE using roxygen2
document:
    Rscript -e "devtools::document()"

# Run the unit test suite using testthat
testthat:
    Rscript -e "devtools::test()"

# Check the package for CRAN compliance and errors
check:
    Rscript -e "devtools::check()"

# Build the package into a distributable tarball
build:
    Rscript -e "devtools::build()"

# Install the package locally
install:
    Rscript -e "devtools::install()"

# Interactively create a new R function file and a matching test file
# Usage: just new-file my_function
new-file name:
    Rscript -e "usethis::use_r('{{name}}')"

# Run test scripts 
test:
    #!/usr/bin/env bash
    INFISICAL_TOKEN=$(infisical login \
    --method=universal-auth \
    --client-id=${BAND_INFISICAL_CLIENT_ID} \
    --client-secret=${BAND_INFISICAL_CLIENT_SECRET} \
    --plain \
    --silent
    )

    infisical run \
    --projectId=${BAND_INFISICAL_PROJECT_ID} \
    --token=$INFISICAL_TOKEN \
    --env=prod \
    --path="/" \
    --recursive \
    -- \
    Rscript debug.R

