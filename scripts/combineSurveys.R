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
# Change work sector from numbers to proper labels
surveys_combined_demos$work_sector[surveys_combined_demos$work_sector == "1"] <- "Academic";
surveys_combined_demos$work_sector[surveys_combined_demos$work_sector == "2"] <- "Government";
surveys_combined_demos$work_sector[surveys_combined_demos$work_sector == "3"] <- "Commercial";
surveys_combined_demos$work_sector[surveys_combined_demos$work_sector == "4"] <- "Non-Profit";
surveys_combined_demos$work_sector[surveys_combined_demos$work_sector == "5"] <- "Other"

# Change Law domain to Other
surveys_combined_demos$domain[surveys_combined_demos$domain == 'Law'] <- 'Other'

# Backup surveys_combined
surveys_combined.backup <- surveys_combined
surveys_combined_demos.backup <- surveys_combined_demos

