#Import species richness data by site from ayanna's csvs
#bird_div_indices, beetle_div_indices, plant_div_indices from box

#select species richness column and site ID
bird_div_indicesSR = bird_div_indices %>% select('siteID','species_richness')
beetle_div_indicesSR = beetle_div_indices %>% select('siteID','species_richness')
plant_div_indicesSR = plant_div_indices %>% select('siteID','species_richness')


#Averaged based multidiversity
#sum all these and multiply by (1/n) so (1/3)
#scale bird data by site
bird_div_indicesSR_scale = as.data.frame(scale(bird_div_indicesSR$species_richness, center=T, scale=T))
bird_div_indicesSR_scale$siteID <- bird_div_indicesSR$siteID
bird_div_indicesSR_scale$birdSRi <- bird_div_indicesSR$species_richness
bird_div_indicesSR_scale$birdrichness <- bird_div_indicesSR_scale$V1


#scale beetle data by site
beetle_div_indicesSR_scale = as.data.frame(scale(beetle_div_indicesSR$species_richness, center=T, scale=T))
beetle_div_indicesSR_scale$siteID <- beetle_div_indices$siteID
beetle_div_indicesSR_scale$beetleSRi <- beetle_div_indices$species_richness
beetle_div_indicesSR_scale$beetlerichness <- beetle_div_indicesSR_scale$V1


#scale plant data by site
plant_div_indicesSR_scale = as.data.frame(scale(plant_div_indicesSR$species_richness, center=T, scale=T))
plant_div_indicesSR_scale$siteID <- plant_div_indices$siteID
plant_div_indicesSR_scale$plantSRi <- plant_div_indices$species_richness
plant_div_indicesSR_scale$plantrichness <- plant_div_indicesSR_scale$V1

#Combine these dataframes together by site
plantbeetledf = merge(plant_div_indicesSR_scale,beetle_div_indicesSR_scale, by='siteID', all.x=FALSE)
birdplantbeetledf = merge(plantbeetledf, bird_div_indicesSR_scale, by='siteID', all.x=FALSE)

#then adding the richness values altogether in a new column, 
birdplantbeetledf$totalSR <- birdplantbeetledf$birdrichness + birdplantbeetledf$plantrichness + 
  birdplantbeetledf$beetlerichness

#then in another column multiply total sum of species richness by 1/3 (1/n) n=number of taxa
birdplantbeetledf$multidiversity = birdplantbeetledf$totalSR*(1/3)


#Need to get a dataframe with just species richness #s not scaled

#select only SRi and site
multidiv_df = birdplantbeetledf %>% select('siteID','birdSRi', 'beetleSRi', 'plantSRi')
multidiv_df2 = multidiv_df
multidiv_df2$siteID_list = multidiv_df2$siteID

#find SRmax.region by designating a column of all species richness sum maximum for all taxa
multidiv_df$maxregion = multidiv_df$birdSRi + multidiv_df$beetleSRi + multidiv_df$plantSRi
hist(multidiv_df$maxregion)
qqnorm(multidiv_df$maxregion)
birdplantbeetledf$maxregion = multidiv_df$maxregion 
write.csv(birdplantbeetledf, "multidiversityresults-nov7.csv")

#should look at maximum for each taxa based on region--- how so?

#Find 95% quantile for species maximums
multidiv_df$maxquant = quantile(multidiv_df$maxregion, 0.95,na.rm = TRUE)
multidiv_df$quantquarter = quantile(multidiv_df$maxregion, 0.95,na.rm = TRUE)


#R Code from PNAS paper
#make a region list?
region_list = multidiv_df$siteID

mfthres = function(x,df){
  for(i in 2:ncol(df)){
  for (j in 1:length(ncol)){
    maximum=quantile(df[df$maxregion==region_list [j],i],0.95,na.rm = TRUE) #SRmax.region
    df[df$maxregion==region_list [j],i]<-df[df$maxregion==region_list [j],i]/maximum*100
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

try1 = mfthres(multidiv_df$plantSRi, multidiv_df)

fdf<-sapply(thres,mfthres,multidiv_df)
fdf<-as.data.frame(fdf)
colnames(fdf)<-paste("T",thres,sep="") 

#Averaging approach to smooth the value for each threshold
for(i in 1:ncol(fdf)){
  idx<-(i-2):(i+2)
  idx<-idx[which(idx%in%(1:ncol(fdf)))]
  fdf[,i]<-rowMeans(fdf[,idx])
  fdf[,i]<-round(fdf[,i])}

Threshold <-fdf


