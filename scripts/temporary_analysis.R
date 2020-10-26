count(subset(surveys_combined_demos,survey_label=="S1" & domain=="Social science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & domain=="Social science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & domain=="Social science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S1" & domain=="Natural science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & domain=="Natural science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & domain=="Natural science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S1" & domain=="Physical science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & domain=="Physical science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & domain=="Physical science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S1" & domain=="Information science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & domain=="Information science")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & domain=="Information science")$funding_agency_recoded)

count(subset(surveys_combined_demos,survey_label=="S1" & work_sector=="Academic")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & work_sector=="Academic")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & work_sector=="Academic")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S1" & work_sector=="Commercial")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & work_sector=="Commercial")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & work_sector=="Commercial")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S1" & work_sector=="Government")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & work_sector=="Government")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & work_sector=="Government")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S1" & work_sector=="Non-Profit")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & work_sector=="Non-Profit")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & work_sector=="Non-Profit")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S1" & work_sector=="Other")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S2" & work_sector=="Other")$funding_agency_recoded)
count(subset(surveys_combined_demos,survey_label=="S3" & work_sector=="Other")$funding_agency_recoded)

# Combine interaction variables domain and work sector
scd <- subset(subset(surveys_combined_demos,work_sector!="Other" | domain!="Other"),
              select=c(domain,work_sector,dim_1))

Information.science_Academic <- subset(subset(scd,work_sector=="Academic" & domain=="Information science"),select=c(dim_1))
Information.science_Commercial <- subset(subset(scd,work_sector=="Commercial" & domain=="Information science"),select=c(dim_1))
Information.science_Government <- subset(subset(scd,work_sector=="Government" & domain=="Information science"),select=c(dim_1))
Information.science_NonProfit <- subset(subset(scd,work_sector=="Non-Profit" & domain=="Information science"),select=c(dim_1))
Natural.science_Academic <- subset(subset(scd,work_sector=="Academic" & domain=="Natural science"),select=c(dim_1))
Natural.science_Commercial <- subset(subset(scd,work_sector=="Commercial" & domain=="Natural science"),select=c(dim_1))
Natural.science_Government <- subset(subset(scd,work_sector=="Government" & domain=="Natural science"),select=c(dim_1))
Natural.science_NonProfit <- subset(subset(scd,work_sector=="Non-Profit" & domain=="Natural science"),select=c(dim_1))
Physical.science_Academic <- subset(subset(scd,work_sector=="Academic" & domain=="Physical science"),select=c(dim_1))
Physical.science_Commercial <- subset(subset(scd,work_sector=="Commercial" & domain=="Physical science"),select=c(dim_1))
Physical.science_Government <- subset(subset(scd,work_sector=="Government" & domain=="Physical science"),select=c(dim_1))
Physical.science_NonProfit <- subset(subset(scd,work_sector=="Non-Profit" & domain=="Physical science"),select=c(dim_1))
Social.science_Academic <- subset(subset(scd,work_sector=="Academic" & domain=="Social science"),select=c(dim_1))
Social.science_Commercial <- subset(subset(scd,work_sector=="Commercial" & domain=="Social science"),select=c(dim_1))
Social.science_Government <- subset(subset(scd,work_sector=="Government" & domain=="Social science"),select=c(dim_1))
Social.science_NonProfit <- subset(subset(scd,work_sector=="Non-Profit" & domain=="Social science"),select=c(dim_1))

interaction_domain_work_sector <- list(
  as.vector(Information.science_Academic$dim_1),
  as.vector(Information.science_Commercial$dim_1),
  as.vector(Information.science_Government$dim_1),
  as.vector(Information.science_NonProfit$dim_1),
  as.vector(Natural.science_Academic$dim_1),
  as.vector(Natural.science_Commercial$dim_1),
  as.vector(Natural.science_Government$dim_1),
  as.vector(Natural.science_NonProfit$dim_1),
  as.vector(Physical.science_Academic$dim_1),
  as.vector(Physical.science_Commercial$dim_1),
  as.vector(Physical.science_Government$dim_1),
  as.vector(Physical.science_NonProfit$dim_1),
  as.vector(Social.science_Academic$dim_1),
  as.vector(Social.science_Commercial$dim_1),
  as.vector(Social.science_Government$dim_1),
  as.vector(Social.science_NonProfit$dim_1)
)
lapply(interaction_domain_work_sector, `length<-`, max(lengths(interaction_domain_work_sector)))
interaction_domain_work_sector <- data.frame(interaction_domain_work_sector)
colnames(interaction_domain_work_sector) <- c("Information.science_Academic","Information.science_Commercial","Information.science_Government",
                                              "Information.science_NonProfit","Natural.science_Academic","Natural.science_Commercial","Natural.science_Government",
                                              "Natural.science_NonProfit","Physical.science_Academic","Physical.science_Commercial","Physical.science_Government",
                                              "Physical.science_NonProfit","Social.science_Academic","Social.science_Commercial","Social.science_Government",
                                              "Social.science_NonProfit")