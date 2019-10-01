### MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
### FMAD Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r-essentials/ 
### Install libraries if need be
# install.packages(c("pacman", "gdata", "plyr", "ggplot2", "readxl", "FactoMineR", "factoextra", "ca", "gplots", "ggpubr"))

### Load all libraries
library(pacman)
pacman::p_load(gdata, dplyr, plyr, ggplot2, readxl, FactoMineR, factoextra, ca, gplots, ggpubr, tidyverse)

### Import surveys and survey dimensions
surveyOne = read.csv('first_scientists_survey.csv', header = TRUE, stringsAsFactors = FALSE)
surveyTwo = read.csv('second_scientists_survey.csv', header = TRUE, stringsAsFactors = FALSE)
surveyThree = read.csv('third_scientists_survey.csv', header = TRUE, stringsAsFactors = FALSE)

bigN1=length(surveyOne[,1])
bigN2=length(surveyTwo[,1])
bigN3=length(surveyThree[,1])
bigN1
bigN2
bigN3

### Survey 2
# Import likert questions from survey 2
surveyTwo_select <- surveyTwo %>% select(Q2, # work sector :: academic, government, commercial, non-profit, other
                                         Q4, # subject discipline :: many choices
                                         Q5, # current position :: Administrator, Assistant Professor, Associate Professor, Professor, Graduate student, Undergraduate, Lecturer, Post-doctoral fellow, Researcher, Other
                                         Q6, # country
                                         Q8, # year_birth
                                         Q9_1,Q9_2,Q9_3,Q9_4,Q9_5,Q9_6,Q9_7,Q9_8,Q9_9, # type of data :: yes, no
                                         Q11, # primary funding agency :: 1 = Federal/national government, 2 = State/regional government, 3 = Local government, 4 = Corporation, 5 = Private foundation, 6 = Other
                                         Q12, # primary funding requires DMP :: Yes, No, Don't Know
                                         Q14_1,Q14_2,Q14_3,Q14_4,Q14_5,Q14_6,Q14_7,Q14_8,Q14_9, # following locations :: none, some, most, all, not sure
                                         Q15, # how much avialable to others :: none, some, most, all
                                         Q16_1,Q16_2,Q16_3,Q16_4,Q16_5,Q16_6,Q16_7,Q16_8, # if data not available then why :: yes, no
                                         Q17_1,Q17_2,Q17_3,Q17_4,Q17_5,Q17_6,Q17_7,Q17_8, # collect and use research data :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q18_1,Q18_2,Q18_3, # data sharing and access :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q19_1,Q19_2,Q19_3,Q19_4,Q19_5,Q19_6,Q19_7,Q19_8,Q19_9,Q19_10,Q19_11,Q19_12, # conditions :: yes, no
                                         Q20_1,Q20_2, # how your organization is involved with your data :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q21_1,Q21_2,Q21_3,Q21_4,Q21_5,Q21_6, # how organization is involved :: yes
                                         Q22_1,Q22_2,Q22_3,Q22_4, # how organization is involved :: OPPOSITE! disagree strongly, disagree somewhat, neither agree nor disagree, agree somewhat, agree strongly
                                         Q23_1,Q23_2,Q23_3,Q23_4,Q23_5,Q23_6, # which provides training :: yes
                                         Q24_1,Q24_2,Q24_3,Q24_4,Q24_5,Q24_6, # which provides dmp assistance :: yes
                                         Q25_1,Q25_2,Q25_3,Q25_4,Q25_5,Q25_6, # which provides metadata assistance :: yes
                                         Q26_1,Q26_2,Q26_3,Q26_4,Q26_5,Q26_6, # which provides citing dataset assistance :: yes
                                         Q27_1,Q27_2, # organization provides funding for data management :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q28_1,Q28_2,Q28_3,Q28_4,Q28_5,Q28_6, # which provides funding assistance :: yes
                                         Q29_1,Q29_2, # organization provides software tools/tech support for data management :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q30_1,Q30_2,Q30_3,Q30_4,Q30_5,Q30_6, # which provides software tools/tech support :: yes
                                         Q31_1,Q31_2,Q31_3,Q31_4,Q31_5, # attitude toward use :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q32_1,Q32_2,Q32_3,Q32_4,Q32_5,Q32_6,Q32_7,Q32_8, # sharing data:: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q47_1,Q47_2,Q47_3,Q47_4,Q47_5,Q47_6,Q47_7, # analyze data :: agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q48, # data collected by someone else :: 1 = Never, 2 = Seldom, 3 = Occasionally, 4 = Frequently, 5 = Always
                                         Q49_1,Q49_2,Q49_3,Q49_4,Q49_5,Q49_6,Q49_7,Q49_8,Q49_9, # conducting research using others data... :: agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q50_1,Q50_2,Q50_3,Q50_4,Q50_5,Q50_6,Q50_7,Q50_8 # concerns using others data :: agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         )

# Change character answers to numerical answers
# Change R type to character
surveyTwo_select <- mutate_all(surveyTwo_select, function(x) as.character(x))

# Remove blanks in yes/no
surveyTwo_select[surveyTwo_select==""] <- "NA"
surveyTwo_select[surveyTwo_select==" "] <- "NA"
surveyTwo_select <- na_if(surveyTwo_select, "NA")
# surveyTwo_select <- na.omit(surveyTwo_select)

# Perform Multiple Correspondence Analysis (ca)
num_cols <- ncol(surveyTwo_select)
num_cols <- as.numeric(num_cols)
surveyTwo.mfa <- MFA(surveyTwo_select,
                     group = c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
                     name.group = c("Q2","Q4","Q5","Q6","Q8","Q9_1","Q9_2","Q9_3","Q9_4","Q9_5",
                                    "Q9_6","Q9_7","Q9_8","Q9_9","Q11","Q12","Q14_1","Q14_2",
                                    "Q14_3","Q14_4","Q14_5","Q14_6","Q14_7","Q14_8","Q14_9",
                                    "Q15","Q16_1","Q16_2","Q16_3","Q16_4","Q16_5","Q16_6","Q16_7",
                                    "Q16_8","Q17_1","Q17_2","Q17_3","Q17_4","Q17_5","Q17_6","Q17_7",
                                    "Q17_8","Q18_1","Q18_2","Q18_3","Q19_1","Q19_2","Q19_3","Q19_4",
                                    "Q19_5","Q19_6","Q19_7","Q19_8","Q19_9","Q19_10","Q19_11","Q19_12",
                                    "Q20_1","Q20_2","Q21_1","Q21_2","Q21_3","Q21_4","Q21_5","Q21_6",
                                    "Q22_1","Q22_2","Q22_3","Q22_4","Q23_1","Q23_2","Q23_3","Q23_4",
                                    "Q23_5","Q23_6","Q24_1","Q24_2","Q24_3","Q24_4","Q24_5","Q24_6",
                                    "Q25_1","Q25_2","Q25_3","Q25_4","Q25_5","Q25_6","Q26_1","Q26_2",
                                    "Q26_3","Q26_4","Q26_5","Q26_6","Q27_1","Q27_2","Q28_1","Q28_2",
                                    "Q28_3","Q28_4","Q28_5","Q28_6","Q29_1","Q29_2","Q30_1","Q30_2",
                                    "Q30_3","Q30_4","Q30_5","Q30_6","Q31_1","Q31_2","Q31_3","Q31_4",
                                    "Q31_5","Q32_1","Q32_2","Q32_3","Q32_4","Q32_5","Q32_6","Q32_7",
                                    "Q32_8","Q47_1","Q47_2","Q47_3","Q47_4","Q47_5","Q47_6","Q47_7",
                                    "Q48","Q49_1","Q49_2","Q49_3","Q49_4","Q49_5","Q49_6","Q49_7","Q49_8",
                                    "Q49_9","Q50_1","Q50_2","Q50_3","Q50_4","Q50_5","Q50_6","Q50_7","Q50_8"),
                     type = c("n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n"), graph = FALSE)

# Extract row results
eig.val <- get_eigenvalue(surveyTwo.mfa)
ind.mfa <- get_mfa_ind(surveyTwo.mfa)
var.mfa <- get_mfa_var(surveyTwo.mfa, "group")

# print all contribs
var.mfa$contrib

# Summary
summary(surveyTwo.mfa)

### Screeplot
eig.val <- get_eigenvalue(surveyTwo.mfa)
if_random <- 100/(ncol(surveyTwo_select)-1)
scree_plot <- fviz_screeplot(surveyTwo.mfa, addlabels = TRUE, ylim = c(0, 10)) + 
  geom_hline(yintercept=if_random, linetype=2, color="red")
scree_plot

# Barplot of variables
#fviz_mfa_ind(surveyTwo.mfa)
fviz_mfa_var(surveyTwo.mfa, "group")
#fviz_mfa_ind(surveyTwo.mfa, col.ind = "cos2", 
#             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#             repel = TRUE)
var.mfa_plot <- fviz_mfa_var(surveyTwo.mfa, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet", repel = TRUE, "group")
var.mfa_plot

# Quality
# cos2_plot <- fviz_cos2(surveyTwo.mfa, choice = "quali.var", axes = 1)

# Barplot of contributions
contribs <- data.frame(var.mfa$contrib)
contribs2 <- reshape(contribs, varying=c("Dim.1","Dim.2","Dim.3","Dim.4","Dim.5"),
                               times=c("Dim.1","Dim.2","Dim.3","Dim.4","Dim.5"), direction="long")
contribs2$time <- revalue(as.character(contribs2$time), c("1"="Dim.1","2"="Dim.2","3"="Dim.3","4"="Dim.4",
                                                          "5"="Dim.5"))
contribs2$time <- factor(as.character(contribs2$time), level = c("Dim.1","Dim.2","Dim.3","Dim.4", "Dim.5"))
contrib_barplot <- ggplot(data=contribs2, aes(x=as.numeric(id), y=Dim, color="red", fill="red")) + geom_bar(stat="identity") + 
  facet_wrap(~ time, nrow=4) + scale_x_continuous(labels=c( "1"="7_17_14_N1","2"="7_17_14_N2","3"="7_17_14_N3",
                                                            "4"="8_20_16_N1","5"="8_20_16_N2",
                                                            "6"="9_31_20_N1","7"="9_31_20_N2","8"="9_31_20_N3","9"="9_31_20_N4","10"="9_31_20_N5",
                                                            "11"="10_32_19_N1","12"="10_32_19_N2","13"="10_32_19_N3","14"="10_32_19_N4","15"="10_32_19_N5","16"="10_32_19_N6","17"="10_32_19_N7"),
                                                  breaks=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)) + theme(legend.position="none",axis.text.x = element_text(angle = 45)) +
                                                  scale_y_continuous() + ylab("Percent Contribution (%)") + xlab("Question")
contrib_barplot <- ggplot(data=contribs2, aes(x=as.numeric(id), y=Dim, color="red", fill="red")) + geom_bar(stat="identity") + 
  facet_wrap(~ time, nrow=4) + scale_x_continuous() + theme(legend.position="none",axis.text.x = element_text(angle = 45)) +
  scale_y_continuous() + ylab("Percent Contribution (%)") + xlab("Question")
contrib_plot_dim1 <- fviz_contrib(surveyTwo.mfa, "group", axes = 1)
contrib_plot_dim2 <- fviz_contrib(surveyTwo.mfa, "group", axes = 2)

# Export all plots to pdf
ggexport(plotlist = list(scree_plot, var.mfa_plot, contrib_barplot, contrib_plot_dim1, contrib_plot_dim2), filename = "mfa_survey2_plots.png", width = 1200, height = 800)
ggexport(plotlist = list(scree_plot, var.mfa_plot, contrib_barplot, contrib_plot_dim1, contrib_plot_dim2), filename = "mfa_survey2_plots.pdf")