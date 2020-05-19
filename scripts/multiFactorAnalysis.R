# Perform Multiple Factpr Analysis (MFA)
surveys_combined.mfa <- MFA(surveys_combined,
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

# Extract and write results for individuals to CSV
ind.sum <- facto_summarize(surveys_combined.mfa, element = "ind",result = c("coord", "contrib", "cos2", "coord.partial"))
ind_coord <- ind.sum$res
# individuals <- ind_coord
# write.csv(individuals,file="individuals.csv")

# Includes all demos and regions
surveys_combined_demos$dim_1 <- ind_coord$Dim.1
surveys_combined_demos$dim_2 <- ind_coord$Dim.2
surveys_combined_demos$contrib <- ind_coord$contrib
# write.csv(surveys_combined_demos, file="./data/surveys_combined_demos.csv")



