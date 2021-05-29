# Readme
### STEP 1
After checking if the data is already loaded into R, it reads the data from the UCI dataset folder...
```R
    read.table("./UCI HAR Dataset/test/X_test.txt")->testdat
    read.table("./UCI HAR Dataset/test/subject_test.txt")->testsub
    read.table("./UCI HAR Dataset/test/y_test.txt")->testy
    
    read.table("./UCI HAR Dataset/train/X_train.txt")->traindat
    read.table("./UCI HAR Dataset/train/subject_train.txt")->trainsub
    read.table("./UCI HAR Dataset/train/y_train.txt")->trainy
```
Merges the test and train data with their respective label files by using cbind (binding them to eachother via their columns)...
```R
    cbind(testsub,testy)->testmerged
    cbind(testmerged,testdat)->testmerged
    
    cbind(trainsub,trainy)->trainmerged
    cbind(trainmerged,traindat)->trainmerged
```
Then merges those two with each other via rbind (they have the same columns, so they stack on top of each other now)...
```R
    rbind(testmerged,trainmerged) -> merged
```
Creating the full dataset used for the rest of the problem

### STEP 2
The column names are imported...
```R
features <- read.table("./UCI HAR Dataset/features.txt")
```
...So they can be used to assign names to the columns of the dataset (subject and activity id need to be filled in because they aren't a part of the original features data)
```R
names(merged) <- c("subject", "activity id", features$V2)
```
Then using these new column names, the columns with "mean()" or "std()" are selected out and put into a new dataset called "selected"
```R
selectedIndecies <- c(1,2,grep("mean()|std()", names(merged)))
merged[,selectedIndecies] -> selected
```

### Step 3
This step was simple enough, just create a vector whose indexes represent the names of each activity type and use it to convert the ids into activities, then assign it to a new column in the dataset.
```R
activityLabels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
selected[["activity id"]] <- activityLabels[selected$`activity id`]
```

### Step 4
Since I already imported the names for each column, I just expanded out the names a bit to make them easier to read
```R
names(descriptiveNames) <- gsub("^t", "time", gsub("^f", "freq", names(descriptiveNames)))
```

### Step 5
This was by far the most complex.
First, the data are arranged by subject and activity
```R
arrange(tidyData, tidyData$subject, tidyData$`activity id`)->tidyData
```
Then it is fed through a pipeline to group the data by subject and activity, and then those groups' data are averaged out with the mean() function.
```R
tidyData %>%
    group_by(subject,tidyData$`activity id`) %>% #Groups the data so it can be processed by summarise
    summarise(across(everything(), list(mean)))->tidyData #takes the mean of each list across each subject-activity pair
```
With the averages taken, the data is written to a file for your viewing.
```R
write.csv(tidyData, "TidyData.csv")
```