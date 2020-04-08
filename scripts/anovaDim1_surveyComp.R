###################################
#             ANOVA               #
###################################
## Surveys ANOVA, mean, sd, and plot 
### ANOVA
s_anova_one_way <- aov(dim_1 ~ survey_label, data = surveys_combined_demos_limited)
s_anova_one_way <- formattable(data.frame(unclass(summary(s_anova_one_way)), 
                                          check.names = FALSE, stringsAsFactors = FALSE))
s_anova_one_way_lm <- lm(dim_1 ~ work_sector, data = surveys_combined_demos_limited)
summary(s_anova_one_way_lm)
TukeyHSD(s_anova_one_way)
# MANOVA for two variables
# Analyze surveys by work sector

### Mean & sd
s_mean_sd <- na.omit(surveys_combined_demos_limited) %>%
  group_by(survey_label) %>%
  summarize(count = n(),
            mean_contrib = mean(dim_1, na.rm = TRUE),
            sd_contrib = sd(dim_1, na.rm = TRUE))
s_mean_sd <- formattable(s_mean_sd)

### Boxplot
s_boxplot <- ggplot(na.omit(subset(surveys_combined_demos_limited,survey_label!="S2")), 
                    aes(x = survey_label, y = dim_1, fill = work_sector)) +
  geom_boxplot() +
  geom_jitter(shape = 15,
              color = "steelblue",
              size = 0.5,
              position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="Survey", y="Dim.1", x="Survey", 
       caption="",fill="Region") +
  theme(plot.title = element_text(face="bold",size=24),
        legend.position = "bottom",
        legend.key.size = unit(1.0, "cm"),
        legend.title = element_blank(),
        legend.text=element_text(size=20),
        axis.text.x = element_text(color="black",size=20, angle=0),
        axis.title.x = element_text(color="black",size=20, angle=0),
        axis.text.y = element_text(color="black",size=20, angle=0),
        axis.title.y = element_text(color="black",size=20, angle=90))
ggexport(plotlist = list(s_boxplot), filename = "plots/s_boxplot.png", width = 1200, height = 800)


## Work sector ANOVA, mean, sd, and plot 
### ANOVA
ws_anova_one_way <- aov(dim_1 ~ work_sector*survey_label, data = na.omit(subset(surveys_combined_demos_limited,survey_label!="S2")))
ws_anova_one_way <- formattable(data.frame(unclass(summary(ws_anova_one_way)), check.names = FALSE, stringsAsFactors = FALSE))
ws_anova_one_way_lm <- lm(dim_1 ~ work_sector, data = na.omit(subset(surveys_combined_demos_limited,survey_label!="S2")))
summary(ws_anova_one_way_lm)
summary(ws_anova_one_way_lm)
TukeyHSD(ws_anova_one_way)

### Mean & sd
ws_mean_sd <- na.omit(surveys_combined_demos_limited) %>%
  group_by(work_sector) %>%
  summarize(count = n(),
            mean_contrib = mean(dim_1, na.rm = TRUE),
            sd_contrib = sd(dim_1, na.rm = TRUE))
ws_mean_sd <- formattable(ws_mean_sd)

### Boxplot
ws_boxplot <- ggplot(na.omit(surveys_combined_demos_limited), 
                     aes(x = work_sector, y = dim_1, fill = work_sector)) +
  geom_boxplot() +
  geom_jitter(shape = 15,
              color = "steelblue",
              position = position_jitter(0.21)) +
  scale_x_discrete(labels = c("Acad","Gov","Comm","Non-profit","Other")) +
  scale_y_continuous() +
  theme_classic() +
  labs(title="Work Sector", y="Contribution", x="Work Sector", 
       caption="",fill="Work Sector") +
  theme(plot.title = element_text(face="bold",size=24),
        legend.position = "bottom",
        legend.key.size = unit(1.0, "cm"),
        legend.title = element_blank(),
        legend.text=element_text(size=20),
        axis.text.x = element_text(color="black",size=20, angle=0),
        axis.title.x = element_text(color="black",size=20, angle=0),
        axis.text.y = element_text(color="black",size=20, angle=0),
        axis.title.y = element_text(color="black",size=20, angle=90))
ggexport(plotlist = list(ws_boxplot), filename = "plots/ws_boxplot.png", width = 1200, height = 800)

## Domain ANOVA, mean, sd, and plot 
### ANOVA
domain_anova_one_way <- aov(dim_1 ~ domain, data = surveys_combined_demos_limited)
domain_anova_one_way <- formattable(data.frame(unclass(summary(domain_anova_one_way)), 
                                               check.names = FALSE, stringsAsFactors = FALSE))

### Mean & sd
domain_mean_sd <- na.omit(surveys_combined_demos_limited) %>%
  group_by(domain) %>%
  summarize(count = n(),
            mean_contrib = mean(dim_1, na.rm = TRUE),
            sd_contrib = sd(dim_1, na.rm = TRUE))
domain_mean_sd <- formattable(domain_mean_sd)

### Boxplot
domain_boxplot <- ggplot(na.omit(surveys_combined_demos_limited), 
                         aes(x = domain, y = dim_1, fill = domain)) +
  geom_boxplot() +
  geom_jitter(shape = 15,
              color = "steelblue",
              position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="Domain", y="Dim.1", x="Domain", 
       caption="",fill="Domain") +
  theme(plot.title = element_text(face="bold",size=24),
        legend.position = "bottom",
        legend.key.size = unit(1.0, "cm"),
        legend.title = element_blank(),
        legend.text=element_text(size=20),
        axis.text.x = element_text(color="black",size=20, angle=0),
        axis.title.x = element_text(color="black",size=20, angle=0),
        axis.text.y = element_text(color="black",size=20, angle=0),
        axis.title.y = element_text(color="black",size=20, angle=90))
ggexport(plotlist = list(domain_boxplot), filename = "plots/domain_boxplot.png", width = 1200, height = 800)

## Funding agency ANOVA, mean, sd, and plot 
### ANOVA
fa_anova_one_way <- aov(dim_1 ~ funding_agency, data = surveys_combined_demos_limited)
fa_anova_one_way <- formattable(data.frame(unclass(summary(fa_anova_one_way)), 
                                           check.names = FALSE, stringsAsFactors = FALSE))

### Mean & sd
fa_mean_sd <- na.omit(surveys_combined_demos_limited) %>%
  group_by(funding_agency) %>%
  summarize(count = n(),
            mean_contrib = mean(dim_1, na.rm = TRUE),
            sd_contrib = sd(dim_1, na.rm = TRUE))
fa_mean_sd <- formattable(fa_mean_sd)

### Boxplot
fa_boxplot <- ggplot(na.omit(surveys_combined_demos_limited), 
                     aes(x = funding_agency, y = dim_1, fill = funding_agency)) +
  geom_boxplot() +
  geom_jitter(shape = 15,
              color = "steelblue",
              position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="Funding Agency", y="Dim.1", x="Domain", 
       caption="",fill="Domain") +
  guides(fill = guide_legend(nrow = 4), byrow = TRUE) +
  theme(plot.title = element_text(face="bold",size=24),
        legend.position = "bottom",
        legend.key.size = unit(1.0, "cm"),
        legend.title = element_blank(),
        legend.text=element_text(size=20),
        axis.text.x = element_text(color="black",size=20, angle=-30),
        axis.title.x = element_text(color="black",size=20, angle=0),
        axis.text.y = element_text(color="black",size=20, angle=0),
        axis.title.y = element_text(color="black",size=20, angle=90))
ggexport(plotlist = list(fa_boxplot), filename = "plots/fa_boxplot.png", width = 1200, height = 800)

## Region ANOVA, mean, sd, and plot 
### ANOVA
region_anova_one_way <- aov(dim_1 ~ region, data = surveys_combined_demos_limited)
region_anova_one_way <- formattable(data.frame(unclass(summary(region_anova_one_way)), 
                                               check.names = FALSE, stringsAsFactors = FALSE))

### Mean & sd
region_mean_sd <- na.omit(surveys_combined_demos_limited) %>%
  group_by(region) %>%
  summarize(count = n(),
            mean_contrib = mean(dim_1, na.rm = TRUE),
            sd_contrib = sd(dim_1, na.rm = TRUE))
region_mean_sd <- formattable(region_mean_sd)

### Boxplot
region_boxplot <- ggplot(na.omit(surveys_combined_demos_limited), 
                         aes(x = region, y = dim_1, fill = region)) +
  geom_boxplot() +
  geom_jitter(shape = 15,
              color = "steelblue",
              position = position_jitter(0.21)) +
  scale_x_discrete() +
  scale_y_continuous() +
  theme_classic() +
  labs(title="Region", y="Dim.1", x="Region", 
       caption="",fill="Region") +
  theme(plot.title = element_text(face="bold",size=24),
        legend.position = "bottom",
        legend.key.size = unit(1.0, "cm"),
        legend.title = element_blank(),
        legend.text=element_text(size=20),
        axis.text.x = element_text(color="black",size=20, angle=0),
        axis.title.x = element_text(color="black",size=20, angle=0),
        axis.text.y = element_text(color="black",size=20, angle=0),
        axis.title.y = element_text(color="black",size=20, angle=90))
ggexport(plotlist = list(region_boxplot), filename = "plots/region_boxplot.png", width = 1200, height = 800)
