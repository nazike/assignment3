run_analysis <- function() {
        ##1. merging data in one data set by reading all files and putting them together
        
        install.package("plyr")
        library(plyr)
        
        ##train data        
        f_subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
        f_y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
        f_X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")

        ##test data
        f_subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
        f_y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
        f_X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
        
        temp_dat1<-cbind(f_subject_train,f_y_train,f_X_train)
        temp_dat2<-cbind(f_subject_test,f_y_test,f_X_test)
        
        dat<-rbind(temp_dat1,temp_dat2)
        
        ## 2. extracting means and standard deviations

        dat_parameters<-dat
        dat_parameters[1:2]<-list(NULL)
        res_means<-colMeans(dat_parameters)
        res_std<-apply(dat_parameters, 2, sd)

        ## 3. giving names to the activities in the data set
        
        dat_act<-rbind(f_y_train,f_y_test)
        dat_act<-replace(dat_act,dat_act==1,"WALKING")
        dat_act<-replace(dat_act,dat_act==2,"WALKING_UPSTAIRS")
        dat_act<-replace(dat_act,dat_act==3,"WALKING_DOWNSTAIRS")
        dat_act<-replace(dat_act,dat_act==4,"SITTING")
        dat_act<-replace(dat_act,dat_act==5,"STANDING")
        dat_act<-replace(dat_act,dat_act==6,"LAYING")

        ## 4. rename columns 
        
        f_features<-read.table("./UCI HAR Dataset/features.txt")
        names(dat_parameters)<-f_features$V2
        result1<-cbind(rbind(f_subject_train,f_subject_test),dat_act,dat_parameters)
        
        ## 5. summary of the data
        cdata <- ddply(result1, f_features, summarise,mean = mean(change))
        

}
