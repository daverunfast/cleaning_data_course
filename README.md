# Cleaning Samsung Phone Activity Data

The data is generally processed mainly by the
[data.table](https://github.com/Rdatatable/data.table/wiki)  package. The
training and testing data are stored at "./training" and "./testing" directory.

## Basic processing of training and testing data

The training data is read into R memory via the fread function provided by
data.table. The acitivity information was then read into the memory as
well. A factor array is built by converting the activity array into factor
replacing numerical value into character values according to the
"activity\_label.txt" file. Subject information was read into an array from
"subject\_train.txt". Those two columns was then combined together into the main
training data table. Column name ("features.txt") is read into the
memory followed by assigning to the data table. After the column name is
fixed. A regular expression is used to slice columns with name containing either
"mean()" or "std()" in the table. The finished data table is stored in "train.set".

Training set data table's columne name was then assigned. The same
process is used in the testing set. The finished data table is stored in "test.set".

# Combine two data tables together and taking mean of each column
"rbindlist" method from data table package is used to combine both train and
test data sets.

After that, a special data.table method is called to calculate the mean of each
column in the table grouped by Subject and Activity.

```r
small.table <- whole[, lapply(.SD, mean, na.rm = TRUE), by=c("Subject", "Activity")]
```

The data table "small.table" is the final table written to the disk.


# Codebook for variables:


These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
