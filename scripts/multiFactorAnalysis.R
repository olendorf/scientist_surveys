# Perform Multiple Factpr Analysis (MFA)
surveys_combined.mfa <- MFA(surveys_combined,
                            group = c(1,1,1,1,1,1,1,1,1,1,
                                      1,1,1,1,1,1,1,1,1,1,
                                      1,1,1,1,1,1,1,1,1,1,
                                      1,1,1,1,1,1,1,1),
                            name.group = c("16_12_09",
                                           "06_16_13_1","06_16_13_2","06_16_13_3","06_16_13_4","06_16_13_5","06_16_13_6","06_16_13_7",
                                           "07_17_14_1","07_17_14_2","07_17_14_3",
                                           "08_20_16_1","08_20_16_2",
                                           "08_22_18",
                                           "09_31_20_1","09_31_20_2","09_31_20_3","09_31_20_4","09_31_20_5",
                                           "10_32_19_1","10_32_19_2","10_32_19_3","10_32_19_4","10_32_19_5","10_32_19_6","10_32_19_7","10_32_19_8",
                                           "11_19_15_1","11_19_15_2","11_19_15_3","11_19_15_4","11_19_15_5","11_19_15_6","11_19_15_7","11_19_15_8",
                                           "11_19_15_9","11_19_15_10","11_19_15_11"),
                            type = c("n","n","n","n","n","n","n","n","n","n",
                                     "n","n","n","n","n","n","n","n","n","n",
                                     "n","n","n","n","n","n","n","n","n","n",
                                     "n","n","n","n","n","n","n","n"), graph = FALSE)

# Extract and write results for variables to CSV
# Dim.1
var.coord <- data.frame(surveys_combined.mfa$group$coord)
  colnames(var.coord) <- c("coord.1","coord.2","coord.3","coord.4","coord.5")
var.contrib <- data.frame(surveys_combined.mfa$group$contrib)
  colnames(var.contrib) <- c("contrib.1","contrib.2","contrib.3","contrib.4","contrib.5")
name <- rownames(var.coord)
var.sum <- cbind(name,var.coord,var.contrib)
dim1_var <-subset(var.sum, name=="10_32_19_2" | name=="11_19_15_11"| name=="11_19_15_11"|name=="11_19_15_5"|
                    name=="11_19_15_10"| name=="10_32_19_6"|name=="11_19_15_1"|name=="10_32_19_3"| 
                    name=="11_19_15_9"| name=="11_19_15_8"|name=="11_19_15_6"|name=="11_19_15_4"|
                    name=="11_19_15_7"| name=="10_32_19_4"|name=="10_32_19_1"|name=="10_32_19_8")
dim1_var <- subset(dim1_var,select=c(name,coord.1,contrib.1))

# Dim.2
dim2_var <-subset(var.sum, name=="07_17_14_2" | name=="10_32_19_2" | name=="10_32_19_6" | name=="09_31_20_1" | 
                    name=="09_31_20_3" | name=="09_31_20_4" | name=="09_31_20_2" | name=="09_31_20_5" |
                    name=="10_32_19_8" | name=="10_32_19_3" | name=="10_32_19_1" | name=="10_32_19_5" | 
                    name=="07_17_14_1"|name=="07_17_14_3"|name=="08_22_18_1"|name=="08_20_16_2" | 
                    name=="08_20_16_1" | name=="10_32_19_4" | name=="10_32_19_7"  | name=="08_22_18")
dim2_var <- subset(dim2_var,select=c(name,coord.2,contrib.2))

# Extract and write results for individuals to CSV
ind.sum <- facto_summarize(surveys_combined.mfa, element = "ind",result = c("coord", "contrib", "cos2", "coord.partial"))
ind_coord <- ind.sum$res
# individuals <- ind_coord
# write.csv(individuals,file="individuals.csv")

# Includes all demos and regions
surveys_combined_demos$dim_1 <- ind_coord$Dim.1
surveys_combined_demos$dim_2 <- ind_coord$Dim.2
surveys_combined_demos$contrib <- ind_coord$contrib
# write.csv(surveys_combined_demos, file="./data/surveys_combined_demos.csv")

# Scree plot and biplot
# scree_plot <- fviz_screeplot(surveys_combined.mfa, addlabels = TRUE, ylim = c(0, 10)) + 
#  geom_hline(yintercept=if_random, linetype=2, color="red")
#
# biplot <- fviz_mfa_ind(surveys_combined.mfa, 
#                             choice="quali.var",
#                             habillage = as.factor(surveys_combined_demos$region), 
#                             addEllipses = TRUE, ellipse.type = "norm",
#                             geom = c("point")) 
#
# Export scree_plot and biplot to plots folder as a PDF
# ggexport(plotlist = list(scree_plot, biplot), filename = "./plots/scree_biplot.pdf")



