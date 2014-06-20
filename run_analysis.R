library(plyr)

DATA_DIR="./data"
EXTRACTED_ZIP_FOLDER="UCI HAR Dataset"

# creates the data directory
# if it does not already exist
func_init_data_dir <- function() {
    if (! file.exists(DATA_DIR)) {
        dir.create(DATA_DIR)
    }
}

# downloads the url and saves it in the DATA_DIR 
# into the zip_filename provided
# then it unzips it in the same direttory
func_download_and_extract <- function(url, zip_filename) {

    fullpath = paste(DATA_DIR, zip_filename, sep='/')

    if (!file.exists(fullpath)) {
        download.file(url, method='curl', destfile=fullpath)
        unzip(fullpath, exdir=DATA_DIR)
    }
}

# Loads a file from the downloaded data set 
# into a data frame
# takes the subdirectory name ('test' or 'train')
# and the name of the file within that folder
func_load_data_frame <- function(subdir_name, filename) {
    fullpath <- paste(DATA_DIR, EXTRACTED_ZIP_FOLDER, subdir_name, filename, sep='/')
    data_frame <- read.table(fullpath)

    data_frame
}

# takes 3 data frames as input: the signal data frame,
# the label data frame and the subject data frame
# combines all frames into one data frame that 
# has the subject, the activity and the values of the signals for 
# all features
func_combine_data_frames <- function(signal_df, label_df, subject_df) {

    # add a column to label_df showing the string-version of the activity 
    # by looking up the activity name by id in activity_labels.txt file
    label_to_id_fullpath <- paste(DATA_DIR, EXTRACTED_ZIP_FOLDER, 'activity_labels.txt', sep='/')
    label_to_id_df <- read.table(label_to_id_fullpath)
    label_df <- join(label_df, label_to_id_df)

    # give the columns in label_df more appropriate names
    colnames(label_df) <- c("activity_id", "activity_name")

    # give the column in subject_df a more appropriate name
    colnames(subject_df) <- c("subject_id")

    # Extract just the features we need for the assignment - std() and mean()
    #
    # load the feature filename file containing column names of the signal data frame
    feature_filename <- paste(DATA_DIR, EXTRACTED_ZIP_FOLDER, "features.txt", sep='/')
    feature_names <- read.table(feature_filename)
    # get the indexes of the feature names like 'std()' and 'mean()'
    feature_indexes <- grep("mean\\(\\)|std\\(\\)", feature_names[,2])
    # strip out just those columns from signal_df
    column_indexes = feature_names[feature_indexes, 1]
    signal_df <- signal_df[, column_indexes]
    
    # name the columns from the actual names of the features
    #
    column_names = feature_names[feature_indexes, 2]
    # clean up the column names , get rid of "()"
    # and convert all '-' to '_'
    column_names <- sub("\\(\\)", "", column_names)
    column_names <- gsub("-", "_", column_names)
    # set the column names
    colnames(signal_df) <- column_names

    # combine all the data frames together
    # TODO: get rid of 1,2,3
    print(dim(signal_df))
    combined_df <- cbind(subject_df, label_df, signal_df)

    combined_df
}

# make sure data directory exists and create if it doesn't
func_init_data_dir()

# download the zipfile and extract it
func_download_and_extract("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")

# Load test frame
test_signal_df <- func_load_data_frame("test", "X_test.txt")
test_subject_df <- func_load_data_frame("test", "subject_test.txt")
test_label_df <- func_load_data_frame("test", "y_test.txt")
test_df <- func_combine_data_frames(test_signal_df, test_label_df, test_subject_df)

# load train frame
train_signal_df <- func_load_data_frame("train", "X_train.txt")
train_subject_df <- func_load_data_frame("train", "subject_train.txt")
train_label_df <- func_load_data_frame("train", "y_train.txt")
train_df <- func_combine_data_frames(train_signal_df, train_label_df, train_subject_df)

# merge the two frames
merged_df <- rbind(test_df, train_df)

# create the tiny data set
# by grouping by subject_id and activity_id
# and calculating the mean of all the feature data
tidy_df <- aggregate(merged_df[,4:69], merged_df[,c(1,3)], FUN=mean)

# save that shit
# have to use ".txt" extension instead of ".csv"
# becuase the assignment upload thingy does
# not accept CSVs
write.csv(tidy_df, "tidy.txt")

