# GettingAndCleaningDataWeek4Project

Rithi Son

Getting and Cleaning Data

Week 4 Project

==================================================

This R script uses data from Human Activity Recognition Using Smartphones Dataset.

==================================================

Section 0: Load libraries dplyr and data.table.

Section 1: Set directory.

Section 2: This section loads data into variables as data frames. The data is read line-by-line.

Section 3: For the x_test and x_train datasets, use regex to identify 1 or 2 spaces and replace with the letter "s". Then split the columns by using "s" as the delimiter.

Section 4: Update the column names for x_train and x_test datasets using the variables from the features dataset. Then name the columns for y_test, y_train, subject_test, and subject_train.

Section 5: cbind all the test datasets together: subject_test, y_test, and x_test.

Section 6: cbind all the train datasets together: subject_train, y_train, and x_train.

Section 7: rbind the train and test datasets together for a combined dataset.

Section 8: Update activity_labels to include descriptive names and an ActivityID for later joining.

Section 9: Extract any columns that contain "mean()" and "std()" and store in variable.

Section 10: Join the activity_labels and combined test/train dataset to include descriptive names for the activities.

Section 11: Create independent dataset that is grouped by the subject and activity performed. Each calculted value is the means of each column name.

Section 12: Write the independent dataset to a tab-delimited text file.
