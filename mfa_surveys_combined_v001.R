### MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
### FMAD Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r-essentials/ 
### Rotation in Factominer :: http://factominer.free.fr/question/FAQ.html 
### Install libraries if need be
# install.packages(c("pacman", "gdata", "plyr", "ggplot2", "readxl", "FactoMineR", "factoextra", "ca", "gplots", "ggpubr"))

### Load all libraries
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
source("scripts/region_count_figure.R")  

# Recode the respondent's domain so that the three 
# surveys' data is comparable.
source("scripts/domain_recode.R")

# Change yes only answer to yes/no
survey_two[c("Q9_1","Q9_2","Q9_3","Q9_4","Q9_5","Q9_6","Q9_7","Q9_8","Q9_9",
             "Q16_1","Q16_2","Q16_3","Q16_4","Q16_5","Q16_7","Q16_8",
             "Q21_1","Q21_2","Q21_3","Q21_4","Q21_5","Q21_6",
             "Q23_1","Q23_2","Q23_3","Q23_4","Q23_5","Q23_6",
             "Q24_1","Q24_2","Q24_3","Q24_4","Q24_5","Q24_6",
             "Q25_1","Q25_2","Q25_3","Q25_4","Q25_5","Q25_6",
             "Q26_1","Q26_2","Q26_3","Q26_4","Q26_5","Q26_6",
             "Q28_1","Q28_2","Q28_3","Q28_4","Q28_5","Q28_6",
             "Q30_1","Q30_2","Q30_3","Q30_4","Q30_5","Q30_6")][is.na(survey_two[c("Q9_1","Q9_2","Q9_3","Q9_4","Q9_5","Q9_6","Q9_7","Q9_8","Q9_9",
                                                                                  "Q16_1","Q16_2","Q16_3","Q16_4","Q16_5","Q16_7","Q16_8",
                                                                                  "Q21_1","Q21_2","Q21_3","Q21_4","Q21_5","Q21_6",
                                                                                  "Q23_1","Q23_2","Q23_3","Q23_4","Q23_5","Q23_6",
                                                                                  "Q24_1","Q24_2","Q24_3","Q24_4","Q24_5","Q24_6",
                                                                                  "Q25_1","Q25_2","Q25_3","Q25_4","Q25_5","Q25_6",
                                                                                  "Q26_1","Q26_2","Q26_3","Q26_4","Q26_5","Q26_6",
                                                                                  "Q28_1","Q28_2","Q28_3","Q28_4","Q28_5","Q28_6",
                                                                                  "Q30_1","Q30_2","Q30_3","Q30_4","Q30_5","Q30_6")])] <- 0
survey_three[c("Q13_1","Q13_2","Q13_3","Q13_4","Q13_5","Q13_6","Q13_7","Q13_8","Q13_9","Q13_10",
               "Q17_1","Q17_2","Q17_3","Q17_4","Q17_5","Q17_6")][is.na(survey_three[c("Q13_1","Q13_2","Q13_3","Q13_4","Q13_5","Q13_6","Q13_7","Q13_8","Q13_9","Q13_10",
                                                                                      "Q17_1","Q17_2","Q17_3","Q17_4","Q17_5","Q17_6")])] <- 0

### Survey 1
# Import survey 1 questions
survey_one_select <- survey_one %>% select(
  Q2, # work sector
  super_domain,  # discipline
  Q15, # funding agency
  Q16,
  region,
  Q6_1,Q6_2,Q6_3,Q6_4,Q6_5,Q6_7,Q6_8,
  Q7_4,Q7_5,Q7_9,
  Q8_1,Q8_2,
  Q8_5,
  Q9_1,Q9_2,Q9_3,Q9_4,Q9_5,
  Q10_1,Q10_2,Q10_3,Q10_4,Q10_5,Q10_6,Q10_7,Q10_8,
  Q11a_1,Q11a_2,Q11a_3,Q11a_4,Q11a_5,Q11a_7,Q11a_8,Q11a_9,Q11a_10,Q11a_11,Q11a_12
)

### Survey 2
# Import survey 2 questions
survey_two_select <- survey_two %>% select(
  Q2, # (work sector)
  super_domain, # (discipline)
  Q11, # (funding agency)  
  Q12, 
  region,
  Q16_1,Q16_2,Q16_3,Q16_4,Q16_5,Q16_7,Q16_8,  
  Q17_3,Q17_4,Q17_7,
  Q20_1,Q20_2,          
  Q22_1,       
  Q31_1,Q31_2,Q31_3,Q31_4,Q31_5,      
  Q32_1,Q32_2,Q32_3,Q32_4,Q32_5,Q32_6,Q32_7,Q32_8,  
  Q19_1,Q19_2,Q19_3,Q19_4,Q19_5,Q19_7,Q19_8,Q19_9,Q19_10,Q19_11,Q19_12
)

### Survey 3
# Import survey 3 questions
survey_three_select <- survey_three %>% select(
  Q2, # (work sector)
  super_domain, # (discipline)
  Q11, # (funding agency)
  Q9,
  region,
  Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,
  Q14_1,Q14_2,Q14_3,
  Q16_1,Q16_2,
  Q18_1,
  Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,
  Q19_1,Q19_2,Q19_3,Q19_4,Q19_5,Q19_6,Q19_7,Q19_8,
  Q15_1,Q15_2,Q15_3,Q15_4,Q15_5,Q15_6,Q15_7,Q15_8,Q15_9,Q15_10,Q15_11,
)

# VITAL! Do not remove!!! Change all to characters
survey_one_select <- mutate_all(survey_one_select, function(x) as.character(x))
survey_two_select <- mutate_all(survey_two_select, function(x) as.character(x))
survey_three_select <- mutate_all(survey_three_select, function(x) as.character(x))
s1_length <- ncol(survey_one_select)
s2_length <- ncol(survey_two_select)
s3_length <- ncol(survey_three_select)
s1_length
s2_length
s3_length

# Recode questions to match 
# 02_02_02 :: Primary work sector
survey_one_select[1] <- revalue(as.character(survey_one_select[[1]]),
                                c("academic"="1", "government"="2", 
                                  "commercial"="3", "non-profit"="4",
                                  "other"="5"))
# 15_11_11 :: Primary funding agency
survey_two_select[3] <- revalue(as.character(survey_two_select[[3]]),c("7"="6"))
survey_two_select[3] <- revalue(as.character(survey_two_select[[3]]),
                                c("1"="Federal/national government", 
                                  "2"="State/regional government",
                                  "3"="Local government",
                                  "4"="Corporation",
                                  "5"="Private foundation",
                                  "6"="Other"))
survey_three_select[3] <- revalue(as.character(survey_three_select[[3]]),c("7"="6"))
survey_three_select[3] <- revalue(as.character(survey_three_select[[3]]),
                                c("1"="Federal/national government", 
                                  "2"="State/regional government",
                                  "3"="Local government",
                                  "4"="Corporation",
                                  "5"="Private foundation",
                                  "6"="Other"))
# 16_12_09 :: Does primary funding agency requires DMP
survey_one_select[4] <- revalue(as.character(survey_one_select[[4]]),
                                c("Yes"="1", "No"="2","Don't know"="3"))
# 06_16_13 :: Why data not available?
for (xx in (6:12)) {
  survey_one_select[xx] <- revalue(as.character(survey_one_select[[xx]]),
                                   c("Yes"="1", "No"="2"))
  survey_two_select[xx] <- revalue(as.character(survey_two_select[[xx]]), 
                               c("0"="2"))
  survey_three_select[xx] <- revalue(as.character(survey_three_select[[xx]]),
                                   c("0"="2"))}
  
# 07_17_14 :: Collection and reuse of data.  How much do you agree?
for (xx in (13:15)) {
  survey_one_select[xx] <- revalue(as.character(survey_one_select[[xx]]),
                                   c("agree strongly"="1", "agree somewhat"="2", 
                                     "neither agree nor disagree"="3", "disagree somewhat"="4",
                                     "disagree strongly"="5"))
  survey_two_select[xx] <- revalue(as.character(survey_two_select[[xx]]),
                                   c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
  survey_three_select[xx] <- revalue(as.character(survey_three_select[[xx]]),
                                     c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))}
# 08_20_16 :: How organization is involved with data
for (xx in (16:17)) {
  survey_one_select[xx] <- revalue(as.character(survey_one_select[[xx]]),
                                   c("agree strongly"="1", "agree somewhat"="2", 
                                     "neither agree nor disagree"="3", "disagree somewhat"="4",
                                     "disagree strongly"="5"))
  survey_two_select[xx] <- revalue(as.character(survey_two_select[[xx]]),
                                   c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
  survey_three_select[xx] <- revalue(as.character(survey_three_select[[xx]]),
                                     c("1"="2","3"="3","2"="4"))}
# 08_22_18 :: How organization is involved with data
survey_one_select[18] <- revalue(as.character(survey_one_select[[18]]),
                                 c("agree strongly"="1", "agree somewhat"="2", 
                                   "neither agree nor disagree"="3", "disagree somewhat"="4",
                                   "disagree strongly"="5"))
survey_two_select[18] <- revalue(as.character(survey_two_select[[18]]),
                                 c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
survey_three_select[18] <- revalue(as.character(survey_three_select[[18]]),
                                   c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
# 09_31_20 :: Views on use across research field
for (xx in (19:23)) {
  survey_one_select[xx] <- revalue(as.character(survey_one_select[[xx]]),
                                   c("agree strongly"="1", "agree somewhat"="2", 
                                     "neither agree nor disagree"="3", "disagree somewhat"="4",
                                     "disagree strongly"="5"))
  survey_two_select[xx] <- revalue(as.character(survey_two_select[[xx]]),
                                   c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
  survey_three_select[xx] <- revalue(as.character(survey_three_select[[xx]]),
                                     c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))}
# 10_32_19 :: Data sharing
for (xx in (24:31)) {
  survey_one_select[xx] <- revalue(as.character(survey_one_select[[xx]]),
                                   c("agree strongly"="1", "agree somewhat"="2", 
                                     "neither agree nor disagree"="3", "disagree somewhat"="4",
                                     "disagree strongly"="5"))
  survey_two_select[xx] <- revalue(as.character(survey_two_select[[xx]]),
                                   c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
  survey_three_select[xx] <- revalue(as.character(survey_three_select[[xx]]),
                                     c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))}
# 11_19_15 :: Conditions on fair exchange for the use of their data
for (xx in (32:42)) {
  survey_one_select[xx] <- recode(as.character(survey_one_select[[xx]]), 
                                  "Yes"="1","No"="2", .default = "")
  survey_two_select[xx] <- recode(as.character(survey_two_select[[xx]]), 
                                  "1"="1","2"="2","3" = "")
  survey_three_select[xx] <- recode(as.character(survey_three_select[[xx]]), 
                                  "1"="1","2"="2","3" = "")}

### VITAL! Do not remove!!! Change all to characters
survey_one_select <- mutate_all(survey_one_select, function(x) as.character(x))
survey_two_select <- mutate_all(survey_two_select, function(x) as.character(x))
survey_three_select <- mutate_all(survey_three_select, function(x) as.character(x))

### Change empty spaces to NA
survey_one_select[survey_one_select==""] <- "NA"
survey_one_select[survey_one_select==" "] <- "NA"
survey_one_select <- na_if(survey_one_select, "NA")
survey_two_select[survey_two_select==""] <- "NA"
survey_two_select[survey_two_select==" "] <- "NA"
survey_two_select <- na_if(survey_two_select, "NA")
survey_three_select[survey_three_select==""] <- "NA"
survey_three_select[survey_three_select==" "] <- "NA"
survey_three_select <- na_if(survey_three_select, "NA")

### Count number of NA values to filter out serial question skippers
# Survey 1
survey_one_select$na_count <- apply(survey_one_select, 1, function(x) sum(is.na(x)))
# Survey 2
survey_two_select$na_count <- apply(survey_two_select, 1, function(x) sum(is.na(x)))
# Survey 3
survey_three_select$na_count <- apply(survey_three_select, 1, function(x) sum(is.na(x)))

# Generater historgrams with number of NA values for each survey
s1_histo_before <- ggplot(survey_one_select, aes(x=na_count))+
  geom_histogram(color="darkblue", fill="lightblue" ,binwidth=1)
s2_histo_before <- ggplot(survey_two_select, aes(na_count))+
  geom_histogram(color="darkblue", fill="lightblue" ,binwidth=1)
s3_histo_before <- ggplot(survey_three_select, aes(na_count))+
  geom_histogram(color="darkblue", fill="lightblue" ,binwidth=1)

# Remove rows with > 5 NA values
survey_one_select <- subset(survey_one_select, na_count < 5)
survey_two_select <- subset(survey_two_select, na_count < 5)
survey_three_select <- subset(survey_three_select, na_count < 5)

# Remove na_count row from surveys and re-index rows
survey_one_select <- subset(survey_one_select, select= -na_count)
rownames(survey_two_select) <- 1:nrow(survey_one_select)
survey_two_select <- subset(survey_two_select, select= -na_count)
rownames(survey_two_select) <- 1:nrow(survey_two_select)
survey_three_select <- subset(survey_three_select, select= -na_count)
rownames(survey_three_select) <- 1:nrow(survey_three_select)

# Reorder the values in the 3 surveys so demographics are at end
survey_one_select <- survey_one_select[c("Q16","Q6_1","Q6_2","Q6_3","Q6_4","Q6_5","Q6_7","Q6_8","Q7_4","Q7_5",
                    "Q7_9","Q8_1","Q8_2","Q8_5","Q9_1","Q9_2","Q9_3","Q9_4","Q9_5","Q10_1",
                    "Q10_2","Q10_3","Q10_4","Q10_5","Q10_6","Q10_7","Q10_8","Q11a_1","Q11a_2",
                    "Q11a_3","Q11a_4","Q11a_5","Q11a_7","Q11a_8","Q11a_9","Q11a_10","Q11a_11",
                    "Q11a_12","Q2","super_domain","Q15","region")]
survey_two_select <- survey_two_select[c("Q12","Q16_1","Q16_2","Q16_3","Q16_4","Q16_5","Q16_7",
                                         "Q16_8","Q17_3","Q17_4","Q17_7","Q20_1","Q20_2","Q22_1",
                                         "Q31_1","Q31_2","Q31_3","Q31_4","Q31_5","Q32_1","Q32_2",
                                         "Q32_3","Q32_4","Q32_5","Q32_6","Q32_7","Q32_8","Q19_1",
                                         "Q19_2","Q19_3","Q19_4","Q19_5","Q19_7","Q19_8","Q19_9",
                                         "Q19_10","Q19_11","Q19_12","Q2","super_domain","Q11",
                                         "region")]
survey_three_select <- survey_three_select[c("Q9","Q13_1","Q13_2","Q13_3","Q13_4","Q13_5","Q13_6",
                                             "Q13_7","Q14_1","Q14_2","Q14_3","Q16_1","Q16_2","Q18_1",
                                             "Q20_1","Q20_2","Q20_3","Q20_4","Q20_5","Q19_1","Q19_2",
                                             "Q19_3","Q19_4","Q19_5","Q19_6","Q19_7","Q19_8","Q15_1",
                                             "Q15_2","Q15_3","Q15_4","Q15_5","Q15_6","Q15_7","Q15_8",
                                             "Q15_9","Q15_10","Q15_11","Q2","super_domain","Q11","region")]

# Add survey number label
survey_one_select$survey_label <- "S1"
survey_two_select$survey_label <- "S2"
survey_three_select$survey_label <- "S3"

# Combine 3 surveys into one data.frame
colnames(survey_one_select)<- c("16_12_09","06_16_13_1","06_16_13_2","06_16_13_3","06_16_13_4","06_16_13_5",
                                "06_16_13_6","06_16_13_7","07_17_14_1","07_17_14_2","07_17_14_3","08_20_16_1",
                                "08_20_16_2","08_22_18","09_31_20_1","09_31_20_2","09_31_20_3","09_31_20_4",
                                "09_31_20_5","10_32_19_1","10_32_19_2","10_32_19_3","10_32_19_4","10_32_19_5",
                                "10_32_19_6","10_32_19_7","10_32_19_8","11_19_15_1","11_19_15_2","11_19_15_3",
                                "11_19_15_4","11_19_15_5","11_19_15_6","11_19_15_7","11_19_15_8","11_19_15_9",
                                "11_19_15_10","11_19_15_11","work_sector","domain","funding_agency","region","survey_label")
colnames(survey_two_select)<- c("16_12_09","06_16_13_1","06_16_13_2","06_16_13_3","06_16_13_4","06_16_13_5","06_16_13_6","06_16_13_7","07_17_14_1","07_17_14_2","07_17_14_3","08_20_16_1","08_20_16_2","08_22_18","09_31_20_1","09_31_20_2","09_31_20_3","09_31_20_4","09_31_20_5","10_32_19_1","10_32_19_2","10_32_19_3","10_32_19_4","10_32_19_5","10_32_19_6","10_32_19_7","10_32_19_8","11_19_15_1","11_19_15_2","11_19_15_3","11_19_15_4","11_19_15_5","11_19_15_6","11_19_15_7","11_19_15_8","11_19_15_9","11_19_15_10",
                                "11_19_15_11","work_sector","domain","funding_agency","region","survey_label")
colnames(survey_three_select)<- c("16_12_09","06_16_13_1","06_16_13_2","06_16_13_3","06_16_13_4","06_16_13_5","06_16_13_6","06_16_13_7","07_17_14_1","07_17_14_2","07_17_14_3","08_20_16_1","08_20_16_2","08_22_18","09_31_20_1","09_31_20_2","09_31_20_3","09_31_20_4","09_31_20_5","10_32_19_1","10_32_19_2","10_32_19_3","10_32_19_4","10_32_19_5","10_32_19_6","10_32_19_7","10_32_19_8","11_19_15_1","11_19_15_2","11_19_15_3","11_19_15_4","11_19_15_5","11_19_15_6","11_19_15_7","11_19_15_8","11_19_15_9","11_19_15_10",
                                  "11_19_15_11","work_sector","domain","funding_agency","region","survey_label")
surveys_combined_demos <- rbind(survey_one_select,survey_two_select,survey_three_select)
surveys_combined <- surveys_combined_demos %>% select("16_12_09","06_16_13_1","06_16_13_2","06_16_13_3","06_16_13_4","06_16_13_5","06_16_13_6","06_16_13_7","07_17_14_1","07_17_14_2","07_17_14_3","08_20_16_1","08_20_16_2","08_22_18","09_31_20_1","09_31_20_2","09_31_20_3","09_31_20_4","09_31_20_5","10_32_19_1","10_32_19_2","10_32_19_3","10_32_19_4","10_32_19_5","10_32_19_6","10_32_19_7","10_32_19_8","11_19_15_1","11_19_15_2","11_19_15_3","11_19_15_4","11_19_15_5","11_19_15_6","11_19_15_7","11_19_15_8","11_19_15_9","11_19_15_10",
                           "11_19_15_11")
### Table with all items included
# surveys_combined_all

# Limit to EuroRussia, USACanada, and AustraliaNZ
surveys_combined_demos_limited <- subset(surveys_combined_demos, (region == "EuroRussia" | region == "USACanada" | region == "AustraliaNZ") &
                                             (domain == "Natural science" | domain == "Physical science"))
surveys_combined_limited <- surveys_combined_demos_limited %>% select("16_12_09","06_16_13_1","06_16_13_2","06_16_13_3","06_16_13_4","06_16_13_5","06_16_13_6","06_16_13_7","07_17_14_1","07_17_14_2","07_17_14_3","08_20_16_1","08_20_16_2","08_22_18","09_31_20_1","09_31_20_2","09_31_20_3","09_31_20_4","09_31_20_5","10_32_19_1","10_32_19_2","10_32_19_3","10_32_19_4","10_32_19_5","10_32_19_6","10_32_19_7","10_32_19_8","11_19_15_1","11_19_15_2","11_19_15_3","11_19_15_4","11_19_15_5","11_19_15_6","11_19_15_7","11_19_15_8","11_19_15_9","11_19_15_10",
                                                      "11_19_15_11")

# Perform Multiple Correspondence Analysis (ca)
num_cols <- ncol(survey__combined)
num_cols <- as.numeric(num_cols)
surveys_combined.mfa <- MFA(surveys_combined_limited,
                            group = c(1,1,1,1,1,1,1,1,1,1,
                                      1,1,1,1,1,1,1,1,1,1,
                                      1,1,1,1,1,1,1,1,1,1,
                                      1,1,1,1,1,1,1,1),
                            name.group = c("16_12_09",
                                           "06_16_13_1","06_16_13_2","06_16_13_3","06_16_13_4","06_16_13_5","06_16_13_6","06_16_13_7",
                                           "07_17_14_1","07_17_14_2","07_17_14_3",
                                           "08_20_16_1","08_20_16_2",
                                           "08_22_18",
                                           "09_31_20_1","09_31_20_2","09_31_20_3","09_31_20_4","09_31_20_5",
                                           "10_32_19_1","10_32_19_2","10_32_19_3","10_32_19_4","10_32_19_5","10_32_19_6","10_32_19_7","10_32_19_8",
                                           "11_19_15_1","11_19_15_2","11_19_15_3","11_19_15_4","11_19_15_5","11_19_15_6","11_19_15_7","11_19_15_8",
                                           "11_19_15_9","11_19_15_10","11_19_15_11"),
                            type = c("n","n","n","n","n","n","n","n","n","n",
                                     "n","n","n","n","n","n","n","n","n","n",
                                     "n","n","n","n","n","n","n","n","n","n",
                                     "n","n","n","n","n","n","n","n"), graph = FALSE)

### Rotate varimax
# Plot of unrotated loadings
# unrotated_plot_dim1 <- ggplot(data.frame(surveys_combined.mfa$quali.var$coord[,1])) +
#  geom_bar(aes(x=surveys_combined.mfa$quali.var$coord[,0]))
unrotated_plot_dim1 <- barplot(surveys_combined.mfa$quali.var$coord[,1], las=2)
unrotated_plot_dim2 <- barplot(surveys_combined.mfa$quali.var$coord[,2], las=2)
coords <- cbind(surveys_combined.mfa$quali.var$coord[,1],surveys_combined.mfa$quali.var$coord[,2]) 

# 1) Calculate loadings from coordinates and print loadings
# 2) Rotate values 
# 3) Load rotated values into previous values
loadings.mfa <- sweep(surveys_combined.mfa$quali.var$coord,2,
                      sqrt(surveys_combined.mfa$eig[1:ncol(surveys_combined.mfa$quali.var$coord),1]),FUN="/")
loadings <- cbind(loadings.mfa[,1],loadings.mfa[,2]) 
loadings.mfa.rot <- varimax(loadings.mfa)$loadings
surveys_combined.mfa$quali.var$coord <- loadings.mfa.rot

# Plot of rotated loadings
rotated_plot_dim1 <- barplot(surveys_combined.mfa$quali.var$coord[,1], las=2)
rotated_plot_dim2 <- barplot(surveys_combined.mfa$quali.var$coord[,2], las=2)
rot_loadings <- cbind(surveys_combined.mfa$quali.var$coord[,1],surveys_combined.mfa$quali.var$coord[,2]) 

# Identity most correlated variables in given dimension
res.desc <- dimdesc(surveys_combined.mfa)
# Description of dimension 1
res.desc$Dim.1$quali
res.desc$Dim.1$category
# Description of dimension 2
res.desc$Dim.2$quali
res.desc$Dim.2$category

# Write loadings to csv
all_loadings <- cbind(coordinates, loadings,rot_loadings)
colnames(all_loadings) <- c("coord.dim1","coord.dim2","load.dim1","load.dim2","rotLoad.dim1","rotLoad.dim2")
my_dataframe$dim_1 <- coord.dim1
write.csv(all_loadings,file="all_loadings.csv")

# Extract and write results for individuals to CSV
 ind.sum_coord <- facto_summarize(surveys_combined.mfa, element = "ind",result = c("coord", "contrib", "cos2", "coord.partial"))
 ind_coord <- ind.sum$res
 # individuals <- ind_coord
 # write.csv(individuals,file="individuals.csv")
 surveys_combined_demos_limited$dim_1 <- ind_coord$Dim.1
 surveys_combined_demos_limited$dim_2 <- ind_coord$Dim.2
 surveys_combined_demos_limited$contrib <- ind_coord$contrib
   
 #res.aov <- aov(dim_1 ~ survey_label + region, data = surveys_combined_demos_limited)
 #summary(res.aov)
 #plot(res.aov)

# Write lists of most correlated variables
write.csv(res.desc$Dim.1$quali,file="correlated_dim1_quali_vars.csv")
write.csv(res.desc$Dim.2$quali,file="correlated_dim2_quali_vars.csv")
write.csv(res.desc$Dim.1$category,file="correlated_dim1_vars_category.csv")
write.csv(res.desc$Dim.2$category,file="correlated_dim2_vars_category.csv")

# Extract row results
eig.val <- get_eigenvalue(surveys_combined.mfa)
ind.mfa <- get_mfa_ind(surveys_combined.mfa)
var.mfa <- get_mfa_var(surveys_combined.mfa, "group")

# print all contribs
# var.mfa$contrib

# Summary
# summary(survey_two.mfa)

### Screeplot
eig.val <- get_eigenvalue(surveys_combined.mfa)
if_random <- 100/(ncol(surveys_combined)-1)
scree_plot <- fviz_screeplot(surveys_combined.mfa, addlabels = TRUE, ylim = c(0, 10)) + 
  geom_hline(yintercept=if_random, linetype=2, color="red")
scree_plot

### Barplots and biplots of individuals
# Individuals
ind.mfa_plot <- fviz_mfa_ind(surveys_combined.mfa, 
                             choice="quali.var",
                             habillage = as.factor(surveys_combined_demos_limited$region), 
#                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                             addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                             geom = c("point")) 
#  theme(legend.position = "none")
ind.mfa_plot.surveys <- fviz_mfa_ind(surveys_combined.mfa, 
                             choice="quali.var",
                             habillage = as.factor(surveys_combined_demos_limited$survey_label), 
                             #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                             addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                             geom = c("point")) 
ind.mfa_plot.domains <- fviz_mfa_ind(surveys_combined.mfa, 
                                     choice="quali.var",
                                     habillage = as.factor(surveys_combined_demos_limited$domain), 
                                     #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                     addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                     geom = c("point")) 

# DIM1: Question effect analysis
ind.mfa_plot.10_32_19_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                     choice="quali.var",
                                     habillage = as.factor(surveys_combined_demos_limited$`10_32_19_2`), 
                                     title = "10_32_19_2: I would  be willing to place at least some of my data
                                     into a central data repository with no restrictions",
                                     #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                     addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                     geom = c("point")) 
ind.mfa_plot.10_32_19_3 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`10_32_19_3`), 
                                        title = "10_32_19_3: I would be willing to place all of my data 
                                        into a central data repository with no restrictions",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_11 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`11_19_15_11`), 
                                        title = "11_19_15_11: The data provider is given and agrees to
                                        a statement of uses to which the data will be put",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.10_32_19_6 <- fviz_mfa_ind(surveys_combined.mfa, 
                                         choice="quali.var",
                                         habillage = as.factor(surveys_combined_demos_limited$`10_32_19_6`), 
                                         title = "10_32_19_6: I would be willing to share data across a
                                        broad group of researchers who use 
                                        data in different ways",
                                         #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                         addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                         geom = c("point")) 
ind.mfa_plot.11_19_15_5 <- fviz_mfa_ind(surveys_combined.mfa, 
                                         choice="quali.var",
                                         habillage = as.factor(surveys_combined_demos_limited$`11_19_15_5`), 
                                         title = "11_19_15_5: Results based (at least in part) on the data
                                        could not be disseminated in any format 
                                        without the data provider's approval",
                                         #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                         addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                         geom = c("point")) 
ind.mfa_plot.11_19_15_10 <- fviz_mfa_ind(surveys_combined.mfa, 
                                         choice="quali.var",
                                         habillage = as.factor(surveys_combined_demos_limited$`11_19_15_10`), 
                                         title = "11_19_15_10: Mutual agreement on reciprocal sharing of data",
                                         #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                         addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                         geom = c("point")) 
ind.mfa_plot.11_19_15_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                         choice="quali.var",
                                         habillage = as.factor(surveys_combined_demos_limited$`11_19_15_1`), 
                                         title = "11_19_15_1: Co-authorship on publications resulting from use of the data",
                                         #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                         addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                         geom = c("point")) 
ind.mfa_plot.11_19_15_9 <- fviz_mfa_ind(surveys_combined.mfa, 
                                         choice="quali.var",
                                         habillage = as.factor(surveys_combined_demos_limited$`11_19_15_9`), 
                                         title = "11_19_15_9: Legal permission for data use is obtained",
                                         #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                         addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                         geom = c("point")) 
ind.mfa_plot.10_32_19_4 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`10_32_19_4`), 
                                        title = "10_32_19_4: I would be more likely to make my data available
                                        if I could place conditions on access",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_4 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`11_19_15_4`), 
                                        title = "11_19_15_4: The opportunity to collaborate on the project 
                                        (including, for example, consultation on analytic methods, 
                                        interpretation of results, dissemination of research results, etc.)",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_8 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`11_19_15_8`), 
                                        title = "11_19_15_8: The data provider is given a complete list of all 
                                        products that make use of the data, including",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.10_32_19_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`10_32_19_1`), 
                                        title = "10_32_19_1: I would use other researchers' datasets if their 
                                        datasets were easily accessible",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_6 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`11_19_15_6`), 
                                        title = "11_19_15_6: Results based (at least in part) on the data could 
                                        not be disseminated without the data provider having the
                                        opportunity to review the results and make suggestions 
                                        or comments, but approval not required",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_7 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`11_19_15_7`), 
                                        title = "11_19_15_7: Reprints of articles that make use of the data
                                        must be provided to the data provider",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.10_32_19_8 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`10_32_19_8`), 
                                        title = "10_32_19_8: It is appropriate to create new datasets from 
                                        shared data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point"))

# DIM2: Question effect analysis
ind.mfa_plot.07_17_14_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`07_17_14_2`), 
                                        title = "07_17_14_2: I am satisfied with the process for searching
                                       for my own data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.07_17_14_3 <- fviz_mfa_ind(surveys_combined.mfa, 
                                       choice="quali.var",
                                       habillage = as.factor(surveys_combined_demos_limited$`07_17_14_3`), 
                                       title = "07_17_14_3: I am satisfied with the process for 
                                       cataloging/describing my data",
                                       #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                       addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                       geom = c("point")) 
ind.mfa_plot.07_17_14_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                       choice="quali.var",
                                       habillage = as.factor(surveys_combined_demos_limited$`07_17_14_1`), 
                                       title = "07_17_14_1: I am satisfied with the process for 
                                       collecting my research data",
                                       #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                       addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                       geom = c("point")) 
ind.mfa_plot.08_20_16_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`08_20_16_2`), 
                                        title = "08_20_16_2: My organization or project has a
                                        formal established process for storing
                                        data beyond the life of the project (long-term)",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.08_22_18 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`08_22_18_1`), 
                                        title = "08_22_18_1: My organization or project provides
                                        training on best practices for data management",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.08_20_16_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`08_20_16_1`), 
                                        title = "08_20_16_1: My organization or project has a formal
                                        established process for managing data during the 
                                        life of the project (short-term)",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.09_31_20_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`09_31_20_1`), 
                                        title = "09_31_20_1: Lack of access to data generated by other
                                        researchers or institutions is a major impediment
                                        to progress in science",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.06_16_13_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`06_16_13_2`), 
                                        title = "06_16_13_2: Lack of standards",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.06_16_13_4 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`06_16_13_4`), 
                                        title = "06_16_13_4: There is insufficient time to make them available",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.06_16_13_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`06_16_13_1`), 
                                        title = "06_16_13_1: Lack of funding",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.09_31_20_3 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos_limited$`09_31_20_3`), 
                                        title = "09_31_20_3: Data may be misinterpreted due to 
                                        complexity of the data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 

# Variables
var.mfa_plot <- fviz_mfa_var(surveys_combined.mfa,choice="quali.var",
                             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                             col.var.sup = "violet", geom = c("point","text"), repel = TRUE)
var.mfa_plot.group <- fviz_mfa_var(surveys_combined.mfa, col.var = "cos2",
                                   gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                                   col.var.sup = "violet", repel = TRUE, "group")

# Barplot of contributions
contribs <- data.frame(var.mfa$contrib)
contrib_plot_dim1 <- fviz_contrib(surveys_combined.mfa,choice="quali.var", axes = 1, top=30)
contrib_plot_dim1_unsorted <- fviz_contrib(surveys_combined.mfa,choice="quali.var", sort.val = ("none"), axes = 1)
contrib_plot_dim1_group <- fviz_contrib(surveys_combined.mfa, "group", axes = 1, top=30)
contrib_plot_dim2 <- fviz_contrib(surveys_combined.mfa,choice="quali.var", axes = 2, top=30)
contrib_plot_dim2_group <- fviz_contrib(surveys_combined.mfa, "group", axes = 2, top=30)

# Export all plots to pdf
ggexport(plotlist = list(scree_plot, ind.mfa_plot.surveys, ind.mfa_plot.domains, ind.mfa_plot,var.mfa_plot.group, contrib_plot_dim1,contrib_plot_dim1_group, contrib_plot_dim2, contrib_plot_dim2_group), filename = "mfa_surveys_combined_plots.pdf")
ggexport(plotlist = list(ind.mfa_plot.10_32_19_2,ind.mfa_plot.10_32_19_3,ind.mfa_plot.11_19_15_11,
                         ind.mfa_plot.10_32_19_6,ind.mfa_plot.11_19_15_5,ind.mfa_plot.11_19_15_10,
                         ind.mfa_plot.11_19_15_1,ind.mfa_plot.11_19_15_9,ind.mfa_plot.10_32_19_4,
                         ind.mfa_plot.11_19_15_4,ind.mfa_plot.11_19_15_8,ind.mfa_plot.10_32_19_1,
                         ind.mfa_plot.11_19_15_6,ind.mfa_plot.11_19_15_7,ind.mfa_plot.10_32_19_8), filename = "mfa_dim1_interpretation.pdf")
ggexport(plotlist = list(ind.mfa_plot.07_17_14_2,ind.mfa_plot.07_17_14_3,ind.mfa_plot.07_17_14_1,
                         ind.mfa_plot.08_20_16_2,ind.mfa_plot.08_22_18,ind.mfa_plot.08_20_16_1, 
                         ind.mfa_plot.09_31_20_1,ind.mfa_plot.06_16_13_2,ind.mfa_plot.06_16_13_4,
                         ind.mfa_plot.06_16_13_1,ind.mfa_plot.09_31_20_3), filename = "mfa_dim2_interpretation.pdf")
# ggexport(plotlist = list(s1_histo_before,s2_histo_before,s3_histo_before, scree_plot, var.mfa_plot, var.mfa_plot.group, contrib_plot_dim1,contrib_plot_dim1_group,contrib_plot_dim2,contrib_plot_dim2_group), filename = "mfa_surveys_combined_plots.png", width = 1600, height = 800)

###################################
#         ANOVA & MANOVA          #
###################################
# ANOVA of Dimenson 1
source("scripts/anovaDim1_surveyComp.R")

# MANOVA
source("scripts/manova_surveyComp.R")
###############################################################################################
#                                           TOOLS                                             #
###############################################################################################
# Which survey do you want to count?
survey <- survey_three_select
s_cols <- ncol(survey)
# Perform counting
i = 1
answer_counts <- data.frame(c(1,2,3,4,5))
for (i in (1:s_cols)){
      column_name <- colnames(survey[i])
      temp <- data.frame(table(survey[[i]]))
      while (nrow(temp) < 5){
        temp[nrow(temp)+1,] <- ""
        temp <- data.frame(temp)
                            }
      answer_counts[,i+1] <- temp$Freq
      colnames(answer_counts)[i+1] <- column_name
      #      cbind(answer_counts, temp$Freq)
      #      rm(temp)
      i <- i + 1}
# Change name of output
survey3_counts <- answer_counts

ncol(survey1_counts)
ncol(survey2_counts)
ncol(survey3_counts)

survey123_counts <- rbind(survey1_counts,survey2_counts,survey3_counts)

write.csv(survey123_counts,"survey123_counts.csv", row.names = TRUE)

