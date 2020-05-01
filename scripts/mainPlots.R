# Extract row results
eig.val <- get_eigenvalue(surveys_combined.mfa)
ind.mfa <- get_mfa_ind(surveys_combined.mfa)
var.mfa <- get_mfa_var(surveys_combined.mfa, "group")

# print all contribs
# var.mfa$contrib

# Summary
# summary(survey_two.mfa)

### Screeplot
eig.val <- get_eigenvalue(surveys_combined.mfa)
if_random <- 100/(ncol(surveys_combined)-1)
scree_plot <- fviz_screeplot(surveys_combined.mfa, addlabels = TRUE, ylim = c(0, 10)) + 
  geom_hline(yintercept=if_random, linetype=2, color="red")
scree_plot

### Barplots and biplots of individuals
# Individual biplots
ind.mfa_plot <- fviz_mfa_ind(surveys_combined.mfa, 
                             choice="quali.var",
                             habillage = as.factor(surveys_combined_demos$region), 
                             #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                             addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                             geom = c("point")) 
#  theme(legend.position = "none")
ind.mfa_plot.surveys <- fviz_mfa_ind(surveys_combined.mfa, 
                                     choice="quali.var",
                                     habillage = as.factor(surveys_combined_demos$survey_label), 
                                     #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                     addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                     geom = c("point")) 
ind.mfa_plot.domains <- fviz_mfa_ind(surveys_combined.mfa, 
                                     choice="quali.var",
                                     habillage = as.factor(surveys_combined_demos$domain), 
                                     #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                     addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                     geom = c("point")) 

# Variables
var.mfa_plot <- fviz_mfa_var(surveys_combined.mfa,choice="quali.var",
                             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                             col.var.sup = "violet", geom = c("point","text"), repel = TRUE)
var.mfa_plot.group <- fviz_mfa_var(surveys_combined.mfa, col.var = "cos2",
                                   gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                                   col.var.sup = "violet", repel = TRUE, "group")

# Barplots of contributions
contribs <- data.frame(var.mfa$contrib)
contrib_plot_dim1 <- fviz_contrib(surveys_combined.mfa,choice="quali.var", axes = 1, top=30)
contrib_plot_dim1_unsorted <- fviz_contrib(surveys_combined.mfa,choice="quali.var", sort.val = ("none"), axes = 1)
contrib_plot_dim1_group <- fviz_contrib(surveys_combined.mfa, "group", axes = 1, top=30)
contrib_plot_dim2 <- fviz_contrib(surveys_combined.mfa,choice="quali.var", axes = 2, top=30)
contrib_plot_dim2_group <- fviz_contrib(surveys_combined.mfa, "group", axes = 2, top=30)

# Export all plots to pdf
ggexport(plotlist = list(scree_plot, ind.mfa_plot.surveys, ind.mfa_plot.domains, 
                         ind.mfa_plot,var.mfa_plot.group, contrib_plot_dim1,
                         contrib_plot_dim1_group, contrib_plot_dim2, 
                         contrib_plot_dim2_group), filename = "./plots/mfa_surveys_combined_plots.pdf")