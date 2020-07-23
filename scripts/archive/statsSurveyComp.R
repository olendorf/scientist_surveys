###########################
#   DIM1 & DIM2 MANOVAs   #
###########################
# DIM1 ANOVAs
# Survey
dim1_survey_label <- aov(dim_1 ~ survey_label, data = surveys_combined_demos)
summary(dim1_survey_label)
TukeyHSD(dim1_survey_label)

# Work sector
dim1_work_sector <- aov(dim_1 ~ work_sector*survey_label, data = surveys_combined_demos)
summary(dim1_work_sector)
TukeyHSD(dim1_work_sector)

# Domain
dim1_domain <- aov(dim_1 ~ domain*survey_label, data = surveys_combined_demos)
summary(dim1_domain)
TukeyHSD(dim1_domain)

# Region
dim1_region <- aov(dim_1 ~ region*survey_label, data = surveys_combined_demos)
summary(dim1_region)
TukeyHSD(dim1_region)

# Funding agency
dim1_funding_agency <- aov(dim_1 ~ funding_agency*survey_label, data = surveys_combined_demos)
summary(dim1_funding_agency)
TukeyHSD(dim1_funding_agency)

# DIM2 ANOVAs
# Survey
dim2_survey_label <- aov(dim_2 ~ survey_label, data = surveys_combined_demos)
summary(dim2_survey_label)
TukeyHSD(dim2_survey_label)

# Work sector
dim2_work_sector <- aov(dim_2 ~ work_sector*survey_label, data = surveys_combined_demos)
summary(dim2_work_sector)
TukeyHSD(dim2_work_sector)

# Domain
dim2_domain <- aov(dim_2 ~ domain*survey_label, data = surveys_combined_demos)
summary(dim2_domain)
TukeyHSD(dim2_domain)

# Region
dim2_region <- aov(dim_2 ~ region*survey_label, data = surveys_combined_demos)
summary(dim2_region)
TukeyHSD(dim2_region)

# Funding agency
dim2_funding_agency <- aov(dim_2 ~ funding_agency*survey_label, data = surveys_combined_demos)
summary(dim2_funding_agency)
TukeyHSD(dim2_funding_agency)

# Interactions 
dim1_d_ws <- aov(dim_1 ~ domain*work_sector, data = surveys_combined_demos)
summary(dim1_d_ws)
TukeyHSD(dim1_d_ws)

dim2_d_ws <- aov(dim_2 ~ domain*work_sector, data = surveys_combined_demos)
summary(dim2_d_ws)
TukeyHSD(dim2_d_ws)

######################################################
#      Summary dataframes for geom_point plots       #
######################################################
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

######################################################
#   DIM1 & DIM2: Plots of dim1/dim2 by demographic   #
######################################################
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

# Export point plots
ggexport(plotlist = list(dims_region, dims_work_sector, dims_domain,
                         dims_funding_agency), filename = "./plots/dims_point.pdf")

######################################################
#    Boxplots of demographic data for DIM and DIM2   #
######################################################
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

# Export boxplots
ggexport(plotlist = list(boxplot_dim1_survey,boxplot_dim2_survey,boxplot_dim1_region,boxplot_dim2_region,
                         boxplot_dim1_work_sector,boxplot_dim2_work_sector,boxplot_dim1_domain,
                         boxplot_dim2_domain,boxplot_dim1_funding_agency,boxplot_dim2_funding_agency),
         filename = "./plots/boxplots_demos_dims.pdf")