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
```
names(merged) <- c("subject", "activity id", features$V2)
```
Then using these new column names, the columns with "mean()" or "std()" are selected out and put into a new dataset called "selected"
```R
selectedIndecies <- c(1,2,grep("mean()|std()", names(merged)))
merged[,selectedIndecies] -> selected
```
