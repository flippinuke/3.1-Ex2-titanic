## 0: Load the data in RStudio

getwd()
setwd("C:/Users/flippinuke/Desktop/Springboard/Ex 2")
df <- read.csv("titanic_original.csv")
View(df)
str(df)

## 1: Point of embarkation

# using sub(), replace empty values in df$embarked with "S"
df$embarked <- sub("^$", "S", df$embarked)

## 2: Age

# This works to show mean of age (not including NA values)
mean(df$age, na.rm = TRUE)
# this works to replace the N/A's with the mean
df = transform(df, age = ifelse(is.na(age), mean(age, na.rm = TRUE), age))
# this is just to view the mean again, ensure that previous work was done correctly
mean(df$age, na.rm = TRUE)
# mean hasn't changed, previous code appears correct

# Other ways to populate missing values in the age column?
# you could do a group_by based on sex (male/female), survived(1, 0), or class (1, 2, or 3)

# for example:
library(dplyr)
df %>% group_by(sex) %>% summarise(mean=mean(age))

## 3: Lifeboat - fill empty slots with dummy value (e.g. string 'None' or 'NA')

# use sub to change empty values ("^$" into "NA"). This works whether it is set to Factor or chr
df$boat <- sub("^$", "NA", df$boat)

## 4: Cabin

## Does it make sense to fill missing cabin numbers with a value?
## - I don't see why (if yes, perhaps only with a placeholder value such as "NA," if it helps run other functions)

## What does a missing value here mean?
## I think this is best left to further research of how the data were collected, or to speculation.
## For example, perhaps people without a cabin number did not have an assigned cabin. This makes
## sense, given that most people in first class have a cabin number, but most people in third
## class do not

## Create a new column, has_cabin_number, with 1 if has cabin number and 0 if does not

df[, "has_cabin_number"] <- sapply(df[, "cabin"], as.character)

df$has_cabin_number[df$has_cabin_number == ""] <- 0
df$has_cabin_number[df$has_cabin_number != "0"] <- 1

df[, "has_cabin_number"] <- sapply(df[, "has_cabin_number"], as.numeric)
str(df)
View(df)

write.csv(df, "titanic_clean.csv")
