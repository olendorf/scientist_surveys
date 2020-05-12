## DIM1 & DIM2 MANOVAs
### DIM1
dim1_sigq_survey_label <- aov(dim_1 ~ survey_label*(`10_32_19_2`+`10_32_19_3`+`11_19_15_11`+
                                               `10_32_19_6`+`11_19_15_5`+`11_19_15_10`+
                                               `11_19_15_1`+`11_19_15_9`+`10_32_19_4`+
                                               `11_19_15_4`+`11_19_15_8`+`10_32_19_1`+
                                               `11_19_15_6`+`11_19_15_7`+`10_32_19_8`), 
                       data = surveys_combined_demos)
dim1_sigq_survey_label_table <- formattable(data.frame(unclass(summary(dim1_sigq_survey_label)), 
                                          check.names = FALSE, stringsAsFactors = FALSE))

# Survey
dim1_survey_label <- aov(dim_1 ~ survey_label, data = surveys_combined_demos)
summary(dim1_survey_label)
TukeyHSD(dim1_survey_label)
describeBy(surveys_combined_demos$dim_1,surveys_combined_demos$survey_label)

# Work sector
dim1_work_sector <- aov(dim_1 ~ work_sector, data = surveys_combined_demos)
summary(dim1_work_sector)
TukeyHSD(dim1_work_sector)
describeBy(surveys_combined_demos$dim_1,surveys_combined_demos$work_sector)

# Compute means and generate DIM1 & DIM2 boxplots
surveys_combined_demos <- surveys_combined_demos %>% 
  group_by(survey_label) %>% mutate(survey_dim1_mean=mean(dim_1)) %>%
  group_by(region,survey_label) %>% mutate(region_dim1_mean=mean(dim_1)) %>% ungroup(funding_agency) %>%
  group_by(work_sector,survey_label) %>% mutate(work_sector_dim1_mean=mean(dim_1)) %>% ungroup(work_sector) %>% 
  group_by(domain,survey_label) %>% mutate(domain_dim1_mean=mean(dim_1)) %>% ungroup(domain) %>% 
  group_by(funding_agency,survey_label) %>% mutate(funding_agency_dim1_mean=mean(dim_1)) %>% ungroup(funding_agency) %>%
surveys_combined_demos <- surveys_combined_demos %>% 
  group_by(survey_label) %>% mutate(survey_dim2_mean=mean(dim_2)) %>%
  group_by(region,survey_label) %>% mutate(region_dim2_mean=mean(dim_2)) %>% ungroup(funding_agency) %>%
  group_by(work_sector,survey_label) %>% mutate(work_sector_dim2_mean=mean(dim_2)) %>% ungroup(work_sector) %>% 
  group_by(domain,survey_label) %>% mutate(domain_dim2_mean=mean(dim_2)) %>% ungroup(domain) %>% 
  group_by(funding_agency,survey_label) %>% mutate(funding_agency_dim2_mean=mean(dim_2)) %>% ungroup(funding_agency)
survey_dim_means <- surveys_combined_demos %>% 
  dplyr::group_by(survey_label) %>% 
  dplyr::summarize(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2))
survey_dim_means <- na.omit(survey_dim_means)
region_dim_means <- surveys_combined_demos %>% 
  dplyr::group_by(survey_label,region) %>% 
  dplyr::summarize(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2))
region_dim_means <- na.omit(region_dim_means)
work_sector_dim_means <- surveys_combined_demos %>% 
  dplyr::group_by(survey_label,work_sector) %>% 
  dplyr::summarize(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2))
work_sector_dim_means <- na.omit(work_sector_dim_means)
domain_dim_means <- surveys_combined_demos %>% 
  dplyr::group_by(survey_label,domain) %>% 
  dplyr::summarize(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2))
domain_dim_means <- na.omit(domain_dim_means)
funding_agency_dim_means <- surveys_combined_demos %>% 
  dplyr::group_by(survey_label,funding_agency) %>% 
  dplyr::summarize(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2))
funding_agency_dim_means <- na.omit(funding_agency_dim_means)

## DIM1 & DIM2: Plots of dim1/dim2 by demographic
## Point plots
theme_point <- theme(plot.title = element_text(face="bold",size=24),
                      legend.position = "none",
                      legend.key.size = unit(0.5, "cm"),
                      legend.title = element_blank(),
                      legend.text=element_text(size=6),
                      axis.text.x = element_text(color="black",size=16, angle=0),
                      axis.title.x = element_text(color="black",size=12, angle=0),
                      axis.text.y = element_text(color="black",size=16, angle=0),
                      axis.title.y = element_text(color="black",size=12, angle=90))
#  stat_ellipse(mapping=aes(x = dim_1, y = dim_2, group=survey_label,color=survey_label,
#                           fill=survey_label),
#               type = "norm", linetype = 2,level = 0.50, geom="polygon", alpha=0.5) +
dims_region <- ggplot() +
  geom_text(survey_dim_means, mapping=aes(x = -dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(region_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, color = region)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(region_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, 
                        label = paste("(",region,",",survey_label,")"),
                        color = region), size=4) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share their data", 
       y="Satisfaction with personal/institutional data sharing practices",fill="Region",caption="") + theme_point
dims_work_sector <- ggplot() +
  geom_text(survey_dim_means, mapping=aes(x = -dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(work_sector_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, color = work_sector)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(work_sector_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, 
                                               label = paste("(",work_sector,",",survey_label,")"),
                                               color = work_sector), size=4) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share their data", 
       y="Satisfaction with personal/institutional data sharing practices",fill="Work Sector",caption="") + theme_point
dims_domain <- ggplot() +
  geom_text(survey_dim_means, mapping=aes(x = -dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(domain_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, color = domain)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(domain_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, 
                                                    label = paste("(",domain,",",survey_label,")"),
                                                    color = domain), size=4) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share their data", 
       y="Satisfaction with personal/institutional data sharing practices",fill="Domain",caption="") + theme_point
dims_funding_agency <- ggplot() +
  geom_text(survey_dim_means, mapping=aes(x = -dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(funding_agency_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, color = funding_agency)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(funding_agency_dim_means,mapping=aes(x = -dim1_mean, y = dim2_mean, 
                                                    label = paste("(",funding_agency,",",survey_label,")"),
                                                    color = funding_agency), size=4) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share their data", 
       y="Satisfaction with personal/institutional data sharing practices",fill="Funding Agency",caption="") + theme_point
#ggexport(plotlist = list(dims_region, dims_work_sector, dims_domain,
#                         dims_funding_agency), filename = "./plots/dims_point.png", 
#         height = 1000,width = 1000)
ggexport(plotlist = list(dims_region, dims_work_sector, dims_domain,
                         dims_funding_agency), filename = "./plots/dims_point.pdf")

### Boxplots
theme_boxplots <-   theme(plot.title = element_text(face="bold",size=24),
                          legend.position = "none",
                          legend.key.size = unit(0.5, "cm"),
                          legend.title = element_text(color="black",face="bold",size=20, angle=0),
                          legend.text=element_text(size=10),
                          axis.text.x = element_text(color="black",size=12, angle=-30),
                          axis.title.x = element_text(color="black",size=20, angle=0),
                          axis.text.y = element_text(color="black",size=20, angle=0),
                          axis.title.y = element_text(color="black",size=20, angle=90))
boxplot_dim1_survey <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = survey_label, y = dim_1, fill = survey_label)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="",fill="",caption="") + theme_boxplots
boxplot_dim2_survey <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = survey_label, y = dim_2, fill = survey_label)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.2", x="",fill="",caption="") + theme_boxplots
boxplot_dim1_region <- ggplot(na.omit(subset(surveys_combined_demos)), 
                                      aes(x = region, y = dim_1, fill = region)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="",fill="",caption="") + theme_boxplots
boxplot_dim2_region <- ggplot(na.omit(subset(surveys_combined_demos)), 
                                      aes(x = region, y = dim_2, fill = region)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.2", x="",fill="",caption="") + theme_boxplots
boxplot_dim1_work_sector <- ggplot(na.omit(subset(surveys_combined_demos)), 
                                   aes(x = work_sector, y = dim_1, fill = work_sector)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="",fill="",caption="") + theme_boxplots
boxplot_dim2_work_sector <- ggplot(na.omit(subset(surveys_combined_demos)), 
                                   aes(x = work_sector, y = dim_2, fill = work_sector)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.2", x="",fill="",caption="") + theme_boxplots
boxplot_dim1_domain <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = domain, y = dim_1, fill = domain)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="",fill="",caption="") + theme_boxplots
boxplot_dim2_domain <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = domain, y = dim_2, fill = domain)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.2", x="",fill="",caption="") + theme_boxplots
boxplot_dim1_funding_agency <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = funding_agency, y = dim_1, fill = funding_agency)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.1", x="",fill="",caption="") + theme_boxplots
boxplot_dim2_funding_agency <- ggplot(na.omit(subset(surveys_combined_demos)), 
                              aes(x = funding_agency, y = dim_2, fill = funding_agency)) +
  geom_boxplot() +
  geom_jitter(shape = 15,color = "steelblue",size = 0.5,position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="", y="Dim.2", x="",fill="",caption="") + theme_boxplots
ggexport(plotlist = list(boxplot_dim1_survey,boxplot_dim2_survey,boxplot_dim1_region,boxplot_dim2_region,
                         boxplot_dim1_work_sector,boxplot_dim2_work_sector,boxplot_dim1_domain,
                         boxplot_dim2_domain,boxplot_dim1_funding_agency,boxplot_dim2_funding_agency),
         filename = "./plots/boxplots_demos_dims.pdf")
  
### DIM2
dim2_surveyLabel <- aov(dim_2 ~ survey_label*(`07_17_14_2`+`07_17_14_3`+`07_17_14_1`+
                                              `08_20_16_2`+`08_22_18`+`08_20_16_1`+
                                              `09_31_20_1`+`06_16_13_2`+`06_16_13_4`+
                                              `06_16_13_1`+`09_31_20_3`), 
                        data = surveys_combined_demos)
dim2_surveyLabel_table <- formattable(data.frame(unclass(summary(dim2_surveyLabel)), 
                                                 check.names = FALSE, stringsAsFactors = FALSE))


write.csv(dim1_sigq_survey_label_table, file = "./data/MANOVA_dim1.csv")
write.csv(dim2_surveyLabel_table, file = "./data/MANOVA_dim2.csv")

#summary(s_anova_two_way)
#TukeyHSD(s_anova_two_way)

## DIM1 & DIM2 individual question comparison
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
