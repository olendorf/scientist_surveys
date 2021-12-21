# MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
# FMAD Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r-essentials/ 

# Rotation in Factominer :: http://factominer.free.fr/question/FAQ.html 
# Install libraries if need be
# 
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
 
 # install_packages(c("gdata", "ggpmisc","dplyr", "plyr", "tidyr","ggplot2","readxl", "FactoMineR", "factoextra", 
 #                    "ca", "gplots","ggrepel","ggpubr", "grid", "gridExtra", "patchwork", "formattable", 
 #                    "data.table","psych", "RColorBrewer", "ggforce"))

install_packages(c("gdata","dplyr", "plyr", "tidyr","ggplot2","readxl", "FactoMineR", "factoextra", 
                   "ca", "gplots","ggrepel", "grid", "gridExtra", "patchwork", "formattable", 
                   "data.table","psych", "RColorBrewer", "ggforce"))


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
#       6) Move Law domain into Other
#       7) Correct funding agency
#       8) Backup surveys_combined & surveys_combined_demos as .backup
source("scripts/combineSurveys.R")

# Perform Multi-Factor Analysis
#       1) Perform MFA
#       2) Add computed DIM1, DIM2, and total contributions to surveys_combined_demos
#       3) Take DIM1*-1 to align with DIM2
#       4) OPTIONAL: Export main dataframe (data/surveys_combined_demos.csv)
#       5) OPTIONAL: Export scree plot and biplot (plots/scree_biplot.pdf)
source("scripts/multiFactorAnalysis.R")
 


