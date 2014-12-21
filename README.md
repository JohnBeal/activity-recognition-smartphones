activity-recognition-smartphones
================================

Script for getting and cleaning Human Activity Recognition Using Smartphones dataset (Coursera Getting and Cleaning Data course project)

As the course project for the Getting and Cleaning Data course of the Data Science specialisation (Coursera), the HCI HAR dataset is to be downloaded and processed to achieve a number of aims:

1) Merge the training and the test sets to create one data set.
2) Extract only the measurements on the mean and standard deviation for each measurement. 
3) Use descriptive activity names to name the activities in the data set
4) Appropriately label the data set with descriptive variable names. 
5) From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


The script run_analysis.R performs the following steps:

- Downloads the HCI HAR Dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset  .zip into a data folder created off the working directory (if the data folder does not already exist).

- Decompresses the data (unzip) into .\data\UCI HAR Dataset and subfolders.

- Creates lists of the .txt files contained within the parent directory and the test and train subdirectories.

- Reads data from the subject_test/train, X_test/train and y_test/train files.

- The subject identifiers (from subject_test/train) and activity codes (from y_test/train) were cbinded to the variable data from X_test/train, for each of the test and train datasets.

- The test and train datasets were cbinded into a single dataset (Test_Train_Data) (in an arbitrary order, and remamined unsorted at this stage).

- The list of variable names were read from "features.txt". 

- Variable names were subsetted by creating a logical vector (column_list) of only those which contained the substring "mean()" or "std()". A list of these names (feature_list) was created and appended with the names of the Subject ID and Activity columns.

- The Test_Train_Data dataset was subsetted according to the logical vector (with additional TRUE elements for the Subject ID and Activity columns).

- The activity codes and their corresponding activity descriptions were read from "activity_labels.txt".

- The activity codes in the Test_Train_Data dataset were substituted with the corresponding activity descriptions. 

- These activity descriptions were converted to a factor, with a level order specified to match the order given in "activity_labels.txt", rather than the default alphabetic ordering.

-The variable names (feature_list) read from "features.txt" were modified by using gsup with regular expressions to remove parentheses, doubling of "Body" and convert "t" and "f" to "Time-" and "Freq-".

- The modified variable names were applied as column names.

- Using the dplyr package, Tidy_Dataset was created by grouping the rows by Subject ID then Activity (group_by), then summarising the measurements for each subject and activity by taking the mean.

-The resulting dataset (Tidy_Dataset) was written to "HCI_HAR_TidyDataset.txt".

