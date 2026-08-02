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
test:
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
    Rscript -e "usethis::use_r('{{name}}')

