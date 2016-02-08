# getting-cleaning-Data
Getting and Cleaning Data  Coursera Course - Course Assignment 

run_analysis.R

The cleanup script (run_analysis.R) does the following:
1.Reads the Train & Test Data sets.
2.Merges Train & Test Data Sets.
3.Selects and extracts only the Mean and Standard Deviation values for each observations.
4.Lables are re written with the Descriptive Names.
5.Activity Names are replaced for the Activity ID's.
6.Creates a Tidy Data Set which is Grouped by Activity & subject
7.Create mean of each of the Variables for the above created groups.
8.Write the tidy data set to the tidydata.txt file. 

Running the script

1.To run the script, source  run_analysis.R .
2.After the script ran successfully , a text file "tidydata.txt" will be created in the working Directory . 


Cleaned Data

The resulting clean dataset is in this repository at:  <Working Dir>/tidydata.txt . It contains one row for each subject/activity pair and columns for subject, activity, and each feature that was a mean or standard deviation from the original dataset.
