## Project Description
This project consolidates and summarizes (averages) the data originally collected in the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Study design and data processing

###Collection of the raw data
The compressed data is downloaded from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) page. Detailed information about how the data for that data set was collected is available on that page.

###Notes on the original (raw) data 
The original data set stores the data in a number of separate files that are combined by this project.

##Creating the tidy datafile

###Guide to create the tidy data file
Run run_analysis.R to create the tidy data file. run_analysis.R requires a number of R packages you may need to install.

###Cleaning of the data
This run_analysis.R code combines data from a number of separate files in the source data and creates a single output file that averages all of the mean and standard deviation data for each measurement by activity and test subject.

##Description of the variables in the activity_subject_averages.txt

activity - Text description of each activity the subject was performing when the measurements were taken. Example: LAYING, SITTING, STANDING, ...
subject - Unique numeric ID given to each subject

Measurement variables:

Measurement variables all follow a set naming convention.

Example:
For "tBodyAcc.mean.X"
"t" indicates this is time domain signal captured at a constant rate of 50 Hz. "f" indicates frequency domain signals.
"BodyAcc" is the type of measurement as described in the source data
"mean" indicates the data is the average or "std" the standard deviation
"X" represents the axis along which the data was recorded. Other values are "Y" or "Z"

Measurements anre in units of gravity or radians/second for angular acceleration.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag