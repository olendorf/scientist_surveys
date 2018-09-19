# Load the data, survey three are from the third scientist survey, 
# the original two surveys from Tenopir 2015 are in survey_one_two
survey_three <- read.csv("third_scientist_survey_20180919.csv", header = TRUE)
survey_one_two <- read.csv("tenopir_2015.csv", header = TRUE)

# Renaming some columns for clarity of code
colnames(survey_three)[colnames(survey_three)=="Q5"] <- "country_code"


country_codes_survey_three <- read.csv("country_codes_survey_three.csv", header = TRUE, stringsAsFactors = FALSE)


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
    survey_three[i,]$country <- country_codes_survey_three[ which(country_codes_survey_three$code == code), ]$country
    survey_three[i,]$region <- country_codes_survey_three[ which(country_codes_survey_three$code == code), ]$region
  }
}



