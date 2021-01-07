library(tidyverse)
library(data.table)
#combine all text files
data <- lapply(Sys.glob("*.txt"), read.table)
df <- dplyr::bind_cols(data)
df <- df[,c(1:4,seq(5, 215, by = 5))]#Change the parameter based on the number of samples (n*5)
#Rename column
df <- df %>% 
  rename(
Chr = V1...1,Start = V2...2,End = V3...3,Annotation = V4...4,
cfMBD03 = V5...5,cfMBD06 = V5...10,cfMBD07 = V5...15,cfMBD08 = V5...20,cfMBD12 = V5...25,
cfMBD16 = V5...30,cfMBD17 = V5...35,cfMBD18 = V5...40,cfMBD19 = V5...45,cfMBD20 = V5...50,cfMBD21 = V5...55,
cfMBD22 = V5...60,cfMBD23 = V5...65,cfMBD24 = V5...70,cfMBD25 = V5...75,cfMBD26 = V5...80,cfMBD27 = V5...85,
cfMBD28 = V5...90,cfMBD29 = V5...95,cfMBD30 = V5...100,cfMBD31 = V5...105,cfMBD38 = V5...110,cfMBD39 = V5...115,
cfMBD40 = V5...120,cfMBD41 = V5...125,cfMBD44 = V5...130,cfMBD45 = V5...135,cfMBD46 = V5...140,cfMBD47 = V5...145,
cfMBD48 = V5...150,cfMBD49 = V5...155,cfMBD51 = V5...160,cfMBD52 = V5...165,cfMBD53 = V5...170,cfMBD54 = V5...175,
cfMBD55 = V5...180,cfMBD56 = V5...185,cfMBD57 = V5...190,cfMBD58 = V5...195,cfMBD61 = V5...200,cfMBD62 = V5...205,
cfMBD63 = V5...210,cfMBD64 = V5...215)#Change the parameter here
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
