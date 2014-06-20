Getting and Cleaning Data Course Project
==========================

Getting and Cleaning Data Course Project.
The goal is to prepare tidy data that can be used for later analysis.
In order to accomplish the assigment I do the following steps.

Read Data
==========================
From features I read the files:
- "activity_labels.txt": Links the class labels with their activity name.
- 'features.txt': List of all features.

Define col_names: a vector (V1, V2, ..., V561) for reading X_test/train.txt file

From test I read the equivalent files:
- "test/subject_test.txt": Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Name: V562.
- "test/X_test.txt": Test set.
- "test/y_test.txt": Test labels. Name: V563.

From train I read the equivalent files:
- "train/subject_train.txt": Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Name: V562.
- "train/X_train.txt": Training set.
- "train/y_train.txt": Training labels. Name: V563.

Merge Data Sets
==========================
From "test"" I join the 3 files with cbind function. First the Test set, then the subject and finally the label.
I do the same with the 3 "train" files.
With rbind function I make the data_set.

Extracts the measurements on the mean and standard deviation
==========================
From the features table I obtain the index for all the features matching with "mean" or "std".
From the same variable I also obtain the index for "meanFreq" to remove from the "mean" index.
With the cbind function I select the columns from data_set refering to the calculated index plus the subject (V562) and id_Activity (V563) to form the data_mean_std_set.

Uses descriptive activity names
==========================
I add a new column to data_mean_std_set, V564, with the labels of the activities obtained from the activity_labels table.

Appropriately labels the data set with descriptive variable names
==========================
I select the same names from "feature.txt" to each column from 1 to 561.
As names from "features.txt" have "-" and "()" characters if we call them directly R interpret them as operators and functions. So we should refer the with "".
"subject", "id_Activity" and "activity" are the labels for the 3 extra columns.

Tidy data set with the average of each variable for each activity and each subject
==========================
With the agreggate function I construct the tidy data.
In each column we have the mean of each variable for each activity and each subject.
There are 180 rows = 30 subjects * 6 activities.
There are 69 columns, 66 variable columns, 1 subject column, 1 id_Activity column and 1 activity column with the label name.