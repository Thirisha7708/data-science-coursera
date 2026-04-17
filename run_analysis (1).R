# Load data
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Merge
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Extract mean & std
features_logical <- grepl("mean\\(\\)|std\\(\\)", features[,2])
x <- x[, features_logical]

# Activity names
y[,1] <- activity_labels[y[,1],2]

# Combine all data
data <- cbind(subject, y, x)
colnames(data)[1:2] <- c("Subject", "Activity")

# Create tidy dataset
library(dplyr)

tidy <- data %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

# Save file
write.table(tidy, "tidy_data.txt", row.names = FALSE)