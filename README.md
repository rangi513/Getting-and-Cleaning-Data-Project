# Getting-and-Cleaning-Data-Project
This is a repo for the results of a course project.

##This repo contains:
* A `CodeBook.md` file for more information on the data.
* A `run_analysis.R` file that runs transformations on the raw data to create a new tidy dataset.
* A `tidy.txt` file that constains the (tidy data) results of the `run_analysis.R` script. 
* A this `README.md` file. 

##Transformations Made
The script `run_analysis.R` takes the following actions on the raw data (can be found in the `CodeBook.md` file):
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* Creates an independent tidy data set with the average of each variable for each activity and each subject.
