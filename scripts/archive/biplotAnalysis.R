# DIM1: Question effect analysis
ind.mfa_plot.10_32_19_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`10_32_19_2`), 
                                        title = "10_32_19_2: I would  be willing to place at least some of my data
                                     into a central data repository with no restrictions",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.10_32_19_3 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`10_32_19_3`), 
                                        title = "10_32_19_3: I would be willing to place all of my data 
                                        into a central data repository with no restrictions",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_11 <- fviz_mfa_ind(surveys_combined.mfa, 
                                         choice="quali.var",
                                         habillage = as.factor(surveys_combined_demos$`11_19_15_11`), 
                                         title = "11_19_15_11: The data provider is given and agrees to
                                        a statement of uses to which the data will be put",
                                         #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                         addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                         geom = c("point")) 
ind.mfa_plot.10_32_19_6 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`10_32_19_6`), 
                                        title = "10_32_19_6: I would be willing to share data across a
                                        broad group of researchers who use 
                                        data in different ways",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_5 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`11_19_15_5`), 
                                        title = "11_19_15_5: Results based (at least in part) on the data
                                        could not be disseminated in any format 
                                        without the data provider's approval",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_10 <- fviz_mfa_ind(surveys_combined.mfa, 
                                         choice="quali.var",
                                         habillage = as.factor(surveys_combined_demos$`11_19_15_10`), 
                                         title = "11_19_15_10: Mutual agreement on reciprocal sharing of data",
                                         #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                         addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                         geom = c("point")) 
ind.mfa_plot.11_19_15_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`11_19_15_1`), 
                                        title = "11_19_15_1: Co-authorship on publications resulting from use of the data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_9 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`11_19_15_9`), 
                                        title = "11_19_15_9: Legal permission for data use is obtained",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.10_32_19_4 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`10_32_19_4`), 
                                        title = "10_32_19_4: I would be more likely to make my data available
                                        if I could place conditions on access",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_4 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`11_19_15_4`), 
                                        title = "11_19_15_4: The opportunity to collaborate on the project 
                                        (including, for example, consultation on analytic methods, 
                                        interpretation of results, dissemination of research results, etc.)",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_8 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`11_19_15_8`), 
                                        title = "11_19_15_8: The data provider is given a complete list of all 
                                        products that make use of the data, including",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.10_32_19_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`10_32_19_1`), 
                                        title = "10_32_19_1: I would use other researchers' datasets if their 
                                        datasets were easily accessible",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_6 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`11_19_15_6`), 
                                        title = "11_19_15_6: Results based (at least in part) on the data could 
                                        not be disseminated without the data provider having the
                                        opportunity to review the results and make suggestions 
                                        or comments, but approval not required",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.11_19_15_7 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`11_19_15_7`), 
                                        title = "11_19_15_7: Reprints of articles that make use of the data
                                        must be provided to the data provider",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.10_32_19_8 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`10_32_19_8`), 
                                        title = "10_32_19_8: It is appropriate to create new datasets from 
                                        shared data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point"))

# DIM2: Question effect analysis
ind.mfa_plot.07_17_14_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`07_17_14_2`), 
                                        title = "07_17_14_2: I am satisfied with the process for searching
                                       for my own data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.07_17_14_3 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`07_17_14_3`), 
                                        title = "07_17_14_3: I am satisfied with the process for 
                                       cataloging/describing my data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.07_17_14_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`07_17_14_1`), 
                                        title = "07_17_14_1: I am satisfied with the process for 
                                       collecting my research data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.08_20_16_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`08_20_16_2`), 
                                        title = "08_20_16_2: My organization or project has a
                                        formal established process for storing
                                        data beyond the life of the project (long-term)",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.08_22_18 <- fviz_mfa_ind(surveys_combined.mfa, 
                                      choice="quali.var",
                                      habillage = as.factor(surveys_combined_demos$`08_22_18`), 
                                      title = "08_22_18: My organization or project provides
                                        training on best practices for data management",
                                      #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                      addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                      geom = c("point")) 
ind.mfa_plot.08_20_16_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`08_20_16_1`), 
                                        title = "08_20_16_1: My organization or project has a formal
                                        established process for managing data during the 
                                        life of the project (short-term)",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.09_31_20_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`09_31_20_1`), 
                                        title = "09_31_20_1: Lack of access to data generated by other
                                        researchers or institutions is a major impediment
                                        to progress in science",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.06_16_13_2 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`06_16_13_2`), 
                                        title = "06_16_13_2: Lack of standards",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.06_16_13_4 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`06_16_13_4`), 
                                        title = "06_16_13_4: There is insufficient time to make them available",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.06_16_13_1 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`06_16_13_1`), 
                                        title = "06_16_13_1: Lack of funding",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ind.mfa_plot.09_31_20_3 <- fviz_mfa_ind(surveys_combined.mfa, 
                                        choice="quali.var",
                                        habillage = as.factor(surveys_combined_demos$`09_31_20_3`), 
                                        title = "09_31_20_3: Data may be misinterpreted due to 
                                        complexity of the data",
                                        #                             palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                                        addEllipses = TRUE, ellipse.type = "norm", # t, norm, convex, euclid 
                                        geom = c("point")) 
ggexport(plotlist = list(ind.mfa_plot.10_32_19_2,ind.mfa_plot.10_32_19_3,ind.mfa_plot.11_19_15_11,
                         ind.mfa_plot.10_32_19_6,ind.mfa_plot.11_19_15_5,ind.mfa_plot.11_19_15_10,
                         ind.mfa_plot.11_19_15_1,ind.mfa_plot.11_19_15_9,ind.mfa_plot.10_32_19_4,
                         ind.mfa_plot.11_19_15_4,ind.mfa_plot.11_19_15_8,ind.mfa_plot.10_32_19_1,
                         ind.mfa_plot.11_19_15_6,ind.mfa_plot.11_19_15_7,ind.mfa_plot.10_32_19_8), 
         filename = "plots/mfa_dim1_interpretation.pdf")
ggexport(plotlist = list(ind.mfa_plot.07_17_14_2,ind.mfa_plot.07_17_14_3,ind.mfa_plot.07_17_14_1,
                         ind.mfa_plot.08_20_16_2,ind.mfa_plot.08_22_18,ind.mfa_plot.08_20_16_1, 
                         ind.mfa_plot.09_31_20_1,ind.mfa_plot.06_16_13_2,ind.mfa_plot.06_16_13_4,
                         ind.mfa_plot.06_16_13_1,ind.mfa_plot.09_31_20_3), 
         filename = "plots/mfa_dim2_interpretation.pdf")
