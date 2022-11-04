##Build phylogenetic tree for Ayanna's Data
##Alexis O'Callahan
##Oct 31 2022

#Import all three community matrices from the box
#beetle_full_data, bird_full_data, plant_full_data

#Find the unique list of species names for each dataset
birdspecies = as.vector(unique(bird_full_data$scientificName))
birdspeciesdf = as.data.frame(birdspecies)
birdspeciesdf = rename(birdspeciesdf, species = birdspecies)

# using paste method
vec_mod = paste(birdspecies, collapse=",")
print (vec_mod)

#Some names are coming up as NAs because they're family/subspecies level or need to find synonym from NCBI manually.
#Remove them now
birdmissingspecies = scan(text = "Picidae sp.
Junco hyemalis oreganus
Oreothlypis celata
Setophaga coronata auduboni
Parulidae sp.
Tyrannidae sp.
Emberizidae sp.
Picoides pubescens
Oreothlypis ruficapilla
Trochilidae sp.
Colaptes auratus cafer
Accipitridae sp.
Vireo sp.
Pheugopedius atrogularis
Icteridae sp.
Turdidae sp.
Coccothraustes vespertinus
Streptoprocne semicollaris
Colaptes auratus auratus
Picoides scalaris
Oreothlypis peregrina
Grus canadensis
Accipiter sp.
Cardinalidae/Thraupidae sp.
Sitta sp.
Buteo sp.
Loxigilla portoricensis
Coccyzus vieilloti
Antrostomus noctitherus
Tiaris bicolor
Euphonia musica
Chordeiles gundlachii
Spindalis portoricensis
Columbidae sp.
Anatinae sp.
Icterus portoricensis
Fringillidae sp.
Laridae sp.
Hirundinidae sp.
Ammodramus henslowii
Porphyrio martinicus
Oreothlypis virginiae
Junco hyemalis caniceps
Empidonax sp.
Antrostomus sp.
Troglodytidae sp.
Cettia diphone
Serinus mozambicus
Amazilia beryllina
Picoides nuttallii
Picoides albolarvatus
Thryophilus sinaloa
Falco sp.
Empidonax difficilis/occidentalis
Apodidae sp.
Junco hyemalis mearnsi
Anas strepera
Anas discors", what="", sep="") #separates by space so i copy and pasted into excel to get a CSV

vec_mod = paste(birdspecies, collapse=",")
print (vec_mod)

#Transform CSV dataframe into vector 
birdmissingspeciesvec2 = as.vector(BirdSpeciesMissing$Species) #58 obs of 1 vars - 58 missing species

#Remove the 48 missing species from the full bird dataframe:
birdspecies_pruned = birdspeciesdf[!birdspeciesdf$birdspecies %in% birdmissingspeciesvec2, ] 
birdspecies_pruned = as.data.frame(birdspecies_pruned) #386 obs of 1 variable df
write.csv(birdspecies_pruned, "birdspecies_pruned.csv")

#Get list of bird species final for making the tree:
birdspecies_list = birdspecies_pruned$birdspecies_pruned
bird_list = paste(birdspecies_list, collapse=",") 
bird_list2 = paste(birdspecies_list, collapse="") #final

#export as txt file
write.table(bird_list, "bird_list.txt", sep=",")
writeLines(bird_list2, "bird_list2.txt", sep="")

#using https://phylot.biobyte.de/treeGenerator.cgi to make tree
#then using https://wiki.duke.edu/display/AnthroTree/11.1+Phylogenetic+community+ecology+in+R 

#Find beetle data
beetlespecies = as.vector(unique(beetle_full_data$scientificName))
beetlespeciesdf = as.data.frame(beetlespecies)
beetlespeciesdf = rename(beetlespeciesdf, species = beetlespecies)
write.csv(beetlespeciesdf, "beetlespeciesdf.csv")

#find plant data
plantspecies = as.vector(unique(plant_full_data$scientificName))
plantspeciesdf = as.data.frame(plantspecies)
plantspeciesdf = rename(plantspeciesdf, species = plantspecies)
write.csv(plantspeciesdf, "plantspeciesdf.csv")

#needs to be cleaned better, select first 2 phrases
library(stringr)
plantspeciescut = ifelse(is.na(word(plantspeciesdf$species, 1, 2)), plantspeciesdf$species, word(plantspeciesdf$species, 1, 2))
write.csv(plantspeciescut, "plantspeciescut.csv")
plantspeciescut2 = paste(plantspeciescut, collapse=",")
#remove unidentified species
plantspeciescut2df = as.data.frame(plantspeciescut)

plantspeciescut3 = as.data.frame(plantspeciescut2df[!grepl("sp.", plantspeciescut2df$plantspeciescut),])
plantspeciescut3alt = as.data.frame(plantspeciescut2df[!grepl("spp.", plantspeciescut2df$plantspeciescut),])
plantspeciescut3$species = plantspeciescut3$`plantspeciescut2df[!grepl("sp.", plantspeciescut2df$plantspeciescut), ]`
plantspeciescut3a = as.data.frame(plantspeciescut3[!grepl("spp.", plantspeciescut3$species),])
write.csv(plantspeciescut3a, "plantspeciescut_nospeciesmissinga.csv")



#Combine all 3 into list:

allspeciesdf = rbind(plantspeciesdf,beetlespeciesdf, birdspeciesdf)
n <- 20

plantspeciessplit = split(plantspeciescut3a, factor(sort(rank(row.names(plantspeciescut3a))%%n)))
plant1 = plantspeciessplit[["0"]]

write.csv(allspeciesdf, "allspeciesdf.csv")

                          