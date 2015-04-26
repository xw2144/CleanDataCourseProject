setwd("UCI HAR Dataset")

subject_train <- read.table("train/subject_train.txt", header=F)
X_train <- read.table("train/X_train.txt", header=F)
y_train <- read.table("train/y_train.txt", header=F)

subject_test <- read.table("test/subject_test.txt", header=F)
X_test <- read.table("test/X_test.txt", header=F)
y_test <- read.table("test/y_test.txt", header=F)

mydat1 <- rbind(subject_train, subject_test)
mydat1f <- data.frame(mydat1)
names(mydat1f) <- "subject"

mydat2 <- rbind(y_train, y_test)
ylabel <- read.table("activity_labels.txt", header=F)
labelmatch <- merge(mydat2, ylabel, by.x="V1", by.y="V1")
mydat2f <- data.frame(labelmatch[,2])
names(mydat2f) <- "activity"

features <- read.table("features.txt", header=F)
mydat3 <- rbind(X_train, X_test)
mydat3f <- data.frame(mydat3)
names(mydat3f) <- as.factor(features[,2])

mydat <- cbind(mydat1f, mydat2f, mydat3f)

meanid <- grep("mean", names(mydat))
stdid <- grep("std", names(mydat))
pickid <- c(meanid, stdid)

mydat_meanstd <- mydat[ , c(1,2,pickid)]


aa <- mydat_meanstd
samsung <- aggregate(aa[,3:81],by=list(aa[,1],aa[,2]), mean)

write.table(samsung, "samsung.txt", row.name=FALSE)




