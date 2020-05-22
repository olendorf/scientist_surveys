# Identity most correlated variables in given dimension
res.desc <- dimdesc(surveys_combined.mfa)
# Description of dimension 1
res.desc$Dim.1$quali
res.desc$Dim.1$category
# Description of dimension 2
res.desc$Dim.2$quali
res.desc$Dim.2$category

# Write lists of most correlated variables
write.csv(res.desc$Dim.1$quali,file="./data/correlated_dim1_quali_vars.csv")
write.csv(res.desc$Dim.2$quali,file="./data/correlated_dim2_quali_vars.csv")
write.csv(res.desc$Dim.1$category,file="./data/correlated_dim1_vars_category.csv")
write.csv(res.desc$Dim.2$category,file="./data/correlated_dim2_vars_category.csv")
