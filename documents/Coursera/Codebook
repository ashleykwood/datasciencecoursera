data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

`test` and `train` : tables `X_test.txt` and `X_train.tst` from UCI HAR Dataset. These contain values for all subjects on the 561 metrics measured.
`feature.labels` : character vector storing names of the 561 metrics measured
`subject.test` and `subject.train` : vectors of subject ID of each observation in `test` and `train` (same as `subject_test.txt` and `subject_train.txt` from UCI HAR Dataset)
'trainlab` and 'testlab` : contains integers 1:6 describing the activities performed at each observation in `test` and `train` (same as `y_train.txt` and `y_test.txt` from UCI HAR Dataset)
`ALLD` : merged dataframe, `test` + `train`. Also includes columns specifying subject ID, activity, and group (testing or training)
`all.stats` : data frame containing mean values for each metric, grouped by subject ID and activity.


To tidy the data the following steps were taken: 
- Load data frames `test` and `train`, and add column names from `feature.labels`.
- Add three additional columns to `test` and `train` - (1) `subject` specifies the subject ID (1:30), (2) `activity` indicates the activity being performed using an integer 1:6, (3) `group` indicates whether the observation was initially in the `test` data set or `train` data set.
- Modify the dataframe `ALLD` to contain only the measurements of mean and standard deviation
- Modify the `activity` column to contain descriptive names of the activity performed instead of numbers 
    - `1 walking`
    - `2 walking_upstairs`
    - `3 walking_downstairs`
    - `4 sitting`
    - `5 standing`
    - `6 lying`
- Finally, create a new, tidy dataframe, `all.stats`, which contains the mean of each variable for each activity and each subject. 
