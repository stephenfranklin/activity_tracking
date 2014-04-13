# activity_tracking
-------------------

### Examining a study: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

### The raw data is located here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Put that .zip in your working directory.
You can extract it or let run_analysis.R extract it.

### run_analysis.R
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### activity.subject.averages.txt
The output file: 180 observations of 65 variables.

### CodeBook.md
Describes the variables, the data, 
and any transformations or work that were performed to 
clean up the data.