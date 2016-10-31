##Merge
#Merges cleaned GDP and ED data sets
GDPmergeED <- merge(x = GDPsmall, y = EDsmall, by = "CountryCode", all=TRUE)
#removes rows that do not have GDP data
GDPmergeED <- GDPmergeED[!is.na(GDPmergeED$GDP.Rank.2012),]