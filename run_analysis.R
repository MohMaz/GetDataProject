# Set Dataset Main Directory
parentDirectory <- 'UCI HAR Dataset'
# Loading dplyr Package
library(dplyr)
# Read Data From Files
Xtrain <- read.table(file.path(parentDirectory,'train','X_train.txt'))
SubjectTrain <- read.table(file.path(parentDirectory,'train','subject_train.txt'))
Ytrain <- read.table(file.path(parentDirectory,'train','Y_train.txt'))
Xtest <- read.table(file.path(parentDirectory,'test','X_test.txt'))
SubjectTest <- read.table(file.path(parentDirectory,'test','subject_test.txt'))
Ytest <- read.table(file.path(parentDirectory,'test','Y_test.txt'))
# Read Feature List From File & Get Index of Features to be kept
f <- file(file.path(parentDirectory,'features.txt'))
features <- readLines(f)
close(f)
# Use Regular Expression to determine Features using mean or std
featureIndex <- grep('.*mean().*|.*std().*', features)

# Merge Train & Test Data (Only Desired columns)
data <- rbind(cbind(select(Xtrain,featureIndex),SubjectTrain, Ytrain),cbind(select(Xtest,featureIndex),SubjectTest,Ytest))
# Remove Unneccesarry Variables
#rm('Xtrain','Ytrain','Xtest','Ytest')
# Provide FeatureNames for Tidy Dataset
features <- c(features[featureIndex],'Subject','Activity')
# Do Simple Processing on Variable Names to Get Better Names
features <- sub('\\(\\)-{0,1}','',features)
features <- sub('\\d+\\s','',features)
names(data) <- features
ActivityLabels <- c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING')
data <- mutate(data,Activity = factor(Activity,labels = ActivityLabels))

# Doing Group & Summarize. this method is easier and more readable than melt & dcast
res <- data %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

write.table(x = res, file = 'output.txt', row.names = FALSE)