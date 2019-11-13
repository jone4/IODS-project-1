#Jone

math = read.csv("student-mat.csv", header=T, sep=";")
por= read.table("student-por.csv", header=T, sep=";")

str(math)
dim(math)

str(por)
dim(por)

library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu"
             ,"Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(math, por, by = join_by)

alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}


alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

write.csv(alc, "alc_data.csv")
