# Downloads the data set and unzip it.
# Will produce a folder called 'UCI HAR Dataset'

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip", method = "curl")
unzip("Dataset.zip")
