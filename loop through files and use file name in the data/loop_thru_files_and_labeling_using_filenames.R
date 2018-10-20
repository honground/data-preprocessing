## read file names and put into file.names
path = "/Users/suckwonhong/Downloads/CHRG_62" #this is where files are located
file.names <- dir(path, pattern =".csv") #save file names into a list
## function to get the value of label from file names
for(i in file.names){
  data<-read.csv(i,skip = 7,header = FALSE)
  data<-data[,-1]
  label<-substring(i,9)
  if(nchar(label)==8){
    label<-substr(label,1,nchar(label)-7)
  }else if(nchar(label)==7){
    label<-substr(label,1,nchar(label)-6)
  }else{
    label<-substr(label,1,nchar(label)-5)
  } 
    data$label<-label
  write.table(data,file = paste("modified",i),sep = ",",
              row.names = FALSE,col.names = FALSE)
}

