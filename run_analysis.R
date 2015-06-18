# run_analysis.R - June 18, 2015

# This function takes in the UCI HAR Dataset, turns it into a tidy data set, 
# then separates out only the mean and standard deviation values of the data and finds
# the mean of those values.  Finally, it outputs those values as a tidy dataset

# the code is commented inline 

# input variables
# filepath - you may input the filepath to the UCI HAR dataset folder, default is the working directory

loadUCIdataset <- function(filepath="") {
  # declaring that this program requires the dplyr package
  require(dplyr)

  # load in each of the tables into R and give them corresponding variable names
  x.train <- read.table(paste0(filepath, "UCI HAR DataSet/train/X_train.txt"))
  y.train <- read.table(paste0(filepath, "UCI HAR DataSet/train/y_train.txt"))
  subject.train <- read.table(paste0(filepath, "UCI HAR DataSet/train/subject_train.txt"))
  
  x.test <- read.table(paste0(filepath, "UCI HAR DataSet/test/X_test.txt"))
  y.test <- read.table(paste0(filepath, "UCI HAR DataSet/test/y_test.txt"))
  subject.test <- read.table(paste0(filepath, "UCI HAR DataSet/test/subject_test.txt"))
  
  activity.labels <- read.table(paste0(filepath, "UCI HAR DataSet/activity_labels.txt"))
  features <- read.table(paste0(filepath, "UCI HAR DataSet/features.txt"))
  
  #adds a column to the subject list that identifies whether the subject was part of the train or test group
  subject.train <- mutate(subject.train, grouping = "train") 
  subject.test <- mutate(subject.test, grouping = "test") 
  
  # the test and train datasets are combined into one using rbind
  x.data <- rbind(x.train, x.test)
  y.data <- rbind(y.train, y.test)
  subject.data <- rbind(subject.train,subject.test)
  
  # columns names are added to the datasets
  colnames(x.data) <- features[,2]
  colnames(y.data) <- "activities"
  colnames(subject.data)[1] <- "subjects"
  
  #this function replaces all "old values" in a list called "data" with "new values" and outputs the updated list
  replaceFunc <- function(data, oldvalue, newvalue){
    
    if (is.factor(data))     data     <- as.character(data)
    if (is.factor(oldvalue)) oldvalue <- as.character(oldvalue)
    if (is.factor(newvalue)) newvalue <- as.character(newvalue)
    
    output <- data
    for (i in unique(oldvalue)){
      output[data == i] <- newvalue[oldvalue == i]
    }
    output
  }
  
  # using the above function, all y.data values (activity numbers) are replaced with the string expression for the activity
  y.data <- replaceFunc(y.data, activity.labels$V1, activity.labels$V2)
  
  # merges all subject, activities and experimental readings into 1 dataframe, then sorts by grouping, subjects and activities 
  # tidy.merged.data is the raw data in its tidy form
  merged.data <- cbind(subject.data,y.data,x.data) 
  tidy.merged.data <- merged.data[order(merged.data$grouping, merged.data$subjects, merged.data$activities),] 
  
  # the data is limited to only to columns with grouping, subjects, activities, mean or std in the name, aka identifiers and mean and std dev values.
  mean.std.data <- tidy.merged.data[, grepl("grouping|subjects|activities|mean|std",colnames(tidy.merged.data))]
  
  # calculating the mean of all of the mean and std deviation values broken up by the persons group (test or train), subject # and activities
  mean.of.mean.std.data <- tbl_df(mean.std.data) %>% 
    group_by(grouping, subjects, activities) %>%
    summarise_each(funs(mean))
  
  #outputs the tidy dataset according to part 5 of the project
  mean.of.mean.std.data
}