##Data Cleaning

##GDP Data Set:
#cleans the empty rows at the top of the data set
GDPsmall <- GDP[5:194,]

#removes empty columns from the data set
GDPsmall <- GDPsmall[,-c(3,6,7,8,9,10)]

#adds appropriate headers to columns in the data set
colnames(GDPsmall) <- c("CountryCode","GDP.Rank.2012","Long.Name","GDP")

#converts character columns to numeric and removes commas from those values
GDPsmall[,c(2,4)] <- apply(GDPsmall[,c(2,4)], 2, function(x) {as.numeric(gsub(",", "", x))})


##ED Data Set:
# Select relevant columns of complete data
EDsmall <- ED[,c(1,2,3,4)]
