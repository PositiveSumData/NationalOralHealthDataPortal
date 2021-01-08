library(tidyverse)
library(httr) 
library(rvest)
library(RCurl)      # for downloading from the internet
library(janitor)    # to help rename columns
library(lubridate)
library(jsonlite)
library(zeallot)
library(stringr)


setwd("E:/Postive Sum/CMS/NPPES")
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

month <- "June"
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

# Let's read our our file into an R-friendly dataframe named "NPI". This will take a while:

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

tax_list <- c("122300000X",	
              "1223D0001X",
              "1223D0004X",
              "1223E0200X",
              "1223G0001X",
              "1223P0106X",
              "1223P0221X",
              "1223P0300X",
              "1223P0700X",
              "1223S0112X",
              "1223X0008X",
              "1223X0400X",
              "1223X2210X")


dental_NPIs <- NPI %>%
  # select the NPI column and all columns containing the taxonomy codes
  select(NPI, contains('Healthcare.Provider.Taxonomy')) %>%
  filter(Healthcare.Provider.Taxonomy.Code_1 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_2 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_3 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_4 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_5 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_6 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_7 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_8 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_9 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_10 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_11 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_12 %in% tax_list |
           Healthcare.Provider.Taxonomy.Code_13 %in% tax_list)

NPI_dental_specialties <- NPI %>%
  semi_join(dental_NPIs, by = c("NPI" = "NPI")) %>%
  select(NPI, contains('Healthcare.Provider.Taxonomy')) %>%
  pivot_longer(cols = contains('Healthcare.Provider.Taxonomy'), 
               names_to = 'tax_num' , 
               values_to = 'code', 
               values_drop_na = TRUE) %>%
  select(-tax_num) %>%
  left_join(dentist_taxonomy_codes, by = c("code" = "code")) %>%
  filter(type != "NA") %>%
  mutate(type_num = case_when(
    type == "Dentist" ~ 1,
    type == "General Practice" ~ 2,
    type == "Dental Public Health" ~ 3,
    type == "Pediatric Dentistry" ~ 4,
    type == "Endodontics" ~ 5,
    type == "Periodontics" ~ 6,
    type == "Orofacial Pain" ~ 7,
    type == "Prosthodontics" ~ 8,
    type == "Oral and Maxillofacial Surgery" ~ 9,
    type == "Orthodontics and Dentofacial Orthopedics" ~ 10,
    type == "Dentist Anesthesiologist" ~ 11,
    type == "Oral and Maxillofacial Radiology" ~ 12,
    type == "Oral and Maxillofacial Pathology" ~ 13 
  ))



# Now we go back to our flat file where each provider is represented as one row. 
# We want to extract only those providers who are also in our specialty table, and 
# we also want to select only the columns that are useful. Let's rename columns to
# make it easier to read and work with, and change the date format so it comports
# with a SQL server.

NPI_dentists <- NPI %>%
  semi_join(dental_NPIs, by = c("NPI" = "NPI")) %>%
  transmute(NPI, 
            NPI_type = Entity.Type.Code,
            f_name = Provider.First.Name,
            l_name = Provider.Last.Name..Legal.Name.,
            credential = Provider.Credential.Text,
            address = Provider.First.Line.Business.Practice.Location.Address,
            city = Provider.Business.Practice.Location.Address.City.Name,
            zip = Provider.Business.Practice.Location.Address.Postal.Code,
            state = Provider.Business.Practice.Location.Address.State.Name,
            last_update = mdy(Last.Update.Date),
            gender = Provider.Gender.Code,
            enumeration = mdy(Provider.Enumeration.Date)
  ) 

remove(dental_NPIs)

write.csv(NPI_dentists, "NPI_dentists.csv", row.names =FALSE)
write.csv(NPI_dental_specialties, "NPI_dental_specialties.csv", row.names=FALSE)

finished <- read_csv("NPI_geocoded.csv")
NPI_dentists2 <- NPI_dentists %>%
  mutate("npi" = NPI)



new_list <- anti_join(NPI_dentists2, finished, by = c("npi", "npi"))

#####################################################################################
###### Step 3: Geocoding
#####################################################################################

# this code is designed to work for the Position Stack API

# uncomment and replace with your key
#my_key <- __insert your key

NPI_geo <- NPI_dentists %>%
  mutate(latitude = NA, longitude = NA) 

state_fips <-read_csv("state_fips.csv")

NPI_geo <- new_list %>%
  left_join(state_fips, by = c("state" = "abbreviation"))


# initialize empty lists. Master2 accumulates the geoceded information. Collection
# is a list of the NPIs that have already run so that R knows where to pick up.
master2 <- list()
collection2 <- list()

# in case the 

# uncomment and run these if geocoding was interrupted and R needs to find where
# it left off.
#load("collection2")
#load("master2")


for (row in length(collection2)+1:nrow(NPI_geo)) {
  NPI <- NPI_geo[row, 'NPI']
  address <- NPI_geo[row, 'address']
  city <- NPI_geo[row, 'city']
  state <- NPI_geo[row, 'full_name']
  zip <- NPI_geo[row, 'zip']
  
  address_url <- str_replace_all(address, " ", "+")
  city_url <- str_replace_all(city, " ", "+")
  zip_url <- str_replace_all(substr(zip, 1, 5), " ", "+")
  state_url <- str_replace_all(state, " ", "+")
  search_string <- paste(address_url, city_url, state_url, zip_url, sep = '+')  
  url <- paste0('https://api.positionstack.com/v1/forward?limit=1&access_key=', 
                my_key,
                '&query=',
                search_string,
                '&region=',
                state_url
  )
  
  if (NPI %in% collection2) {next}
  print(url)
  collection2[[as.character(NPI)]] <- NPI
  
  output_frame <- "nope"
  
  try(output_frame <- try(fromJSON(try(getURL(url)))))

  if(class(output_frame) == "try-error" | output_frame == "nope") {next} 

  if(try(length(output_frame$data)) > 0){ 
    lat <- output_frame$data$latitude
    long <- output_frame$data$longitude
    coded_state <- output_frame$data$region
    coded_county <- output_frame$data$county
    coded_confidence <- output_frame$data$confidence
    coded_continent <- output_frame$data$continent
    coded_city <- output_frame$data$locality
  } else {
    lat <- 'error'
    long <- 'error'
    coded_state <- 'error'
    coded_county <- 'error'
    coded_confidence <- 'error'
    coded_continent <- 'error'
    coded_city <- 'error'
  }

  
  try(master2[[as.character(NPI)]] <- c("NPI" = as.character(NPI),
                                   "address" = as.character(address), 
                                   "city" = as.character(city),
                                   "state" = as.character(state),
                                   "zip" = as.character(zip),
                                   "lat" = as.character(lat),
                                   "long" = as.character(long),
                                   "url" = as.character(url),
                                   "coded_state" = as.character(coded_state),
                                   "coded_county" = as.character(coded_county),
                                   "coded_confidence" = as.character(coded_confidence),
                                   "coded_continent" = as.character(coded_continent),
                                   "coded_city" = as.character(coded_city)))
  
  
  print(paste(length(collection2), lat, long, coded_state, coded_city, sep = "|"))
  
  # Save every 100 files
  if(length(collection2) %% 100 == 0) {
    save(collection2, file = "collection2")
    save(master2, file = "master2")}
  
  
  
  remove(output_frame)
  remove(lat)
  remove(long)
  remove(coded_state)
  remove(coded_county)
  remove(coded_confidence)
  remove(coded_continent)
  remove(coded_city)
  
  Sys.sleep(.0001)
}

#####################################################################################
###### Step 4: Cleaning up and saving
#####################################################################################

# convert from list into data frame
npi_prelim2 <- do.call(rbind.data.frame, master2)

colnames(npi_prelim2) <- c("npi", "street", "city", "state", "zip", "lat", "long")
# remove geocoding errors
npi_correct2 <- npi_prelim2 %>%
  filter(lat != "error" & long != "error") %>%
  filter(!grepl("http", lat))

NPI_geocoded <- read_csv("NPI_geocoded.csv") %>%
  mutate(npi = as.character(npi),
         lat = as.character(lat),
         long = as.character(long),
         coded_confidence = as.character(coded_confidence))%>%
  bind_rows(npi_correct2, by = c("npi" = "npi"))

# save to disk
write.csv(NPI_correct, "NPI_geocoded.csv", row.names = FALSE)