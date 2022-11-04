mfthres = function(x,df){
  for(i in 2:ncol(df)){
    for (j in 1:length(ncol)){
      maximum=quantile(df[df$Region==Region_list [j],i],0.95,na.rm = TRUE) #SRmax.region
      df[df$Region==Region_list [j],i]<-df[df$Region==Region_list [j],i]/maximum*100
    }
  }
  
  df2=df[,-1]
  out<-df2>=x
  nfun<-rowSums(!is.na(out))
  out<-rowSums(out,na.rm = TRUE)
  out<-out/nfun*100
  return(out)
}

thres<-seq(from = 10, to = 100, by=10) #defining lowest and highestminimum % to reach and interval

