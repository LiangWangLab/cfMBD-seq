library(tidyverse)
library(data.table)

#listing files with .txt extension in the `data` folder
files = list.files(path = "data/.", pattern = ".txt") 
file_names = unlist(strsplit(files, ".txt")) #getting file basename

#parallel read all files in data directory
data <- lapply(paste("data/", files, sep=""), data.table::fread)
df <- dplyr::bind_cols(data)
df <- data.frame(df)[,c(1:4,seq(5, ncol(df), by = 5))] #autoscale
colnames(df) = c("Chr", "Start", "End", "Annotation", file_names) #rename columns by file name

#Add length and type column
df <- add_column(df, Length = df$End - df$Start + 1, .after = "End")
df <- separate(df, "Annotation", "Type", sep = ":", remove = FALSE)
#TPM normalization
df[-(1:6)] <- df[-(1:6)]/(df[,4]/1000)[row(df[-(1:6)])]
df[,-(1:6)] = apply(df[,-(1:6)],2,function(x){x/sum(x)*1e6})
head(df)
write.table(df,"CpG_annotation_coverage_TPM.txt", sep = "\t", row.names = FALSE, quote = FALSE)
#Sum of each feature
Island_sum = apply(subset(df, Type == "island")[,-(1:6)], 2, sum)
Shore_sum = apply(subset(df, Type == "shore")[,-(1:6)], 2, sum)
Shelf_sum = apply(subset(df, Type == "shelf")[,-(1:6)], 2, sum)
Inter_sum = apply(subset(df, Type == "inter")[,-(1:6)], 2, sum)
Extended_sum = apply(subset(df, Type != "inter")[,-(1:6)], 2, sum)
#To data frame
All <- data.frame(Island_sum,Shore_sum,Shelf_sum,Inter_sum,Extended_sum)
write.table(All,"CpG_annotation_coverage_TPM_sum.txt", sep = "\t", row.names = TRUE, quote = FALSE)
