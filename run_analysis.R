#run_analysis.R
# loading the libraries that I will use:
library(data.table)
library(dplyr)

# 1) Merges the training and the test sets to create one data set.
trainsubjects<-read.table("./UCI HAR Dataset/train/subject_train.txt")
testsubjects<-read.table("./UCI HAR Dataset/test/subject_test.txt")
# allsubjects will be the merged table of subjects in training sample and in test sample:
# using rbind() to create the merged table "allsubjects":
# this new object is a data table with 1 variable that contains the identifiers of the subjects 
# who participated in the experiment:
# I chose to give a more meaningful name to this variable, namely: subjid.
# for more details about the choice of variable names: please see in  my "codebook" file.
allsubjects<-data.table(rbind(trainsubjects,testsubjects))
allsubjects <- rename(allsubjects, subjid=V1)
# ..............................................................................
# 2) in the same way, "allactivities" will be a merged table of activities 
# in training sample and in test sample : 
# here, the variable "activitycode" designates the different phases of physical 
# activities that gave rise to measurements.
# this variable : "activitycode" may have six different values according to the 
# description of the original file "activity_labels.txt"        ....
trainactivities<-data.table(read.table("./UCI HAR Dataset/train/y_train.txt"))
testactivities <- data.table(read.table("./UCI HAR Dataset/test/y_test.txt"))
allactivities<-data.table(rbind(trainactivities,testactivities))
allactivities<-rename(allactivities, activitycode=V1)
# naming activities levels in the data set:
# for more details about the choice of variable names: please see in  my "codebook" file.
allactivities$activitycode<-factor(allactivities$activitycode,
    levels=c(1:6),
    labels=c("walking","walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying"))
# ------------------------------------------------------------------- #

features<-read.table(file = "./UCI HAR Dataset/features.txt")
trainset <- data.table(read.table("./UCI HAR Dataset/train/X_train.txt"))
testset<- data.table(read.table(file = "./UCI HAR Dataset/test/X_test.txt"))
allset <- data.table(rbind(trainset,testset)) 
#featuressubset<-grep("mean()|std()", features[,2])
#featuressubset<-grep("mean()|std()|Mean", features[,2])
featuressubset<-grep("mean[^Freq]()|std()", features[,2])
meanandstdsubset<-allset[,..featuressubset]
subfea<-features[featuressubset,]
namesvec <- as.character(subfea$V2)
meanandstdsubset <- setnames(meanandstdsubset, namesvec)

#Creating a grouped tidydataset : step4:
# data set is already labeled with descriptive variable names...
# ... because labels added during each step.
tidydataset<-cbind(allsubjects, allactivities, meanandstdsubset)

#From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
#tidyarr<-arrange(tidydataset, activitycode, subjid)
#newtidydata<-melt(tidydataset, id.vars = c("subjid", "activitycode"))
#aqw <-dcast(newtidydata, formula = subjid +activitycode ~variable)
# ds<-group_by(tidydataset, activitycode,subjid)
# ds.avg<-summarise_all(ds,funs(mean))
tidydatasetG<-group_by(tidydataset, activitycode,subjid)
tidydatasetG<-summarise_all(tidydatasetG, funs(mean))

write.table(tidydatasetG, "tidydatasetG.txt", row.names = FALSE)
