##IMPORTING PACKAGES
library(dplyr)

###STEP 1
{
#checking if the data is already loaded to allow faster testing
if(!exists("testdat")){
    #loading the data into R
    #test
    read.table("./UCI HAR Dataset/test/X_test.txt")->testdat
    read.table("./UCI HAR Dataset/test/subject_test.txt")->testsub
    read.table("./UCI HAR Dataset/test/y_test.txt")->testy
    
    #train
    read.table("./UCI HAR Dataset/train/X_train.txt")->traindat
    read.table("./UCI HAR Dataset/train/subject_train.txt")->trainsub
    read.table("./UCI HAR Dataset/train/y_train.txt")->trainy
}

if(!exists("testmerged")){ #merging the test data
    cbind(testsub,testy)->testmerged
    cbind(testmerged,testdat)->testmerged
}

if(!exists("trainmerged")){ #merging the train data
    cbind(trainsub,trainy)->trainmerged
    cbind(trainmerged,traindat)->trainmerged
}

if(!exists("merged")){ #merging the test and train data
    rbind(testmerged,trainmerged) -> merged
}
}

###STEP 2
{
#loads the names of the columns for the dataset into R
features <- read.table("./UCI HAR Dataset/features.txt")

# Applies the names from the features file to the dataset names
names(merged) <- c("subject", "activity id", features$V2)

# selects the indexes of columns which have a name which includes mean() or
# std, as well as the 2 label columns
selectedIndecies <- c(1,2,grep("mean()|std()", names(merged)))

# A dataset containing only the labels and columns with mean or std
merged[,selectedIndecies] -> selected
}

###STEP 3
{
# Setting up a vector to use to index names
activityLabels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
# Creates a column called "activityname" to merge the data
selected[["activity id"]] <- activityLabels[selected$`activity id`]
}

###STEP 4
{
# no step required for adding descriptive variable names, that was done when the
# features table overwrote the merged dataset's names, only slight modifications
# needed
selected -> descriptiveNames
# Applies basic replacements to make time and freq clearer, everything else had
# enough letters to make the idea of what the variable referred to clear
names(descriptiveNames) <- gsub("^t", "time", gsub("^f", "freq", names(descriptiveNames)))
}

###STEP 5

descriptiveNames -> tidyData
arrange(tidyData, tidyData$subject, tidyData$`activity id`)->tidyData
arrange(tidyData,)

tidyData %>%
    group_by(subject,tidyData$`activity id`) %>% #Groups the data so it can be processed by summarise
    summarise(across(everything(), list(mean)))->tidyData #takes the mean of each list across each subject-activity pair

write.csv(tidyData, "TidyData.csv") #Writes the tidt data to a csv