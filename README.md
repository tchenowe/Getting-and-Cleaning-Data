#### *timchenoweth*

#### *Fri Nov 21 10:36:28 2014*

Load dplyr library

``` {.r}
library("dplyr")
```

    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following object is masked from 'package:stats':
    ## 
    ##     filter
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Construct Test Data

€”Load Training Data Files

``` {.r}
XData<-read.table("UCI HAR Dataset/test/X_test.txt")
YData<-read.table("UCI HAR Dataset/test/y_test.txt")
subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
features<-read.table("UCI HAR Dataset/features.txt")   #'Loading the Features Data File.
```

€”Properly Label Columns

``` {.r}
names(XData) <- features$V2
XData <- XData[, !duplicated(colnames(XData))] #'Generate Unique Labels for Features.
names(YData) <- "Activities"
names(subjects) <- "Subjects"
```

€”Add the Activities and Subjects Columns to the Data Frame

``` {.r}
XYData<-cbind(YData,XData)
testData <- cbind(subjects,XYData)
```

Constructs Train Data

€”Loading Training Data Files

``` {.r}
XData<-read.table("UCI HAR Dataset/train/X_train.txt")
YData<-read.table("UCI HAR Dataset/train/y_train.txt")
subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
```

€”Properly Label Columns

``` {.r}
names(XData) <- features$V2
XData <- XData[, !duplicated(colnames(XData))]
names(YData) <- "Activities"
names(subjects) <- "Subjects"
```

€”Add the Activities and Subjects Columns to the Data Frame

``` {.r}
XYData<-cbind(YData,XData)
trainData <- cbind(subjects, XYData)
```

Merge the Test and Training Data Frames into a Single Merged Data Frame

``` {.r}
mergeData <- rbind(testData, trainData)
```

Translate the Numeric Values for Activities to the Corresponding Character Strings

``` {.r}
mergeData$Activities[mergeData$Activities == 1] <- "WALKING"
mergeData$Activities[mergeData$Activities == 2] <- "WALKING_UPSTAIRS"
mergeData$Activities[mergeData$Activities == 3] <- "WALKING_DOWNSTAIRS"
mergeData$Activities[mergeData$Activities == 4] <- "SITTING"
mergeData$Activities[mergeData$Activities == 5] <- "STANDING"
mergeData$Activities[mergeData$Activities == 6] <- "LAYING"
```

Filter Out Non-Mean and Standard Deviation Columns Using dplyr'™s
select() Function

``` {.r}
finalData <- select(mergeData, Subjects, Activities, 
                    contains("-mean()"), contains("-std()"))
```

Create Final Tidy Data Frame Using dplyr's group_by() and
summarise_each() Functions

``` {.r}
meanData <- finalData %>%
    group_by(Activities, Subjects) %>%
    summarise_each(funs(mean))
```

Remove Temporary Data Frames and Variables

``` {.r}
rm(XYData)
rm(YData)
rm(XData)
rm(mergeData)
rm(subjects)
rm(testData)
rm(trainData)
rm(features)
```
