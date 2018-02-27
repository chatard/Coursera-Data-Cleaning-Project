---
title: "CODEBOOK"
author: "john"
date: "27 février 2018"
output: html_document
---

## Codebook elements provided in the original files:

* ./UCI_HAR_Dataset/features_info.txt

this file lists and gives information on the main measured variables.  

* ./UCI_HAR_Dataset/features.txt

this file provides the names of each one of 561 measured or estimated variables.

* ./UCI_HAR_Dataset/activity_labels.txt

this file provides the names of the different categories of activities for which measurements have been made.

* ./UCI_HAR_Dataset/train/y_train.txt and ./UCI_HAR_Dataset/test/y_test.txt

these 2 files provide an identification code in range [1, 30] to identify each trial participant for each observation.


## About variables related units of measure:

* <ins>For acceleration type variables along an axis:</ins> units of gravity expressed in g.  

* <ins>For other variables (gyroscope angular speed):</ins> unit = gradians / second.


## Modified or added variables during the process for my "tidy data set":


 
 ### modified activity labels (line 32 of run_analysis.R) :  
 
 WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING. 
 
 respectively substituted by:
 
 walking, walkingupstairs, walkingdownstairs, sitting, laying.
 
### added : "subjid"
 
 * subjid is a subject identifier : line 16 in file run_analysis.R
 
### added : "activitycode" 
 
 * activitycode is a container for activity labels  : line 27 in file run_analysis.R
 
 
 
                    
 
                   