# MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
# FMAD Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r-essentials/
# Rotation in Factominer :: http://factominer.free.fr/question/FAQ.html

# Install pacman if need be
install.packages(c("pacman"))

library(pacman)
pacman::p_load(gdata, dplyr, plyr, ggplot2, readxl, FactoMineR, factoextra, ca, gplots,
               ggpubr, tidyverse, gridExtra, patchwork, formattable,data.table)

# Load the data into memory, do a few minor
# mods to the data
source("scripts/load_data.R")

# Recode the three sureys to get the general regions
# based on the country
source("scripts/country_codes.R")

# Create the figure to show regional representation
# of respondents by survey
# source("scripts/region_count_figure.R")

# Recode the respondent's domain so that the three
# surveys' data is comparable.
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
source("scripts/combineSurveys.R")

# Limit work sector and domain
# COMMENT OUT TO ANALYZE FULL DATAFRAME
#       1) Limit dataframe limited to:
#                Regions: EuroRussia, USACanada, AustraliaNZ
#                Domains: Natural science, Physical science
# source("scripts/limitDomainRegion.R")

# Perform Multi-Factor Analysis
#       1) Perform MFA
#       2) Add computed DIM1 and DIM2 to surveys_combined_demos
source("scripts/multiFactorAnalysis.R")

# PLOTS: Generate scree, contribution, biplots & export as mfa_surveys_combined_plots.pdf
source("scripts/mainPlots.R")

# PLOTS: Generate biplots of primary influential DIM1 & DIM2 questions
#         Print biplots as mfa_dim1_interpretation.pdf & mfa_dim2_interpretation.pdf
source("scripts/biplotAnalysis.R")

# PLOTS: MANOVA and boxplots for influential DIM1 & DIM2 questions
# CSV files of MANOVA tables,
#         ./data/MANOVA_dim1.csv
#         ./data/MANOVA_dim2.csv
source("scripts/statsSurveyComp.R")

# Print loadings to /data/all_loadings.csv
# Print list  of most correlated variables to
#         ./data/correlated_dim1_quali_vars.csv
#         ./data/correlated_dim2_quali_vars.csv
#         ./data/correlated_dim1_vars_category.csv
#         ./data/correlated_dim2_vars_category.csv
# source("scripts/printLoadings.R")
