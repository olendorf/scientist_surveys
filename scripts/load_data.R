

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