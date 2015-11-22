README! 

Course project requirement:
Write an R script called run_analysis.R that does the following:-
- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement. 
- Assign descriptive activity names to name the activities in the data set
- Appropriately label the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

-----------------------------------------------------------------  

(A) To run the function run_analysis.R() 

1. Copy the script file (run_analysys.R) to your working directory. 
2. The following files should be in the working directory:-
- features.txt
- activity_labels.txt
- subject_test.txt
- subject_train.txt
- X_test.txt
- y_test.txt
- X_train.txt
- y_train.txt
[Note : Some of these files might be originally stored in sub-directories. Move them to the directory given to the working directory.]
3. Then source run_analysis.R
4. Run the function by typing this in your R console, for example : X_merged <- run_analysis() [The function does not need input argument]
5. The function returns the merged training and test dataset as data frame X_merged 


(B) run_analysis() performs the following tasks:-
1. Read in all the required data files (listed above) and make sure they are in appropriate dimension. 
2. Set appropriate column names for the data sets and unique row names for X_test and X_train.
3. Bind the "subject_id" and "activity_label" to the main measurement datasets X_test and X_train (added as new columns).  
4. Merge these "new" training and test data frames (X_train, X_test) by binding their rows together to form X_merged.
5. Remove duplicated columns in X_merged (duplicates are identified by their column names only, not the data) to get X_noDup.
6. From X_noDup, sift out only mean and std measurements to form X_ms.
7. Add a column to X_ms for "activity name" that corresponds to the record's activity label.   
8. Re-label the columns of X_ms with appropriate names. (Note : Mostly modify the original names given in features.txt, e.g. removing repititions)
9. Reaarrage the dataframe X_ms by melting it into id variables (subject ids and activity names) and measures variables (all columns containing measurement)
10. Re-cast the melted data frame to form the tidy dataset X_tidy, where the subject_id and activity forms the row and the average of the measurements are in the columns  
11. Rename the columns of X_tidy by adding a prefix "Avg" to indicate the values in the columns are the average over the given subject and activity
12. The function returns the merged training and test dataset, X_merged

 
