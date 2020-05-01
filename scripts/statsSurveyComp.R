## DIM1 & DIM2 MANOVAs
dim1_surveyLabel <- aov(dim_1 ~ survey_label*(`10_32_19_2`+`10_32_19_3`+`11_19_15_11`+
                                               `10_32_19_6`+`11_19_15_5`+`11_19_15_10`+
                                               `11_19_15_1`+`11_19_15_9`+`10_32_19_4`+
                                               `11_19_15_4`+`11_19_15_8`+`10_32_19_1`+
                                               `11_19_15_6`+`11_19_15_7`+`10_32_19_8`), 
                       data = surveys_combined_demos)
dim1_surveyLabel_table <- formattable(data.frame(unclass(summary(dim1_surveyLabel)), 
                                          check.names = FALSE, stringsAsFactors = FALSE))
dim2_surveyLabel <- aov(dim_2 ~ survey_label*(`07_17_14_2`+`07_17_14_3`+`07_17_14_1`+
                                              `08_20_16_2`+`08_22_18`+`08_20_16_1`+
                                              `09_31_20_1`+`06_16_13_2`+`06_16_13_4`+
                                              `06_16_13_1`+`09_31_20_3`), 
                        data = surveys_combined_demos)
dim2_surveyLabel_table <- formattable(data.frame(unclass(summary(dim2_surveyLabel)), 
                                                 check.names = FALSE, stringsAsFactors = FALSE))
write.csv(dim1_surveyLabel_table, file = "./data/MANOVA_dim1.csv")
write.csv(dim2_surveyLabel_table, file = "./data/MANOVA_dim2.csv")

#summary(s_anova_two_way)
#TukeyHSD(s_anova_two_way)

## DIM1: Boxplots of questions by survey
theme_boxplots <-   theme(plot.title = element_text(face="bold",size=24),
                          legend.position = "bottom",
                          legend.key.size = unit(1.0, "cm"),
                          legend.title = element_text(color="black",face="bold",size=20, angle=0),
                          legend.text=element_text(size=20),
                          axis.text.x = element_text(color="black",size=20, angle=0),
                          axis.title.x = element_text(color="black",size=20, angle=0),
                          axis.text.y = element_text(color="black",size=20, angle=0),
                          axis.title.y = element_text(color="black",size=20, angle=90))

boxplot_10_32_19_2 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                    aes(x = survey_label, y = dim_1, fill = `10_32_19_2`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="10_32_19_2", 
       caption="",fill="Region") + theme_boxplots
boxplot_10_32_19_3 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `10_32_19_3`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="10_32_19_3", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_11 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `11_19_15_11`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_11", 
       caption="",fill="Region") + theme_boxplots
boxplot_10_32_19_6 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = survey_label, y = dim_1, fill = `10_32_19_6`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="10_32_19_6", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_5 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `11_19_15_5`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_5", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_10 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `11_19_15_10`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_10", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_1 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = survey_label, y = dim_1, fill = `11_19_15_1`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_1", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_9 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = survey_label, y = dim_1, fill = `11_19_15_9`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_9", 
       caption="",fill="Region") + theme_boxplots
boxplot_10_32_19_4 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = survey_label, y = dim_1, fill = `10_32_19_4`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="10_32_19_4", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_4 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `11_19_15_4`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_4", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_8 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `11_19_15_8`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_8", 
       caption="",fill="Region") + theme_boxplots
boxplot_10_32_19_1 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `10_32_19_1`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="10_32_19_1", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_6 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `11_19_15_6`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_6", 
       caption="",fill="Region") + theme_boxplots
boxplot_11_19_15_7 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `11_19_15_7`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="11_19_15_7", 
       caption="",fill="Region") + theme_boxplots
boxplot_10_32_19_8 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_1, fill = `10_32_19_8`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="10_32_19_8", 
       caption="",fill="Region") + theme_boxplots

ggexport(plotlist = list(boxplot_10_32_19_2,boxplot_10_32_19_3,boxplot_11_19_15_11,
                         boxplot_10_32_19_6,boxplot_11_19_15_5,boxplot_11_19_15_10,
                         boxplot_11_19_15_1,boxplot_11_19_15_9,boxplot_10_32_19_4,
                         boxplot_11_19_15_4,boxplot_11_19_15_8,boxplot_10_32_19_1,
                         boxplot_11_19_15_6,boxplot_11_19_15_7,boxplot_10_32_19_8), filename = "plots/boxplots_dim1.pdf")

## DIM2: Boxplots of questions by survey
boxplot_07_17_14_2 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `07_17_14_2`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="07_17_14_2", 
       caption="",fill="Region") + theme_boxplots
boxplot_07_17_14_3 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `07_17_14_3`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="07_17_14_3", 
       caption="",fill="Region") + theme_boxplots
boxplot_07_17_14_1 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `07_17_14_1`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="07_17_14_1", 
       caption="",fill="Region") + theme_boxplots
boxplot_08_20_16_2 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `08_20_16_2`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="08_20_16_2", 
       caption="",fill="Region") + theme_boxplots
boxplot_08_22_18 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `08_22_18`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="08_22_18", 
       caption="",fill="Region") + theme_boxplots
boxplot_08_20_16_1 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                           aes(x = survey_label, y = dim_2, fill = `08_20_16_1`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="08_20_16_1", 
       caption="",fill="Region") + theme_boxplots
boxplot_09_31_20_1 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `09_31_20_1`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="09_31_20_1", 
       caption="",fill="Region") + theme_boxplots
boxplot_06_16_13_2 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `06_16_13_2`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="06_16_13_2", 
       caption="",fill="Region") + theme_boxplots
boxplot_06_16_13_4 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `06_16_13_4`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="06_16_13_4", 
       caption="",fill="Region") + theme_boxplots
boxplot_06_16_13_1 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `06_16_13_1`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="06_16_13_1", 
       caption="",fill="Region") + theme_boxplots
boxplot_09_31_20_3 <- ggplot(na.omit(subset(surveys_combined_demos)), 
                             aes(x = survey_label, y = dim_2, fill = `09_31_20_3`)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="Survey",fill="09_31_20_3", 
       caption="",fill="Region") + theme_boxplots

ggexport(plotlist = list(boxplot_07_17_14_2,boxplot_07_17_14_3,boxplot_07_17_14_1,
                         boxplot_08_20_16_2,boxplot_08_22_18,boxplot_08_20_16_1, 
                         boxplot_09_31_20_1,boxplot_06_16_13_2,boxplot_06_16_13_4,
                         boxplot_06_16_13_1,boxplot_09_31_20_3), filename = "./plots/boxplots_dim2.pdf")
