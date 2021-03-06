library(dplyr)

# Part 2
# Data loaded to variables
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Part 3
# Structure
str(hd)
str(gii)

# Dimensions
dim(gii)
dim(gii)

# Summaries
summary(hd)
summary(gii)

colnames(hd)
colnames(gii)

# Part 4
# New variable names
colnames(hd)[1] <- "rank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "humanDev"
colnames(hd)[4] <- "expectancy"
colnames(hd)[5] <- "expectedEducation"
colnames(hd)[6] <- "meanEducation"
colnames(hd)[7] <- "gni"
colnames(hd)[8] <- "gniMinusRank"

colnames(gii)[1] <- "rank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "genderInequality"
colnames(gii)[4] <- "maternalMortality"
colnames(gii)[5] <- "adolescentBirth"
colnames(gii)[6] <- "repInParliament"
colnames(gii)[7] <- "popWithSecondaryEduF"
colnames(gii)[8] <- "popWithSecondaryEduM"
colnames(gii)[9] <- "labourParticipationF"
colnames(gii)[10] <- "labourParticipationM"

# Part 5
# 
gii <- mutate(gii, secondaryPopRatio = popWithSecondaryEduF / popWithSecondaryEduM)
gii <- mutate(gii, labourRatio = labourParticipationF / labourParticipationM)
colnames(gii)
# Part 6
human <- inner_join(hd, gii, by = c("country"))
# 195 observations and 19 variables
dim(human)

# Save to data folder
setwd("C:/Users/Anton/Documents/IODS-project/data/")
write.csv(human, file="human")

#Week 5 Data wrangling
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header = TRUE, sep = ",")

# Structure and dimensions
# We can see that there's 195 observations and 19 variables.
# The data is a dataset from the United Nations Development Programme. It's about human
# development in different areas.
str(human)
dim(human)

# human$gni to numeric
human$GNI <- as.numeric(human$GNI)

# Columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep))

# Filter out rows with no values
human_ <- filter(human, complete.cases(human))

# Remove observations which relate to regions instead of countries
last <- nrow(human_) - 7
human_ <- human_[1:last, ]

# Add countries as rownames
rownames(human_) <- human_$Country

# Remove the Country variable
human_ <- select(human, -Country)

# Save and replace old human file
setwd("C:/Users/Anton/Documents/IODS-project/data/")
write.csv(human_, file="human")

