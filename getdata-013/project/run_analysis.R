library(plyr)

# 1. Merge the training and the test sets to create one data set.

load.data = function(path) {
  data = read.table(paste0("dataset/", path))
  message("Read the table ", path, ": ", dim(data)[1], " x ", dim(data)[2])
  data
}

x_train = load.data("train/X_train.txt")
y_train = load.data("train/y_train.txt")
subject_train = load.data("train/subject_train.txt")

x_test = load.data("test/X_test.txt")
y_test = load.data("test/y_test.txt") 
subject_test = load.data("test/subject_test.txt")

data = rbind(x_train, x_test)
labels = rbind(y_train, y_test)
subjects = rbind(subject_train, subject_test)
 
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

prettify_feature_names = function(names) {
  names = gsub("\\(\\)", "", names)       # remove "()"
  names = gsub("mean", "Mean", names)     # capitalize M
  names = gsub("std", "Std", names)       # capitalize S
  names = gsub("-", ".", names)           # replace "-" with "."
  names
}

features = load.data("features.txt")
mean.std = grep("mean\\(\\)|std\\(\\)", features[, 2])
filtered_data = data[, mean.std]
names(filtered_data) = prettify_feature_names(features[mean.std, 2])

# 3. Use descriptive activity names to name the activities in the data set.

prettify_activity_names = function(names) {
  names = tolower(names)                  # lowercase
  names = sapply(names, function(s) {     # capitalize and replace "_" with "."
    split = strsplit(s, "_")[[1]]
    paste(toupper(substring(split, 1, 1)), substring(split, 2),
          sep="", collapse=".")
  })
  names
}

activity = load.data("activity_labels.txt")
activity[, 2] = prettify_activity_names(activity[, 2])
labels[, 1] = activity[labels[, 1], 2]

# 4. Appropriately label the data set with descriptive activity names. 

names(subjects) = "Subject"
names(labels) = "Activity"
clean_data = cbind(subjects, labels, filtered_data)
write.table(clean_data, "clean_data.txt", row.names=FALSE)

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

clean_means = ddply(clean_data, .(Subject, Activity), function(data) { 
  colMeans(data[,-c(1,2)])  # Exclude subject and activity columns
})
names(clean_means)[-c(1,2)] = paste0("Mean", names(clean_means)[-c(1,2)])
write.table(clean_means, "clean_means.txt", row.names=FALSE)
