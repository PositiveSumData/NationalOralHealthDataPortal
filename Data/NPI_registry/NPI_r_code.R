# import libraries
library(tidyverse)
library(RCurl)      # for downloading from the internet
library(janitor)    # to help rename columns


#####################################################################################
###### Step 1: Downloading and extracting our NPI dataframe
#####################################################################################

# The NPI file is an ENORMOUS 7 gigabiytes! We don't want that taking up space
# on our computers or having to delete it manually everytime after we're done 
# with it. Instead, let's download it directly from the CWS websiteinto a to a
# temporary file that automatically # gets wiped when we close R. 

# The NPI file is available from the CMS website here:
# https://download.cms.gov/nppes/NPI_Files.html
# It downloads as a compressed ZIP folder with several files. We just want one of the 
# files: the Full Replacement Monthly File. Unfortunately the url is not persistent;
# it changes every time it is updated because the month and year are in the file name.
# e.g. "https://download.cms.gov/nppes/NPPES_Data_Dissemination_April_2020.zip".
# So we build our own url by inputting month and year ourselves and concatenating:

month <- "April"
year <- "2020"
url_base <- "https://download.cms.gov/nppes/NPPES_Data_Dissemination_"
url <- paste(url_base, month, "_", year, ".zip", sep = "")

# Now we download the zip file to a temporary director. First we initialize the directory.

temp1 <- tempfile()

# Then we download the ZIP folder to the temp directory:

download.file(url, temp1)

# We have temporarily saved the compressed folder. Let's unzip it and save all the 
# invidual files in another temoporary directory:

temp2 <- tempfile()
temp2 <- unzip(zipfile = temp1, exdir = temp2)

# We see 10 files inside. Unfortunately the one we want again has a filename that changes
# according the date CMS updated it, and we have no way of predicting that date.
# Let's write a fot loop that iterates over each of the files in the ZIP folder and plucks
# the one we want. We want the file that begins with "npidata_pfile" but DOES NOT end
# with "FileHeader". Save our file location as "outfile".

for(file in temp2){print(file)}

for (file in temp2){
  if (str_detect(file, "npidata_pfile")) {
    if (str_detect(file, "FileHeader", negate = TRUE)){
        outfile = file
    }
  }
}    

# Let's read our ourfile into an R-friendly dataframe named "NPI". This will take a while:

NPI <- as.data.frame(read_csv(outfile))

# Great, we have out dataframe. Time to clean up our environment of those temp directories 
# and free up some memory.

unlink(temp1, recursive=TRUE)
unlink(temp2, recursive=TRUE)
gc()

#####################################################################################
###### Step 2: Extract dentists
#####################################################################################

# We have over 6 millions rows of different types of healthcare providers and organizations.
# Let's extract only the dentists and make the file size more manageable.
# First let's fix our column headers. The headers currently have spaces in them, which are 
# more difficult to work with. This step replaces spaces with periods.

colnames(NPI) <- make.names(colnames(NPI))

# How do we know which NPI #s are associated with dentists? We need taxonomy codes to decifer
# all the 'Healthcare.Provider.Taxonomy fields. We can download these from our GitHub repository:

dentist_taxonomy_codes <- as.data.frame(read.csv("https://raw.githubusercontent.com/PositiveSumData/NationalOralHealthDataPortal/master/Data/NPI_registry/taxonomy_codes.csv"))

# Now we build a simple three-column table of NPIs by their specialty code and type, unpivoting the dozen or so 
# taxonomy columns into one column. Note, these pivots take R long time to process.

specialty <- NPI %>%
  # select the NPI column and all columns containing the taxonomy codes
  select(NPI, contains('Healthcare.Provider.Taxonomy')) %>%
  pivot_longer(cols = contains('Healthcare.Provider.Taxonomy'), 
               names_to = 'tax_num' , 
               values_to = 'code', 
               values_drop_na = TRUE) %>%
  # keep only those NPIs where the taxonomy codes match our dentist list
  inner_join(dentist_taxonomy_codes, by = c('code' = 'code')) %>%
  select(-tax_num)

# Now we go back to our flat file where each provider is represented as one row. 
# We want to extract only those providers who are also in our specialty table, and 
# we also want to select only the columns that are useful. Let's rename columns to
# make it easier to read and work with, and change the date format so it comports
# with a SQL server.

provider <- NPI %>%
  transmute(NPI, 
            NPI_type = Entity.Type.Code,
            f_name = Provider.First.Name,
            l_name = Provider.Last.Name..Legal.Name.,
            credential = Provider.Credential.Text,
            address = Provider.First.Line.Business.Practice.Location.Address,
            city = Provider.Business.Practice.Location.Address.City.Name,
            zip = Provider.Business.Practice.Location.Address.Postal.Code,
            state = Provider.Business.Practice.Location.Address.State.Name,
            last_update = ymd(Last.Update.Date),
            gender = Provider.Gender.Code,
            enumeration = ymd(Provider.Enumeration.Date),
            deactivation = ymd(NPI.Deactivation.Date),
            reactivation = ymd(NPI.Reactivation.Date)
            ) %>%
  semi_join(specialty, by = c('NPI' = 'NPI'))


#####################################################################################
###### Optional Step 2.1: Geocode addresses
#####################################################################################

# We would like additional geographic information including longitude, latitude,
# and the county FIPS code for each provider. A separate R script can do this, please
# find the R script titled 'fido' the Positive Sum GitHub account. 
# It will read the address, city, state, and zip # fields and add lat,long, and FIPS
# fields using calls to the US Census geocoder.


#####################################################################################
###### Step 3: Geocode addresses
#####################################################################################

# Write our specialty and provider dataframes to csv in our default directory.

#write file to csv
write.csv(provider, "provider.csv", na = "", row.names=FALSE)
write.csv(specialty, "specialty.csv", row.names=FALSE)


