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




# Load the data, survey three are from the third scientist survey, 
# the original two surveys from Tenopir 2015 are
survey_one <- read.csv('data/first_scientists_survey.csv', header = TRUE, stringsAsFactors = FALSE)
survey_two <- read.csv('data/second_scientists_survey.csv', header = TRUE, stringsAsFactors = FALSE)
survey_three <- read.csv("data/third_scientists_survey.csv", header = TRUE, stringsAsFactors = FALSE)

# Renaming some columns for clarity of code and other various adjustments
# coln
colnames(survey_one)[colnames(survey_one)=="Q20"] <- "country_code" 
colnames(survey_two)[colnames(survey_two)=="Q6"] <- "country_code"
colnames(survey_three)[colnames(survey_three)=="Q5"] <- "country_code"


survey_one$survey <- 1
survey_two$survey <- 2
survey_three$survey <- 3

# Recode the three sureys to get the general regions 
# based on the country
source("country_codes.R")

# code to generate this figure pulled off to its own file 
source("region_count_figure.R")  

# Print the figure generated above
png("figures/region_plot.png")
print(region_plot)
dev.off()
region_plot + coord_flip()


