### MFA Guide :: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/116-mfa-multiple-factor-analysis-in-r-essentials/
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

### Survey 1
# Import likert questions from survey 1
surveyOne_select <- surveyOne %>% select(Q2, # work sector :: academic, government, commercial, non-profit, other
                                         Q3, # subject discipline :: Atmospheric science, Biology, Business, Computer science, Ecology, Education, Engineering, Environmental science, Geology, Hydrology, Information science, Law, Medicine, Physical sciences, Psychology, Social sciences, Other
                                         Q4_1,Q4_2,Q4_3,Q4_4,Q4_5,Q4_6,Q4_7,Q4_8,Q4_9, # type of data :: yes, no
                                         Q6_1,Q6_2,Q6_3,Q6_4,Q6_5,Q6_6,Q6_7,Q6_8, # if data not available then why :: yes, no
                                         Q11a_1,Q11a_2,Q11a_3,Q11a_4,Q11a_5,Q11a_6,Q11a_7,Q11a_8,Q11a_9,Q11a_10,Q11a_11,Q11a_12, # conditions :: yes, no
                                         Q16, # primary funding requires DMP :: Yes, No, Don't Know
                                         Q5_1,Q5_2,Q5_3,Q5_4,Q5_5,Q5_6, # if data is available, where :: none, some, most all
                                         Q7_1,Q7_2,Q7_3,Q7_4,Q7_5,Q7_6,Q7_7,Q7_8,Q7_9,Q7_10, # collect and use research data :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q8_1,Q8_2,Q8_3,Q8_4,Q8_5,Q8_6,Q8_7, # how your organization is involved with your data :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q9_1,Q9_2,Q9_3,Q9_4,Q9_5, # use data across your research field :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q10_1,Q10_2,Q10_3,Q10_4,Q10_5,Q10_6,Q10_7,Q10_8, # data sharing :: agree strongly, agree somewhat, neither agree nor disagree, disagree somewhat, disagree strongly
                                         Q15, # primary funding agency :: 1 = Federal/national government, 2 = State/regional government, 3 = Local government, 4 = Corporation, 5 = Private foundation, 6 = Other
                                         Q19, # current position :: Administrator, Assistant Professor, Associate Professor, Professor, Graduate student, Undergraduate, Lecturer, Post-doctoral fellow, Researcher, Other
                                         Q20, # country
                                         Q23, # gender
                                         Q22, # age
                                         )
# Change character answers to numerical answers
# Change R type to numeric
surveyOne_select <- mutate_all(surveyOne_select, function(x) as.character(x))
surveyOne_select$Q22 <- as.numeric(as.character(surveyOne_select$Q22))

# Remove blanks in yes/no
surveyOne_select$Q16 <- sub("Don't know", "NA", surveyOne_select$Q16)
surveyOne_select[surveyOne_select==""] <- "NA"
surveyOne_select[surveyOne_select==" "] <- "NA"
surveyOne_select <- na_if(surveyOne_select, "NA")
# surveyOne_select <- na.omit(surveyOne_select)

# Perform Multiple Correspondence Analysis (ca)
num_cols <- ncol(surveyOne_select)
num_cols <- as.numeric(num_cols)
num_cols
# Group broken up :: group = c(1, 1, # categorial 9, # yes/no 8, # yes/no 12, # yes/no 1, # yes/no/don't know 6, # none/some/most/all 10, 7, 5, 8, # likert  1, # categorical 1 # categorical)
surveyOne.mfa <- MFA(surveyOne_select,
                     group = c(1, 1, # categorial
                               9, 8, 12, 1, # yes/no
                               6, # none/some/most/all
                               10, 7, 5, 8, # likert 
                               1, 1, 1, 1, # categorical
                               1 # numeric
                               ),
                     type = c("n","n",
                              "n","n","n","n",
                              "n",
                              "n","n","n","n",
                              "n","n","n","n",
                              "c"), graph = TRUE)
surveyOne.mfa

# Extract row results
eig.val <- get_eigenvalue(surveyOne.mfa)
ind.mfa <- get_mfa_ind(surveyOne.mfa)
var.mfa <- get_mfa_var(surveyOne.mfa, "group")

# print all contribs
var.mfa$contrib

# Summary
summary(surveyOne.mfa)

### Screeplot
eig.val <- get_eigenvalue(surveyOne.mfa)
if_random <- 100/(ncol(surveyOne_select)-1)
scree_plot <- fviz_screeplot(surveyOne.mfa, addlabels = TRUE, ylim = c(0, 4.5)) + 
  geom_hline(yintercept=if_random, linetype=2, color="red")
scree_plot

# Barplot of variables
#fviz_mfa_ind(surveyOne.mfa)
fviz_mfa_var(surveyOne.mfa, "group")
#fviz_mfa_ind(surveyOne.mfa, col.ind = "cos2", 
#             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#             repel = TRUE)
var.mfa_plot <- fviz_mfa_var(surveyOne.mfa, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             col.var.sup = "violet", repel = TRUE, "group")

# Quality
# cos2_plot <- fviz_cos2(surveyOne.mfa, choice = "quali.var", axes = 1)

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
contrib_plot_dim1 <- fviz_contrib(surveyOne.mfa, "group", axes = 1)
contrib_plot_dim2 <- fviz_contrib(surveyOne.mfa, "group", axes = 2)

# Export all plots to pdf
ggexport(plotlist = list(scree_plot, contrib_barplot, contrib_plot_dim1, contrib_plot_dim2, var.mfa_plot), filename = "mfa_survey1_grouped_plots.pdf")



