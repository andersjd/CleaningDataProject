# Data Science Getting and Cleaning Data Course Project

## Project Goal

The goal of this project is to complete the requirements for the _Getting and Cleaning Data_ course project.

This involves taking data from the __Human Activity Recognition Using Smartphones Data Set__ and manipulating that information to create a tidy summary subset data file. This includes the following requirements:

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data Source(s)

This project uses and is dependent upon the"Human Activity Recognition Using Smartphones Dataset", which can be obtained at the following URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Please see the README.txt and features_info.txt from that data source for information on the original experiments that generated the source data. More information can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

When downloaded and unziped, a directory named _UCI HAR Dataset_ is created in which all the source data files can be found.
_Note:_ It is assumed that no changes are made to this directory structure or the files within for successful execution of the code in this project.


## Project Assumptions

### Selection of mean and standard Deviation measurements (Requirement 2)
For this requirement only measurement names with the explicit strings "mean()" and "std()" were selected. Other fields with similar text (i.e. MeanFreq) were not thought to align with the requirements.

### Definition of Tidy (Requirement 5) (Narrow vs Wide)
It is open to interpretation as to the final structure of the file. Beyond the standard elements of tidy (i.e. 1 row per observation, etc.) whether this should result in a "Wide" table (all mean and standard deviation averaged values in separate columns), or a "Narrow" table (key/value parings for the measurements) was not explicit. Based on review of the discussion forms, statements by the TA's that either was appropriate, and personal preference, the Wide format was used for this project.

### Variable Names (Requirement 4)
Because of the complexity of the measurements, strict adherance to the general rules for variable naming (specifically having the name all lower case and fully spelling out all words) seemed to create long, unreadable results. The decision was made for this project to retain mixed case and some of the abbreviations inherent in the base data in order to make the column names more readable, and allow easier mapping of the names back to the original data set. See the CodeBook.txt file for specifics on how the variable names were altered.


## Project Elements

### Readme.md

This File.

### Codebook.txt

Detailed information on the usage of the source data, the transformations that were performed, and the structure of results file.

### run_analysis.R

R Code file containing the process for creating the results file from the source data. This file contains 1 (one) function:

   Function: run_analysis()

   Parameters:
      SourceDirectory - Directory where "UCI HAR Dataset" exists (Default = "./data/UCI HAR Dataset")
      ResultFileName  - Name of the resulting file (Default = "GettingDataCourseProjectResult.txt")

   Library Requirements:
      plyr
      dplyr
      reshape

   Examples:
      ## Run the function with default parameters described above
      run_analysis()

      ## Run the function where the unzipped source data is located in C:\WorkingDirectory, creating a file named "Output.txt" in the current working directory
      run_analysis(SourceDirectory="C:\WorkingDirectory\UCI HAR Dataset", ResultFileName="Output.txt"

   Detailed information on the data manipulations performed by this function can be found in the Codebook.txt file


### GettingDataCourseProjectResult.txt

The data file resulting from this project.

Details for this file structure and contents can be found in CodeBook.txt

