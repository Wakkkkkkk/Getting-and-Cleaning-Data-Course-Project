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

