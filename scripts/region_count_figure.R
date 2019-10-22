survey_one_region_counts <- count(survey_one[which(!is.na(survey_one$region)),], "region")
survey_two_region_counts <- count(survey_two[which(!is.na(survey_two$region)),], "region")
survey_three_region_counts <- count(survey_three[which(!is.na(survey_three$region)),], "region")

survey_one_region_counts$survey = 1
survey_two_region_counts$survey = 2
survey_three_region_counts$survey = 3
region_counts <- rbind(rbind(survey_one_region_counts, survey_two_region_counts), survey_three_region_counts)



region_plot <- ggplot(region_counts, aes(survey, freq, fill = region))
region_plot <- region_plot + geom_bar(position = "fill", stat = "identity")
region_plot <- region_plot + theme_bw() + scale_fill_brewer(palette="Set2")
region_plot <- region_plot + theme(panel.grid.major = element_blank(), 
                                   panel.grid.minor = element_blank(), 
                                   panel.border = element_blank())
region_plot <- region_plot + coord_flip()
region_plot <- region_plot + xlab("Survey") + ylab("Frequency")

# Print the figure generated above
png("figures/region_plot_set2.png")
print(region_plot)
dev.off()

region_plot <- ggplot(region_counts, aes(survey, freq, fill = region))
region_plot <- region_plot + geom_bar(position = "fill", stat = "identity")
region_plot <- region_plot + theme_bw() + scale_fill_brewer(palette="Reds")
region_plot <- region_plot + theme(panel.grid.major = element_blank(), 
                                   panel.grid.minor = element_blank(), 
                                   panel.border = element_blank())
region_plot <- region_plot + coord_flip()
region_plot <- region_plot + xlab("Survey") + ylab("Frequency")

# Print the figure generated above
png("figures/region_plot_reds.png")
print(region_plot)
dev.off()

region_plot <- ggplot(region_counts, aes(survey, freq, fill = region))
region_plot <- region_plot + geom_bar(position = "fill", stat = "identity")
region_plot <- region_plot + theme_bw() + scale_fill_brewer(palette="YlGnBu")
region_plot <- region_plot + theme(panel.grid.major = element_blank(), 
                                   panel.grid.minor = element_blank(), 
                                   panel.border = element_blank())
region_plot <- region_plot + coord_flip()
region_plot <- region_plot + xlab("Survey") + ylab("Frequency")

# Print the figure generated above
png("figures/region_plot_ylgnbu.png")
print(region_plot)
dev.off()

