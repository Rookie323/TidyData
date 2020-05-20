## This code is to complete the course project
##  First we will load the Training data and combine it
##  Second, repeat for the Test data
##  retain ID, Activity, and all columns with mean or std
##  Combine data using rbind
## use dplyr to summarize the data (mean and sd)


library(plyr)
library(dplyr)

##Load and combine Train Data
activitylabel <- read.table(file = "Data/Activity_labels.txt" , col.names = c("label", "activity"))
View(activitylabel)

features<- read.table(file="Data/features.txt", col.names = c("label", "feature"))
View(features)


train_subject <- read.table(file = "Data/train/subject_train.txt")
View(train_subject)


x_train <- read.table(file = "Data/train/X_train.txt")
y_train <- read.table(file = "Data/train/y_train.txt")


colnames(train_subject) <- "ID"
colnames(x_train) <- features$feature
colnames(y_train) <- "Activity"


Training<- cbind(train_subject, y_train, x_train)

Training$Activity <- factor(Training$Activity, levels = activitylabel$label, labels = activitylabel$activity)

###load and combine test data

test_subject <- read.table(file = "Data/test/subject_test.txt")


x_test <- read.table(file = "Data/test/X_test.txt")
y_test <- read.table(file = "Data/test/y_test.txt")


colnames(test_subject) <- "ID"
colnames(x_test) <- features$feature
colnames(y_test) <- "Activity"


Testing<- cbind(test_subject, y_test, x_test)

Testing$Activity <- factor(Testing$Activity, levels = activitylabel$label, labels = activitylabel$activity)

#Retain columsn with mean and std
TestingMeanSTD <- Testing[,grepl(pattern = "ID|Activity|mean|std", x = names(Testing))]
colnames(TestingMeanSTD)

TrainingMeanSTD <- Training[,grepl(pattern = "ID|Activity|mean|std", x = names(Training))]
colnames(TrainingMeanSTD)

##combine the data
AllData <- rbind(TestingMeanSTD, TrainingMeanSTD)

##Summarize day by ID and Activity with mean and sd
Final <- AllData %>% group_by(ID, Activity) %>% summarise_all(funs(mean, sd))


#create table to upload to coursera

write.table(x = Final, file = "Data/summary.txt", row.names = F)
names(AllData)
