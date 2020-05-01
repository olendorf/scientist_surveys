# Identity most correlated variables in given dimension
res.desc <- dimdesc(surveys_combined.mfa)
# Description of dimension 1
res.desc$Dim.1$quali
res.desc$Dim.1$category
# Description of dimension 2
res.desc$Dim.2$quali
res.desc$Dim.2$category

# Write loadings to csv
all_loadings <- cbind(coordinates, loadings,rot_loadings)
colnames(all_loadings) <- c("coord.dim1","coord.dim2","load.dim1","load.dim2","rotLoad.dim1","rotLoad.dim2")
my_dataframe$dim_1 <- coord.dim1
write.csv(all_loadings,file="./data/all_loadings.csv")

# Write lists of most correlated variables
write.csv(res.desc$Dim.1$quali,file="./data/correlated_dim1_quali_vars.csv")
write.csv(res.desc$Dim.2$quali,file="./data/correlated_dim2_quali_vars.csv")
write.csv(res.desc$Dim.1$category,file="./data/correlated_dim1_vars_category.csv")
write.csv(res.desc$Dim.2$category,file="./data/correlated_dim2_vars_category.csv")