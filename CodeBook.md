# GetData Final Project CodeBook
<p> Here I describe process of getting and cleaning data to make a tidy data set. First I describe variables that you should know to run the code. Then I describe the process of making the tidy dataset and finally a short description about variables used in the script.</p>
---
### Necessary Variables
<p><code>parentDirectory</code>: it indicates address of main folder of dataset. (e.g. 'UCI HAR Dataset')</p>
### Steps
1. Read 3 files in each train/test folder. Files are : <b> X\_train.txt, Y\_train.txt, subject\_train.txt, X\_test.txt, Y\_test.txt and subject\_test.txt</b>
2.  Select Mean & STD Columns
  1. Read entire file <b>features.txt</b>
  2. Select features that contain <b>mean</b> or <b>std</b>
3. Merge 6 Parts of data into one data.table using cbind & rbind (Only Selected Features)
4. Simplify Remaining Feature names, delete dash and parentheses in column names
5. Create Activity Factor and change Activity column to its factor equivalent 
6. use <b><i>group\_by</i></b> and <b><i>summarise\_each</i></b> to calculate mean of each variable
7. Store tidy dataset in <b>"output.txt"</b>
 
### Output Format
In output we have mean of each features for every combination of subject and activity.
After running the script, result is saved in a variable named <code>res</code>. </br>

	1st Column: Activity
	2nd Column: Subject
	3rd Column: Mean of X variable for tBodyAcc (tBodyAcc-meanX)
	4th Column: STD of Y variable for tBodyAcc (tBodyAcc-std)
	etc.