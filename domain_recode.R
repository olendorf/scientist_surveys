

########################################################################################
##
##  SURVEY ONE
##
########################################################################################

survey_one_domain_codes <- read.csv("data/domains/survey_one_domain_code.csv")

survey_one$domain_code <- 18

get_survey_one_code <- function(domain_name) {
  survey_one_domain_codes[which(survey_one_domain_codes$domain == domain_name),]$domain_code
}

for(row in 1:nrow(survey_one)) {
  if(survey_one[row,]$Q3 != " " && survey_one[row,]$Q3 != "" && !is.na(survey_one[row,]$Q3)) {
    domain_name = survey_one[row,]$Q3
    if(domain_name != "" && length(domain_name) > 0) {
      survey_one[row, ]$domain_code <- get_survey_one_code(domain_name)
    } else {
      survey_one[row, ]$domain_code <- NA
    }
  }
}

survey_one$domain_code[grep("chemistry", survey_one$Q3_text, ignore.case = TRUE)] <- 24

survey_one$domain_code[grep("(natural resources)|fisheries", survey_one$Q3_text, ignore.case = TRUE)] <- 21

survey_one$domain_code[grep("geograph", survey_one$Q3_text, ignore.case = TRUE)] <- 22

survey_one$domain_code[grep("ocean|marine", survey_one$Q3_text, ignore.case = TRUE)] <- 19

survey_one$domain_code[grep("virology|biology", survey_one$Q3_text, ignore.case = TRUE)] <- 3

survey_one$domain_code[grep("math|statistics|bioinform", survey_one$Q3_text, ignore.case = TRUE)] <- 23

survey_one$domain_code[grep("planetary|space|helio", survey_one$Q3_text, ignore.case = TRUE)] <- 20

survey_one$domain_code[grep("health|veterin|epidemi|virolog|immunol|dentist|nursing|medical", survey_one$Q3_text, ignore.case = TRUE)] <- 25

survey_one$domain_code[grep("mineral|petrol|geophysic|seismol|geodesy|earth|glaci|geoscience|geomatic", survey_one$Q3_text, ignore.case = TRUE)] <- 10

survey_one$domain_code[grep("climat|air-sea", survey_one$Q3_text, ignore.case = TRUE)] <- 2

survey_one$domain_code[grep("chemistry", survey_one$Q3_text, ignore.case = TRUE)] <- 24

survey_one$domain_code[grep("hydrogeo", survey_one$Q3_text, ignore.case = TRUE)] <- 11


########################################################################################
##
##  SURVEY THREE
##
########################################################################################

survey_three$domain <- survey_three$Q3_mod

survey_three$domain[grep("chemistry", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 24

survey_three$domain[grep("(natural resources)|fisheries", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 21

survey_three$domain[grep("geograph", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 22

survey_three$domain[grep("ocean|marine", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 19

survey_three$domain[grep("virology|biology", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 3

survey_three$domain[grep("math|statistics|bioinform", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 23

survey_three$domain[grep("planetary|space|helio", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 20

survey_three$domain[grep("health|veterin|epidemi|virolog|immunol|dentist|nursing|medical|pharmac", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 25

survey_three$domain[grep("mineral|petrol|geophysic|seismol|geodesy|earth|glaci|geoscience|geomatic", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 10

survey_three$domain[grep("climat|air-sea", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 2

survey_three$domain[grep("chemistry", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 24

survey_three$domain[grep("hydrogeo", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 11

survey_three$domain[grep("sociolo|communicat|culture|law|econom|history|humanit", survey_three$Q3_Other_text, ignore.case = TRUE)] <- 17
