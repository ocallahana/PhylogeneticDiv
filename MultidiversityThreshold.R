#Import species richness data by site from ayanna's csvs
#bird_div_indices, beetle_div_indices, plant_div_indices from box

#select species richness column and site ID
bird_div_indicesSR = bird_div_indices %>% select('siteID','species_richness')
beetle_div_indicesSR = beetle_div_indices %>% select('siteID','species_richness')
plant_div_indicesSR = plant_div_indices %>% select('siteID','species_richness')


#Averaged based multidiversity
#sum all these and multiply by (1/n) so (1/3)
bird_div_indicesSR_scale = as.data.frame(scale(bird_div_indicesSR$species_richness, center=T, scale=T))
bird_div_indicesSR_scale$siteID <- bird_div_indicesSR$siteID

#R Code from PNAS paper

mfthres = function(x,df){
  for(i in 2:ncol(df)){
  for (j in 1:length(ncol)){
    maximum=quantile(df[df$siteID==siteID_list [j],i],0.95,na.rm = TRUE) #SRmax.region
    df[df$siteID==siteID_list [j],i]<-df[df$siteID==siteID_list [j],i]/maximum*100
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

mfthres(species_richness, bird_div_indicesSR_scale)

fdf<-sapply(thres,mfthres,MF)
fdf<-as.data.frame(fdf)
colnames(fdf)<-paste("T",thres,sep="") 

#Averaging approach to smooth the value for each threshold
for(i in 1:ncol(fdf)){
  idx<-(i-2):(i+2)
  idx<-idx[which(idx%in%(1:ncol(fdf)))]
  fdf[,i]<-rowMeans(fdf[,idx])
  fdf[,i]<-round(fdf[,i])}

Threshold <-fdf


