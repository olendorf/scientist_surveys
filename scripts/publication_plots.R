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
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S1"), ]$survey_label <- "2011"
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S2"), ]$survey_label <- "2015"
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S3"), ]$survey_label <- "2020"
surveys_combined_demos$survey_label <- ordered(surveys_combined_demos$survey_label, levels = c("2011", "2015", "2020"))

##################################################
#        Create left and right plot themes       #
##################################################
left_plot_theme <- theme(legend.position = "none", 
                         plot.tag.position = c(.05, .95),
                         plot.title = element_text(face="bold",size=24,hjust = 0.5),
                         plot.tag = element_text(face="bold",size=24,hjust = 0.5),
                         axis.ticks = element_line(size = 1, colour = "black", linetype=1),
                         axis.text.x = element_text(color="black",size=16, angle=0),
                         axis.title.x = element_blank(),
                         axis.line.y = element_line(size = 1, colour = "black", linetype=1),
                         axis.text.y = element_text(color="black",size=16, angle=0),
                         axis.title.y = element_text(face="bold",color="black",size=16, angle=90))

right_plot_theme <- theme(legend.position = c(.7, .18), 
                          plot.tag.position = c(.05, .95),
                          plot.title = element_text(face="bold",size=24,hjust = 0.5),
                          plot.tag = element_text(face="bold",size=24,hjust = 0.5),
                          legend.key.size = unit(0.5, "cm"),
                          legend.title = element_text(face="bold",size=16),
                          legend.text=element_text(size=20),
                          axis.ticks = element_line(size = 1, colour = "black", linetype=1),
                          axis.text.x = element_text(color="black",size=16, angle=0),
                          axis.title.x = element_blank(),
                          axis.line.y = element_line(size = 1, colour = "black", linetype=1),
                          axis.text.y = element_text(color="black",size=16, angle=0),
                          axis.title.y = element_text(face="bold",color="black",size=16, angle=90))

##################################################
#         Clean REGION data for plotting         #
##################################################
no_region_na <- surveys_combined_demos[which(!is.na(surveys_combined_demos$region)), ]

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
                     geom_point(size = 6, aes(color = region, shape=region), position = dodge) + 
                     geom_line(size = 1, linetype = "dashed", position = dodge) +
                     geom_hline(yintercept=0, color = "black", size=1) +
                     geom_errorbar(
                                     aes(
                                          ymin = mean_dim_1 - se_dim_1, 
                                          ymax = mean_dim_1 + se_dim_1), 
                                     size = 1, 
                                     width = 0.2, 
                                     position = dodge
                                   ) + 
                     labs(y = "Willingness to Share (mean ± standard error)",tag = "A") +
#                     ggtitle("Changes in region by survey") + 
                     scale_y_continuous(breaks=seq(-2,2,1)) +
                     ylim(-2, 2) + 
                     scale_color_manual(labels = c("Africa & Middle East","Asia & Southeast Asia",
                                                   "Australia & New Zealand","Europe & Russia",
                                                   "Latin America","USA & Canada"),
                                        values = c("#67001F","#67001F","#67001F",
                                                   "#67001F","#67001F","#67001F"), guide="legend") +
                     scale_shape_discrete(labels = c("Africa & Middle East","Asia & Southeast Asia",
                                                     "Australia & New Zealand","Europe & Russia",
                                                     "Latin America","USA & Canada"), guide="legend") +
                     theme_minimal() + left_plot_theme

region_plot_dim_2 <- ggplot(
                              region_summary, 
                              aes(
                                    x = survey_label, 
                                    y = mean_dim_2, 
                                    group = region, 
                                    color = region
                                  )
                              ) +
                     geom_point(size = 6, aes(color = region, shape=region), position = dodge) + 
                     geom_line(size = 1, linetype = "dashed", position = dodge) +
                     geom_hline(yintercept=0, color = "black", size=1) + 
                     geom_errorbar(
                                    aes(
                                          ymin = mean_dim_2 - se_dim_2, 
                                          ymax = mean_dim_2 + se_dim_2
                                        ), 
                                    size = 1, 
                                    width = 0.2,
                                    position = dodge
                                  ) + 
                     labs(y = "Satisfaction with Resources (mean ± standard error)", tag="B", color="Region", shape="Region") +
                     ggtitle("") + 
                     scale_y_continuous(breaks=seq(-2,2,1)) +
                     ylim(-2, 2) + 
                     scale_color_manual(labels = c("Africa & Middle East","Asia & Southeast Asia",
                                                   "Australia & New Zealand","Europe & Russia",
                                                  "Latin America","USA & Canada"),
                                        values = c("#67001F","#67001F","#67001F",
                                                   "#67001F","#67001F","#67001F"), guide="legend") +
                     scale_shape_discrete(labels = c("Africa & Middle East","Asia & Southeast Asia",
                                                     "Australia & New Zealand","Europe & Russia",
                                                     "Latin America","USA & Canada"), guide="legend") +
                     theme_minimal() + right_plot_theme + theme(legend.position = c(.65, .14)) 
#region_plot_dim_2
region_grid_plot <- ( region_plot_dim_1 | region_plot_dim_2 ) + 
  plot_annotation(caption = 'Survey Publication Year',
                  theme = theme(plot.caption=element_text(face="bold",color="black",size=20, angle=0,hjust = 0.5)))
ggsave("plots/region_survey.pdf", plot = region_grid_plot, scale = 1,width = 16,height = 10, dpi = 300,limitsize = TRUE)

##################################################
#        Clean DOMAIN data for plotting          #
##################################################
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
                     geom_point(size = 6, aes(color = domain,shape=domain), position = dodge) + 
                     geom_line(size = 1, linetype = "dashed", position = dodge) +
                     geom_hline(yintercept=0, color = "black", size=1) + 
                     geom_errorbar(
                                      aes(
                                            ymin = mean_dim_1 - se_dim_1, 
                                            ymax = mean_dim_1 + se_dim_1
                                          ), 
                                      size = 1, 
                                      width = 0.2, 
                                      position = dodge
                                    ) + 
                     ylim(-2, 2) + 
                     labs(x = "Survey", y = "Willingness to Share (mean ± standard error)",tag="A",color="Domain",shape="Domain") +
 #                    ggtitle("Changes in domain by survey") + 
                     scale_color_manual(values = c("#67001F","#67001F","#67001F",
                                                   "#67001F","#67001F"), guide="legend") +
                     scale_shape_discrete(guide="legend") +
                     theme_minimal() + left_plot_theme
# domain_plot_dim_1

domain_plot_dim_2 <- ggplot(
                              domain_summary, 
                              aes(
                                    x = survey_label, 
                                    y = mean_dim_2, 
                                    group = domain, 
                                    color = domain
                                  )
                            ) + 
                     geom_point(size = 6, aes(color = domain,shape=domain), position = dodge) + 
                     geom_line(size = 1, linetype = "dashed", position = dodge) +
                     geom_hline(yintercept=0, color = "black", size=1) + 
                     geom_errorbar(
                                      aes(
                                            ymin = mean_dim_2 - se_dim_2, 
                                            ymax = mean_dim_2 + se_dim_2), 
                                      size = 1, 
                                      width = 0.2, 
                                      position = dodge) + 
                     ylim(-2, 2) + 
                     labs(x = "Survey", y = "Satisfaction with Resources (mean ± standard error)",tag="B",color="Domain",shape="Domain") +
                     ggtitle("") + 
                     scale_color_manual(values = c("#67001F","#67001F","#67001F",
                                                   "#67001F","#67001F"), guide="legend") +
                     scale_shape_discrete(guide="legend") +
                     theme_minimal() + right_plot_theme
# domain_plot_dim_2

domain_grid_plot <- ( domain_plot_dim_1 | domain_plot_dim_2 ) + 
  plot_annotation(caption = 'Survey Publication Year',
                  theme = theme(plot.caption=element_text(face="bold",color="black",size=20, angle=0,hjust = 0.5)))
ggsave("plots/domain_survey.pdf", plot = domain_grid_plot, scale = 1,width = 16,height = 10, dpi = 300,limitsize = TRUE)

##################################################
#      Clean WORK SECTOR data for plotting       #
##################################################
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
                          geom_point(size = 6, aes(color = work_sector,shape=work_sector), position = dodge) + 
                          geom_line(size = 1, linetype = "dashed", position = dodge) +
                          geom_hline(yintercept=0, color = "black", size=1) + 
                          geom_errorbar(
                                          aes(
                                                ymin = mean_dim_1 - se_dim_1, 
                                                ymax = mean_dim_1 + se_dim_1), 
                                                size = 1, 
                                                width = 0.2,
                                                position = dodge) + 
                          ylim(-2, 2) +
                          labs(x = "Survey", y = "Willingness to Share (mean ± standard error)",tag="A",color="Work Sector",shape="Work Sector") +
#                          ggtitle("Changes in work sector by survey") + 
                          scale_color_manual(values = c("#67001F","#67001F","#67001F",
                                                        "#67001F","#67001F"), guide="legend") +
                          scale_shape_discrete(guide="legend") +
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
                          geom_point(size = 6, aes(color = work_sector, shape=work_sector), position = dodge) + 
                          geom_line(size = 1, linetype = "dashed", position = dodge) +
                          geom_hline(yintercept=0, color = "black", size=1) + 
                          geom_errorbar(
                                          aes(
                                                ymin = mean_dim_2 - se_dim_2, 
                                                ymax = mean_dim_2 + se_dim_2
                                              ), 
                                          size = 1, 
                                          width = 0.2, 
                                          position = dodge) + 
                          coord_cartesian(ylim=c(-2, 2)) +
                          labs(x = "Survey", y = "Satisfaction with Resources (mean ± standard error)",tag="B",color="Work Sector",shape="Work Sector") +
                          ggtitle("") + 
                          scale_color_manual(values = c("#67001F","#67001F","#67001F",
                                                        "#67001F","#67001F"), guide="legend") +
                          scale_shape_discrete(guide="legend") +
                          theme_minimal() + right_plot_theme #+ theme(legend.position = c(.76, .80))
#work_sector_plot_dim_2

work_sector_grid_plot <- ( work_sector_plot_dim_1 | work_sector_plot_dim_2 ) + 
  plot_annotation(caption = 'Survey Publication Year',
                  theme = theme(plot.caption=element_text(face="bold",color="black",size=20, angle=0,hjust = 0.5)))
ggsave("plots/work_sector_survey.pdf", plot = work_sector_grid_plot, scale = 1,width = 16,height = 10,dpi = 300,limitsize = TRUE)

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
                                         levels = c("Corporation",                    
                                                    "Federal/national gov.",                          
                                                    "Private foundation",                 
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
                             geom_point(size = 6, aes(color = funding_agency,shape=funding_agency), position = dodge) + 
                             geom_line(size = 1, linetype = "dashed", position = dodge) +
                             geom_hline(yintercept=0, color = "black", size=1) + 
                             geom_errorbar(
                                              aes(
                                                    ymin = mean_dim_1 - se_dim_1, 
                                                    ymax = mean_dim_1 + se_dim_1
                                                  ), 
                                              size = 1, 
                                              width = 0.2,
                                              position = dodge) + 
                             ylim(-2, 2) +
                             labs(x = "Survey", y = "Willingness to Share (mean ± standard error)",tag="A", color="Funding Agency",shape="Funding Agency") +
#                             ggtitle("Changes in funding agency by survey") + 
                             scale_color_manual(labels = c("Corporation",                    
                                                           "Federal & national government",                          
                                                           "Private foundation",                 
                                                           "State, regional & local government","Other"),
                                                values = c("#67001F","#67001F","#67001F",
                                                           "#67001F","#67001F"), guide="legend") +
                             scale_shape_discrete(labels = c("Corporation",                    
                                                             "Federal & national government",                          
                                                             "Private foundation",                 
                                                             "State, regional & local government","Other"), guide="legend") +
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
                             geom_point(size = 6, aes(color = funding_agency,shape=funding_agency), position = dodge) + 
                             geom_line(size = 1, linetype = "dashed", position = dodge) +
                             geom_hline(yintercept=0, color = "black", size=1) + 
                             geom_errorbar(
                                              aes(
                                                    ymin = mean_dim_2 - se_dim_2, 
                                                    ymax = mean_dim_2 + se_dim_2
                                                  ), 
                                              size = 1, 
                                              width = 0.2,
                                              position = dodge
                                          ) +  
                             ylim(-2, 2) +
                             labs(x = "Survey", y = "Satisfaction with Resources (mean ± standard error)",tag="B", color="Funding Agency",shape="Funding Agency") +
                             ggtitle("") + 
                             scale_color_manual(labels = c("Corporation",                    
                                                           "Federal & national government",                          
                                                           "Private foundation",                 
                                                           "State, regional & local government","Other"),
                                                values = c("#67001F","#67001F","#67001F",
                                                           "#67001F","#67001F"), guide="legend") +
                             scale_shape_discrete(labels = c("Corporation",                    
                                                             "Federal & national government",                          
                                                             "Private foundation",                 
                                                             "State, regional & local government","Other"), guide="legend") +
                             theme_minimal() + right_plot_theme + theme(legend.position = c(.57, .14))
#funding_agency_plot_dim_2
funding_agency_grid_plot <- ( funding_agency_plot_dim_1 | funding_agency_plot_dim_2 ) + 
  plot_annotation(caption = 'Survey Publication Year',
                  theme = theme(plot.caption=element_text(face="bold",color="black",size=20, angle=0,hjust = 0.5)))
ggsave("plots/funding_agency_survey.pdf", plot = funding_agency_grid_plot, scale = 1,width = 16,height = 10,dpi = 300,limitsize = TRUE)