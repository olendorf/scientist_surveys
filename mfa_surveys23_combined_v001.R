### MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
### FMAD Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r-essentials/ 
### Install libraries if need be
# install.packages(c("pacman", "gdata", "plyr", "ggplot2", "readxl", "FactoMineR", "factoextra", "ca", "gplots", "ggpubr"))

### Load all libraries
library(pacman)
pacman::p_load(gdata, dplyr, plyr, ggplot2, readxl, FactoMineR, factoextra, ca, gplots, ggpubr, tidyverse)

### Import surveys and survey dimensions
source("scripts/load_data.R")

# Recode the three sureys to get the general regions 
# based on the country
source("scripts/country_codes.R")

# Recode the respondent's domain so that the three 
# surveys' data is comparable.
source("scripts/domain_recode.R")

# Change yes only answer to yes/no
survey_two[c("Q9_1","Q9_2","Q9_3","Q9_4","Q9_5","Q9_6","Q9_7","Q9_8","Q9_9",
            "Q21_1","Q21_2","Q21_3","Q21_4","Q21_5","Q21_6",
            "Q23_1","Q23_2","Q23_3","Q23_4","Q23_5","Q23_6",
            "Q24_1","Q24_2","Q24_3","Q24_4","Q24_5","Q24_6",
            "Q25_1","Q25_2","Q25_3","Q25_4","Q25_5","Q25_6",
            "Q26_1","Q26_2","Q26_3","Q26_4","Q26_5","Q26_6",
            "Q28_1","Q28_2","Q28_3","Q28_4","Q28_5","Q28_6",
            "Q30_1","Q30_2","Q30_3","Q30_4","Q30_5","Q30_6")][is.na(survey_two[c("Q9_1","Q9_2","Q9_3","Q9_4","Q9_5","Q9_6","Q9_7","Q9_8","Q9_9",
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

### Survey 2
# Import survey 2 questions
survey23_two_select <- survey_two %>% select(Q2,
                                         Q4,
                                         Q11,
                                         Q12,
                                         country_code,
                                         Q14_1,Q14_2,Q14_3,Q14_4,Q14_5,Q14_6,Q14_7,Q14_8,Q14_9,
                                         Q16_1,Q16_2,Q16_3,Q16_4,Q16_5,Q16_7,Q16_8,
                                         Q17_3,Q17_4,Q17_7,
                                         Q20_1,Q20_2,
                                         Q21_1,Q21_2,Q21_3,Q21_4,Q21_5,Q21_6,
                                         Q22_1,
                                         Q31_1,Q31_2,Q31_3,Q31_4,Q31_5,
                                         Q32_1,Q32_2,Q32_3,Q32_4,Q32_5,Q32_6,Q32_7,Q32_8,
                                         Q19_1,Q19_2,Q19_3,Q19_4,Q19_5,Q19_7,Q19_8,Q19_9,Q19_10,Q19_11,Q19_12,
                                         Q47_1,Q47_2,Q47_3,Q47_4,Q47_5,Q47_6,Q47_7,
                                         Q48,
                                         Q49_1,Q49_2,Q49_3,Q49_4,Q49_5,Q49_6,Q49_7,Q49_8,Q49_9,
                                        )

### Survey 3
# Import survey 3 questions
survey23_three_select <- survey_three %>% select(Q2,
                                             Q3_mod,
                                             Q11,
                                             Q9,
                                             country_code,
                                             Q12_1,Q12_2,Q12_3,Q12_4,Q12_5,Q12_7,Q12_8,Q12_9,Q12_10,
                                             Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,
                                             Q14_1,Q14_2,Q14_3,
                                             Q16_1,Q16_2,
                                             Q17_1,Q17_2,Q17_3,Q17_4,Q17_5,Q17_6,
                                             Q18_1,
                                             Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,
                                             Q19_1,Q19_2,Q19_3,Q19_4,Q19_5,Q19_6,Q19_7,Q19_8,
                                             Q15_1,Q15_2,Q15_3,Q15_4,Q15_5,Q15_6,Q15_7,Q15_8,Q15_9,Q15_10,Q15_11,
                                             Q22_1,Q22_2,Q22_3,Q22_4,Q22_5,Q22_6,Q22_7,
                                             Q23,
                                             Q24_1,Q24_2,Q24_3,Q24_4,Q24_5,Q24_6,Q24_7,Q24_8,Q24_9,
                                             )

# VITAL! Do not remove!!! Change all to characters
survey23_two_select <- mutate_all(survey23_two_select, function(x) as.character(x))
survey23_three_select <- mutate_all(survey23_three_select, function(x) as.character(x))
s2_23_length <- ncol(survey23_two_select)
s3_23_length <- ncol(survey23_three_select)
s2_23_length
s3_23_length

# Recode questions to match 
# 02_02 :: No recode [1] :: Primary work sector
# 04_03 :: No recode [2] :: Discipline
# 11_11 :: Primary funding agency
survey23_two_select[3] <- revalue(as.character(survey23_two_select[[3]]),c("6"="7"))
survey23_three_select[3] <- revalue(as.character(survey23_three_select[[3]]),c("6"="7"))
# 12_19 :: No recode [4] :: Does primary funding agency requires DMP
# country_code :: No recode [5] 
# 14_12 :: No recode [6-14] ::How much of your data do you make available to others?
# 16_13 :: No recode [15-21] Why data not available?
# 17_14 :: Collection and reuse of data. How much do you agree?
for (xx in (22:24)) {
  survey23_two_select[xx] <- revalue(as.character(survey23_two_select[[xx]]),
                                   c("1"="1", "2"="2","3"="3", "4"="4","5"="5","6"="3"))
  survey23_three_select[xx] <- revalue(as.character(survey23_three_select[[xx]]),
                                     c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))}
# 20_16 :: How organization is involved with data
for (xx in (25:26)) {
  survey23_two_select[xx] <- revalue(as.character(survey23_two_select[[xx]]),
                                   c("1"="1", "2"="2","3"="3", "4"="4","5"="5","6"="3"))
  survey23_three_select[xx] <- revalue(as.character(survey23_three_select[[xx]]),
                                     c("1"="2","3"="3","2"="4"))}
# 21_17 :: No recode [27-32] :: Organizational process for managing data storage
# 22_18 :: How organization is involved with data
  survey23_two_select[33] <- revalue(as.character(survey23_two_select[[33]]),
                                   c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
  survey23_three_select[33] <- revalue(as.character(survey23_three_select[[33]]),
                                     c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))
# 31_20 :: Views on use across research field
for (xx in (34:38)) {
  survey23_two_select[xx] <- revalue(as.character(survey23_two_select[[xx]]),
                                   c("1"="1", "2"="2","3"="3", "4"="4","5"="5","6"="3"))
  survey23_three_select[xx] <- revalue(as.character(survey23_three_select[[xx]]),
                                     c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))}
# 32_19 :: Data sharing
for (xx in (39:46)) {
  survey23_two_select[xx] <- revalue(as.character(survey23_two_select[[xx]]),
                                   c("1"="1", "2"="2","3"="3", "4"="4","5"="5","6"="3"))
  survey23_three_select[xx] <- revalue(as.character(survey23_three_select[[xx]]),
                                     c("5"="1", "4"="2","3"="3", "2"="4","1"="5","6"="3"))}
# 19_15 :: No recode [47-57] :: Conditions on fair exchange for the use of their data
# 47_22 :: No recode [58-64] :: When I need to analyze data to answer a research q...
# 48_23 :: No recode [65] :: How often do you use other's data?
# 49_24 :: No recode [66-74] :: Opinions on using other's data
  
### VITAL! Do not remove!!! Change all to characters
survey23_two_select <- mutate_all(survey23_two_select, function(x) as.character(x))
survey23_three_select <- mutate_all(survey23_three_select, function(x) as.character(x))

### Change empty spaces to NA
survey23_two_select[survey23_two_select==""] <- "NA"
survey23_two_select[survey23_two_select==" "] <- "NA"
survey23_two_select <- na_if(survey23_two_select, "NA")
survey23_three_select[survey23_three_select==""] <- "NA"
survey23_three_select[survey23_three_select==" "] <- "NA"
survey23_three_select <- na_if(survey23_three_select, "NA")

### Count number of NA values to filter out serial question skippers
# Survey 2
survey23_two_select$na_count <- apply(survey23_two_select, 1, function(x) sum(is.na(x)))
# Survey 3
survey23_three_select$na_count <- apply(survey23_three_select, 1, function(x) sum(is.na(x)))

# Generater historgrams with number of NA values for each survey
s2_histo_before <- ggplot(survey23_two_select, aes(na_count))+
  geom_histogram(color="darkblue", fill="lightblue" ,binwidth=1)
s3_histo_before <- ggplot(survey23_three_select, aes(na_count))+
  geom_histogram(color="darkblue", fill="lightblue" ,binwidth=1)

# Remove rows with > 5 NA values
survey23_two_select <- subset(survey23_two_select, na_count < 5)
survey23_three_select <- subset(survey23_three_select, na_count < 5)

# Remove na_count row from surveys and re-index rows
survey23_two_select <- subset(survey23_two_select, select= -na_count)
  rownames(survey23_two_select) <- 1:nrow(survey23_two_select)
survey23_three_select <- subset(survey23_three_select, select= -na_count)
  rownames(survey23_three_select) <- 1:nrow(survey23_three_select)
  
# Combine 3 surveys into one data.frame
colnames(survey23_two_select)<- c("02_02","04_03","11_11","12_19","country_code","14_12_1","14_12_2","14_12_3","14_12_4","14_12_5","14_12_6","14_12_7","14_12_8","14_12_9","16_13_1","16_13_2","16_13_3","16_13_4","16_13_5","16_13_6","16_13_7","17_14_1","17_14_2","17_14_3","20_16_1","20_16_2","21_17_1","21_17_2","21_17_3","21_17_4","21_17_5","21_17_6","22_18","31_20_1","31_20_2","31_20_3","31_20_4","31_20_5","32_19_1","32_19_2","32_19_3","32_19_4","32_19_5","32_19_6","32_19_7","32_19_8","19_15_1","19_15_2","19_15_3","19_15_4","19_15_5","19_15_6","19_15_7","19_15_8","19_15_9","19_15_10","19_15_11","47_22_1","47_22_2","47_22_3","47_22_4","47_22_5","47_22_6","47_22_7","48_23","49_24_1","49_24_2","49_24_3","49_24_4","49_24_5","49_24_6","49_24_7","49_24_8","49_24_9")
colnames(survey23_three_select)<- c("02_02","04_03","11_11","12_19","country_code","14_12_1","14_12_2","14_12_3","14_12_4","14_12_5","14_12_6","14_12_7","14_12_8","14_12_9","16_13_1","16_13_2","16_13_3","16_13_4","16_13_5","16_13_6","16_13_7","17_14_1","17_14_2","17_14_3","20_16_1","20_16_2","21_17_1","21_17_2","21_17_3","21_17_4","21_17_5","21_17_6","22_18","31_20_1","31_20_2","31_20_3","31_20_4","31_20_5","32_19_1","32_19_2","32_19_3","32_19_4","32_19_5","32_19_6","32_19_7","32_19_8","19_15_1","19_15_2","19_15_3","19_15_4","19_15_5","19_15_6","19_15_7","19_15_8","19_15_9","19_15_10","19_15_11","47_22_1","47_22_2","47_22_3","47_22_4","47_22_5","47_22_6","47_22_7","48_23","49_24_1","49_24_2","49_24_3","49_24_4","49_24_5","49_24_6","49_24_7","49_24_8","49_24_9")
surveys23_combined <- rbind(survey23_two_select,survey23_three_select)

# Perform Multiple Correspondence Analysis (ca)
num_cols <- ncol(survey__combined)
num_cols <- as.numeric(num_cols)
surveys23_combined.mfa <- MFA(surveys23_combined,
                     group = c(1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1),
                     name.group = c("02_02","04_03","11_11",
                                    "12_19","country_code",
                                    "14_12_1","14_12_2","14_12_3","14_12_4","14_12_5","14_12_6","14_12_7","14_12_8","14_12_9",
                                    "16_13_1","16_13_2","16_13_3","16_13_4","16_13_5","16_13_6","16_13_7",
                                    "17_14_1","17_14_2","17_14_3",
                                    "20_16_1","20_16_2",
                                    "21_17_1","21_17_2","21_17_3","21_17_4","21_17_5","21_17_6",
                                    "22_18",
                                    "31_20_1","31_20_2","31_20_3","31_20_4","31_20_5",
                                    "32_19_1","32_19_2","32_19_3","32_19_4","32_19_5","32_19_6","32_19_7","32_19_8",
                                    "19_15_1","19_15_2","19_15_3","19_15_4","19_15_5","19_15_6","19_15_7","19_15_8","19_15_9","19_15_10","19_15_11",
                                    "47_22_1","47_22_2","47_22_3","47_22_4","47_22_5","47_22_6","47_22_7",
                                    "48_23",
                                    "49_24_1","49_24_2","49_24_3","49_24_4","49_24_5","49_24_6","49_24_7","49_24_8","49_24_9"),
                     type = c("n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n"), graph = FALSE)

# Extract row results
eig.val <- get_eigenvalue(surveys23_combined.mfa)
ind.mfa <- get_mfa_ind(surveys23_combined.mfa)
var.mfa <- get_mfa_var(surveys23_combined.mfa, "group")

# print all contribs
# var.mfa$contrib

# Summary
# summary(survey23_two.mfa)

### Screeplot
eig.val <- get_eigenvalue(surveys23_combined.mfa)
if_random <- 100/(ncol(surveys23_combined)-1)
scree_plot <- fviz_screeplot(surveys23_combined.mfa, addlabels = TRUE, ylim = c(0, 5)) + 
  geom_hline(yintercept=if_random, linetype=2, color="red")
scree_plot

# Barplot of variables
var.mfa_plot <- fviz_mfa_var(surveys23_combined.mfa,choice="quali.var", col.var="cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet",select.var = list(cos2 = 0.55), geom = c("point","text"), repel = TRUE)
var.mfa_plot.group <- fviz_mfa_var(surveys23_combined.mfa, col.var = "cos2",
                                   gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                                   col.var.sup = "violet", repel = TRUE, "group")

# Barplot of contributions
contribs <- data.frame(var.mfa$contrib)
contrib_plot_dim1 <- fviz_contrib(surveys23_combined.mfa,choice="quali.var", axes = 1, top=30)
contrib_plot_dim1_unsorted <- fviz_contrib(surveys23_combined.mfa,choice="quali.var", sort.val = ("none"), axes = 1)
contrib_plot_dim1_group <- fviz_contrib(surveys23_combined.mfa, "group", axes = 1, top=30)
contrib_plot_dim2 <- fviz_contrib(surveys23_combined.mfa,choice="quali.var", axes = 2, top=30)
contrib_plot_dim2_group <- fviz_contrib(surveys23_combined.mfa, "group", axes = 2, top=30)

# Export all plots to pdf
ggexport(plotlist = list(s2_histo_before,s3_histo_before, scree_plot, var.mfa_plot, var.mfa_plot.group, contrib_plot_dim1,contrib_plot_dim1_group,contrib_plot_dim2,contrib_plot_dim2_group), filename = "mfa_surveys23_combined_plots.pdf")
# ggexport(plotlist = list(s1_histo_before,s2_histo_before,s3_histo_before, scree_plot, var.mfa_plot, var.mfa_plot.group, contrib_plot_dim1,contrib_plot_dim1_group,contrib_plot_dim2,contrib_plot_dim2_group), filename = "mfa_surveys23_combined_plots.png", width = 1600, height = 800)

