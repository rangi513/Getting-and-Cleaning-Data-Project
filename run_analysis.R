# Set WD
## setwd(".\\DS Coursera")
library(dplyr)

# Load Test and Train data and labels
xtest <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
xtrain <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
testlabs <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt") %>% 
        dplyr::rename(activity = V1)
trainlabs <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt") %>% 
        dplyr::rename(activity = V1)

# Load subjects, activities, and features
testsubs <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt") %>% 
        dplyr::rename(subject = V1)

trainsubs <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt") %>% 
        dplyr::rename(subject = V1)

activitylabs <- read.table(".\\UCI HAR Dataset\\activity_labels.txt") %>% 
        dplyr::rename(activity=V1) %>% 
        dplyr::mutate(activity_name=as.character(V2)) %>% 
        dplyr::select(1,3)

feat <- read.table(".\\UCI HAR Dataset\\features.txt") %>% 
        dplyr::mutate(feature=as.character(V2)) %>% 
        dplyr::select(3)

# Attach labels to the test data
colnames(xtest) <- feat[,1]
testfinal <- cbind(testsubs,testlabs,xtest)

# Attach labels to the train data
colnames(xtrain) <- feat[,1]
trainfinal <- cbind(trainsubs,trainlabs,xtrain)

# Combine training and testing data
df <- rbind(testfinal,trainfinal)

# Now extract mean and std for each measurement
logi <- grepl('subject|activity|mean()|std()',colnames(df))
dfms <- df[,logi==TRUE]

# Insert activity names
dfms2 <- merge(dfms,activitylabs, by = 'activity')

#reorder and remove activity index
dfms3 <- dfms2[,c(2,82,3:81)]
dfms3$subject <- as.factor(dfms3$subject)
dfms3$activity_name <- as.factor(dfms3$activity_name)

# Apply mean using the aggregate function for all variables on subject and activity_name
aggdata <- aggregate(formula = .~ subject + activity_name, data = dfms3, FUN = mean)

#reorder based on subject number, then activity name
aggdata1 <- aggdata[order(aggdata$subject,aggdata$activity_name),]

# Creates a tidy data set with the average of each variable for 
# each activity and each subject
write.table(aggdata, file = "tidy.txt", row.names = FALSE, quote = FALSE)
