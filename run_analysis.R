# Description...

column_names <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE, colClasses = c("numeric", "character"))

# Read training set and merge with activity
x_train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE, colClasses = c(rep("numeric", 561)))
names(x_train) = column_names[,2]
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
names(y_train) = c("Activity")
train <- cbind(x_train, y_train)

rm(list = c("x_train", "y_train")) # clean up


# Read test set and merge with activity
x_test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
names(x_test) = column_names[,2]
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
names(y_test) = c("Activity")
test <- cbind(x_test, y_test)

rm(list = c("x_test", "y_test")) # clean up

# update columne names
column_names <- rbind(column_names, c(562, "Activity"))

# Merge training with test set
full_set <- rbind(train, test)

# Remove columns with duplicated names
full_set <- full_set[!duplicated(column_names[,2])]

# Extract mean and std
mean_and_std_set <- select(full_set, matches("mean\\(\\)|std\\(\\)|Activity"))

rm(list = c("full_set", "test", "train")) # clean up

# Merge with activity labels
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)


