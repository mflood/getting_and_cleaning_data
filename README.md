getting_and_cleaning_data
=========================

Here is what the script (run_analysis.R) does:

1. Creates the data directory if it does not already exist

2. Downloads the url and saves it in the DATA_DIR into the zip_filename provided then it unzips it in the same direttory

3. For both the test and the training data set, it loads the 3 data files (the subject file, the activity label file, and the signal measurements file) into data frames

4. These 3 data frames are then processed to create the cleaned-up data frame. This is done for both the 3 training frames and the 3 test frames
   the processing works as follows
 
    First, we grab the names of the activies from the activity_labels.,txt file in the root of the extracted folder
    and we lookup these names based on the IDs in the activity label dta frame 
    We replace the V1 and V2 column names with 'activity_id' and 'activity_name'

    In the subject data frame, we replace the "V1" column name with "subject_id"

    In the signal feature measuremeng data frame, we want to just keep the columns matching "std" or "mean"
    to do this, we load the feature filename file (features.txt) containing column names of the signal data frame,
    and get the indexes of the feature names like 'std()' and 'mean()'
    Using those indexes, we can reference the explicit colimns from the signal data frame 
    
    Replace the "V1", "V2", etc.. column names with the actual names of the features that we grabbed from features.txt, 
    but cleaned up - the "()" are stipped out from the columns names, and '-' are converted to '_'.

    Once all the individual data frames are cleaned up, we merge them together by aligning the columns from each set using cbind.
    

5. Now that we have cleaned up and assembled test data frame (test_df) and training data frame (train_df), we merge them together by appending train_df to test_df

6. The tidy data set is created by grouping by subject_id and activity_name and calculating the mean() of all the feature-signal-measurement columns

7. Finally, we write the tidy data frame out to a file

