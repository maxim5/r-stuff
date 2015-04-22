download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="dataset.zip", method="curl")
unzip("dataset.zip")
file.rename("UCI HAR Dataset", "dataset")
