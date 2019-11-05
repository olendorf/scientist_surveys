survey_one_domain_counts <- count(survey_one[which(!is.na(survey_one$domain_name)), ]$domain_name)
survey_two_domain_counts <- count(survey_two[which(!is.na(survey_two$domain_name)), ]$domain_name)
survey_three_domain_counts <- count(survey_three[which(!is.na(survey_three$domain_name)), ]$domain_name)

survey_one_domain_counts$survey <- 1
survey_two_domain_counts$survey <- 2
survey_three_domain_counts$survey <- 3

domain_counts <- rbind(survey_one_domain_counts, survey_two_domain_counts, survey_three_domain_counts)


domain_plot <- ggplot(domain_counts, aes(Survey, Frequency, fill=Domain))
domain_plot <- domain_plot + geom_bar(stat = "identity", position = "fill" )
domain_plot <- domain_plot + theme_bw()
domain_plot <- domain_plot + theme(panel.grid.major = element_blank(),
                    panel.grid.minor = element_blank(),
                    panel.border = element_blank(),
                    panel.background = element_blank())
domain_plot <- domain_plot + coord_flip()
# domain_plot + xlab("Survey") + ylab("Frequency")

png("figures/domain_plot_all.png")
print(domain_plot)
dev.off()






