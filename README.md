Getting and cleaning data
=========================
Project to extract and tidy up a data set from a smart phone.
This is part of 'Getting and Cleaning data' course on Coursera.

How to run
==========
To download the data, source (execute) the script **downloadDataSet.R**
This should only be needed once.

To run the analysis and write the output data set, source (execute) the script **run_analysis.R**


Feature description
===================
The measurements have been split into 2 main parts:
1. How much is the body accelerating
2. How much of the acceleration is gravity 

The output data set includes only mean values and standard deviations of the raw data. 

All features with starting with **Body** are measurements of the body acceleration and all features starting with **Gravity** are measurements of gravity.

The data also includes frequency analysis and these features start with **Frequency**. The datapoints are actuallt Fast-Fourier-Transforms of the data points in the time domain.

The column *Subject* states which test subject the measurement was colleded on.

The column *ActivityName* states which activity the subject was performing when the measurment was taken.


Raw data
========
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


