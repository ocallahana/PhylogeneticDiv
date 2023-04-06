# PhylogeneticDiv

## MULTITROPHIC DIVERSITY CODE

I used MultidiversityThreshold.R to calculate multidiversity based on Ayanna's data and this paper: https://www.pnas.org/doi/10.1073/pnas.1906419116
#output file was: multidiversityresults-nov7.csv
I couldn't figure out the authors' threshold approach so only calculated without thresholds, which means we need to figure out how to do thresholds still.

## PHYLOGENETIC DIVERSITY CODES
BuildTree.R is the script that produced many outputs in the github ("allspeciesdf.csv", plantspeciescut_nospeciesmissinga.csv, 
"plantspeciesdf.csv", "beetlespeciesdf.csv", "birdspecies_pruned.csv"

The three spreadsheets containing species data from NEON are csvs/excel files: beetle_full_data, bird_full_data, plant_full_data 
which are from Ayanna's work and found on the box because plant data was too big to push to git

To compute phylodiv, need to 1) clean data, 2) find a reference taxonomic phylogeny to help clean/standardize data 
#and later calculate the Phylogenetic Diversity which is what BuildTree.R is for...

BuildTree.R led to 3 species outputs, which were uploaded to  https://phylot.biobyte.de/index.cgi. There were formatting issues
with csvs/excel files and the type of delimiter (comma vs. space vs line) so I experimented with apple scripts and text files.
Moving excel/csvs into apple scripts was productive for removing any artifacts I think, and I later saved those to text files because
I'm working on a mac and don't know where the notepad app is lol. I had to remove commas to work with PHYLOT, 
and data needs to be separated by lines. This explains the triplicate files.

The bird text file worked for making a phylogenetic tree ("birdtext.txt") on PHYLOT, then I moved onto plants and beetles. Plants didn't work for building 
phyloenetic trees because there were so many NAs from incongruences between NCBI's taxonomic naming and NEON's. Last file I worked with was 
(plantspecies_nocommas_nospp.txt),
where I removed the "spp" to improve matching between the databases. This didn't work. I tried to make sure the plants worked period so made a small 
sample file with 3 species (test_plant_smallsubsample.txt).
