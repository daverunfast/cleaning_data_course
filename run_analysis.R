### This is the script to process the data

library(data.table)

## This line here is to set the working directory. You can adjust that by your own home directory.

setwd(".")

## Here is the training set
train.set <- fread("./train/X_train.txt")
activity.num <- read.table("./train/y_train.txt", col.names = "Activity",
                           colClasses = "character")

fac.act <- factor(activity.num$Activity, levels=c("1","2","3","4","5","6"),
                  labels = c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                             "SITTING", "STANDING", "LAYING"))
subject.num <- read.table("./train/subject_train.txt", col.names = "Subject")
columns <- read.table("features.txt")
train.set <- cbind(subject.num$Subject, fac.act, train.set)
colnames(train.set) <- c("Subject", "Activity", as.character(columns$V2)) # Getting corrected columne name
col.test.set <- list()
col.test.set <- grep("mean\\(\\)|std\\(\\)", colnames(train.set), value = TRUE)
col.test.set <- c("Subject", "Activity", col.test.set)
train.set <- train.set[, col.test.set, with = FALSE]



## Here is the testing set
test.set <- fread("./test/X_test.txt")
activity2.num <- read.table("./test/y_test.txt", col.names = "Activity",
                           colClasses = "character")
fac.act2 <- factor(activity2.num$Activity, levels=c("1","2","3","4","5","6"),
                  labels = c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                             "SITTING", "STANDING", "LAYING"))
subject2.num <- read.table("./test/subject_test.txt", col.names = "Subject")
test.set <- cbind(subject2.num$Subject, fac.act2, test.set)
colnames(test.set) <- c("Subject", "Activity", as.character(columns$V2)) # Getting corrected columne name

col.test.set <- list()
col.test.set <- grep("mean\\(\\)|std\\(\\)", colnames(train.set), value = TRUE)
col.test.set <- c("Subject", "Activity", col.test.set)
test.set <- test.set[, col.test.set, with = FALSE]

whole <- rbindlist(list(train.set, test.set))#, use.names = TRUE, fill = TRUE)

#write.table(whole, "project-data-table2.csv", row.names = FALSE)

small.table <- whole[, lapply(.SD, mean, na.rm = TRUE), by=c("Subject", "Activity")]

write.table(small.table, "summary-tidy.csv", row.names = FALSE)
