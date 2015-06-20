Coursera - Getting and Cleaning Data Course Project

This file loads up a function that takes the "Human Activity Recognition Using Smartphones Dataset" by Jorge L. and turns it into a tidy dataset consisting of the mean of the mean accelerometer and gyroscope data for each group, subject number and subject activity.

To run this program, copy the run_analysis.R files and the UCI HAR DataSet into the same folder.  Then make that folder the working directory in R and source the run_analysis.R file.  Running the LoadUCIdataSet function will load the files, do the analysis and output the above data. 

Additionally, if the UCI HAR DataSet isn't in your current working directory, you may input the filepath to the dataset into the LoadUCIdataSet function and it will load the files appropriately.

The codebook includes additional details on the process used to create the tidy dataset.

tidy UCI HAR Dataset includes the final tidy dataset (from part 5) outputted to a text file.
