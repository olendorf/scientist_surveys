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
rownames(survey_one_select) <- 1:nrow(survey_one_select)
survey_two_select <- subset(survey_two_select, select= -na_count)
rownames(survey_two_select) <- 1:nrow(survey_two_select)
survey_three_select <- subset(survey_three_select, select= -na_count)
rownames(survey_three_select) <- 1:nrow(survey_three_select)
