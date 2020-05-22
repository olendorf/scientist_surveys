# Need to convert some of the data to factors rather than characters.
surveys_combined_demos$domain <- as.factor(surveys_combined_demos$domain)
surveys_combined_demos$work_sector <- as.factor(surveys_combined_demos$work_sector)
surveys_combined_demos$funding_agency <- as.factor(surveys_combined_demos$funding_agency)
surveys_combined_demos$region <- as.factor(surveys_combined_demos$region)

surveys_combined_demos[which(surveys_combined_demos$survey_label == "S1"), ]$survey_label <- "One"
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S2"), ]$survey_label <- "Two"
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S3"), ]$survey_label <- "Three"
surveys_combined_demos$survey_label <- ordered(surveys_combined_demos$survey_label, levels = c("One", "Two", "Three"))

surveys_combined_demos$dim_1 <- surveys_combined_demos$dim_1 * -1
no_region_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$region)), ]


region_summary <- no_region_na %>% 
                    dplyr::group_by(region, survey_label) %>% 
                    dplyr::summarize(
                      mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
                      mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
region_summary$se_dim_1 <- sqrt(region_summary$var_dim_1/region_summary$n)
region_summary$se_dim_2 <- sqrt(region_summary$var_dim_2/region_summary$n)



region_plot_dim_1 <- ggplot(region_summary, aes(x = survey_label, y = mean_dim_1, group = region, color = region))
region_plot_dim_1 + geom_point(size = 4, aes(color = region)) + 
  geom_line(size = 1) + theme_minimal() + 
  labs(x = "Survey", y = "Willingness to Share", color="Region") +
  ggtitle("Willingness to Share by Geographical Region and Survey") + 
  scale_color_brewer(palette = "Dark2") + 
  geom_errorbar(aes(ymin = mean_dim_1 - se_dim_1, ymax = mean_dim_1 + se_dim_1), size = 1, width = 0.2)



region_plot_dim_2 <- ggplot(region_summary, aes(x = survey_label, y = mean_dim_2, group = region, color = region))
region_plot_dim_2 + geom_point(size = 4, aes(color = region)) + 
  geom_line(size = 1) + theme_minimal() + 
  labs(x = "Survey", y = "Data Resources", color="Region") +
  ggtitle("Satisfaction with Data Management Resources by Geographical Region and Survey") + 
  scale_color_brewer(palette = "Dark2") + 
  geom_errorbar(aes(ymin = mean_dim_2 - se_dim_2, ymax = mean_dim_2 + se_dim_2), size = 1, width = 0.2)
