# Description...

column_names <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE, colClasses = c("numeric", "character"))

# Read training set and merge with subject and activity
x_train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE, colClasses = c(rep("numeric", 561)))
names(x_train) = column_names[,2]
s_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE, colClasses = c("numeric"))
names(s_train) = c("Subject")
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE, colClasses = c("numeric"))
names(y_train) = c("Activity")
train <- cbind(x_train, s_train, y_train)

rm(list = c("x_train", "s_train", "y_train")) # clean up


# Read test set and merge with subject and activity
x_test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE, colClasses = c(rep("numeric", 561)))
names(x_test) = column_names[,2]
s_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE, colClasses = c("numeric"))
names(s_test) = c("Subject")
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE, colClasses = c("numeric"))
names(y_test) = c("Activity")
test <- cbind(x_test, s_test, y_test)

rm(list = c("x_test", "s_test", "y_test")) # clean up

# update column names
column_names <- rbind(column_names, c(562, "Subject"))
column_names <- rbind(column_names, c(563, "Activity"))

# Merge training with test set
full_set <- rbind(train, test)

# Remove columns with duplicated names
full_set <- full_set[!duplicated(column_names[,2])]

# Extract mean and std
sensor_data <- select(full_set, matches("mean\\(\\)|std\\(\\)|Subject|Activity"))

rm(list = c("full_set", "test", "train")) # clean up

# Merge with activity labels
#activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE, colClasses = c("numeric", "character"))

sensor_data <- mutate(sensor_data, ActivityName = recode(sensor_data$Activity, `1` = "WALKING", `2` = "WALKING_UPSTAIRS", `3` = "WALKING_DOWNSTARIS", `4` = "SITTING", `5`= "STANDING", `6` = "LAYING"))

# Set descriptive column names
sensor_colnames <- c(
  "BodyAccMeanX",
  "BodyAccMeanY",
  "BodyAccMeanZ",
  "BodyAccStdX",
  "BodyAccStdY",
  "BodyAccStdZ",
  "GravityAccMeanX",
  "GravityAccMeanY",
  "GravityAccMeanZ",
  "GravityAccStdX",
  "GravityAccStdY",
  "GravityAccStdZ",
  "BodyAccJerkMeanX",
  "BodyAccJerkMeanY",
  "BodyAccJerkMeanZ",
  "BodyAccJerkStdX",
  "BodyAccJerkStdY",
  "BodyAccJerkStdZ",
  "BodyGyroMeanX",
  "BodyGyroMeanY",
  "BodyGyroMeanZ",
  "BodyGyroStdX",
  "BodyGyroStdY",
  "BodyGyroStdZ",
  "BodyGyroJerkMeanX",
  "BodyGyroJerkMeanY",
  "BodyGyroJerkMeanZ",
  "BodyGyroJerkStdX",
  "BodyGyroJerkStdY",
  "BodyGyroJerkStdZ",
  "BodyAccMagMean",
  "BodyAccMagStd",
  "GravityAccMagMean",
  "GravityAccMagStd",
  "BodyAccJerkMagMean",
  "BodyAccJerkMagStd",
  "BodyGyroMagMean",
  "BodyGyroMagStd",
  "BodyGyroJerkMagMean",
  "BodyGyroJerkMagStd",
  "FrequencyBodyAccMeanX",
  "FrequencyBodyAccMeanY",
  "FrequencyBodyAccMeanZ",
  "FrequencyBodyAccStdX",
  "FrequencyBodyAccStdY",
  "FrequencyBodyAccStdZ",
  "FrequencyBodyAccJerkMeanX",
  "FrequencyBodyAccJerkMeanY",
  "FrequencyBodyAccJerkMeanZ",
  "FrequencyBodyAccJerkStdX",
  "FrequencyBodyAccJerkStdY",
  "FrequencyBodyAccJerkStdZ",
  "FrequencyBodyGyroMeanX",
  "FrequencyBodyGyroMeanY",
  "FrequencyBodyGyroMeanZ",
  "FrequencyBodyGyroStdX",
  "FrequencyBodyGyroStdY",
  "FrequencyBodyGyroStdZ",
  "FrequencyBodyAccMagMean",
  "FrequencyBodyAccMagStd",
  "FrequencyBodyBodyAccJerkMagMean",
  "FrequencyBodyBodyAccJerkMagStd",
  "FrequencyBodyBodyGyroMagMean",
  "FrequencyBodyBodyGyroMagStd",
  "FrequencyBodyBodyGyroJerkMagMean",
  "FrequencyBodyBodyGyroJerkMagStd",
  "Subject",
  "Activity",
  "ActivityName"
)

colnames(sensor_data) <- sensor_colnames

# Group data according to subject and activity
sensor_data_grouped <- group_by(sensor_data, Subject, ActivityName)

output_set <- summarise_all(sensor_data_grouped, funs(mean))

# Write output_set to file
write.csv(output_set, file = "sensor_set.csv", row.names = FALSE)
