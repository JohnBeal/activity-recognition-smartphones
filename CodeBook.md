#HCI HAR Tidy Dataset Codebook

Experimental Design and background:

Measurements were carried out on a group of 30 volunteers aged 19-48 years, while they performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). The embedded accelerometer and gyroscope of a smartphone worn on the subject's waist measured 3-axial linear acceleration and angular velocity at a rate of 50 Hz. The sensor signals were preprocessed with noise filters and sampled in 2.56 s windows with 50% overlap. A series of variables were calcultated for each window. The acceleration signal was decomposed into a body acceleration and gravitational component with a Butterworth low-pass filter (0.3 Hz). Jerk signals were derived from the body linear accleration and angular velocity and the magnitudes were calculated using the Euclidean norm. Fast Fourier Transform was applied to some signals to transform from the time to frequency domain.    

Raw data:

The preprocessed data of the HCI HAR Dataset was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The dataset had been split into "test" and "train" subsets containing 30% and 70% of the subjects, respectively. The following files from the dataset were used in preparing the tidy dataset:

- 'README.txt'                          Experiment design and general information
- 'features_info.txt':                  Gives information on the variables 
- 'features.txt':                       Lists the codes and corresponding variable names of the 561-feature vector
- 'activity_labels.txt':                Links the activity codes with the corresponding activity names
- 'subject_test/train.txt':             Lists the subject ID code for each row in the test/train datasets    
- 'X_test/train.txt':                   Contains the data from the 561 feature variables 
- 'y_test/train.txt:                    Lists the activity code for each row in the test/train datasets

 
Data Processing:

1) Data was read from the "subject_test/train.txt", "X_test/train.txt" and "y_test/train.txt" files.
2) The subject identifier (Subject ID) and activity code (Activity) for each row were appended to "X_test/train" from  "subject_test/train" and "y_test/train", respectively. This was done for each of the "test" and "train" datasets.
3) The "test" and "train" datasets were merged by column (rbind without sorting)
4) A list of feature names was read from the "features.txt" file, and the merged dataset was subsetted to include only those variables which contained the strings "mean()" or "std()" in their descriptions - denoting the mean and standard deviation, respectively, calculated from each measurement. This did not include the values derived from the angle() variable of the original dataset (gravityMean,tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean).
5) The activity descriptions and their corresponding codes were read from the "activity_labels.txt" file. The activity codes were replaced in the dataset by their descriptions.
6) The variable names given in the "features.txt" were modified by removing parentheses; removing accidentally doubled occurences of the term "Body"; and substituting the prefixs "t" and "f", denoting time and frequency domain, 
respectively, with the more descriptive versions "Time-" and "Freq-". These variable names were then applied to the dataset.
7) The dataset was ordered by Subject ID and then Activity. An independent, tidy dataset was created by taking the mean of each variable for each activity and each subject.    

Field Names:

## Subject_ID    Identication code of experimental subjects
-int: 1-30 

## Activity      Activities performed by experimental subjects
        1 WALKING
        2 WALKING_UPSTAIRS
        3 wALKING_DOWNSTAIRS
        4 SITTING
        5 STANDING
        6 LAYING

"Time-" denotes time-domain signals
"Freq-" denotes signals transformed into the frequency domain by Fast Fourier Transform
"-XYZ" denotes 3-axial signals in the X, Y and Z directions.

## Time-BodyAcc-XYZ             Body acceleration (time domain)
## Time-GravityAcc-XYZ          Gravitational acceleration (time domain)
## Time-BodyAccJerk-XYZ         Jerk signal derived from body acceleration (time domain)
## Time-BodyGyro-XYZ            Body angular velocity (time domain)
## Time-BodyGyroJerk-XYZ        Jerk signal derived from body angular velocity (time domain)
## Time-BodyAccMag              Magnitude of body acceleration (time domain)  
## Time-GravityAccMag           Magnitude of gravity acceleration (time domain)
## Time-BodyAccJerkMag          Magnitude of jerk signal derived from body acceleration (time domain)
## Time-BodyGyroMag             Magnitide of body angular velocity (time domain)
## Time-BodyGyroJerkMag         Magnitide of jerk signal derived from body angular velocity (time domain)
## Freq-BodyAcc-XYZ             Body acceleration (frequency domain)
## Freq-BodyAccJerk-XYZ         Jerk signal derived from body acceleration (frequency domain)
## Freq-BodyGyro-XYZ            Body angular velocity (frequency domain)
## Freq-BodyAccMag              Magnitude of body acceleration (frequency domain)
## Freq-BodyAccJerkMag          Magnitude of jerk signal derived from body acceleration (frequency domain)
## Freq-BodyGyroMag             Magnitude of body angular velocity (frequency domain)
## Freq-BodyGyroJerkMag         Magnitude of jerk signal derived from body angular velocity (frequncy domain)

For each signal was calculated:

mean: mean value
std: standard deviation



