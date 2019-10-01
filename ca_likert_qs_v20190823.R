### Install libraries if need be
# install.packages(c("pacman", "gdata", "plyr", "ggplot2", "readxl", "FactoMineR", "factoextra", "ca", "gplots", "ggpubr"))

### Load all libraries
library(pacman)
pacman::p_load(gdata, plyr, dplyr, ggplot2, readxl, FactoMineR, factoextra, ca, gplots, ggpubr)

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
surveyOne_likert <- surveyOne %>% select(Q7_4,Q7_5,Q7_9,
                                         Q8_1,Q8_2,
                                         Q9_1,Q9_2,Q9_3,Q9_4,Q9_5,
                                         Q10_1,Q10_2,Q10_3,Q10_4,Q10_5,Q10_6,Q10_7)
# Change character answers to numerical answers
for (xx in (1:18)) {
  surveyOne_likert[xx] <- revalue(as.character(surveyOne_likert[[xx]]), 
                                   c("agree strongly"="1", "agree somewhat"="2", 
                                     "neither agree nor disagree"="3", "disagree somewhat"="4",
                                     "disagree strongly"="5","not sure"="3"))}
# Change R type to numeric
surveyOne_likert <- mutate_all(surveyOne_likert, function(x) as.numeric(as.character(x)))
# Remove NA
surveyOne_likert <- na.omit(surveyOne_likert)

### Survey 2
# Import likert questions from survey 2
surveyTwo_likert_1 <- surveyTwo %>% select(Q17_3,Q17_4,Q17_7)
surveyTwo_likert_2 <- surveyTwo %>% select(Q20_1,Q20_2)
# Recode "not sure" (6) as "neither agree nor disagree" (3)
for (xx in (1:2)) {
  surveyTwo_likert_2[xx] <- revalue(as.character(surveyTwo_likert_2[[xx]]), 
                                    c("1"="1", "2"="2","3"="3", "4"="4","5"="5","6"="3"))}
# Reverse likert order for Q31
surveyTwo_likert_3 <- surveyTwo %>% select(Q31_1,Q31_2,Q31_3,Q31_4,Q31_5)
for (xx in (1:5)) {
  surveyThree_likert_3[xx] <- revalue(as.character(surveyThree_likert_3[[xx]]), 
                                      c("1"="5","2"="4", "3"="3","4"="2","5"="1","6"="3"))}
surveyTwo_likert_4 <- surveyTwo %>% select(Q32_1,Q32_2,Q32_3,Q32_4,Q32_5,Q32_6,Q32_7)
# Bind together results in one data.frame
surveyTwo_likert <- cbind(surveyTwo_likert_1,surveyTwo_likert_2,surveyTwo_likert_3,surveyTwo_likert_4)
# Change R type to numeric
surveyTwo_likert <- mutate_all(surveyTwo_likert, function(x) as.numeric(as.character(x)))
# Remove NA
surveyTwo_likert <- na.omit(surveyTwo_likert)

### Survey 3
# Import likert questions from survey 3
surveyThree_likert_1 <- surveyThree %>% select(Q14_1,Q14_2,Q14_3)
# Reverse likert order for 14
for (xx in (1:3)) {
  surveyThree_likert_1[xx] <- revalue(as.character(surveyThree_likert_1[[xx]]), 
                                      c("1"="5","2"="4", "3"="3","4"="2","5"="1","6"="3"))}
surveyThree_likert_2 <- surveyThree %>% select(Q16_1,Q16_2)
# Change "yes", "no", "don't know" answers in to "agree", "disagree", and "neither nor disagree"
for (xx in (1:2)) {
  surveyThree_likert_2[xx] <- revalue(as.character(surveyThree_likert_2[[xx]]), 
                                    c("1"="2","2"="4", "3"="3"))}
surveyThree_likert_3 <- surveyThree %>% select(Q20_1,Q20_2,Q20_3,Q20_4,Q20_5)
# Reverse likert order for 20
for (xx in (1:3)) {
  surveyThree_likert_3[xx] <- revalue(as.character(surveyThree_likert_3[[xx]]), 
                                      c("1"="5","2"="4", "3"="3","4"="2","5"="1","6"="3"))}
surveyThree_likert_4 <- surveyThree %>% select(Q19_1,Q19_2,Q19_3,Q19_4,Q19_5,Q19_6,Q19_7)
# Reverse likert order for 19
for (xx in (1:3)) {
  surveyThree_likert_4[xx] <- revalue(as.character(surveyThree_likert_4[[xx]]), 
                                      c("1"="5","2"="4", "3"="3","4"="2","5"="1","6"="3"))}
# Bind together results in one data.frame
surveyThree_likert <- cbind(surveyThree_likert_1,
                            surveyThree_likert_2,
                            surveyThree_likert_3,
                            surveyThree_likert_4)
# Change R type to numeric
surveyThree_likert <- mutate_all(surveyThree_likert, function(x) as.numeric(as.character(x)))
# Remove NA
surveyThree_likert <- na.omit(surveyThree_likert)

### Combine all surveys into one data.frame
# Remove columns to match between all three surveys
colnames(surveyOne_likert) <- c("7_17_14_N1","7_17_14_N2","7_17_14_N3",
                                 "8_20_16_N1","8_20_16_N2",
                                 "9_31_20_N1","9_31_20_N2","9_31_20_N3","9_31_20_N4","9_31_20_N5",
                                 "10_32_19_N1","10_32_19_N2","10_32_19_N3","10_32_19_N4","10_32_19_N5","10_32_19_N6","10_32_19_N7")
colnames(surveyTwo_likert) <- c("7_17_14_N1","7_17_14_N2","7_17_14_N3",
                                "8_20_16_N1","8_20_16_N2",
                                "9_31_20_N1","9_31_20_N2","9_31_20_N3","9_31_20_N4","9_31_20_N5",
                                "10_32_19_N1","10_32_19_N2","10_32_19_N3","10_32_19_N4","10_32_19_N5","10_32_19_N6","10_32_19_N7")
colnames(surveyThree_likert) <- c("7_17_14_N1","7_17_14_N2","7_17_14_N3",
                                  "8_20_16_N1","8_20_16_N2",
                                  "9_31_20_N1","9_31_20_N2","9_31_20_N3","9_31_20_N4","9_31_20_N5",
                                  "10_32_19_N1","10_32_19_N2","10_32_19_N3","10_32_19_N4","10_32_19_N5","10_32_19_N6","10_32_19_N7")

# Bind together all surveys
all_surveys_likert <- rbind(surveyOne_likert,surveyTwo_likert,surveyThree_likert)
# Remove NA
all_surveys_likert <- na.omit(all_surveys_likert)

# Perform Multiple Correspondence Analysis (ca)
surveyOne.ca <- ca(surveyOne_likert, ncp = 17, graph = FALSE)
surveyTwo.ca <- ca(surveyTwo_likert, ncp = 17, graph = FALSE)
surveyThree.ca <- ca(surveyThree_likert, ncp = 17, graph = FALSE)
all_surveys.ca <- ca(all_surveys_likert, ncp = 17, graph = FALSE)

# Extract row results
rowcol <- get_ca(all_surveys.ca, element = c("row", "col"))
col <- get_ca_col(all_surveys.ca)
row <- get_ca_row(all_surveys.ca)

# print all contribs
col$contrib

# Summary
summary(all_surveys.ca, nb.dec = 2, ncp = 17)

### Screeplot
if_random <- 100/(ncol(all_surveys_likert)-1)
eig.val <- get_eigenvalue(all_surveys.ca)
scree_plot <- fviz_screeplot(all_surveys.ca, addlabels = TRUE, ylim = c(0, 30)) + 
  geom_hline(yintercept=if_random, linetype=2, color="red")

# Barplot of variables
cos2_plot <- fviz_cos2(all_surveys.ca, choice = "col", axes = 1:2)

# Barplot of contributions
contribs <- data.frame(col$contrib)
contribs2 <- reshape(contribs, varying=c("Dim.1","Dim.2","Dim.3","Dim.4","Dim.5","Dim.6",
                                         "Dim.7","Dim.8","Dim.9","Dim.10","Dim.11","Dim.12",
                                         "Dim.13","Dim.14","Dim.15","Dim.16"),
                               times=c("Dim.1","Dim.2","Dim.3","Dim.4","Dim.5","Dim.6",
                                        "Dim.7","Dim.8","Dim.9","Dim.10","Dim.11","Dim.12",
                                        "Dim.13","Dim.14","Dim.15","Dim.16"), direction="long")
contribs2$time <- revalue(as.character(contribs2$time), c("1"="Dim.1","2"="Dim.2","3"="Dim.3","4"="Dim.4",
                                                          "5"="Dim.5","6"="Dim.6","7"="Dim.7","8"="Dim.8",
                                                          "9"="Dim.9","10"="Dim.10","11"="Dim.11","12"="Dim.12",
                                                          "13"="Dim.13","14"="Dim.14","15"="Dim.15","16"="Dim.16"))
contribs2$time <- factor(as.character(contribs2$time), level = c("Dim.1","Dim.2","Dim.3","Dim.4", "Dim.5","Dim.6","Dim.7","Dim.8",
                                                          "Dim.9","Dim.10","Dim.11","Dim.12","Dim.13","Dim.14","Dim.15","Dim.16"))
contrib_barplot <- ggplot(data=contribs2, aes(x=as.numeric(id), y=Dim, color="red", fill="red")) + geom_bar(stat="identity") + 
  facet_wrap(~ time, nrow=4) + scale_x_continuous(labels=c( "1"="7_17_14_N1","2"="7_17_14_N2","3"="7_17_14_N3",
                                                            "4"="8_20_16_N1","5"="8_20_16_N2",
                                                            "6"="9_31_20_N1","7"="9_31_20_N2","8"="9_31_20_N3","9"="9_31_20_N4","10"="9_31_20_N5",
                                                            "11"="10_32_19_N1","12"="10_32_19_N2","13"="10_32_19_N3","14"="10_32_19_N4","15"="10_32_19_N5","16"="10_32_19_N6","17"="10_32_19_N7"),
                                                  breaks=c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)) + theme(legend.position="none",axis.text.x = element_text(angle = 45)) +
                                                  scale_y_continuous() + ylab("Percent Contribution (%)") + xlab("Question")

### Biplot
biplot_all <- fviz_ca_biplot(all_surveys.ca, col.row="cos2", geom = c("point","text")) + theme_minimal()
biplot_clean <- fviz_ca_biplot(all_surveys.ca, invisible="row", geom = c("point","text")) + theme_minimal()

# Export all plots to pdf
ggexport(plotlist = list(scree_plot, contrib_barplot,biplot_all,biplot_clean, cos2_plot), filename = "ca_likert_plots.pdf")



