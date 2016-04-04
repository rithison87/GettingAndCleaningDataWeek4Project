# Rithi Son

# Section 0: load dplyr and tidyr library
library(dplyr)
library(data.table)

# Section 1: set directory to location of files
setwd("C:/Users/rithison/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

# Section 2: store the various text files into variables (activity labels, features, test and train datasets)
activity_labels <- read.delim("activity_labels.txt", header=FALSE)
features <- read.delim("features.txt", header=FALSE)
subject_test <- read.delim("C:/Users/rithison/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
x_test <- readLines("C:/Users/rithison/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.delim("C:/Users/rithison/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_train <- read.delim("C:/Users/rithison/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
x_train <- readLines("C:/Users/rithison/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.delim("C:/Users/rithison/Documents/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header=FALSE)

#  Section 3: replace 2 spaces with 1 "s", then split columns by "s", delete first column
x_test <- gsub("\\s\\s?", "\\s", x_test)
tc1 <- textConnection(x_test)
x_test <- read.table(tc1, sep="s")
close(tc1)
x_test[1] <- NULL

x_train <- gsub("\\s\\s?", "\\s", x_train)
tc2 <- textConnection(x_train)
x_train <- read.table(tc2, sep="s")
close(tc2)
x_train[1] <- NULL

# Section 4: labelling the test and train datasets with descriptive variable names; naming columns
features_unlist <- unlist(features)
x_test <- setNames(x_test, features_unlist)
x_train <- setNames(x_train, features_unlist)
names(y_test) <- c("ActivityID")
names(subject_test) <- c("SubjectID")
names(y_train) <- c("ActivityID")
names(subject_train) <- c("SubjectID")

# Section 5: cbind test datasets together, then sort columns
x_test_y_test_subject_test <- cbind(subject_test, y_test, x_test)

# Section 6: cbind train datasets together
x_train_y_train_subject_train <- cbind(subject_train, y_train, x_train)

# Section 7: rbind test and train datasets into large dataset
combined_test_train <- rbind(x_test_y_test_subject_test, x_train_y_train_subject_train)

# Section 8: add two columns to activity_levels: ActivityID and ActivityName
activity_labels$ActivityID <- 1:nrow(activity_labels)
activity_labels$ActivityName <- c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying")

# Section 9: extract any columns that are means and standard deviations for the combined dataset
combined_mean_std <- data.frame(combined_test_train$SubjectID, combined_test_train$ActivityID, subset(combined_test_train, select = grep(".(mean[^Ff]|std).", names(combined_test_train))))

# Section 10: update the combined dataset so the activity description is included
combined_activity <- inner_join(activity_labels, combined_test_train, "ActivityID")

# Section 11: create independent dataset that is the means of each variable for each Subject and Activity
combined_all_variables_mean <- combined_activity %>% 
  group_by(SubjectID, ActivityName) %>%
  summarise_each(funs(mean(., na.rm = TRUE)), -ActivityID, -V1)

# Section 12: export independent dataset into tab-delimited text file
write.table(combined_all_variables_mean, "all_variable_means.txt", sep="\t", row.names = FALSE)
