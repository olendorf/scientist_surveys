# Load the data, survey three are from the third scientist survey, 
# the original two surveys from Tenopir 2015 are in survey_one_two
survey_three <- read.csv("third_scientist_survey_20180919.csv", header = TRUE)
survey_one_two <- read.csv("tenopir_2015.csv", header = TRUE)

third_survey_contentent_codes <- c("")


# Recreating some of the original analysis as a sanity check
ages <- table(survey_one_two$AgeCategory)
age_by_survey <- xtabs(~survey_one_two$Survey + ~survey_one_two$AgeCategory)
continents <- table(survey_one_two$Continent)
continents_by_survey <- xtabs(~survey_one_two$Continent + ~survey_one_two$Survey)

