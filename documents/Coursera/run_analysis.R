## This file will read datasets for testing and training data (provided the the folder UCH HAR Dataset is in your working directory), merge the two sets into a single dataset, add desriptive names to the variables and activities, extracts only the the mean values and standard deviation measurements,and finally, create a new data frame consisting of the mean value of every measurement, for each activity for all subjects.


#required package
library(dplyr)

#read training and testing data feature vectors
test<-read.table("~/UCI HAR Dataset/test/X_test.txt",header=F)             
train<-read.table("~/UCI HAR Dataset/train/X_train.txt",header=F)

#read names of feature vector
feature.labels<-read.table("~/UCI HAR Dataset/features.txt")

#merge both columns of feature label vector together to ensure that all labels are unique
feature.labels <- as.character(feature.labels)
for (i in 1:nrow(feature.labels)){  feature.labels[i,1]<-paste0(feature.labels[i,1],feature.labels[i,2])}
feature.labels <-feature.labels[,1]

#read testing and training subject IDs
subject.test<-read.table("~/UCI HAR Dataset/test/subject_test.txt")         
subject.train<-read.table("~/UCI HAR Dataset/train/subject_train.txt")

#read numbers describing activity performed
trainlab<-read.table("~/UCI HAR Dataset/train/y_train.txt",header=F)        
testlab<-read.table("~/UCI HAR Dataset/test/y_test.txt",header=F)

#add names to columns
names(test)<-feature.labels                                                 
names(train)<-feature.labels

#create large data frame merging test and train datanames
test <- data.frame(subject.test, testlab,group="test", test)
train <- data.frame(subject.train, trainlab, group="train",train)        
ALLD <- rbind(test,train)                                                   
(ALLD)[1:2] <- c("id","activity")
ALLD$activity <- as.character(ALLD$activity)

#choose measurements that contain only the mean or standarad deviation
ALLD <- select(ALLD,id,activity,contains("mean"),contains("std"))

#name the activities
ALLD$activity[ALLD$activity==1] <- "walking"                                
ALLD$activity[ALLD$activity==2] <- "walking_upstairs"
ALLD$activity[ALLD$activity==3] <- "walking_dowstairs"
ALLD$activity[ALLD$activity==4] <- "sitting"
ALLD$activity[ALLD$activity==5] <- "standing"
ALLD$activity[ALLD$activity==6] <- "lying"

#create dataframe containing average of each variable for each ativity of each subject 
all.stats <- aggregate(ALLD[,4:ncol(ALLD)],by=list(ID=ALLD$id,activity=ALLD$activity),mean)   

#sort tidy data frame by subject
all.stats <- arrange(all.stats,ID,activity)                                                   
