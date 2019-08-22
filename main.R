# Run this script to perform all the analyses and figures.
# To run in individual scripts you will typically have to run
# scripts/load_data.R first to get it into memory.

###################
## Automate package install and load

is_installed <- function(package_name) is.element(package_name, installed.packages()[,1])

# If a package is not installed, install it. Then load the package.
install_and_load <- function(package_name) {
  if(!is_installed(package_name)) {
    install.packages(package_name)
  }
  library(package_name, character.only = TRUE)
}

install_packages <- function(packages) {
  for(package in packages) {
    install_and_load(package)
  }
}

install_packages(c("ggplot2", "plyr", "gridExtra"))

# Load the data into memory, do a few minor 
# mods to the data
source("scripts/load_data.R")

# Recode the three sureys to get the general regions 
# based on the country
source("scripts/country_codes.R")

# Create the figure to show regional representation
# of respondents by survey
source("scripts/region_count_figure.R")  






