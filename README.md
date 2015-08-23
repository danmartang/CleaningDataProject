# CleaningDataProject

Objective of this program is to take Samsung phone activity data from a number of sources, combine all of the data
into one data frame, clean up names of columns/variables, calculate an average value for 66 variables for each subject/activity 
combination and return a tidy dataframe (output.txt). 

This script assumes the data has been downloaded and the UCI HAR Dataset folder is in the working directory in order to execute the
run_analysis.R script succesfully. You will also need to download the dplyr package and load the library before running.

The main highlights/assumptions of the script are as follows:
- All the files are read from the UCI HAR Dataset including: X_test (Test data), y_test(Test Activity data), subject_test 
  (Test Subject data), X_train (Train data), y_train (Train Activity data), subject_train (Train Subject data), features 
  (names of all the variables in the dataset), activity_labels (names of the 6 activities)
- Add subject and activity to the column name vector (from the features file)
- Merge the data (x file), activity (y file) and subject (subject file) data into 1 dataframe using cbind function.
  This is done for test and train separately.
- Merge test and train dataframes into a combined one (merged_data) using rbind function. Assign column names vector using names(). 
  There are a total of 563 variables (561 measurements, subject  & activity) and 10299 entries(rows).
- Filter out the columns that provide mean and standard deviation data (as specified in the assignment). We only took the variables
  that were direct mean and std measurements ignoring Frequency mean data and additional vectors obtained by averaging the signals
  in a signal window sample. This leaves us at 66 measurements (33 each for mean and std) plus an activity and subject column.
- Next step is to clean up all the column and variable names to make this a tidy dataset:
	- Replace: BodyBody for Body, Mag for Magnitude, Gyro for Gyroscope and Acc for Accelerometer
	- Remove: () symbols from names
	- Substitute: Activity codes (1-6) for the actual activities (Walking, Walking_upstairs, Walking downstairs, Sitting,
	              Standing, Laying
- Once the dataset was cleaned up, we created a new dataset with the mean of each of the measurement variables for each 
  combination of subject/activity (output_data). This dataset had 68 columns and 180 rows  (30 subjects x 6 activities). The 
  group_by() and summarise_each functions are used to group all the data by subject/activity and then to calculate the means.
- Finally, the tidy summarized data set (output_data) is written to the file output.txt using write.table()



