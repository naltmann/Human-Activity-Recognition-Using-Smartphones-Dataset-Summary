#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#data set description
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

setwd("C:/n/Google Drive/School/Coursera/Getting and Cleaning Data/Course Project/Human-Activity-Recognition-Using-Smartphones-Dataset-Summary")
dir.create("data")
setwd("data")

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

if(!file.exists(filename)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = filename)
}

unzip(filename)

#561 columns, each 16 characters wide
col_widths <- rep(16,561)

#library that's fast at reading fixed with columns
library(readr)

#reasonably fast method way to read fixed width files
X_test <- read_fwf(file="UCI HAR Dataset/test/X_test.txt", fwf_widths(col_widths))
X_train <- read_fwf(file="UCI HAR Dataset/train/X_train.txt", fwf_widths(col_widths))

#uses gigabyte of memory to read file
#X_test <- read.fwf(file="UCI HAR Dataset/test/X_test.txt",widths=col_widths)
#X_train <- read.fwf(file="UCI HAR Dataset/train/X_train.txt",widths=col_widths)

#results in different numbers of columns because of varying amounts of spaces between columns
#X_test <- read.csv("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = " ", colClasses = "character")
#X_train <- read.csv("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = " ", colClasses = "character")

Y_test <- read.csv("UCI HAR Dataset/test/Y_test.txt", header = FALSE, sep = " ", colClasses = "character")
Y_train <- read.csv("UCI HAR Dataset/train/Y_train.txt", header = FALSE, sep = " ", colClasses = "character")

subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = " ", colClasses = "character")
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = " ", colClasses = "character")

activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ", colClasses = "character")

#join test and train data
X_full <- rbind(X_train, X_test)
Y_full <- rbind(Y_train, Y_test)
subject_full <- rbind(subject_train, subject_test)

#delete variables that are no longer needed
rm(X_test, Y_test, X_train, Y_train, subject_test, subject_train)

#merge meaningful names into Y_full
activities <- merge(Y_full,activity_labels,by="V1")

#get names of all fields from features.txt
features <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep = " ", colClasses = "character")

#select only the columns that are mean ("-mean()") or standard deviation ("-std()")
selected_features <- subset(features, grepl("-mean\\(\\)|-std\\(\\)", features[[2]]))
mean_and_std_column_list <- as.numeric(selected_features[[1]])

#make nicer names for column names
measurement_column_names <- make.names(selected_features[[2]], unique = TRUE)

#prepend the subject and activity labels column ahead the meand and std columns we want from the X_full data
full_mean_and_std <- cbind(subject_full, activities[2], X_full[mean_and_std_column_list])

#delete variables that are no longer needed
rm(X_full, Y_full, subject_full, X_full_mean_and_std)

#add column names to data frame
colnames(full_mean_and_std) <- c("subject", "activity", measurement_column_names)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
average_subject_activity <- aggregate(. ~ subject + activity, full_mean_and_std, mean)

write.table(average_subject_activity, file = "../average_subject_activity.txt", quote = FALSE, row.names = FALSE)