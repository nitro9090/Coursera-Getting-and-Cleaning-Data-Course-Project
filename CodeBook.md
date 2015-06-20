Code Book 
===========

The study design
==============

All data was collected from 

"Human Activity Recognition Using Smartphones Dataset"
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

Variables
grouping - whether a subject was part of the training set or test data set
subjects - the subject number
activities - the corresponding activity of the subject when the data was taken

The other variables are the average values partitioned by grouping, subjects and activities from the features_info.txt file in the UCI HAR dataset and are identified therein. 

The data
==========

The data looks at the average mean and std dev accelerometer and gyroscopic data values from the "Human Activity Recognition Using Smartphones Dataset" partitioned by grouping subjects and activities

The data is in a single data table with each variable in a single column and each observation in a single row following tidy principles.

Transformations
===========

1. The X_train, y_train, subject_train and test counterparts are loaded as tables along with the activity labels and features
2. A new column is added to identify if the subject is in the training or test group
3. All of the data is combined into a single table to form a tidy dataset(using rbind and cbind), during which column names are given and the activity labels are changed from numbers to descriptor values
4. The tidy dataset is then condensed down to only identifiers, mean and standard deviation values.
5. The condensed data is grouped by group, subject number, and activities and the mean of the mean and standard deviation values of the tidy data set is taken, to give the final tidy dataset
