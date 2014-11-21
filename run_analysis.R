#'Load dplyr library
library("dplyr")

#'Constructs Test Data
#'* Load Training Data Files
XData<-read.table("X_test.txt")
YData<-read.table("y_test.txt")
subjects <- read.table("subject_test.txt")
features<-read.table("features.txt")   #'Loading the Features Data File.

#'* Properly Label Columns
names(XData) <- features$V2
XData <- XData[, !duplicated(colnames(XData))] #'Generate Unique Labels for Features.
names(YData) <- "Activities"
names(subjects) <- "Subjects"

#'* Add the Activities and Subjects Columns to the Data Frame
XYData<-cbind(YData,XData)
testData <- cbind(subjects,XYData)

#'Constructs Train Data
#'* Loading Training Data Files
XData<-read.table("X_train.txt")
YData<-read.table("y_train.txt")
subjects <- read.table("subject_train.txt")

#'* Properly Label Columns
names(XData) <- features$V2
XData <- XData[, !duplicated(colnames(XData))]
names(YData) <- "Activities"
names(subjects) <- "Subjects"

#'* Add the Activities and Subjects Columns to the Data Frame
XYData<-cbind(YData,XData)
trainData <- cbind(subjects, XYData)

#'Merge the Test and Training Data Frames into a Single Merged Data Frame
mergeData <- rbind(testData, trainData)

#'Translate the Numeric Values for Activities to the Corresponding Character Strings
mergeData$Activities[mergeData$Activities == 1] <- "WALKING"
mergeData$Activities[mergeData$Activities == 2] <- "WALKING_UPSTAIRS"
mergeData$Activities[mergeData$Activities == 3] <- "WALKING_DOWNSTAIRS"
mergeData$Activities[mergeData$Activities == 4] <- "SITTING"
mergeData$Activities[mergeData$Activities == 5] <- "STANDING"
mergeData$Activities[mergeData$Activities == 6] <- "LAYING"

#'Filter Out Non-Mean and Standard Deviation Columns
#'Using dplyr's select() Function
finalData <- select(mergeData, Subjects, Activities, 
                    contains("-mean()"), contains("-std()"))

#'Create Final Tidy Data Frame Using dplyr's group_by()
#'and summarise_each() Functions
meanData <- finalData %>%
    group_by(Activities, Subjects) %>%
    summarise_each(funs(mean))

#'Write the TidyData.txt file
write.table(meanData, file = "TidyData.txt", row.name=FALSE)

#'Remove Temporary Data Frames and Variables
rm(XYData)
rm(YData)
rm(XData)
rm(mergeData)
rm(subjects)
rm(testData)
rm(trainData)
rm(features)
