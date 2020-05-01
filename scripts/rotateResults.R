# Plot of unrotated loadings
# unrotated_plot_dim1 <- ggplot(data.frame(surveys_combined.mfa$quali.var$coord[,1])) +
#  geom_bar(aes(x=surveys_combined.mfa$quali.var$coord[,0]))
unrotated_plot_dim1 <- barplot(surveys_combined.mfa$quali.var$coord[,1], las=2)
unrotated_plot_dim2 <- barplot(surveys_combined.mfa$quali.var$coord[,2], las=2)
coords <- cbind(surveys_combined.mfa$quali.var$coord[,1],surveys_combined.mfa$quali.var$coord[,2]) 

# 1) Calculate loadings from coordinates and print loadings
# 2) Rotate values 
# 3) Load rotated values into previous values
loadings.mfa <- sweep(surveys_combined.mfa$quali.var$coord,2,
                      sqrt(surveys_combined.mfa$eig[1:ncol(surveys_combined.mfa$quali.var$coord),1]),FUN="/")
loadings <- cbind(loadings.mfa[,1],loadings.mfa[,2]) 
loadings.mfa.rot <- varimax(loadings.mfa)$loadings
surveys_combined.mfa$quali.var$coord <- loadings.mfa.rot

# Plot of rotated loadings
rotated_plot_dim1 <- barplot(surveys_combined.mfa$quali.var$coord[,1], las=2)
rotated_plot_dim2 <- barplot(surveys_combined.mfa$quali.var$coord[,2], las=2)
rot_loadings <- cbind(surveys_combined.mfa$quali.var$coord[,1],surveys_combined.mfa$quali.var$coord[,2]) 
