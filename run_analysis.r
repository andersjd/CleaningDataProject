## Function: run_analysis
##
## Description: Uses the information from the "Human Activity Recognition Using Smartphones Data Set"
##              to create a tidy summarized subset file.
##
## Parameters: 
##    SourceDirectory:   
##    ResultingFileName
##
## Required Libraries
##    plyr
##    dplyr
##    reshape2

run_analysis <- function(SourceDirectory="./data/UCI HAR Dataset",ResultFileName="GettingDataCourseProjectResult.txt") {
  
  ## load required libraries
  require(plyr)
  require(dplyr)
  require(reshape2)
  
  ## Read in all files
  features <- read.table(paste(SourceDirectory,"/features.txt",sep=""))
  activity_labels <- read.table(paste(SourceDirectory,"/activity_labels.txt",sep=""))
  x_test <- read.table(paste(SourceDirectory,"/test/x_test.txt",sep=""))
  y_test <- read.table(paste(SourceDirectory,"/test/y_test.txt",sep=""))
  subject_test <- read.table(paste(SourceDirectory,"/test/subject_test.txt",sep=""))
  x_train <- read.table(paste(SourceDirectory,"/train/x_train.txt",sep=""))
  y_train <- read.table(paste(SourceDirectory,"/train/y_train.txt",sep=""))
  subject_train <- read.table(paste(SourceDirectory,"/train/subject_train.txt",sep=""))
  
  ## Provider readable Column Names
  colnames(x_test) <- features$V2
  colnames(x_train) <- features$V2
  colnames(subject_test) <- "SubjectID"
  colnames(y_test) <- "ActivityID"
  colnames(subject_train) <- "SubjectID"
  colnames(y_train) <- "ActivityID"
  colnames(activity_labels) <- c("ActivityID","Activity")

  ## Add Subject IDs and Activity IDs to Test and Train Data Frames
  x_test$SubjectID <- subject_test[,1]
  x_test$ActivityID <- y_test[,1]
  x_train$SubjectID <- subject_train[,1]
  x_train$ActivityID <- y_train[,1]
  
  ## Combind the Test and Train Data Frames
  x_combined <- rbind(x_test,x_train)
  
  ## Add in the Activity Names based on the ActivityID key
  x_joined <- join(x_combined,activity_labels,by="ActivityID")
  
  ## Subset the the combined/joined set down to the key fields and measure which contain mean() and std()
  x_subset <- select(x_joined,SubjectID,Activity,grep("mean\\(\\)",features$V2),grep("std\\(\\)",features$V2))
  
  ## Reduce the subset down to a single line per Activity and Subject with the measures averaged
  x_melt <- melt(x_subset,id=c("SubjectID","Activity"))
  x_dcast <- dcast(x_melt,Activity + SubjectID ~ variable,mean)

  ## Clean up column names (somewhat) and indicate they are now avereaged values
  colnames(x_dcast) <- sub("tBody","TimeBody",colnames(x_dcast))
  colnames(x_dcast) <- sub("tGravity","TimeGravity",colnames(x_dcast))
  colnames(x_dcast) <- sub("fBody","FrequencyBody",colnames(x_dcast))
  colnames(x_dcast) <- sub("fGravity","FrequencyGravity",colnames(x_dcast))
  colnames(x_dcast) <- sub("-mean\\(\\)","AverageMean",colnames(x_dcast))
  colnames(x_dcast) <- sub("-std\\(\\)","AverageStdDev",colnames(x_dcast))
  colnames(x_dcast) <- sub("-X","X",colnames(x_dcast))
  colnames(x_dcast) <- sub("-Y","Y",colnames(x_dcast))
  colnames(x_dcast) <- sub("-Z","Z",colnames(x_dcast))
  
  ## Write out the Finished Product
  write.table(x_dcast,ResultFileName,row.name=FALSE)
  
  
}