# CodeBook.md
-------------

### A code book describes the variables, the data, 
and any transformations or work that were performed to 
clean up the data.

### Variables
There are 30 subjects, labeled '1' to '30'.
21 of the subjects were in the training set.
9 of the subjects were randomly chosen to be the test set:
"2"  "4"  "9"  "10" "12" "13" "18" "20" "24".

Each of the 30 subjects performed six activities: 	
1	WALKING
2	WALKING_UPSTAIRS
3	WALKING_DOWNSTAIRS
4	SITTING
5	STANDING
6	LAYING 

These activities were measured and 561 features were computed and included
in the raw data.  The features have names such as:
"tBodyAcc-std()-X", "tBodyAcc-energy()-Y", "tBodyAccJerk-correlation()-Y,Z",
etc.
Of which, 65 features computing the mean or the standard deviation 
 were included in this analysis. Such features include::
"tBodyGyro-mean()-X", "tBodyGyroJerk-std()-Y", "tBodyAccJerkMag-std()", etc.

### Data
In the Samsung Galaxy S II, there are two sensors of note, 
an accelerometer in 3 axes, 
and an angular velocity sensor (or rate sensor, or "gyro") in 3 axes.
We can consider the two together as 6 axes.
By separating the data points by different sampling rates, 
many different movements can be computed.
In this analysis, only the mean and the standard deviation of all 6 axes
 were included.

Each subject performed each activity for a period of time 
in which about 30 measurements were taken.

There are 7352 observations in the training set,
and 2947 observations in the test set.

### Work
The raw data was very clean: there were no NAs, there were no dates to process,
and there were no inappropriate data types.
The labels were in separate files and had to be incorporated.

I combined the training and test sets into a single data.frame.
I coerced the subjects and activities into factors to split
 the data.frame so that a colMeans could be taken on each variable.
The output file is "activity.subject.averages.txt"
