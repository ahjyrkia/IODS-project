#Anton Jyrkiäinen
#9.11.2018
#Data used http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

# installing of packages need only to be run once
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("GGally")
library(GGally)
library(ggplot2)
library(dplyr)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# structure of the data
# The output shows us some meta data about the data in general and about each column:
# amount of rows and columns, name of each column, data type and the first values. 
str(lrn14)

# dimensions of the data
# Returns the number of rows and colums
dim(lrn14)

# Questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Select the columns related to deep learning and create column 'deep' by averaging.
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# Select the columns related to surface learning and create column 'surf' by averaging.
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# Select the columns related to strategic learning and create column 'stra' by averaging.
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# Define a new dataset 'learning2014'. Get only the columns we want using select() and one_of()
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# Exclude observations where the exam points are 0 by using filter()
learning2014 <- filter(learning2014, Points > 0)

# Dimensions of new dataset
dim(learning2014)

# Setting and printing working directory

setwd("C:/Users/Anton/Documents/IODS-project/")
getwd()

# Saving the dataset locally
write.table(learning2014,file="learning2014.txt")

# Testing saved dataset. Shows same results as the dim(learning2014)
importedDataset <- read.table("C:/Users/Anton/Documents/IODS-project/learning2014.txt")
dim(importedDataset)

#sandbox
lm1 <- lm(formula = Points ~ Attitude + stra + deep, data = learning2014)

summary(lm1)

lm1 <- lm(formula = Points ~ Attitude + stra, data = learning2014)

summary(lm1)

plot(lm1, which = c(1,2,5))