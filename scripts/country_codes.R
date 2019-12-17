# Does some normalizing of country codes, then
# uses the countries reported by the respondents 
# to assign them to a broad geographical region
#
# AfricaMena = Africa, Middle East
# AsiaSeAsia = Asia, SouthEast Asia
# AustraliaNZ = Australia, New Zealand
# EuroRussia = Europe, Russia
# LatinAmerica = South America, Central America, Mexico
# USACanada = United States of America, Canada

country_codes <- read.csv("data/country_codes/regions_master_list.csv")

survey_one$region <- NA
# Go through and look up regions from the country codes table
for(i in 1:length(survey_one$country_code)) {
  code <- survey_one[i, ]$country_code
  if(code != " ") {
    # had to make it as character to work, otherwise it inserted the number rather than the name for some reason
    survey_one[i,]$region <- as.character(
      country_codes[ which(country_codes$country_name == code),]$region_name[[1]])
  }
}
# make region as a factor
survey_one$region <- as.factor(survey_one$region)


survey_two$region <- NA
for(i in 1:length(survey_two$country_code)) {
  code <- survey_two[i,]$country_code
  if(!is.na(code)){
    survey_two[i,]$region <- as.character(country_codes[ which(country_codes$survey1_2_code == code),]$region_name[[1]])
  }
}
survey_two$region <- as.factor(survey_two$region)

survey_three$region <- NA
for(i in 1:length(survey_three$country_code)) {
  code <- survey_three[i,]$country_code
  if(!is.na(code)){
    survey_three[i,]$region <- as.character(country_codes[ which(country_codes$survey3_code == code),]$region_name[[1]])
  }
}
survey_three$region <- as.factor(survey_three$region)