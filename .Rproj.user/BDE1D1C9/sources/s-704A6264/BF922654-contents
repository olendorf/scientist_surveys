# Load the data, survey three are from the third scientist survey, 
# the original two surveys from Tenopir 2015 are in survey_one_two
survey_three <- read.csv("data/third_scientist_survey_20180919.csv", header = TRUE)
survey_one_two <- read.csv("data/first_second_scientist_survey_20180919.csv", header = TRUE)

# Renaming some columns for clarity of code
colnames(survey_three)[colnames(survey_three)=="Q5"] <- "country_code"
colnames(survey_one_two)[colnames(survey_one_two)=="Q5"] <- "country_code"


# Read in look up tables for country codes

country_codes_three <- read.csv("data/country_codes/survey_three.csv", header = TRUE, stringsAsFactors = FALSE)
country_codes_one_two <- read.csv("data/country_codes/survey_one_and_two.csv", header = TRUE, stringsAsFactors = FALSE)


# Recreating some of the original analysis as a sanity check
ages <- table(survey_one_two$AgeCategory)
age_by_survey <- xtabs(~survey_one_two$Survey + ~survey_one_two$AgeCategory)
continents <- table(survey_one_two$Continent)
continents_by_survey <- xtabs(~survey_one_two$Continent + ~survey_one_two$Survey)



survey_three$country <- NA
survey_three$region <- NA
for(i in 1:length(survey_three$country_code)) {
  code <- survey_three[i,]$country_code
  if(!is.na(code)) {
    survey_three[i,]$country <- country_codes_three[ which(country_codes_three$code == code), ]$country
    survey_three[i,]$region <- country_codes_three[ which(country_codes_three$code == code), ]$region
  }
}



survey_one_two$country <- NA
survey_one_two$region <- NA
for(i in 1:length(survey_one_two$country_code)) {
  code <- survey_one_two[i,]$country_code
  if(!is.na(code)) {
    survey_one_two[i,]$country <- country_codes_one_two[ which(country_codes_one_two$code == code), ]$country
    survey_one_two[i,]$region <- country_codes_one_two[ which(country_codes_one_two$code == code), ]$region
  }
}



