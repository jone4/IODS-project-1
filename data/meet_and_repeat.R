#1.

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

names(RATS)
str(RATS)

#2.

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID = factor(RATS$ID)
RATS$Group = factor(RATS$Group)

#3.
library(dplyr)
library(tidyr)

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))

RATSL <- RATS %>%
  gather(key = WD, value = Weigth, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#4.
summary(RATSL)
summary(RATS)

write.table(RATSL, "RATSL.txt")
write.table(BPRSL, "BPRSL.txt")
