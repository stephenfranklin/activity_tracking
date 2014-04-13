# gc_assignment.R 
rm(list = ls())
library(plyr)

###--> Be sure to change your working directory here:
setwd("/Users/s/git_folder/datascience/getclean/activity_tracking/")

# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
###--> Download and place the "UCI HAR Dataset" zip or directory 
###    within your working directory.
if(!file.exists("UCI HAR Dataset")){
    cat(sprintf("The dataset isn't unzipped\n"))
     if(file.exists("getdata_projectfiles_UCI HAR Dataset.zip")){
         str(sprintf("I'm unzipping the dataset.\n"))
         unzip("getdata_projectfiles_UCI HAR Dataset.zip") 
     } else str(sprintf("The dataset zipfile isn't here.\n"))
} else cat(sprintf("Good, the dataset is here.\n"))

# A full description is available at the site where the data
# was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 

# Create one R script called run_analysis.R that does the following: 
# 1 Merges the training and the test sets to create one data set. 
# 2 Extracts only the measurements on the mean and standard deviation 
#   for each measurement. 
# 3 Uses descriptive activity names to name the activities 
#   in the data set.
# 4 Appropriately labels the data set with descriptive activity names. 
# 5 Creates a second, independent tidy data set with the average 
#   of each variable for each activity and each subject.

#unzip("getdata_projectfiles_UCI_HAR_Dataset.zip") 

## I've changed the working directory to this:
# The unzipped directory is: "UCI_HAR_Dataset"
## I put in the [_]s.
# Within that are many files which are explained by the README.
#  We're looking for the training set and the test set:
# 'train/X_train.txt'
# 'test/X_test.txt'
# Those files have data (7352 observations) 
# but no feature or observation labels.
# In addition to those labels, there are also groups of activities,
# and those also are without labels.
# The activity labels (as numbers 1:6) are located in:
#   'train/y_train.txt'
#   'test/y_test.txt'
# Those are lists of 1:6 representing activity labels. 
# The actual activity labels are located in:
#   'activity_labels.txt'
# There's also the files:
#   'train/subject_train.txt'
#   'test/subject_test.txt'
#   where each row identifies the subject (int, 1:30) 
#   who performed the activity for each window sample. 
# The features (columns) are listed in features.txt. There are 561.

### Get training data and features ###
X_train <- read.table('train/X_train.txt') # training sample
View(X_train)
dim(X_train)    # 7352  561
features <- read.table('features.txt') # 2 561
dim(features)    # 2 561
View(features)
names(X_train) <- features$V2  # now we have named variables.

# Get activity labels
y_train <- read.table('train/y_train.txt')
dim(y_train)    # [1] 7352    1
names(y_train) <- "activity"
View(y_train)
yX_train <- cbind(y_train,X_train)
View(yX_train)
activity_labels <- read.table('activity_labels.txt')
View(activity_labels)
yX_train$activity <- mapvalues(yX_train$activity, activity_labels$V1, as.character(activity_labels$V2))
## Now we have the training activities labeled.

# Get training subjects
subject_train<- read.table("train/subject_train.txt")
dim(subject_train)      # 7352 1
names(subject_train) <- "subject"
yX_train <- cbind(subject_train,yX_train)
View(yX_train)

### Get testing data and features ###
X_test <- read.table('test/X_test.txt') # training sample
View(X_test)
dim(X_test)    # 2947  561
names(X_test) <- features$V2  # now we have named variables.

# Apply activity labels
y_test <- read.table('test/y_test.txt')
dim(y_test)    # 2947    1
names(y_test) <- "activity"
View(y_test)
yX_test <- cbind(y_test,X_test)
View(yX_test)
yX_test$activity <- mapvalues(yX_test$activity, activity_labels$V1, as.character(activity_labels$V2))
## Now we have the test activities labeled.

# Get testing subjects
subject_test<- read.table("test/subject_test.txt")
dim(subject_test)      # 2947    1
names(subject_test) <- "subject"
yX_test <- cbind(subject_test,yX_test)
View(yX_test)
# We now have well labeled training and test data.frames

# Merge train and test sets
yX <- rbind(yX_train,yX_test)
dim(yX)     # 10299   563

# Extract only the measurements on the mean and standard deviation 
#   for each measurement. 
View(yX)
names(yX[201:300])
i <- grep("(mean\\()|(std)", names(yX))
Mean_Std <- yX[,c(1,2,i)]
View(Mean_Std)

# Create a second, independent tidy data set with the average 
#   of each variable for each activity and each subject.
