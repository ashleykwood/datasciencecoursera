There are three files in this repository:

`README.md` (this file) describes the files in the repo.

`run_analysis.R` will read the data tables `X_test.txt` and `X_train.txt` from the UCI HAR Dataset (provided that this is in your working directory).

Using these datasets, the code will then execute the following steps - 
  1. Merge the train and test sets to create one large dataset
  2. Use activity names to name the activities in the dataset.
  3. Appropriately label the dataset with variable names
  4. Extract only the measurements on the mean and standard deviation for each measurement. 
  5. Create a second, tidy data set with the average of each variable for each activity and each subject.  

`Codebook.md` is a descriptive file explaining all variables used in `run_analysis` and all transformations done to the data. 


