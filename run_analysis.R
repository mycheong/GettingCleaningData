## run_analysis.R 
## 21/11/2015 by mycheong
##

run_analysis <- function()
{

## Reading relevant data files into R
##
#filepath <- paste(directory, fname, sep="/")
filepath <- "./features.txt"
features <- read.csv(filepath, header=F, sep="")
features <- features$V2

filepath <- "./activity_labels.txt"
act_label <- read.table(filepath)

filepath <- "./subject_test.txt"
subject_test <- read.table(filepath)

filepath <- "./X_test.txt"
X_test <- read.table(filepath)

filepath <- "./y_test.txt"
y_test <- read.table(filepath)

filepath <- "./subject_train.txt"
subject_train <- read.table(filepath)

filepath <- "./X_train.txt"
X_train <- read.table(filepath)

filepath <- "./y_train.txt"
y_train <- read.table(filepath)

##
## Naming the columns of the measurement datasets: 
## Columns of X_test and X_trainas the elements in features 
## Column of subject_train and subject_test as "subject_id"
## Column of y_train and y_test as "activ_label"
##
colnames(X_test) <- features
colnames(X_train) <- features

colnames(subject_train)<- "subject_id"
colnames(subject_test)<- "subject_id"
colnames(y_train)<- "activ_label"
colnames(y_test)<- "activ_label"

##
## Making the row names of X_train and X_test unique (for rbind later)
##
rownames(X_train) <- make.names(c(1:nrow(X_train)), unique = T)
rownames(X_test) <- make.names(c(1:nrow(X_test))+7352, unique = T)

##
## Binding subject id and activity label to the columns of X_train and X_test
##
X_train<-cbind(X_train, subject_id = subject_train, activ_label = y_train)
X_test<-cbind(X_test, subject_id = subject_test, activ_label = y_test)

##
## Binding the rows of X_train and X_test  together (they have same number of columns) 
##
X_merged <- rbind(as.matrix(X_train), as.matrix(X_test))
X_merged <- as.data.frame(X_merged)

##
## Removing columns with duplicated column names
##
X_noDup <- X_merged[,-which(duplicated(features)==T)]

##
## Sifting out mean and std measurements
##
#X_ms <- X_merged[,c(grep("mean()", names(X_merged), fixed=T), grep("std()", names(X_merged), fixed=T), 562, 563)]
X_ms <- X_noDup[,c(grep("mean()", names(X_noDup), fixed=T), grep("std()", names(X_noDup), fixed=T), 478, 479)]


##
## Giving descriptive name for activities in an added new column
## Create a 1-variable data frame translating the activ_label to activity names
## given in act_label
## 
activity_name <- character(nrow(X_ms))
activity_name[which(X_ms$activ_label==1)]<- as.character(act_label[1,2])
activity_name[which(X_ms$activ_label==2)]<- as.character(act_label[2,2])
activity_name[which(X_ms$activ_label==3)]<- as.character(act_label[3,2])
activity_name[which(X_ms$activ_label==4)]<- as.character(act_label[4,2])
activity_name[which(X_ms$activ_label==5)]<- as.character(act_label[5,2])
activity_name[which(X_ms$activ_label==6)]<- as.character(act_label[6,2])
activity_name <- as.data.frame(activity_name)
colnames(activity_name) <- "activ_name"

##
## Bind activity_name column to X_ms
##
X_ms <- cbind(X_ms, activity_name)


## Appropriately label variables (columns) with descriptive names  
## 
## Here, only the typo in the original names given in features.txt are corrected. 
## Specifically, replacing names with "BodyBody.." to "Body.."
## Replacing "-" in the names with "_"
##
names(X_ms) <- sub("BodyBody", "Body", names(X_ms), fixed=T)
names(X_ms) <- gsub("-", "_", names(X_ms))


##
## Create independent tidy data set X_tidy 
## with the average of each variable for each activity and each subject.
##
X_melt <- melt(X_ms, id=c("subject_id", "activ_name"), measure.vars=c(names(X_ms[1:66])))
X_tidy <-dcast(X_melt, subject_id+activ_name~variable,mean)

##
## Renaming variables names with a prefix "Avg_"
## to indicate the values shown are the average  
##
newNames <- as.factor(c(names(X_tidy[,1:2]), (paste("Avg", names(X_tidy[,3:68]), sep="_"))))
colnames(X_tidy) <- newNames


##
## Returning the tidy dataset X_tidy
##
return(X_tidy)

}