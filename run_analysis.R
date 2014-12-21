library(dplyr)
        
        ## Download and unzip UCI HAR dataset in a data directory off the working directory 

URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data")){dir.create("./data")}                ##Create data folder 
filename<-paste("./data", basename(URL), sep = "/")             ##Generate file name from URL
if(!file.exists(filename)) {                                    ##Download data if file doesn't already exist locally
        download.file(URL, filename)
        dateDownloaded<-date()                                  ##Record date downloaded
        unzip(filename, exdir="./data", overwrite = FALSE)      ##Unzip data to ./data folder        
}                       

        ## Read test and train datasets into data frames

filepath<-"./data/UCI HAR Dataset"                              ##Create file path to UCI HAR Dataset folder

## Create lists of files in UCI HAR Dataset root folder and the test and train subfolders
filelist_root<-list.files(filepath, pattern = "\\.txt$", full.names = TRUE)
filelist_test<-list.files(paste(filepath, "test", sep ="/"), pattern = "\\.txt$", full.names = TRUE)
filelist_train<-list.files(paste(filepath, "train", sep ="/"), pattern = "\\.txt$", full.names = TRUE)

##For "train" and "test", read "subject", "X" and "y" datasets from respective files 
subject_test<-read.table(filelist_test[1], col.names = "Subject ID")
X_test<-read.table(filelist_test[2])
y_test<-read.table(filelist_test[3],col.names = "Activity")
subject_train<-read.table(filelist_train[1], col.names = "Subject ID")
X_train<-read.table(filelist_train[2])
y_train<-read.table(filelist_train[3],col.names = "Activity")

## Append subject and activity ID columns to X_test ad X_train
Test_data<-cbind(subject_test, y_test, X_test)
Train_data<-cbind(subject_train, y_train, X_train)

        ## (1) Merges the training and the test sets to create one data set

Test_Train_Data<-rbind(Test_data, Train_data)                  

        ## (2) Extract only the measurements on the mean and standard deviation for each measurement

features<-read.table(filelist_root[2], sep = "", stringsAsFactors = FALSE)## Read list of feature names from features.txt
column_list<-grepl("mean\\(\\)|std\\(\\)", features[,2])                  ## Generate logical vector of feature names  
                                                                          ## containing the strings "mean()" or "std()" 

## Derive list of subsetted feature names and append additional column names for Subject ID, Activity and Data_subset
feature_list<-features[column_list, 2]                  
feature_list<-append(feature_list, c("Subject_ID", "Activity"), after = 0)             

column_list<-append(column_list, rep(TRUE, times = 2), after=0)           ## Append "Subject ID", "Activity" and 
                                                                          ## by appending TRUE values to
                                                                          ## corresponding positions  
                                                                          ## in logical vector
                                      
Test_Train_Data<-Test_Train_Data[,column_list]                            ## Extract measurements of mean 
                                                                          ## and standard deviation

        ## (3) Use descriptive activity names to name the activities in the data set

activity_labels<-read.table(filelist_root[1], sep = "") ## Read activity descriptions from activity_labels file
for (i in 1:6) {
        Test_Train_Data$Activity<-gsub(activity_labels[i,1], activity_labels[i,2], Test_Train_Data$Activity)
}                                                       ## For each entry in activity_labels, sustitute activity 
                                                        ## description for activity number in Activity column of dataset
                                                        ## Reassign factor levels to match order given in activity_levels
Test_Train_Data$Activity<-factor(Test_Train_Data$Activity, levels(activity_labels[,2]) [c(4,6,5,2,3,1)])
       
        ## (4) Appropriately label the data set with descriptive variable names

feature_list<-gsub("\\(\\)", "", feature_list)          ## Remove parentheses from feature names   
feature_list<-gsub("BodyBody", "Body", feature_list)    ## Replace occurences of "BodyBody" with "Body" to match codebook
feature_list<-gsub("^t", "Time-", feature_list)         ## Replace prefixes "t" (denoting time) and "f" (denoting   
feature_list<-gsub("^f", "Freq-", feature_list)         ## frequency) with more descriptive "Time-" and "Freq-", 
                                                        ## respectively

colnames(Test_Train_Data)<-feature_list                 ## Assign modified feature names as variable names

        ## (5) Create a second, independent tidy data set with the average of each variable 
        ## for each activity and each subject.

Tidy_Dataset<-group_by(Test_Train_Data, Subject_ID, Activity)   ## Create dataset grouped by Subject ID, then Activity
Tidy_Dataset<-summarise_each(Tidy_Dataset, funs(mean))          ## Collapse dataframe taking the mean for each grouping

write.table(Tidy_Dataset, "Tidy_Dataset.txt", row.names = FALSE) 
        
