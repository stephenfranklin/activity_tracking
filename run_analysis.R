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
X_train <- read.table('UCI HAR Dataset/train/X_train.txt') # training sample
View(X_train)
dim(X_train)    # 7352  561
features <- read.table('UCI HAR Dataset/features.txt') # 2 561
dim(features)    # 561   2
View(features)
names(X_train) <- features$V2  # now we have named variables.

# Get activity labels
y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
dim(y_train)    # 7352    1
names(y_train) <- "activity"
View(y_train)
yX_train <- cbind(y_train,X_train)
View(yX_train)
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
View(activity_labels)
activities <- factor(as.character(activity_labels$V2),levels = activity_labels$V2)  # as ordered factor
is.factor(activities)   # TRUE
levels(activities)
yX_train$activity <- mapvalues(yX_train$activity, activity_labels$V1, as.character(activities))
is.factor(yX_train$activity)  # FALSE
    ## we want $activity to be a factor in the originally given order.
yX_train$activity <- factor(yX_train$activity, levels=activities)
levels(yX_train$activity)
## Now we have the training activities labeled.

# Get training subjects
subject_train<- read.table("UCI HAR Dataset/train/subject_train.txt")
dim(subject_train)      # 7352 1
names(subject_train) <- "subject"
yX_train <- cbind(subject_train,yX_train)
View(yX_train)
yX_train$subject <- factor(yX_train$subject)
is.factor(yX_train$subject)
levels(yX_train$subject)

### Get testing data and features ###
X_test <- read.table('UCI HAR Dataset/test/X_test.txt') # training sample
View(X_test)
dim(X_test)    # 2947  561
names(X_test) <- features$V2  # now we have named variables.

# Apply activity labels
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
dim(y_test)    # 2947    1
names(y_test) <- "activity"
View(y_test)
yX_test <- cbind(y_test,X_test)
View(yX_test)
yX_test$activity <- mapvalues(yX_test$activity, activity_labels$V1, as.character(activities))
yX_test$activity <- factor(yX_test$activity, levels=activities)
levels(yX_test$activity)
## Now we have the test activities labeled.

# Get testing subjects
subject_test<- read.table("UCI HAR Dataset/test/subject_test.txt")
dim(subject_test)      # 2947    1
names(subject_test) <- "subject"
yX_test <- cbind(subject_test,yX_test)
View(yX_test)
yX_test$subject <- factor(yX_test$subject)
is.factor(yX_test$subject)
levels(yX_test$subject)
# We now have well labeled training and test data.frames
# And the subject and activity variables are factors.

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
levels(Mean_Std$subject)    # train [1:30] then test [2:24].
                            # not sure that's what we want.
levels(Mean_Std$activity)   # goood.

# Create a second, independent tidy data set with the average 
#   of each variable for each activity and each subject.
s<-split(Mean_Std, list(Mean_Std$activity,Mean_Std$subject), drop=TRUE)
str(s,1)
Averages<-data.frame(t(sapply(s, function(x) colMeans(x[, 3:68]))))
    ## t() is transpose.
View(Averages)
