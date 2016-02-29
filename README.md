# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Loads the data sets from the working directory / data
2. Load the activity and feature info
3. Loads both the training and test datasets, keeping only mean or standard deviation
4. Loads and merges subject and activity data
5. Merges the two sets of data
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consists of the mean() value of each
   variable for each subject and activity grouping

The end result is saved in the file `tidy_means.txt`.