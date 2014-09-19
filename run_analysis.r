## Function: run_analysis
##
## Description: 
##
## Parameters: Resulting File Name
##
run_analysis <- function(ResultFileName="GettingDataCourseProjectResult.txt") {
  
  ## load required librarys
  require(plyr)
  require(dplyr)
  require(reshape2)
  
  ## Read in all files
  features <- read.table("./data/UCI HAR Dataset/features.txt")
  activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
  x_test <- read.table("./data/UCI HAR Dataset/test/x_test.txt")
  y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
  x_train <- read.table("./data/UCI HAR Dataset/train/x_train.txt")
  y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
  
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
  
  ## Subset the the combined/joined set down to the key fields and measure which contain mean and std
  x_subset <- select(x_joined,SubjectID,Activity,contains("mean()"),contains("std()"))
  
  ## Reduce the subset down to a single line per Activity and Subject with the measures averaged
  x_melt <- melt(x_subset,id=c("SubjectID","Activity"))
  x_dcast <- dcast(x_melt,Activity + SubjectID ~ variable,mean)

  ## Add "-avg" to the measure column names to indicate they are now avereaged values
  colnames(x_dcast)[3:length(x_dcast)] <- paste(colnames(x_dcast)[3:length(x_dcast)],"-avg",sep="")
  
  ## Write out the Finished Product
  write.table(x_dcast,ResultFileName,row.name=FALSE)
  
  
}