# See README.md for a description of the code
# See CodeBook.md for a description of the output file


# Set working directory
setwd("C:/n/Google Drive/School/Coursera/Getting and Cleaning Data/Course Project/Human-Activity-Recognition-Using-Smartphones-Dataset-Summary")

# Create a data folder if one does not exist and change to that folder
if(!file.exists("./data")) {
  dir.create("./data")
}
setwd("data")

# Download the source data file if it has not already been downloaded and decompress the data
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

if(!file.exists(filename)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = filename)
}

unzip(filename)


col_widths <- rep(16,561) # 561 columns, each 16 characters wide

# Read data file using read_fwf. read_fwf seemed to be much faster than read.fwf
library(readr) # Load library that's fast at reading fixed with columns
X_test <- read_fwf(file="UCI HAR Dataset/test/X_test.txt", fwf_widths(col_widths))
X_train <- read_fwf(file="UCI HAR Dataset/train/X_train.txt", fwf_widths(col_widths))

# Read in other data files
Y_test <- read.csv("UCI HAR Dataset/test/Y_test.txt", header = FALSE, sep = " ", colClasses = "character")
Y_train <- read.csv("UCI HAR Dataset/train/Y_train.txt", header = FALSE, sep = " ", colClasses = "character")

subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = " ", colClasses = "character")
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = " ", colClasses = "character")

activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ", colClasses = "character")

# Join the test and train data into a single data frame for each type
X_full <- rbind(X_train, X_test)
Y_full <- rbind(Y_train, Y_test)
subject_full <- rbind(subject_train, subject_test)

# Delete temporary variables that are no longer needed
rm(X_test, Y_test, X_train, Y_train, subject_test, subject_train)

# Merge meaningful field names into Y_full from activity_labels
activities <- merge(Y_full,activity_labels,by="V1")

# Read in names of all fields from features.txt
features <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep = " ", colClasses = "character")

# Select only the columns that are mean ("-mean()") or standard deviation ("-std()")
selected_features <- subset(features, grepl("-mean\\(\\)|-std\\(\\)", features[[2]]))
mean_and_std_column_list <- as.numeric(selected_features[[1]])

# Make column names easier to read
measurement_column_names <- make.names(selected_features[[2]], unique = TRUE)

measurement_column_names <- gsub("\\.+", ".", measurement_column_names) # Remove consective periods
measurement_column_names <- gsub("\\.$", "", measurement_column_names) # Remove trailing periods
measurement_column_names <- gsub("BodyBody", "Body", measurement_column_names) # Remove doubled "BodyBody" text

# Prepend the activity and subject labels columns ahead the mean and std columns we want from the X_full data
full_mean_and_std <- cbind(activities[2], subject_full, X_full[mean_and_std_column_list])

# Delete variables that are no longer needed
rm(X_full, Y_full, subject_full)

# Add column names to data frame
colnames(full_mean_and_std) <- c("activity", "subject", measurement_column_names)

# Create a new dataframe with the average of each variable for each activity and each subject.
activity_subject_averages <- aggregate(. ~ activity + subject, full_mean_and_std, mean)

# Sort the data frame
activity_subject_averages <- activity_subject_averages[with(activity_subject_averages, order(activity, subject)), ]

# Write out the data
write.table(activity_subject_averages, file = "../activity_subject_averages.txt", quote = FALSE, row.names = FALSE)