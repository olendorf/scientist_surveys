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

library(grid)


region_summary <- no_region_na %>% 
                    dplyr::group_by(region, survey_label) %>% 
                    dplyr::summarize(
                      mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
                      mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
region_summary$se_dim_1 <- sqrt(region_summary$var_dim_1/region_summary$n)
region_summary$se_dim_2 <- sqrt(region_summary$var_dim_2/region_summary$n)

dodge = position_dodge(width = 0.25)

region_plot_dim_1 <- ggplot(
                              region_summary, 
                              aes(x = survey_label, 
                                  y = mean_dim_1, 
                                  group = region, 
                                  color = region)
                            ) + 
                     geom_point(size = 4, aes(color = region), position = dodge) + 
                     geom_line(size = 1, position = dodge) +
                     geom_errorbar(
                                     aes(
                                          ymin = mean_dim_1 - se_dim_1, 
                                          ymax = mean_dim_1 + se_dim_1), 
                                     size = 1, 
                                     width = 0.2, 
                                     position = dodge
                                   ) + 
                     labs(x = element_blank(), y = "Willingness to Share") +
                     ylim(-2, 2) + 
                     ggtitle("Willingness to Share") + 
                     scale_color_brewer(palette = "Dark2") + 
                     theme_minimal() + 
                     theme(legend.position = "none", plot.title = element_text(hjust = 0.5), aspect.ratio = 3/4)
region_plot_dim_1

region_plot_dim_2 <- ggplot(
                              region_summary, 
                              aes(
                                    x = survey_label, 
                                    y = mean_dim_2, 
                                    group = region, 
                                    color = region
                                  )
                              ) +
                     geom_point(size = 4, aes(color = region), position = dodge) + 
                     geom_line(size = 1, position = dodge) +  
                     geom_errorbar(
                                    aes(
                                          ymin = mean_dim_2 - se_dim_2, 
                                          ymax = mean_dim_2 + se_dim_2
                                        ), 
                                    size = 1, 
                                    width = 0.2,
                                    position = dodge
                                  ) + 
                     labs(x = element_blank(), y = "Satisfaction with Resources", color="Region") +
                     ggtitle("Satisfaction with Resources") + 
                     scale_color_brewer(palette = "Dark2") + 
                     theme_minimal() + 
                     theme(legend.position = c(.85, .20), plot.title = element_text(hjust = 0.5), aspect.ratio = 3/4)  
region_plot_dim_2

region_grob_dim_1 <- ggplotGrob(region_plot_dim_1)
region_grob_dim_2 <- ggplotGrob(region_plot_dim_2)

region_grid_plot <- grid.arrange(
                                    arrangeGrob(region_grob_dim_1), 
                                    arrangeGrob(region_grob_dim_2), 
                                    nrow = 1, 
                                    top=textGrob(
                                                  "Changes In Region By Survey\n",
                                                  gp=gpar(fontsize=20,font=3),
                                                  vjust = 2.0
                                                ),
                                    bottom = textGrob(
                                                        "Survey\n", 
                                                        gp = gpar(fontsize = 12),
                                                        vjust = -1.8
                                                      )
                                )
ggsave("plots/region_grid_plot.png", region_grid_plot)

#######################################################################################
#######################################################################################


no_domain_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$domain)), ]


domain_summary <- no_domain_na %>% 
  dplyr::group_by(domain, survey_label) %>% 
  dplyr::summarize(
    mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
    mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
domain_summary$se_dim_1 <- sqrt(domain_summary$var_dim_1/domain_summary$n)
domain_summary$se_dim_2 <- sqrt(domain_summary$var_dim_2/domain_summary$n)



domain_plot_dim_1 <- ggplot(
                              domain_summary, 
                              aes(
                                    x = survey_label, 
                                    y = mean_dim_1, 
                                    group = domain, 
                                    color = domain
                                  )
                            ) + 
                     geom_point(size = 4, aes(color = domain), position = dodge) + 
                     geom_line(size = 1, position = dodge) + 
                     geom_errorbar(
                                      aes(
                                            ymin = mean_dim_1 - se_dim_1, 
                                            ymax = mean_dim_1 + se_dim_1
                                          ), 
                                      size = 1, 
                                      width = 0.2, 
                                      position = dodge
                                    ) + 
                     labs(x = "Domain", y = "Willingness to Share", color="Domain") +
                     ylim(-2, 2) +
                     ggtitle("Willingness to Share") + 
                     scale_color_brewer(palette = "Dark2") +  
                     theme_minimal() + 
                     theme(
                           legend.position = "none", 
                           plot.title = element_text(hjust = 0.5), 
                           aspect.ratio = 3/4
                          )

domain_plot_dim_1



domain_plot_dim_2 <- ggplot(
                              domain_summary, 
                              aes(
                                    x = survey_label, 
                                    y = mean_dim_2, 
                                    group = domain, 
                                    color = domain
                                  )
                            ) + 
                     geom_point(size = 4, aes(color = domain), position = dodge) + 
                     geom_line(size = 1, position = dodge) + 
                     geom_errorbar(
                                      aes(
                                            ymin = mean_dim_2 - se_dim_2, 
                                            ymax = mean_dim_2 + se_dim_2), 
                                      size = 1, 
                                      width = 0.2, 
                                      position = dodge) + 
                     labs(x = "Survey", y = "Satisfaction with Resources", color="Domain") +
                     ggtitle("Satisfaction Resources") + 
                     scale_color_brewer(palette = "Dark2") +
                     theme_minimal() + 
                     theme(
                            legend.position = c(.80, .18), 
                            plot.title = element_text(hjust = 0.5),
                            aspect.ratio = 3/4
                          ) 

domain_plot_dim_2


domain_grob_dim_1 <- ggplotGrob(domain_plot_dim_1)
domain_grob_dim_2 <- ggplotGrob(domain_plot_dim_2)

domain_grid_plot <- grid.arrange(
                                  arrangeGrob(domain_grob_dim_1), 
                                  arrangeGrob(domain_grob_dim_2), 
                                  nrow = 1, 
                                  top=textGrob(
                                    "Changes In Domain By Survey\n",
                                    gp=gpar(fontsize=20,font=3),
                                    vjust = 2.0
                                  ),
                                  bottom = textGrob(
                                    "Survey\n", 
                                    gp = gpar(fontsize = 12),
                                    vjust = -1.8
                                  )
                                )
ggsave("plots/domain_grid_plot.png", domain_grid_plot)


#######################################################################################
#######################################################################################



no_work_sector_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$work_sector)), ]


work_sector_summary <- no_work_sector_na %>% 
  dplyr::group_by(work_sector, survey_label) %>% 
  dplyr::summarize(
    mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
    mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
work_sector_summary$se_dim_1 <- sqrt(work_sector_summary$var_dim_1/work_sector_summary$n)
work_sector_summary$se_dim_2 <- sqrt(work_sector_summary$var_dim_2/work_sector_summary$n)



work_sector_plot_dim_1 <- ggplot(
                                  work_sector_summary, 
                                  aes(
                                        x = survey_label, 
                                        y = mean_dim_1, 
                                        group = work_sector, 
                                        color = work_sector
                                      )
                                ) + 
                          geom_point(size = 4, aes(color = work_sector), position = dodge) + 
                          geom_line(size = 1, position = dodge) + 
                          geom_errorbar(
                                          aes(
                                                ymin = mean_dim_1 - se_dim_1, 
                                                ymax = mean_dim_1 + se_dim_1), 
                                                size = 1, 
                                                width = 0.2,
                                                position = dodge) + 
                          labs(x = "Work Sector", y = "Willingness to Share", color="Work Sector") +
                          ylim(-2, 2) +
                          ggtitle("Willingness to Share") + 
                          scale_color_brewer(palette = "Dark2") + 
                          theme_minimal() +
                          theme(legend.position = "none", plot.title = element_text(hjust = 0.5))
work_sector_plot_dim_1



work_sector_plot_dim_2 <- ggplot(
                                    work_sector_summary, 
                                    aes(
                                          x = survey_label, 
                                          y = mean_dim_2, 
                                          group = work_sector, 
                                          color = work_sector
                                        )
                                  ) +
                          geom_point(size = 4, aes(color = work_sector), position = dodge) + 
                          geom_line(size = 1, position = dodge) + 
                          geom_errorbar(
                                          aes(
                                                ymin = mean_dim_2 - se_dim_2, 
                                                ymax = mean_dim_2 + se_dim_2
                                              ), 
                                          size = 1, 
                                          width = 0.2, 
                                          position = dodge) + 
                          labs(x = "Survey", y = "Satisfaction with Resource", color="Work Sector") +
                          ggtitle("Satisfaction with Resources") + 
                          scale_color_brewer(palette = "Dark2") + 
                          theme_minimal() +
                          theme(legend.position = c(.80, .80), plot.title = element_text(hjust = 0.5)) 
work_sector_plot_dim_2


work_sector_grob_dim_1 <- ggplotGrob(work_sector_plot_dim_1)
work_sector_grob_dim_2 <- ggplotGrob(work_sector_plot_dim_2)

work_sector_grid_plot <- grid.arrange(
  arrangeGrob(work_sector_grob_dim_1), 
  arrangeGrob(work_sector_grob_dim_2), 
  nrow = 1, 
  top=textGrob(
    "Changes In work_sector By Survey\n",
    gp=gpar(fontsize=20,font=3),
    vjust = 2.0
  ),
  bottom = textGrob(
    "Survey\n", 
    gp = gpar(fontsize = 12),
    vjust = -1.8
  )
)
ggsave("plots/work_sector_grid_plot.png", work_sector_grid_plot)
#######################################################################################
#######################################################################################



no_funding_agency_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$funding_agency_recoded)), ]


funding_agency_summary <- no_funding_agency_na %>% 
  dplyr::group_by(funding_agency_recoded, survey_label) %>% 
  dplyr::summarize(
    mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
    mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
funding_agency_summary$se_dim_1 <- sqrt(funding_agency_summary$var_dim_1/funding_agency_summary$n)
funding_agency_summary$se_dim_2 <- sqrt(funding_agency_summary$var_dim_2/funding_agency_summary$n)



funding_agency_plot_dim_1 <- ggplot(
                                      funding_agency_summary, 
                                      aes(
                                            x = survey_label, 
                                            y = mean_dim_1, 
                                            group = funding_agency_recoded, 
                                            color = funding_agency_recoded
                                          )
                                    ) +
                             geom_point(size = 4, aes(color = funding_agency_recoded), position = dodge) + 
                             geom_line(size = 1, position = dodge) + 
                             geom_errorbar(
                                              aes(
                                                    ymin = mean_dim_1 - se_dim_1, 
                                                    ymax = mean_dim_1 + se_dim_1
                                                  ), 
                                              size = 1, 
                                              width = 0.2,
                                              position = dodge) + 
                             labs(x = "Funding Agency", y = "Willingness to Share", color="Funding Agency") +
                             ylim(-2, 2) + 
                             ggtitle("Willingness to Share") + 
                             scale_color_brewer(palette = "Dark2")  + 
                             theme_minimal() + 
                             theme(legend.position = "none", plot.title = element_text(hjust = 0.5))
funding_agency_plot_dim_1



funding_agency_plot_dim_2 <- ggplot(
                                      funding_agency_summary, 
                                      aes(
                                            x = survey_label, 
                                            y = mean_dim_2, 
                                            group = funding_agency_recoded, 
                                            color = funding_agency_recoded
                                          )
                                    ) +
                             geom_point(size = 4, aes(color = funding_agency_recoded), position = dodge) + 
                             geom_line(size = 1, position = dodge) +
                             geom_errorbar(
                                              aes(
                                                    ymin = mean_dim_2 - se_dim_2, 
                                                    ymax = mean_dim_2 + se_dim_2
                                                  ), 
                                              size = 1, 
                                              width = 0.2,
                                              position = dodge
                                          ) +  
                             labs(x = "Survey", y = "Satisfaction with Resource", color="Funding Agency") +
                             ggtitle("Satisfaction with Resources") + 
                             scale_color_brewer(palette = "Dark2")  + 
                             theme_minimal() +
                             theme(legend.position = c(0.80, 0.75), plot.title = element_text(hjust = 0.5))
funding_agency_plot_dim_2



funding_agency_grob_dim_1 <- ggplotGrob(funding_agency_plot_dim_1)
funding_agency_grob_dim_2 <- ggplotGrob(funding_agency_plot_dim_2)

funding_agency_grid_plot <- grid.arrange(
                                  arrangeGrob(funding_agency_grob_dim_1), 
                                  arrangeGrob(funding_agency_grob_dim_2), 
                                  nrow = 1, 
                                  top=textGrob(
                                                "Changes In funding_agency By Survey\n",
                                                gp=gpar(fontsize=20,font=3),
                                                vjust = 2.0
                                  ),
                                  bottom = textGrob(
                                                    "Survey\n", 
                                                    gp = gpar(fontsize = 12),
                                                    vjust = -1.8
                                  )
                                )
ggsave("plots/funding_agency_grid_plot.png", funding_agency_grid_plot)