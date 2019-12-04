human= read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt",
                 sep=",", header=T)
dim(human)
str(human)

#1.

library(stringr)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
human$GNI =str_replace(human$GNI, pattern=",", replace ="") %>%
  as.numeric

#2.

setwd("")
library(dplyr)

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

testi= human

colnames(testi[1]) ="testi"

getwd()

#3.

human= human[complete.cases(human),]

#4.
human= human[1:(nrow(human)-7),]

?write.csv

header= T


#5.
rownames(human)= human$Country
human= human[,-1]

write.table(human, "human.txt", row.names = T)
