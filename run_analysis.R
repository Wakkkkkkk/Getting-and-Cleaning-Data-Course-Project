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

#locations with names from features.txt with mean() in the name
meanlocs <- c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,202,203,214,227,240,253,266,267,268,345,346,347,424,425,426,503,513,516,529,542)
#locations with names from features.txt with std() in the name
stdlocs <- c(4,5,6,44,45,46,84,85,86,124,125,126,164,165,166,202,215,228,241,254,269,270,271,348,349,350,427,428,429,504,517,530,543)
features <- read.table("./UCI HAR Dataset/features.txt")
names(merged) <- c("subject", "activity id", features$V2)

c(meanlocs,stdlocs) -> mergedlocs
# added 1 and 2 so they are kept in the end dataset along with all the
# columns for std and mean which have been shifted over by 2 places due
# to the addition of y and subjects
c(1,2,mergedlocs+2) -> mergedlocs

# A dataset containing only the labels and columns with mean or std
merged[,mergedlocs] -> selected

# Setting up a vector to use to index names
activityLabels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING,STANDING","LAYING")
# Creates a column called "activityname" to merge the data
selected$activityname <- activityLabels[selected$`activity id`]