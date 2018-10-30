#load data
setwd("/Users/suckwonhong/Desktop/nuclear_powerplant/kcloud/") # where response file is
kcloud<-read.csv("response.csv")
kcloud<-t(kcloud)

#make output data frame (empty)
label<-c()
for (i in 1:300){
  label[i]<-paste0("label", i)
}

label_y<-c()
for (i in seq(1,length(kcloud)-2,3)){
  label_y[(i+2)/3] <- which.max(kcloud[as.numeric(i):as.numeric(i+2)])
}

label.df<-data.frame(t(label_y))
names(label.df)<-label

# load 300 time series data fiels 
path = "/Users/suckwonhong/Desktop/nuclear_powerplant/kcloud/Kcloud_data" #where time series files are
setwd(path)
file.names <- dir(path, pattern =".csv")

for (i in file.names){
  data<-read.csv(i,header = T)
  data<-data[,-1]
  data<-data[,1:401]
  if (nchar(i)==18){
    idx<-as.numeric(substr(i,14,14))
    data$label <- label.df[,idx]
    write.csv(data,file = paste0("data_labeled_",idx,".csv"))
  }
  else if (nchar(i)==19){
    idx<-as.numeric(substr(i,14,15))
    data$label <- label.df[,idx]
    write.csv(data,file = paste0("data_labeled_",idx,".csv"))
  }
  else {
    idx<-as.numeric(substr(i,14,16))
    data$label <- label.df[,idx]
    write.csv(data,file = paste0("data_labeled_",idx,".csv"))
  }
}

df.kc<-read.csv("data_labeled_1.csv",header = TRUE)
df.kc<-df.kc[,-1]
df.kc<-t(df.kc)

for(i in file.names){
  data<-read.csv(i,header=TRUE)
  data<-data[,-1]
  df.kc<-cbind(df.kc,c(t(data)))
}
df.kc<-as.data.frame(df.kc)
df.kc<-df.kc[,-1]
df.kc<-t(df.kc)
write.csv(df.kc,file = "df.csv")