#The code run_analysis.R will read the data tables X_test.txt and X_train.txt from the folder UCI HAR Dataset (provided that it is in your working directory).

# run_analysis adds column names for each of the 561 measurements recorded, as well as add columns specifying which subject and activity is being represented.

# The code will calculate the mean and standard deviation of each of the 561 variables, and as well as calculating the mean of each   measurement for each subject and activity.

#====================================================
#CODEBOOK

#test, train : tables X_test.txt and X_train.tst from UCI HAR Dataset. These contain values for all subjects on the 561 metrics measured.
#ALLD : merged dataframe, test+train. Also includes columns specifying subject ID, activity, and group (testing or training)
#summary.stats : data frame with three columns -- name of the metric measured, mean measurement, and standard deviation
#all.stats : data frame containing mean values for each metric, grouped by subject ID and activity.
