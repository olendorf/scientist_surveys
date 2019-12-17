no_other <- domain_counts[which(domain_counts$Domain != "Other"), ]
aggregated_no_other <- aggregate(no_other$Frequency, by=list(Domain=no_other$Domain), FUN = sum, na.rm = TRUE)
aggregated_no_other <- aggregated_no_other[order(-aggregated_no_other$x), ]
View(aggregated_no_other)
