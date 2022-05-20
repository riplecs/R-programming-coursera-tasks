library(dplyr)

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url, 'data.zip', method = 'curl')
unzip('data.zip', exdir = 'D://')
setwd('D://UCI HAR Dataset')

#Merges the training and the test sets to create one data set.

x_test <- read.table('test//X_test.txt')
x_train <- read.table('train//X_train.txt')
y_test <- read.table('test//y_test.txt')
y_train <- read.table('train//y_train.txt')
subject_test <- read.table('test//subject_test.txt')
subject_train <- read.table('train//subject_train.txt')
data <- rbind(cbind(subject_test, y_test, x_test), 
              cbind(subject_train, y_train, x_train))

#Extracts only the measurements on the mean and standard deviation for 
#each measurement. 

names(data)[-c(1, 2)] <- read.table('features.txt')[,2]
names(data)[c(1, 2)] <- c('subject', 'Activity')
data <- data[grepl('mean|std', names(data)[-c(1, 2)])]

#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 

activities <- read.table('activity_labels.txt', 
                         col.names = c('id', 'Activity name'))
data <- merge(data, activities, by.x = 'Activity', by.y = 'id')
data <- subset(relocate(data, 'Activity.name', .before = 'subject'), select = -1)


#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

grouped_data <- data %>% group_by(Activity.name, subject)
tidy_data <- grouped_data %>%
            summarise_at(vars("tBodyAcc-mean()-X":"angle(Z,gravityMean)"), mean)
write.table(tidy_data, 'tidy_data.txt', row.name = FALSE)