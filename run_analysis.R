# Read Data 
## From Features
file = "./UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(file, sep = " ", header = FALSE)
names(activity_labels) <- c("id", "label")
file = "./UCI HAR Dataset/features.txt"
features <- read.table(file, sep = " ", header = FALSE)
names(features) <- c("id", "feature")

col_names = paste(c(rep("V", 561)), c(1:561), sep ="")

## From Test Data
file= "./UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.table(file, sep = " ", header = FALSE)
names(subject_test) <- "V562"
file= "./UCI HAR Dataset/test/X_test.txt"
X_test <- read.table(file, sep = "", header = FALSE, col.names = col_names)
file= "./UCI HAR Dataset/test/y_test.txt"
y_test <- read.table(file, sep = " ", header = FALSE)
names(y_test) <- "V563"

## From Train Data
file= "./UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.table(file, sep = " ", header = FALSE)
names(subject_train) <-"V562"
file= "./UCI HAR Dataset/train/X_train.txt"
X_train <- read.table(file, sep = "", header = FALSE, col.names = col_names)
file= "./UCI HAR Dataset/train/y_train.txt"
y_train <- read.table(file, sep = " ", header = FALSE)
names(y_train) <- "V563"

# Merge Data Sets
test_set = cbind(X_test, subject_test, y_test)
train_set = cbind(X_train, subject_train, y_train)
data_set = rbind(train_set, test_set)

# Extracts the measurements on the mean and standard deviation
index = sort(grep("mean|std", features$feature))
index_freq = grep("meanFreq", features$feature)
index = index[! index %in% index_freq]
data_mean_std_set = cbind(data_set[,index], data_set[,562:563])

# Uses descriptive activity names
data_mean_std_set[, "V564"] <- activity_labels[data_mean_std_set$V563, 2]

# Appropriately labels the data set with descriptive variable names
names(data_mean_std_set) <- c(as.character(features[index,]$feature), "subject",
                              "id_Activity", "activity")

# Tidy data set with the average of each variable for each activity and each subject
tidy_data <- aggregate(.~subject+id_Activity+activity, FUN=mean, data=data_mean_std_set)
write.table(tidy_data, file = "./Getting_Cleaning_Data_Project/output.txt")