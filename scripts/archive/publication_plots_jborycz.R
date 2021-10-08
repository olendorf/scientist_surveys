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
surveys_combined_demos[which(surveys_combined_demos$survey_label == "S3"), ]$survey_label <- "2019"
surveys_combined_demos$survey_label <- ordered(surveys_combined_demos$survey_label, levels = c("2011", "2015", "2019"))

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
ggexport(plotlist = list(region_grid_plot), filename = "plots/region_survey.png", height=650,width=900)

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
ggexport(plotlist = list(domain_grid_plot), filename = "plots/domain_survey.png",height=650,width=900)

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
ggexport(plotlist = list(work_sector_grid_plot), filename = "plots/work_sector_survey.png",height=650,width=900)

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
ggexport(plotlist = list(funding_agency_grid_plot), filename = "plots/funding_agency_survey.png",height=650,width=900)

##################################################
#            DIM1 vs DIM2 by domain              #
##################################################
reg1 <- lm(region_summary$mean_dim_1 ~ region_summary$mean_dim_2)
reg1 <- lm(region_summary$mean_dim_1 ~ region_summary$mean_dim_2,weights=region_summary$n)
summary(reg1)
with(region_summary, plot(mean_dim_1, mean_dim_2))
abline(reg1)
summary(lm(domain_summary$mean_dim_1 ~ domain_summary$mean_dim_2))
summary(lm(work_sector_summary$mean_dim_1 ~ work_sector_summary$mean_dim_2))
summary(lm(funding_agency_summary$mean_dim_1 ~ funding_agency_summary$mean_dim_2))

theme_avg <- theme(plot.title = element_text(face="bold",size=24),
                   legend.position = "bottom",
                   legend.title = element_text(size=12),
                   legend.text=element_text(size=12),
                   legend.key.size = unit(0.5, "cm"),
                   axis.text.x = element_text(color="black",size=12, angle=0),
                   axis.title.x = element_text(color="black",size=16, angle=0),
                   axis.text.y = element_text(color="black",size=12, angle=0),
                   axis.title.y = element_text(color="black",size=16, angle=90))
avg_dim1_2_region <- ggplot() +
#  geom_point(region_summary,mapping=aes(x = mean_dim_1, y = mean_dim_2, 
#                                              color = region)) +
  geom_smooth(region_summary, method="lm", formula=y ~ x,
              mapping=aes(x = mean_dim_1, y = mean_dim_2,weight=n)) +
  stat_poly_eq(region_summary, mapping=aes(x = mean_dim_1, y = mean_dim_2, weight=n, label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "right", label.y.npc = 0.95,
               formula = y  ~x, parse = TRUE, size = 8,color="red") + 
  geom_text(region_summary,mapping=aes(x = mean_dim_1, y = mean_dim_2, 
                                                  label=survey_label),color="black",size=4) +
  geom_ellipse(region_summary,mapping=aes(x0 = mean_dim_1, y0 = mean_dim_2, a = se_dim_1, 
                                         b = se_dim_2, angle = 0,
                                         fill=paste(region),color=paste(region)),alpha=0.50) +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="PC1", 
       y="PC2",color="Region",fill="Region",
       size="",caption="") + theme_avg
ggexport(plotlist = list(avg_dim1_2_region),
         filename = "plots/dim1_dim2_weighted.png",height=700,width=700)

##################################################
#            DIM1 vs DIM2 by domain              #
##################################################
theme_regression <- theme(plot.title = element_text(face="bold",size=24),
                     legend.position = "none",
                     legend.key.size = unit(0.5, "cm"),
                     legend.title = element_blank(),
                     legend.text=element_text(size=6),
                     strip.text = element_text(color="black",size=14, angle=0),
                     axis.text.x = element_text(color="black",size=14, angle=0),
                     axis.title.x = element_text(face="bold",color="black",size=16, angle=0),
                     axis.text.y = element_text(color="black",size=14, angle=0),
                     axis.title.y = element_text(face="bold",color="black",size=16, angle=90))


my.formula <- y ~ x
region_dim1_2_reg <- ggplot(na.omit(subset(surveys_combined_demos)),
                                 mapping=aes(x = dim_1, y = dim_2,color = region)) +
  geom_point() +
  facet_wrap(~ region,nrow=2) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 9, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share", 
       y="Satisfaction with resources",fill="Region",caption="") + theme_regression

my.formula <- y ~ x
domain_dim1_2_reg <- ggplot(na.omit(subset(surveys_combined_demos,domain!="Other")),
                            mapping=aes(x = dim_1, y = dim_2,color = domain)) +
  geom_point() +
  facet_wrap(~ domain,nrow=2) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 9, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share", 
       y="Satisfaction with resources",fill="Domain",caption="") + theme_regression

my.formula <- y ~ x
work_sector_dim1_2_reg <- ggplot(na.omit(subset(surveys_combined_demos,work_sector!="Other")),
                            mapping=aes(x = dim_1, y = dim_2,color = work_sector)) +
  geom_point() +
  facet_wrap(~ work_sector,nrow=2) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 9, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share", 
       y="Satisfaction with resources",fill="Work sector",caption="") + theme_regression

my.formula <- y ~ x
funding_agency_dim1_2_reg <- ggplot(na.omit(subset(surveys_combined_demos,funding_agency_recoded!="Other")),
                                 mapping=aes(x = dim_1, y = dim_2,color = funding_agency_recoded)) +
  geom_point() +
  facet_wrap(~ funding_agency_recoded,nrow=2) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 9, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Willingness to share", 
       y="Satisfaction with resources",fill="Funding agency",caption="") + theme_regression

ggexport(plotlist = list(region_dim1_2_reg,domain_dim1_2_reg,
                         work_sector_dim1_2_reg,funding_agency_dim1_2_reg),
         filename = "plots/dim1_2_regs.png",height=650,width=900)

##################################################
#            Demographics by survey              #
##################################################
my.formula <- y ~ x
USACanada_dim1_2_survey <- ggplot(na.omit(subset(surveys_combined_demos,region=="USACanada")),
                                  mapping=aes(x = dim_1, y = dim_2,color = survey_label)) +
  geom_point() +
  facet_wrap(~ survey_label,nrow=1) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 6, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="Region = USACanada", x="Willingness to share", 
       y="Satisfaction with resources",fill="Region",caption="") + theme_regression

my.formula <- y ~ x
Academic_dim1_2_survey <- ggplot(na.omit(subset(surveys_combined_demos,work_sector=="Academic")),
                                  mapping=aes(x = dim_1, y = dim_2,color = survey_label)) +
  geom_point() +
  facet_wrap(~ survey_label,nrow=1) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 9, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="Work sector = Academic", x="Willingness to share", 
       y="Satisfaction with resources",fill="Academic",caption="") + theme_regression

my.formula <- y ~ x
Government_dim1_2_survey <- ggplot(na.omit(subset(surveys_combined_demos,work_sector=="Government")),
                                 mapping=aes(x = dim_1, y = dim_2,color = survey_label)) +
  geom_point() +
  facet_wrap(~ survey_label,nrow=1) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 5, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="Work sector = Government", x="Willingness to share", 
       y="Satisfaction with resources",fill="Government",caption="") + theme_regression

my.formula <- y ~ x
Physical_science_dim1_2_survey <- ggplot(na.omit(subset(surveys_combined_demos,domain=="Physical science")),
                                 mapping=aes(x = dim_1, y = dim_2,color = survey_label)) +
  geom_point() +
  facet_wrap(~ survey_label,nrow=1) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 9, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="Domain = Physical science", x="Willingness to share", 
       y="Satisfaction with resources",fill="Physical science",caption="") + theme_regression

my.formula <- y ~ x
Funding_agency_dim1_2_survey <- ggplot(na.omit(subset(surveys_combined_demos,funding_agency_recoded=="Federal/national gov.")),
                                         mapping=aes(x = dim_1, y = dim_2,color = survey_label)) +
  geom_point() +
  facet_wrap(~ survey_label,nrow=1) + 
  geom_smooth(method="lm",color = "black") + 
  stat_poly_eq(aes(label = paste("atop(", ..eq.label..,",",..rr.label..,")",sep = "")), 
               label.x.npc = "left", label.y.npc = 0.99,
               formula = my.formula, parse = TRUE, size = 6,color="red") + 
  stat_fit_glance(method.args = list(formula = my.formula),
                  geom = 'text', aes(label = paste("P-value = ",signif(..p.value.., digits = 3), 
                                                   sep = "")),label.x = -1.9,
                  label.y = 9, color="red",size = 6) + 
  geom_vline(xintercept=0, linetype="dashed", color = "black") +
  geom_hline(yintercept=0, linetype="dashed", color = "black") +
  scale_x_continuous() + scale_y_continuous() + theme_classic() +
  labs(title="Funding agency = Federal national/gov.", x="Willingness to share", 
       y="Satisfaction with resources",fill="Federal national/gov.",caption="") + theme_regression

ggexport(plotlist = list(USACanada_dim1_2_survey,Academic_dim1_2_survey,Government_dim1_2_survey,
                         Physical_science_dim1_2_survey,Funding_agency_dim1_2_survey), filename = "plots/dim1_2_survey_regs.png",height=400,width=900)

##################################################
#    Group boxplot of domain and work_sector     #
##################################################
scd <- subset(subset(surveys_combined_demos,work_sector!="Other" & domain!="Other"),
              select=c(domain,work_sector,dim_1,dim_2))

theme_boxplot <- theme(plot.title = element_text(face="bold",size=24),
                       legend.position = "right",
                       legend.key.size = unit(1, "cm"),
                       legend.title = element_blank(),
                       legend.text=element_text(size=14),
                       strip.text = element_text(color="black",size=14, angle=0),
                       axis.text.x = element_text(color="black",size=14, angle=0),
                       axis.title.x = element_text(face="bold",color="black",size=16, angle=0),
                       axis.text.y = element_text(color="black",size=14, angle=0),
                       axis.title.y = element_text(face="bold",color="black",size=16, angle=90))

dim1_domain_work_sector_boxplot <- ggplot(na.omit(scd),mapping=aes(x = domain, y = dim_1,fill=work_sector)) +
  geom_boxplot() +
  scale_x_discrete() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Domain", 
       y="Willingness to share",fill="Work sector",caption="") + theme_boxplot

dim2_domain_work_sector_boxplot <- ggplot(na.omit(scd),mapping=aes(x = domain, y = dim_2,fill=work_sector)) +
  geom_boxplot() +
  scale_x_discrete() + scale_y_continuous() + theme_classic() +
  labs(title="", x="Domain", 
       y="Satisfaction with resources",fill="Work sector",caption="") + theme_boxplot

ggexport(plotlist = list(dim1_domain_work_sector_boxplot,dim2_domain_work_sector_boxplot),
         filename = "plots/domain_work_sector_boxplot.png",height=650,width=900)

