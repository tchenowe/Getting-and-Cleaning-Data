---
title: "CodeBook.md"
author: "Tim Chenoweth"
date: "Thursday, November 20, 2014"
output: html_document
---
##Getting and Cleaning Data --- Course Project
###Data Source and Description

This project used the **Human Activity Recognition Using Smartphones Data Set** located at the Machine Learning Repository in UC Irvine. A summary of the data source is available at\
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data files for the project were contained in a zip file downloaded from\
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The abstract from the above referenced data source summary states that the

>*Human Activity Recognition database [is] built from the recordings of 30 subjects*\
>*performing activities of daily living (ADL) while carrying a waist-mounted*\
>*smartphone with embedded inertial sensors.*\

A detailed description of the data source is provided in a README.txt file included in the data source zip file and [linked to here](DataSourceREADME.txt). This README.txt file contains

* A description of the experiment including data collection
* A description of the pre-processing applied to the raw data
* A description of the information contained in each observation
* A description of the data files included in the zip file.
* **Of particular note is that all variable values are normalized and bounded within [-1, 1].**

###Variables Description
####Source Data Variables

A detailed description of the data source variables is provided in a file named features\_info.txt. This file is included in the data source zip file and [linked to here](features\_info.txt). This README.txt file contains

* A description of the data source for the selected variables and
* A description of the variable naming conventions used.

To summarize, the source data variables are comprised of several statistical values estimated using various time domain signal metrics. The combination of signal metrics and statistics resulted in a total of 561 variables. In addition, each observation in the source data set is for a specific *Subject* engaged in a specific *Activity*. The experiment included a total of 30 subjects engaged in six different activities. The six possible Activities are

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

####Course Project Variable

For my course project I used the same variable naming conventions for the signal statistics that are used in the source data and are described in the [features_info.txt](features_info.txt) file. In addition, the activities variable is labeled Activities and the subjects variable is labeled Subjects. The variable datatypes are listed below.

* Activities are character strings
* Subjects are integers
* All signal statistic variables are numeric and are normalized and bounded within [-1, 1]

###Project Transformation Processes
####Source Data File Descriptions

The source data contained in the zip file is divided into a test data set and a training data set. The data for each data set is distributed across several files located in either the test folder or the train folder. These files are described next.

######The test Folder

* **X_test.txt**: Contains a matrix of normalized signal statistics data. Each row corresponds to a specific observation. This file does not contained column headings.
* **y_test.txt**: Contains a vector of activity factors. These factors are in the same order as X_test.txt and indicate the specific activity for each observation.
* **subject_test.txt**: Contains a vector of integer values corresponding to the participating subjects. The vector values are in the same order as X_test.txt and indicate the subject for each observation.

######The train Folder

* **X_train.txt**: Contains a matrix of normalized signal statistics data. Each row corresponds to a specific observation. This file does not contained column headings.
* **y_train.txt**: Contains a vector of activity factors. These factors are in the same order as X_train.txt and indicate the specific activity for each observation.
* **subject_train.txt**: Contains a vector of integer values corresponding to the participating subjects. The vector values are in the same order as X_train.txt and indicate the subject for each observation.

In addition to these six files, my project also used the **features.txt** file, which contains a vector of character strings that provide the column labels for both the test and training data sets.

####Project Data Transformations

What follows is a summary description of the steps and transformations performed to create the TidyData data set. For more details see the [README.md file](README.HTML).

1. Construct the test data frame.
    a. Read in the three test folder files and features.txt.
    b. Label all columns.
    c. Add the Subjects and Activities vectors to the X_test data frame.
    d. Remove columns with duplicate column headings--**see the note below**.
2. Construct the train data frame.
    a. Read in the three train folder files.
    b. Label all columns.
    c. Add the Subjects and Activities vectors to the X_train data frame.
    d. Remove columns with duplicate column headings--**see the note below**.
3. Merge the test and train data frames into a single data frame.
4. Remove non-mean and standard deviation columns from the data frame.
5. Create the final Tidy data frame.
    a. The Tidy data frame was grouped first by Activities then Subjects.
    b. Compute the average for each signal statistic for each combination of activity and subject.

**NOTE**: For step 4 above I used dplyr's select() function. This function requires that the column labels be unique, which was not the case for the source data sets. More simply, the character string vector contained in features.txt had duplicate values. An examination of the features vector indicated that the duplicated column labels involved neither mean nor standard deviation columns. Therefore the columns with duplicate column labels were removed from the merged data frame before the select() function was used.
