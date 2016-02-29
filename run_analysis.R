library(reshape2)

filename <- "getdata_dataset.zip"

# activity and features and cast
activityLabels <- read.table("data/activity_labels.txt")
activityLabels[, 2] <- as.character(activityLabels[, 2])
features <- read.table("data/features.txt")
features[, 2] <- as.character(features[, 2])

# only want the mean and sd stuff
desired_features <- grep(".*mean.*|.*std.*", features[,2])
desired_features.names <- features[desired_features,2]
desired_features.names <- gsub('-mean', 'Mean', desired_features.names)
desired_features.names <- gsub('-std', 'Std', desired_features.names)
desired_features.names <- gsub('[-()]', '', desired_features.names)

# actual training data
train <- read.table("data/train/X_train.txt")[desired_features]
trainAct <- read.table("data/train/Y_train.txt")
trainSubj <- read.table("data/train/subject_train.txt")
train <- cbind(trainSubj, trainAct, train)

# actual test data
test <- read.table("data/test/X_test.txt")[desired_features]
testAct <- read.table("data/test/Y_test.txt")
testSubj <- read.table("data/test/subject_test.txt")
test <- cbind(testSubj, testAct, test)

# merge and name
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", desired_features.names)

# factorize
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

# melt it to change the shape
allData.melted <- melt(allData, id = c("subject", "activity"))

#write out just the mean to a tidy file
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
write.table(allData.mean, "tidy_means.txt", row.names = FALSE, quote = FALSE)