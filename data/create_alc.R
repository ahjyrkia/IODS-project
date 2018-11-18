# Anton Jyrkiäinen, 16.11.2018, week 3 R exercise.
# Data used: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

# install.packages("dplyr")
library(dplyr)


# Files load to variables.
student_mat <- read.table("C:/Users/Anton/Documents/IODS-project/student-mat.csv", sep = ";", header=TRUE)
student_por <- read.table("C:/Users/Anton/Documents/IODS-project/student-por.csv", sep = ";", header=TRUE)

# Structure
str(student_mat)
str(student_por)

# Dimensions
dim(student_mat)
dim(student_por)

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

math_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".math",".por"))

str(math_por)
dim(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns


for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

setwd("C:/Users/Anton/Documents/IODS-project/data/")
getwd()

# Saving the dataset locally
write.csv(alc,file="alc")
