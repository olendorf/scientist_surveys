library(readr)
regions_master_list <- read_csv("data/country_codes/regions_master_list.csv")
first_scientists_survey <- read_csv("data/first_scientists_survey.csv")
second_scientists_survey <- read_csv("data/second_scientists_survey.csv")
third_scientists_survey <- read_csv("data/third_scientists_survey.csv")

# Helper function to extract the region name from the country codes in surveys, 
# each survey is a little different so one function for each survey
get_region_from_code1 <- function(country_name) {
  return( regions_master_list[ which( egions_master_list$country_name == country_name),][1,]$region_name)
}

get_region_from_code2 <- function(country_code){
  return( regions_master_list[ which(regions_master_list$survey1_2_code == country_code),][1,]$region_name)
}

get_region_from_code3 <- function(country_code){
  return( regions_master_list[ which(regions_master_list$survey3_code == country_code),][1,]$region_name)
}

codes <- c()
survey <- c()

for(cn in first_scientists_survey$Q20) {
  codes <- c(codes, get_region_from_code1(cn))
  survey <- c(survey, 1)
}

for(cc in second_scientists_survey$Q6) {
  codes <- c(codes, get_region_from_code2(cc))
  survey <- c(survey, 2)
}

for(cc in third_scientists_survey$Q5){
  codes <- c(codes, get_region_from_code3(cc))
  survey <- c(survey, 3)
}

table(codes_df$survey, codes_df$codes)

