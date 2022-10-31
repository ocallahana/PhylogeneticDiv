##Build phylogenetic tree for Ayanna's Data
##Alexis O'Callahan
##Oct 31 2022

#Import all three community matrices from the box
#beetle_full_data, bird_full_data, plant_full_data

#Find the unique list of species names for each dataset
birdspecies = as.vector(unique(bird_full_data$scientificName))
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

#all the ways i failed at selecting the vector
#dput(birdmissingspecies) #missing bird species names to be removed
#birdspecies = as.data.frame(birdspecies)
#birdspecies_pruned <- birdspecies[c(birdmissingspecies),]
birdmissingspecies = as.vector(BirdSpeciesMissing)
birdspecies_pruned = birdspecies[c('BirdSpeciesMissing'), ]

#using https://phylot.biobyte.de/treeGenerator.cgi to make tree
#then using https://wiki.duke.edu/display/AnthroTree/11.1+Phylogenetic+community+ecology+in+R 


                          