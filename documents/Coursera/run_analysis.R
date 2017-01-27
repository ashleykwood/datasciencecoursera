## This file will read datasets for testing and training data (provided they are in your
#working directory), merge the two sets into a single dataset, add desriptive names to the
#variables and activities, extract the mean values and standard deviation of each measurement,
#and finally, create a new data frame consisting of the mean value of every measurement, for each 
#activity for all subjects.

test<-read.table("~/UCI HAR Dataset/test/X_test.txt",header=F)             #read training and testing data feature vectors
train<-read.table("~/UCI HAR Dataset/train/X_train.txt",header=F)            

feature.labels<-read.table("~/UCI HAR Dataset/features.txt")                #read names of feature vector
feature.labels <- feature.labels[,2]                                        #keep only column of names, change class from factor to character
feature.labels <- as.character(feature.labels)
for (i in 1:nrow(feature.labels)){
  feature.labels[i,1]<-paste0(feature.labels[i,1],feature.labels[i,2])
}
feature.labels <-feature.labels[,1]

subject.test<-read.table("~/UCI HAR Dataset/test/subject_test.txt")         #read testing and training subject IDs
subject.train<-read.table("~/UCI HAR Dataset/train/subject_train.txt")      

trainlab<-read.table("~/UCI HAR Dataset/train/y_train.txt",header=F)        #read numbers describing activity performed
testlab<-read.table("~/UCI HAR Dataset/test/y_test.txt",header=F)

names(test)<-feature.labels                                                 #add names to columns
names(train)<-feature.labels

test <- data.frame(subject.test, testlab,group="test", test)
train <- data.frame(subject.train, trainlab, group="train",train)        
ALLD <- rbind(test,train)                                                   #create large data frame merging test and train data
names(ALLD)[1:2] <- c("id","activity")
ALLD$activity <- as.character(ALLD$activity)

ALLD$activity[ALLD$activity==1] <- "walking"                                #name the activities
ALLD$activity[ALLD$activity==2] <- "walking_upstairs"
ALLD$activity[ALLD$activity==3] <- "walking_dowstairs"
ALLD$activity[ALLD$activity==4] <- "sitting"
ALLD$activity[ALLD$activity==5] <- "standing"
ALLD$activity[ALLD$activity==6] <- "lying"

mean_meas <- data.frame(measurement=feature.labels,mean=sapply(ALLD[,4:ncol(ALLD)],mean))   #find mean and standard deviation of all measurement and store them in data frame
sd_meas <- data.frame(measurement=feature.labels, SD=sapply(ALLD[,4:ncol(ALLD)],sd))

summary.stats <- data.frame(measurement=mean_meas[,1],mean=mean_meas[,2],SD=sd_meas[,2]) #data frame with mean of each activity in second column, standard deviation in third  

all.stats <- aggregate(ALLD[,4:ncol(ALLD)],by=list(ID=ALLD$id,activity=ALLD$activity),mean)   #create dataframe containing average of each variable for each ativity of each subject 
all.stats <- arrange(all.stats,ID,activity)                                                   #sort data frame by subject