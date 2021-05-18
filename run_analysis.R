#loading the data into R
#test
read.table("./UCI HAR Dataset/test/X_test.txt")->testdat
read.table("./UCI HAR Dataset/test/subject_test.txt")->testsub
read.table("./UCI HAR Dataset/test/y_test.txt")->ytest

#train
read.table("./UCI HAR Dataset/train/X_train.txt")->traindat
read.table("./UCI HAR Dataset/train/subject_train.txt")->trainsub
read.table("./UCI HAR Dataset/train/y_train.txt")->ytrain