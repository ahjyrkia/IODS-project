#Week 6
#Anton Jyrkiäinen 014417841

install.packages("lme4") 
library(lme4)
library(dplyr)
library(tidyr)

# Load data
BPRS  <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Names
names(BPRS)
names(RATS)

# Structure
str(BPRS)
str(RATS)

# Summaries
summary(BPRS)
summary(RATS)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Names
names(BPRS)
names(RATS)

# Structure
str(BPRS)
str(RATS)

# Summaries
summary(BPRS)
summary(RATS)