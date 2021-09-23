###########################
#   DIM1 & DIM2 ANOVAs   #
###########################
# DIM1 ANOVAs
# Survey
dim1_survey_label <- aov(dim_1 ~ survey_label, data = surveys_combined_demos)
summary(dim1_survey_label)
TukeyHSD(dim1_survey_label)

#############################
#  Generate TukeyHSD tables #
############################# 
# ANOVA
dim1_work_sector <- aov(dim_1 ~ work_sector, data = surveys_combined_demos)
dim1_domain <- aov(dim_1 ~ domain, data = surveys_combined_demos)
dim1_region <- aov(dim_1 ~ region, data = surveys_combined_demos)
dim1_funding_agency <- aov(dim_1 ~ funding_agency_recoded, data = surveys_combined_demos)
dim2_work_sector <- aov(dim_2 ~ work_sector, data = surveys_combined_demos)
dim2_domain <- aov(dim_2 ~ domain, data = surveys_combined_demos)
dim2_region <- aov(dim_2 ~ region, data = surveys_combined_demos)
dim2_funding_agency <- aov(dim_2 ~ funding_agency_recoded, data = surveys_combined_demos)
dim1_work_sector_survey <- aov(dim_1 ~ survey_label*work_sector, data = surveys_combined_demos)
dim1_domain_survey <- aov(dim_1 ~ survey_label*domain, data = surveys_combined_demos)
dim1_region_survey <- aov(dim_1 ~ survey_label*region, data = surveys_combined_demos)
dim1_funding_agency_survey <- aov(dim_1 ~ survey_label*funding_agency_recoded, data = surveys_combined_demos)
dim2_work_sector_survey <- aov(dim_2 ~ survey_label*work_sector, data = surveys_combined_demos)
dim2_domain_survey <- aov(dim_2 ~ survey_label*domain, data = surveys_combined_demos)
dim2_region_survey <- aov(dim_2 ~ survey_label*region, data = surveys_combined_demos)
dim2_funding_agency_survey <- aov(dim_2 ~ survey_label*funding_agency_recoded, data = surveys_combined_demos)

# TukeyHSD
dim1_work_sector_thsd <- TukeyHSD(dim1_work_sector)
dim1_domain_thsd <- TukeyHSD(dim1_domain)
dim1_region_thsd <- TukeyHSD(dim1_region)
dim1_funding_agency_thsd <- TukeyHSD(dim1_funding_agency)
dim2_work_sector_thsd <- TukeyHSD(dim2_work_sector)
dim2_domain_thsd <- TukeyHSD(dim2_domain)
dim2_region_thsd <- TukeyHSD(dim2_region)
dim2_funding_agency_thsd <- TukeyHSD(dim2_funding_agency)
dim1_work_sector_survey_thsd <- TukeyHSD(dim1_work_sector_survey)
dim1_domain_survey_thsd <- TukeyHSD(dim1_domain_survey)
dim1_region_survey_thsd <- TukeyHSD(dim1_region_survey)
dim1_funding_agency_survey_thsd <- TukeyHSD(dim1_funding_agency_survey)
dim2_work_sector_survey_thsd <- TukeyHSD(dim2_work_sector_survey)
dim2_domain_survey_thsd <- TukeyHSD(dim2_domain_survey)
dim2_region_survey_thsd <- TukeyHSD(dim2_region_survey)
dim2_funding_agency_survey_thsd <- TukeyHSD(dim2_funding_agency_survey)

# Save to CSV
write.csv(dim1_work_sector_thsd$work_sector, file = "data/tukeyhsd/dim1_work_sector_thsd.csv")
write.csv(dim1_domain_thsd$domain, file = "data/tukeyhsd/dim1_domain_thsd.csv")
write.csv(dim1_region_thsd$region, file = "data/tukeyhsd/dim1_region_thsd.csv")
write.csv(dim1_funding_agency_thsd$funding_agency, file = "data/tukeyhsd/dim1_funding_agency_thsd.csv")
write.csv(dim2_work_sector_thsd$work_sector, file = "data/tukeyhsd/dim2_work_sector_thsd.csv")
write.csv(dim2_domain_thsd$domain, file = "data/tukeyhsd/dim2_domain_thsd.csv")
write.csv(dim2_region_thsd$region, file = "data/tukeyhsd/dim2_region_thsd.csv")
write.csv(dim2_funding_agency_thsd$funding_agency, file = "data/tukeyhsd/dim2_funding_agency_thsd.csv")
write.csv(dim1_work_sector_survey_thsd$`survey_label:work_sector`, file = "data/tukeyhsd/dim1_work_sector_survey_thsd.csv")
write.csv(dim1_domain_survey_thsd$`survey_label:domain`, file = "data/tukeyhsd/dim1_domain_survey_thsd.csv")
write.csv(dim1_region_survey_thsd$`survey_label:region`, file = "data/tukeyhsd/dim1_region_survey_thsd.csv")
write.csv(dim1_funding_agency_survey_thsd$`survey_label:funding_agency`, file = "data/tukeyhsd/dim1_funding_agency_survey_thsd.csv")
write.csv(dim2_work_sector_survey_thsd$`survey_label:work_sector`, file = "data/tukeyhsd/dim2_work_sector_survey_thsd.csv")
write.csv(dim2_domain_survey_thsd$`survey_label:domain`, file = "data/tukeyhsd/dim2_domain_survey_thsd.csv")
write.csv(dim2_region_survey_thsd$`survey_label:region`, file = "data/tukeyhsd/dim2_region_survey_thsd.csv")
write.csv(dim2_funding_agency_survey_thsd$`survey_label:funding_agency`, file = "data/tukeyhsd/dim2_funding_agency_survey_thsd.csv")

# Compute means
## Total
surveys_means_work_sector <- surveys_combined_demos %>% group_by(work_sector) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=work_sector, dim1_mean, dim2_mean) %>% distinct()
surveys_means_domain <- surveys_combined_demos %>% group_by(domain) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=domain, dim1_mean, dim2_mean) %>% distinct()
surveys_means_region <- surveys_combined_demos %>% group_by(region) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=region, dim1_mean, dim2_mean) %>% distinct()
surveys_means_funding_agency <- surveys_combined_demos %>% group_by(funding_agency_recoded) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=funding_agency_recoded, dim1_mean, dim2_mean) %>% distinct()

## By survey
surveys_means_work_sector_survey <- surveys_combined_demos %>% group_by(work_sector,survey_label) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=work_sector,survey_label,dim1_mean, dim2_mean) %>% distinct()
surveys_means_domain_survey <- surveys_combined_demos %>% group_by(domain,survey_label) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=domain,survey_label,dim1_mean, dim2_mean) %>% distinct()
surveys_means_region_survey <- surveys_combined_demos %>% group_by(region,survey_label) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=region,survey_label, dim1_mean, dim2_mean) %>% distinct()
surveys_means_funding_agency_survey <- surveys_combined_demos %>% group_by(funding_agency_recoded,survey_label) %>% 
  mutate(dim1_mean=mean(dim_1),dim2_mean=mean(dim_2)) %>% summarize(variable=funding_agency_recoded,survey_label,dim1_mean, dim2_mean) %>% distinct()

# Combine
survey_means_all <- rbind(surveys_means_work_sector,surveys_means_domain,surveys_means_region,surveys_means_funding_agency)
survey_means_bysurvey <- rbind(surveys_means_work_sector_survey,surveys_means_domain_survey,
                          surveys_means_region_survey,surveys_means_funding_agency_survey)

# Save to CSV
#write.csv(survey_means_all, file = "data/tukeyhsd/survey_means_all.csv")
#write.csv(survey_means_bysurvey, file = "data/tukeyhsd/survey_means_bysurvey.csv")

# Work sector
dim1_work_sector <- aov(dim_1 ~ survey_label*work_sector, data = surveys_combined_demos)
dim1_work_sector <- aov(dim_1 ~ work_sector, data = surveys_combined_demos)
dim2_work_sector <- aov(dim_2 ~ survey_label*work_sector, data = surveys_combined_demos)
dim2_work_sector <- aov(dim_2 ~ work_sector, data = surveys_combined_demos)
summary(dim1_work_sector)
TukeyHSD(dim1_work_sector)
TukeyHSD(dim2_work_sector)

# Domain
dim1_domain <- aov(dim_1 ~ survey_label*domain, data = surveys_combined_demos)
dim2_domain <- aov(dim_2 ~ survey_label*domain, data = surveys_combined_demos)
dim1_domain <- aov(dim_1 ~ domain, data = surveys_combined_demos)
dim2_domain <- aov(dim_2 ~ domain, data = surveys_combined_demos)
TukeyHSD(dim1_domain)
TukeyHSD(dim2_domain)

# Region
## Change aov to lm
dim1_region <- aov(dim_1 ~survey_label*region, data = surveys_combined_demos)
dim2_region <- aov(dim_2 ~survey_label*region, data = surveys_combined_demos)
dim1_region <- aov(dim_1 ~region, data = surveys_combined_demos)
dim2_region <- aov(dim_2 ~region, data = surveys_combined_demos)
TukeyHSD(dim1_region)
TukeyHSD(dim2_region)

# Funding agency
dim1_funding_agency <- aov(dim_1 ~ survey_label*funding_agency_recoded, data = surveys_combined_demos)
dim1_funding_agency <- aov(dim_1 ~ funding_agency_recoded, data = surveys_combined_demos)
dim2_funding_agency <- aov(dim_2 ~ survey_label*funding_agency_recoded, data = surveys_combined_demos)
dim2_funding_agency <- aov(dim_2 ~ funding_agency_recoded, data = surveys_combined_demos)
TukeyHSD(dim1_funding_agency)
TukeyHSD(dim2_funding_agency)

# Count respondent demographics
# Survey 1
nrow(subset(surveys_combined_demos,survey_label=="2011"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & region=="AfricaMENA"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & region=="AsiaSEAsia"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & region=="AustraliaNZ"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & region=="EuroRussia"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & region=="LatinAmerica"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & region=="USACanada"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & domain=="Natural science"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & domain=="Physical science"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & domain=="Information science"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & domain=="Social science"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & domain=="Other"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & work_sector=="Academic"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & work_sector=="Commercial"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & work_sector=="Government"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & work_sector=="Non-Profit"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & work_sector=="Other"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & funding_agency_recoded=="Corporation"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & funding_agency_recoded=="Federal/national gov."))
nrow(subset(surveys_combined_demos,survey_label=="2011" & funding_agency_recoded=="Private foundation"))
nrow(subset(surveys_combined_demos,survey_label=="2011" & funding_agency_recoded=="State/regional/local gov."))
nrow(subset(surveys_combined_demos,survey_label=="2011" & funding_agency_recoded=="Other"))

# Survey 2
nrow(subset(surveys_combined_demos,survey_label=="2015"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & region=="AfricaMENA"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & region=="AsiaSEAsia"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & region=="AustraliaNZ"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & region=="EuroRussia"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & region=="LatinAmerica"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & region=="USACanada"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & domain=="Natural science"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & domain=="Physical science"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & domain=="Information science"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & domain=="Social science"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & domain=="Other"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & work_sector=="Academic"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & work_sector=="Commercial"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & work_sector=="Government"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & work_sector=="Non-Profit"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & work_sector=="Other"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & funding_agency_recoded=="Corporation"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & funding_agency_recoded=="Federal/national gov."))
nrow(subset(surveys_combined_demos,survey_label=="2015" & funding_agency_recoded=="Private foundation"))
nrow(subset(surveys_combined_demos,survey_label=="2015" & funding_agency_recoded=="State/regional/local gov."))
nrow(subset(surveys_combined_demos,survey_label=="2015" & funding_agency_recoded=="Other"))

# Survey 3
nrow(subset(surveys_combined_demos,survey_label=="2019"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & region=="AfricaMENA"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & region=="AsiaSEAsia"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & region=="AustraliaNZ"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & region=="EuroRussia"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & region=="LatinAmerica"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & region=="USACanada"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & domain=="Natural science"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & domain=="Physical science"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & domain=="Information science"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & domain=="Social science"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & domain=="Other"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & work_sector=="Academic"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & work_sector=="Commercial"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & work_sector=="Government"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & work_sector=="Non-Profit"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & work_sector=="Other"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & funding_agency_recoded=="Corporation"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & funding_agency_recoded=="Federal/national gov."))
nrow(subset(surveys_combined_demos,survey_label=="2019" & funding_agency_recoded=="Private foundation"))
nrow(subset(surveys_combined_demos,survey_label=="2019" & funding_agency_recoded=="State/regional/local gov."))
nrow(subset(surveys_combined_demos,survey_label=="2019" & funding_agency_recoded=="Other"))

# Regression of DIM1 and DIM2 
summary(lm(surveys_combined_demos$dim_1 ~ surveys_combined_demos$dim_2))

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
  geom_text(survey_dim_means, mapping=aes(x = dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(region_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, color = region)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(region_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, 
                        label = paste("(",region,",",survey_label,")"),
                        color = region), size=4) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share their data", 
       y="Satisfaction with personal/institutional data sharing practices",fill="Region",caption="") + theme_point
dims_work_sector <- ggplot() +
  geom_text(survey_dim_means, mapping=aes(x = dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(work_sector_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, color = work_sector)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(work_sector_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, 
                                               label = paste("(",work_sector,",",survey_label,")"),
                                               color = work_sector), size=4) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share their data", 
       y="Satisfaction with personal/institutional data sharing practices",fill="Work Sector",caption="") + theme_point
dims_domain <- ggplot() +
  geom_text(survey_dim_means, mapping=aes(x = dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(domain_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, color = domain)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(domain_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, 
                                                    label = paste("(",domain,",",survey_label,")"),
                                                    color = domain), size=4) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share their data", 
       y="Satisfaction with personal/institutional data sharing practices",fill="Domain",caption="") + theme_point
dims_funding_agency <- ggplot() +
  geom_text(survey_dim_means, mapping=aes(x = dim1_mean, y = dim2_mean, label = survey_label),color = "Black",
            fontface="bold", size=4) +
  geom_point(funding_agency_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, color = funding_agency)) +
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  geom_text_repel(funding_agency_dim_means,mapping=aes(x = dim1_mean, y = dim2_mean, 
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