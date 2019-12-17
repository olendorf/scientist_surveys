# Run this script to perform all the analyses and figures.
# To run in individual scripts you will typically have to run
# scripts/load_data.R first to get it into memory.
###################
### MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
### FMAD Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r-essentials/ 
### Rotation in Factominer :: http://factominer.free.fr/question/FAQ.html 
### Install libraries if need be
# install.packages(c("pacman", "gdata", "plyr", "ggplot2", "readxl", "FactoMineR", "factoextra", "ca", "gplots", "ggpubr"))
############################################################################
### Load all libraries
library(pacman)
pacman::p_load(gdata, dplyr, plyr, ggplot2, readxl, FactoMineR, factoextra, ca, gplots, ggpubr, tidyverse, gridExtra)

# Load the data into memory, do a few minor 
# mods to the data
source("scripts/load_data.R")

# Recode the three sureys to get the general regions 
# based on the country
source("scripts/country_codes.R")

# Create the figure to show regional representation
# of respondents by survey
source("scripts/region_count_figure.R")  

# Recode the respondent's domain so that the three 
# surveys' data is comparable.
source("scripts/domain_recode.R")

# Factor analysis code
# source("mfa_surveys_combined_v001.R")








