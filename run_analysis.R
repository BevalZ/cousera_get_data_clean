library(tidyverse)
library(lubridate)

# set path
# getwd()
# setwd("C:/Users/Administrator/Desktop/Project/")

# download data and unzip file
Description <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, destfile = "data.zip")
unzip("data.zip")

# Read all datasets under the folder
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt") 
features <- read.table("./UCI HAR Dataset/features.txt")               
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# combine the test and train files and then into a full dataset
test  <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)
datfull <- rbind(test,train)

# subsetting
colNames <- c("subject", "activity", as.character(features$V2))
select_names <- grep("subject|activity|[Mm]ean|std", colNames, value = FALSE)
subdatSet <- datfull[,select_names]


# change colnames

names(activity_labels) <- c("activityNumber", "activityName")
subdatSet$V1.1 <- activity_labels[match(subdatSet$V1.1,                                        
                                        activity_labels$activityNumber),"activityName"]
select_names <- colNames[select_names]
select_names<- gsub("mean", "Mean", select_names)
select_names<- gsub("std", "Std", select_names)
select_names<- gsub("gravity", "Gravity", select_names)
select_names<- gsub("[[:punct:]]", "", select_names)
select_names<- gsub("^t", "time", select_names)
select_names<- gsub("^f", "frequency", select_names)
select_names<- gsub("^anglet", "angleTime", select_names)
names(subdatSet) <- select_names

# Get the mean of data and save tidy data
cleanedDat <- subdatSet %>% group_by(activity,subject) %>% 
  summarise_all(funs(mean))
cleanedDat                
write.csv(cleanedDat,file = "tidyData.csv")


# Generate codebook
library(codebook)
new_codebook_rmd()
