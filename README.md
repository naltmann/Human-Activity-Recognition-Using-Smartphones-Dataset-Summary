#Human Activity Recognition Using Smartphones Dataset Summary

This repository contains R code (run_analysis.R) that generates summary data (activity_subject_averages.txt) from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

##Contents
* README.md - This file
* run_analysis.R - Reads in source data and writes out activity_subject_averages.txt
* activity_subject_averages.txt - Produced by running run_analysis.R. Contents of file are described in CodeBook.md
* CodeBook.md - Describes the contents of activity_subject_averages.txt

##Requirements
* R
* Lots of different R libraries

##Usage
Run run_analysis.R

##What it does

Running the run_analysis.R file performs a number of operations:

1. Downloads and extracts data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
1. Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
Writes out a new data set containing the averages of each variable for each activity and each subject.
