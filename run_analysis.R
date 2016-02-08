library(dplyr)

# Download the Zip File from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Unzip It inside c:/users/narasimman/data/UCI HAR Dataset/

#set Working Directory

setwd("c:/users/narasimman")

#Read Activity Data - both Test & Train Data Sets 

activityTest  <- read.table("./data/UCI HAR Dataset/test/Y_test.txt",header = FALSE)
activityTrain <- read.table("./data/UCI HAR Dataset/train/Y_train.txt",header = FALSE)

# Read Subject Files Data - Both Test & Train

subjectTest  <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

# Read Features Data - Both Test & Train

featuresTest  <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)
featuresTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)


# Read Column Lables for Features Data Sets 
# From features.txt file

featuresLables <- read.table("./data/UCI HAR Dataset/features.txt",header=FALSE)

# set the column Lables for feature Data Sets

names(featuresTest) <- featuresLables$V2
names(featuresTrain) <- featuresLables$V2

# Set column Lable for Subject Data Sets 

names(subjectTest) <- "Subject"
names(subjectTrain) <- "Subject"

# Set the column Lable for Activity Data Sets

names(activityTest) <- "Activity"
names(activityTrain) <- "Activity"

# Get Activities from Activity Lables 

activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names=c("Activity", "activityLabel"))

# Remove "-" from Activities

activities$activityLabel <- gsub("_", "", as.character(activities$activityLabel))

# Replace Activities Lables into Activity Id's

activityTest$Activity <- merge(activityTest, activities, by="Activity")$activityLabel
activityTrain$Activity <- merge(activityTrain, activities, by="Activity")$activityLabel

# Combine Features , Subject and Activity Data sets by Columns for Test Data

combinedTest <- cbind(featuresTest,subjectTest,activityTest)

# Combine Features , Subject and Activity Data sets by Columns for Train Data

combinedTrain <- cbind(featuresTrain,subjectTrain,activityTrain)

# Join combinedTest & CombinedTrain (By Row) to create one Data Set

combinedData <- rbind(combinedTest,combinedTrain)

# Get only the Variables which has mean() or std() in name 

selectedVariableName <- grep("mean\\(\\)|std\\(\\)",featuresLables$V2,value = TRUE)

# Prepare a List of Colums to subset the Data ( with All Mean and STD columns + Activity + Subject Columns)

listofcolumns <- c(grep("mean\\(\\)|std\\(\\)",featuresLables$V2,value = T),"Subject","Activity")

# Subset the combinedData , taking only the selected Columns

FinalDataSet <- subset(combinedData,select = listofcolumns)


# Clean the lables 
#prefix t is replaced by time
#Acc is replaced by Accelerometer
#Gyro is replaced by Gyroscope
#prefix f is replaced by frequency
#Mag is replaced by Magnitude
#BodyBody is replaced by Body
# Make the lables all lower case letters

names(FinalDataSet)<-gsub("^t", "time", names(FinalDataSet))
names(FinalDataSet)<-gsub("^f", "frequency", names(FinalDataSet))
names(FinalDataSet)<-gsub("Acc", "Accelerometer", names(FinalDataSet))
names(FinalDataSet)<-gsub("Gyro", "Gyroscope", names(FinalDataSet))
names(FinalDataSet)<-gsub("Mag", "Magnitude", names(FinalDataSet))
names(FinalDataSet)<-gsub("BodyBody", "Body", names(FinalDataSet))
names(FinalDataSet)<- tolower(names(FinalDataSet))


# Create the Final Output Tidy Data set by computing Mean of eachof the Variables by Activity & Subject

FinalDataSet1<-aggregate(. ~activity + subject, FinalDataSet, mean)

# Write the Final Tidy data set into a File

write.table(FinalDataSet1, file = "tidydata.txt", row.names = FALSE)


