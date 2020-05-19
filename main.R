# MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
# FMAD Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r-essentials/ 
######################################################
#             Install & Load libraries               #
######################################################
# Set up CRAN mirror
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

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

install_packages(c("gdata", "dplyr", "plyr", "ggplot2", "readxl", "FactoMineR", "factoextra", "ca", 
                   "gplots","ggpubr", "tidyverse", "gridExtra", "patchwork", "formattable",
                   "data.table","psych","ggrepel"))

######################################################
#                     Main scripts                   #
######################################################
# Load the data into memory, do a few minor 
# mods to the data
# DEPENDENCIES
#     "data/first_scientists_survey.csv"
#     "data/second_scientists_survey.csv"
#     "data/third_scientists_survey.csv"
source("scripts/load_data.R")

# Recode the three sureys to get the general regions 
# based on the country
# DEPENDENCIES
#     "data/country_codes/regions_master_list.csv"
source("scripts/country_codes.R")

# Recode the respondent's domain so that the three 
# surveys' data is comparable.
# DEPENDENCIES
#     "data/domains/survey_one_domain_code.csv"
#     "data/domains/recoded_domain_mapping.csv"
source("scripts/domain_recode.R")

# Clean the survey data
#       1) Input questions
#       2) Make questions align between surveys
#       3) Change all values to characters
#       4) Change blank spaces to NA
#       5) Remove individuals with more than 5 NAs
source("scripts/cleanSurveys.R")

# Combine 3 surveys
#       1) Reorder questions
#       2) Add survey label
#       3) Create dataframe that includes demographic data (surveys_combined_demos)
#       4) Combine dataframe for factor analysis
#       5) Change work sector from numbers to proper labels
#       6) Backup surveys_combined & surveys_combined_demos as .backup
#       7) Move Law domain into Other
source("scripts/combineSurveys.R")

# Perform Multi-Factor Analysis
#       1) Perform MFA
#       2) Add computed DIM1, DIM2, and total contributions to surveys_combined_demos
#       3) OPTIONAL: Export main dataframe (data/surveys_combined_demos.csv)
#       4) OPTIONAL: Export scree plot and biplot (plots/scree_biplot.pdf)
source("scripts/multiFactorAnalysis.R")

##################################################
#                    ARCHIVE                     #
##################################################

# PLOTS: Generate scree, contribution, biplots & export as mfa_surveys_combined_plots.pdf
# source("scripts/archive/mainPlots.R")

# PLOTS: Generate biplots of primary influential DIM1 & DIM2 questions
#         Print biplots as mfa_dim1_interpretation.pdf & mfa_dim2_interpretation.pdf
# source("scripts/archive/biplotAnalysis.R")

# PLOTS: MANOVA and boxplots for influential DIM1 & DIM2 questions
# CSV files of MANOVA tables, 
#         ./data/MANOVA_dim1.csv 
#         ./data/MANOVA_dim2.csv
# source("scripts/archive/statsSurveyComp.R")

# Print loadings to /data/all_loadings.csv
# Print list  of most correlated variables to
#         ./data/correlated_dim1_quali_vars.csv
#         ./data/correlated_dim2_quali_vars.csv
#         ./data/correlated_dim1_vars_category.csv
#         ./data/correlated_dim2_vars_category.csv
# source("scripts/archive/printLoadings.R")

# Limit work sector and domain
#       1) Limit dataframe limited to:
#                Regions: EuroRussia, USACanada, AustraliaNZ
#                Domains: Natural science, Physical science
# source("scripts/archive/limitDomainRegion.R")

