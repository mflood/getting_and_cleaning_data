getting_and_cleaning_data
=========================

Data Science Coursera

Here is what the script does:

1. Creates the data directory if it does not already exist

2. Downloads the url and saves it in the DATA_DIR into the zip_filename provided then it unzips it in the same direttory


3.  Loads a file from the downloaded data set into a data frame takes the subdirectory name ('test' or 'train') and the name of the file within that folder




# takes 3 data frames as input: the signal data frame,
# the label data frame and the subject data frame
# combines all frames into one data frame that 
# has the subject, the activity and the values of the signals for 
# all features
func_combine_data_frames <- function(signal_df, label_df, subject_df) {

    # add a column to label_df showing the string-version of the activity 
    # by looking up the activity name by id in activity_labels.txt file

    # give the columns in label_df more appropriate names

    # give the column in subject_df a more appropriate name

    # Extract just the features we need for the assignment - std() and mean()
    #
    # load the feature filename file containing column names of the signal data frame


    # get the indexes of the feature names like 'std()' and 'mean()'
    # strip out just those columns from signal_df
    
    # name the columns from the actual names of the features
    #
    # clean up the column names , get rid of "()"
    # and convert all '-' to '_'
    # set the column names

    # combine all the data frames together
}

# make sure data directory exists and create if it doesn't
func_init_data_dir()

# download the zipfile and extract it
func_download_and_extract("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")

# Load test frame

# load train frame

# merge the two frames: the train data frame (train_df) is appended to the test data frame (test_df)

# create the tiny data set
# by grouping by subject_id and activity_id
# and calculating the mean of all the feature data


# the data frame is then written out to a file names "tidy.txt"

