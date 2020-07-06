##################################################
#               Convert to factors               #
##################################################
surveys_combined_demos$domain <- as.factor(surveys_combined_demos$domain)
surveys_combined_demos$work_sector <- as.factor(surveys_combined_demos$work_sector)
surveys_combined_demos$funding_agency <- as.factor(surveys_combined_demos$funding_agency)
surveys_combined_demos$region <- as.factor(surveys_combined_demos$region)

##################################################
#             Change survey labels               #
##################################################
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S1"), ]$survey_label <- "One"
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S2"), ]$survey_label <- "Two"
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S3"), ]$survey_label <- "Three"
surveys_combined_demos$survey_label <- ordered(surveys_combined_demos$survey_label, levels = c("One", "Two", "Three"))

##################################################
#               Reverse dimension 1              #
##################################################
surveys_combined_demos$dim_1 <- surveys_combined_demos$dim_1 * -1
no_region_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$region)), ]

<<<<<<< HEAD:scripts/publication_plots.R
library(grid)


=======
##################################################
#        Create left and right plot themes       #
##################################################
left_plot_theme <- theme(legend.position = "none", 
                         plot.title = element_text(face="bold",size=24,hjust = 0.5),
                         axis.text.x = element_text(color="black",size=16, angle=0),
                         axis.title.x = element_text(face="bold",color="black",size=20, angle=0),
                         axis.text.y = element_text(color="black",size=16, angle=0),
                         axis.title.y = element_text(face="bold",color="black",size=20, angle=90))

right_plot_theme <- theme(legend.position = c(.80, .18), 
                          plot.title = element_text(face="bold",size=24,hjust = 0.5),
                          legend.key.size = unit(0.5, "cm"),
                          legend.title = element_text(face="bold",size=16),
                          legend.text=element_text(size=14),
                          axis.text.x = element_text(color="black",size=16, angle=0),
                          axis.title.x = element_text(face="bold",color="black",size=20, angle=0),
                          axis.text.y = element_text(color="black",size=16, angle=0),
                          axis.title.y = element_text(face="bold",color="black",size=20, angle=90))

##################################################
#         Clean REGION data for plotting         #
##################################################
>>>>>>> 5d639ecdaad0780864fc7032417bfd86d70688c9:scripts/archive/publication_plots.R
region_summary <- no_region_na %>% 
                    dplyr::group_by(region, survey_label) %>% 
                    dplyr::summarize(
                      mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
                      mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
region_summary$se_dim_1 <- sqrt(region_summary$var_dim_1/region_summary$n)
region_summary$se_dim_2 <- sqrt(region_summary$var_dim_2/region_summary$n)
region_summary$region <- factor(region_summary$region, levels = c("AfricaMENA","AsiaSEAsia","AustraliaNZ",
                                                                  "EuroRussia","LatinAmerica","USACanada"))
dodge = position_dodge(width = 0.25)

##################################################
#              Create REGION plots               #
##################################################
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
<<<<<<< HEAD:scripts/publication_plots.R
                     theme_minimal() + 
                     theme(legend.position = "none", plot.title = element_text(hjust = 0.5), aspect.ratio = 3/4)
region_plot_dim_1
=======
                     theme_minimal() + left_plot_theme
#region_plot_dim_1
#region_summary
>>>>>>> 5d639ecdaad0780864fc7032417bfd86d70688c9:scripts/archive/publication_plots.R

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
<<<<<<< HEAD:scripts/publication_plots.R
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


=======
                     labs(x = "Survey", y = "Satisfaction with Resources", color="Region") +
                     ggtitle("Satisfaction with Resources") + 
                     scale_color_brewer(palette = "Dark2") + 
                     theme_minimal() + right_plot_theme 
#region_plot_dim_2
region_grid_plot <- ( region_plot_dim_1 | region_plot_dim_2 )
ggexport(plotlist = list(region_grid_plot), filename = "plots/region_survey.png",height=650,width=800)


#region_grid_plot <- grid.arrange(
#                                    region_plot_dim_1, 
#                                    region_plot_dim_2, 
#                                    nrow = 1, 
#                                    top=textGrob(
#                                                  "By Region and Survey\n",
#                                                  gp=gpar(fontsize=20,font=3)
#                                                )
#                                )

##################################################
#        Clean DOMAIN data for plotting          #
##################################################
>>>>>>> 5d639ecdaad0780864fc7032417bfd86d70688c9:scripts/archive/publication_plots.R
no_domain_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$domain)), ]

domain_summary <- no_domain_na %>% 
  dplyr::group_by(domain, survey_label) %>% 
  dplyr::summarize(
    mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
    mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
domain_summary$se_dim_1 <- sqrt(domain_summary$var_dim_1/domain_summary$n)
domain_summary$se_dim_2 <- sqrt(domain_summary$var_dim_2/domain_summary$n)
domain_summary$domain <- factor(domain_summary$domain, levels = c("Natural science","Physical science",
                                                                  "Information science","Social science","Other"))

##################################################
#              Create DOMAIN plots               #
##################################################
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
<<<<<<< HEAD:scripts/publication_plots.R
                     theme_minimal() + 
                     theme(
                           legend.position = "none", 
                           plot.title = element_text(hjust = 0.5), 
                           aspect.ratio = 3/4
                          )

domain_plot_dim_1


=======
                     theme_minimal() + left_plot_theme
# domain_plot_dim_1
>>>>>>> 5d639ecdaad0780864fc7032417bfd86d70688c9:scripts/archive/publication_plots.R

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
<<<<<<< HEAD:scripts/publication_plots.R
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



=======
                     theme_minimal() + right_plot_theme
# domain_plot_dim_2

domain_grid_plot <- ( domain_plot_dim_1 | domain_plot_dim_2 )
ggexport(plotlist = list(domain_grid_plot), filename = "plots/domain_survey.png",height=650,width=800)

#domain_grid_plot <- grid.arrange(
#                                    domain_plot_dim_1, 
#                                    domain_plot_dim_2, 
#                                    nrow = 1, 
#                                    top=textGrob(
#                                      "By Domain and Survey\n",
#                                      gp=gpar(fontsize=20,font=3)
#                                    )
#                                  )

##################################################
#      Clean WORK SECTOR data for plotting       #
##################################################
>>>>>>> 5d639ecdaad0780864fc7032417bfd86d70688c9:scripts/archive/publication_plots.R
no_work_sector_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$work_sector)), ]

work_sector_summary <- no_work_sector_na %>% 
  dplyr::group_by(work_sector, survey_label) %>% 
  dplyr::summarize(
    mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
    mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
work_sector_summary$se_dim_1 <- sqrt(work_sector_summary$var_dim_1/work_sector_summary$n)
work_sector_summary$se_dim_2 <- sqrt(work_sector_summary$var_dim_2/work_sector_summary$n)
work_sector_summary$work_sector <- factor(work_sector_summary$work_sector, 
                                          levels = c("Academic", "Commercial", "Government", "Non-Profit", "Other"))

##################################################
#           Create WORK SECTOR plots             #
##################################################
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
                          theme_minimal() + left_plot_theme
#work_sector_plot_dim_1

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
                          labs(x = "Survey", y = "Satisfaction with Resources", color="Work Sector") +
                          ggtitle("Satisfaction with Resources") + 
                          scale_color_brewer(palette = "Dark2") + 
<<<<<<< HEAD:scripts/publication_plots.R
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



=======
                          theme_minimal() + right_plot_theme + theme(legend.position = c(.76, .80))
#work_sector_plot_dim_2

work_sector_grid_plot <- ( work_sector_plot_dim_1 | work_sector_plot_dim_2 )
ggexport(plotlist = list(work_sector_grid_plot), filename = "plots/work_sector_survey.png",height=650,width=800)

#work_sector_grid_plot <- grid.arrange(
#                                        work_sector_plot_dim_1, 
#                                        work_sector_plot_dim_2, 
#                                        nrow = 1, 
#                                        top=textGrob(
#                                          "By Work Sector and Survey\n",
#                                          gp=gpar(fontsize=20,font=3)
#                                        )
#                                      )

##################################################
#     Clean FUNDING AGENCY data for plotting     #
##################################################
>>>>>>> 5d639ecdaad0780864fc7032417bfd86d70688c9:scripts/archive/publication_plots.R
no_funding_agency_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$funding_agency_recoded)), ]

funding_agency_summary <- no_funding_agency_na %>% 
  dplyr::group_by(funding_agency_recoded, survey_label) %>% 
  dplyr::summarize(
    mean_dim_1 = mean(dim_1), var_dim_1 = var(dim_1), n = length(dim_1) ,
    mean_dim_2 = mean(dim_2), var_dim_2 = var(dim_2) )
funding_agency_summary$se_dim_1 <- sqrt(funding_agency_summary$var_dim_1/funding_agency_summary$n)
funding_agency_summary$se_dim_2 <- sqrt(funding_agency_summary$var_dim_2/funding_agency_summary$n)
names(funding_agency_summary)[names(funding_agency_summary) == "funding_agency_recoded"] <- "funding_agency"
funding_agency_summary$funding_agency <- factor(funding_agency_summary$funding_agency, 
                                         levels = c("Academic institution","Corporation",                    
                                                    "Federal/national gov.",                          
                                                    "Private foundation","Self supported",                 
                                                    "State/regional/local gov.","Other"))

##################################################
#          Create FUNDING AGENCY plots           #
##################################################
funding_agency_plot_dim_1 <- ggplot(
                                      funding_agency_summary, 
                                      aes(
                                            x = survey_label, 
                                            y = mean_dim_1, 
                                            group = funding_agency, 
                                            color = funding_agency
                                          )
                                    ) +
                             geom_point(size = 4, aes(color = funding_agency), position = dodge) + 
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
                             theme_minimal() + left_plot_theme
# funding_agency_plot_dim_1

funding_agency_plot_dim_2 <- ggplot(
                                      funding_agency_summary, 
                                      aes(
                                            x = survey_label, 
                                            y = mean_dim_2, 
                                            group = funding_agency, 
                                            color = funding_agency
                                          )
                                    ) +
                             geom_point(size = 4, aes(color = funding_agency), position = dodge) + 
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
                             labs(x = "Survey", y = "Satisfaction with Resources", color="Funding Agency") +
                             ggtitle("Satisfaction with Resources") + 
                             scale_color_brewer(palette = "Dark2")  + 
<<<<<<< HEAD:scripts/publication_plots.R
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
=======
                             theme_minimal() + right_plot_theme + theme(legend.position = c(.76, .80))
#funding_agency_plot_dim_2

funding_agency_grid_plot <- ( funding_agency_plot_dim_1 | funding_agency_plot_dim_2 )
ggexport(plotlist = list(funding_agency_grid_plot), filename = "plots/funding_agency_survey.png",height=650,width=800)

#funding_agency_grid_plot <- grid.arrange(
#                                            funding_agency_plot_dim_1, 
#                                            funding_agency_plot_dim_2, 
#                                            nrow = 1, 
#                                            top=textGrob(
#                                              "By Funding Agency and Survey\n",
#                                              gp=gpar(fontsize=20,font=3)
#                                            )
#                                          )
>>>>>>> 5d639ecdaad0780864fc7032417bfd86d70688c9:scripts/archive/publication_plots.R
