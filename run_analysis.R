run_analysis <- function(){
  #Read data files. Working directory should contain features.txt and the test 
  #  and train folders with the corresponding X, y & subject files.
  test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
  test_activities <- read.table("./UCI HAR Dataset/test/y_test.txt")
  test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
  train_activities <- read.table("./UCI HAR Dataset/train/y_train.txt")
  train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  features <- read.table("./UCI HAR Dataset/features.txt")
  activity_labels <-read.table("./UCI HAR Dataset/activity_labels.txt")
  
  #Pull the column names from features and assign them to both data files
  vector <- as.vector(features[,2])
  vector[562]<-c("activity")
  vector[563]<-c("subject")
  
  #Add the activity and subject data to the corresponding data files
  test_data<-cbind(test_data,test_activities)
  test_data<-cbind(test_data,test_subjects)
  train_data<-cbind(train_data,train_activities)
  train_data<-cbind(train_data,train_subjects)
  
  #Merge the two data frames and assign column namme values
  merged_data <- rbind(test_data,train_data)
  names(merged_data) <- vector
  
  #Filter out mean & std columns only
  mean_filter <- grep("mean(",names(merged_data),fixed = TRUE)
  mean_data <- merged_data[,mean_filter]
  std_filter <-grep("std(",names(merged_data),fixed = TRUE)
  std_data <- merged_data[,std_filter]
  filtered_data <- merged_data[,562:563]
  filtered_data <- cbind(filtered_data,mean_data)
  filtered_data <- cbind(filtered_data,std_data)
  
  #Clean up Column names
  names(filtered_data) <- sub("BodyBody", "Body", names(filtered_data), fixed = TRUE)
  names(filtered_data) <- sub("Mag", "Magnitude", names(filtered_data), fixed = TRUE)
  names(filtered_data) <- sub("Gyro", "Gyroscope", names(filtered_data), fixed = TRUE)
  names(filtered_data) <- sub("Acc", "Accelerometer", names(filtered_data), fixed = TRUE)
  names(filtered_data) <- sub("()", "", names(filtered_data), fixed = TRUE)
  
  #Create output table
  grouped_data <- group_by(filtered_data,activity,subject)
  output_data <- summarise_each (grouped_data,funs (mean))
  
  #Update activity names
  activity.names <- as.vector(activity_labels[,2])
  activity_vector<-as.vector(output_data$activity)
  name <- activity.names[activity_vector]
  name<-as.data.frame(name)
  output_data[,1]<- name[1]
  write.table(output_data, "output.txt", sep="\t", row.name=FALSE)
  
}