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

### Survey 3
# Import likert questions from survey 3
surveyThree_select <- surveyThree %>% select(Q2,Q3_mod,Q4_mod,Q5,Q7,Q8,Q9,
                                         Q10_1,Q10_2,Q10_3,Q10_4,Q10_5,Q10_6,Q10_7,Q10_8,Q10_9,Q10_10,Q10_11,Q10_12,Q10_13,
                                         Q11,
                                         Q12_1,Q12_2,Q12_3,Q12_4,Q12_5,Q12_6,Q12_7,Q12_8,Q12_9,Q12_10,Q12_11,
                                         Q13_1,Q13_2,Q13_3,Q13_4,Q13_5,Q13_6,Q13_7,Q13_8,Q13_9,Q13_10,
                                         Q14_1,Q14_2,Q14_3,Q14_4,Q14_5,
                                         Q15_1,Q15_2,Q15_3,Q15_4,Q15_5,Q15_6,Q15_7,Q15_8,Q15_9,Q15_10,Q15_11,
                                         Q16_1,Q16_2,
                                         Q17_1,Q17_2,Q17_3,Q17_4,Q17_5,Q17_6,
                                         Q18_1,Q18_2,Q18_3,Q18_4,
                                         Q19_1,Q19_2,Q19_3,Q19_4,Q19_5,Q19_6,Q19_7,Q19_8,
                                         Q20_1,Q20_2,Q20_3,Q20_4,Q20_5,
                                         Q21_1,Q21_2,Q21_3,Q21_4,
                                         Q22_1,Q22_2,Q22_3,Q22_4,Q22_5,Q22_6,Q22_7,
                                         Q23,
                                         Q24_1,Q24_2,Q24_3,Q24_4,Q24_5,Q24_6,Q24_7,Q24_8,Q24_9)

# Change character answers to numerical answers
# Change R type to character
surveyThree_select <- mutate_all(surveyThree_select, function(x) as.character(x))

# Remove blanks in yes/no
surveyThree_select[surveyThree_select==""] <- "NA"
surveyThree_select[surveyThree_select==" "] <- "NA"
surveyThree_select <- na_if(surveyThree_select, "NA")
# surveyThree_select <- na.omit(surveyThree_select)

# Perform Multiple Correspondence Analysis (ca)
num_cols <- ncol(surveyThree_select)
num_cols <- as.numeric(num_cols)
num_cols
surveyThree.mfa <- MFA(surveyThree_select,
                     group = c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                               1,1,1,1,1,1,1,1,1,1,1,1,1,1),
                     name.group = c("Q2","Q3","Q4","Q5","Q7","Q8","Q9",
                                    "Q10_1","Q10_2","Q10_3","Q10_4","Q10_5","Q10_6","Q10_7","Q10_8","Q10_9","Q10_10","Q10_11","Q10_12","Q10_13",
                                    "Q11",
                                    "Q12_1","Q12_2","Q12_3","Q12_4","Q12_5","Q12_6","Q12_7","Q12_8","Q12_9","Q12_10","Q12_11",
                                    "Q13_1","Q13_2","Q13_3","Q13_4","Q13_5","Q13_6","Q13_7","Q13_8","Q13_9","Q13_10",
                                    "Q14_1","Q14_2","Q14_3","Q14_4","Q14_5",
                                    "Q15_1","Q15_2","Q15_3","Q15_4","Q15_5","Q15_6","Q15_7","Q15_8","Q15_9","Q15_10","Q15_11",
                                    "Q16_1","Q16_2",
                                    "Q17_1","Q17_2","Q17_3","Q17_4","Q17_5","Q17_6",
                                    "Q18_1","Q18_2","Q18_3","Q18_4",
                                    "Q19_1","Q19_2","Q19_3","Q19_4","Q19_5","Q19_6","Q19_7","Q19_8",
                                    "Q20_1","Q20_2","Q20_3","Q20_4","Q20_5",
                                    "Q21_1","Q21_2","Q21_3","Q21_4",
                                    "Q22_1","Q22_2","Q22_3","Q22_4","Q22_5","Q22_6","Q22_7",
                                    "Q23",
                                    "Q24_1","Q24_2","Q24_3","Q24_4","Q24_5","Q24_6","Q24_7","Q24_8","Q24_9"),
                     type = c("n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n","n",
                              "n","n"), graph = FALSE)

# Extract row results
eig.val <- get_eigenvalue(surveyThree.mfa)
ind.mfa <- get_mfa_ind(surveyThree.mfa)
var.mfa <- get_mfa_var(surveyThree.mfa, "group")

# print all contribs
var.mfa$contrib

# Summary
summary(surveyThree.mfa)

### Screeplot
eig.val <- get_eigenvalue(surveyThree.mfa)
if_random <- 100/(ncol(surveyThree_select)-1)
scree_plot <- fviz_screeplot(surveyThree.mfa, addlabels = TRUE, ylim = c(0, 10)) + 
  geom_hline(yintercept=if_random, linetype=2, color="red")
scree_plot

# Barplot of variables
#fviz_mfa_ind(surveyThree.mfa)
fviz_mfa_var(surveyThree.mfa, "group")
#fviz_mfa_ind(surveyThree.mfa, col.ind = "cos2", 
#             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#             repel = TRUE)
var.mfa_plot <- fviz_mfa_var(surveyThree.mfa, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet", repel = TRUE, "group")
var.mfa_plot

# Quality
# cos2_plot <- fviz_cos2(surveyThree.mfa, choice = "quali.var", axes = 1)

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
contrib_plot_dim1 <- fviz_contrib(surveyThree.mfa, "group", axes = 1)
contrib_plot_dim2 <- fviz_contrib(surveyThree.mfa, "group", axes = 2)

# Export all plots to pdf
ggexport(plotlist = list(scree_plot, var.mfa_plot, contrib_barplot, contrib_plot_dim1, contrib_plot_dim2), filename = "mfa_survey3_plots.png", width = 1200, height = 800)
ggexport(plotlist = list(scree_plot, var.mfa_plot, contrib_barplot, contrib_plot_dim1, contrib_plot_dim2), filename = "mfa_survey3_plots.pdf")

