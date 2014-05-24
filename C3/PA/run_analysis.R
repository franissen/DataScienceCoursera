# To run this program it's required that the folder with data have the name of "UCI HAR Dataset"
# 0) Get into memory all the required data
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subject2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
x2 <- read.table("UCI HAR Dataset/test/X_test.txt")
x1 <- read.table("UCI HAR Dataset/train/X_train.txt")
y2 <- read.table("UCI HAR Dataset/test/y_test.txt")
y1 <- read.table("UCI HAR Dataset/train/y_train.txt")

# 1) Merges the training and the test sets to create one data set.
subject <- rbind(subject1, subject2)
x <- rbind(x1, x2)
y <- rbind(y1, y2)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x <- x[, indices_of_good_features]
names(x) <- features[indices_of_good_features, 2]
names(x) <- tolower(gsub("\\(|\\)", "", names(x)))
#names(x) <- tolower(names(x))

# 3) Uses descriptive activity names to name the activities in the data set
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
y[,1] = activities[y[,1], 2]
names(y) <- "activity"

# 4) Appropriately labels the data set with descriptive activity names. 
names(subject) <- "subject"
merged <- cbind(subject, y, x)

write.table(merged, "merged_data.txt")

# 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
num_activities = length(activities[,1])
num_subjects = length(unique(subject)[,1])
unique_subjects = unique(subject)[,1]

num_cols = dim(merged)[2]

result <- matrix(NA, nrow=num_subjects*num_activities, ncol=num_cols)
result <- as.data.frame(result)
colnames(result) <- colnames(merged)

row = 1
for (s in 1:num_subjects) {
  for (a in 1:num_activities) {
    condition1 <- s == merged$subject
    condition2 <- activities[a, 2] == merged$activity
	
	result[row, 1] = unique_subjects[s]	
    result[row, 2] = activities[a, 2]	
    result[row, 3:num_cols] <- colMeans(merged[condition1&condition2, 3:num_cols])
	
    row <- row + 1
  }
}

write.table(result, "means_data.txt")