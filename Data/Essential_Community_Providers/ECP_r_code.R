#####################################################################################
##### Step 1: load libraries and files, set directory
#####################################################################################

library(tidyverse)
library(readxl)
library(httr) 
library(rvest)
library(RCurl) 
library(jsonlite)

setwd("E:/Postive Sum/HHS/ECP")

ECP <- read_excel("PY2021FINALECPLISTPUBLIC04.09.20.xlsx", col_names = FALSE)

state_fips <-read_csv("state_fips.csv")

colnames(ECP) <- c("ref_num", "site_name", "org_name", "NPI", "category", 
                  "num_hospital_bed", "FTE_medical", "FTE_dental", 
                  "address_1", "address_2", "city", "state", "zip", "county",
                  "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                  "AA", "AB", "AC", "AD", "AE")


#####################################################################################
##### Step 2: created dental-only file; split into sites and categories files
#####################################################################################

ECP_dental_sites <- ECP %>%
  left_join(state_fips, by = c("state" = "abbreviation")) %>%
  transmute(ref_num, site_name, org_name, NPI, FTE_dental, address_1, city, 
            state_abr = state, state_name = short_name, zip, county, 
            category = category) %>%
  filter(FTE_dental > 0)

ECP_dental_sites = ECP_dental_sites[-1,]
  

ECP_dental_categories <- ECP %>%
  select(ref_num, category) %>%
  separate_rows(category, sep = ", ")
ECP_dental_sites = ECP_dental_sites[-1,]
  
write.csv(ECP_dental_categories, "ECP_categories_2019.csv", row.names = FALSE)
  

#####################################################################################
##### Step 4: Geocode
#####################################################################################

# This code will only work with the PositionStack API

# Uncomment and replace with your own key
#my_key <- _____your_key________ 


# initialize empty lists. Master will gather the geocoding API output. Collection is
# a list of all the sites geocoded that's easy for the code to check if a site has 
# been run already or not
master <- list()
collection <- list()


# this code reads each row in the dental_sites file that has not been geocoded yet
for (row in length(collection)+1:nrow(ECP_dental_sites)) {
  ref <- ECP_dental_sites[row, "ref_num"]
  NPI <- ECP_dental_sites[row, 'NPI']
  address <- ECP_dental_sites[row, 'address_1']
  city <-ECP_dental_sites[row, 'city']
  state_name <- ECP_dental_sites[row, 'state_name']
  zip <- str_sub(ECP_dental_sites[row, 'zip'], 1, 5)
  
  address_url <- str_replace_all(address, " ", "+")
  city_url <- str_replace_all(city, " ", "+")
  zip_url <- str_replace_all(substr(zip, 1, 5), " ", "+")
  state_url <- str_replace_all(state_name, " ", "+")
  search_string <- paste(address_url, city_url, state_url, zip_url, sep = '+')  
  url <- paste0('https://api.positionstack.com/v1/forward?limit=1&access_key=', 
                my_key,
                '&query=',
                search_string,
                '&region=',
                state_url
  )
  
  if (NPI %in% collection) {next}
  print(url)
  collection[[as.character(NPI)]] <- NPI
  
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
  
  
  try(master[[as.character(NPI)]] <- c( "ref" = as.character(ref),
                                        "NPI" = as.character(NPI),
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
  
  
  print(paste(length(collection), lat, long, coded_state, coded_city, sep = "|"))
  
  
  if(length(collection) %% 100 == 0) {
    save(collection, file = "collection")
    save(master, file = "master")}
  
  
  
  remove(output_frame)
  remove(lat)
  remove(long)
  remove(coded_state)
  remove(coded_county)
  remove(coded_confidence)
  remove(coded_continent)
  remove(coded_city)
  
  if (length(collection) == nrow(ECP_dental_sites)) {break}
  Sys.sleep(.1)
}

#####################################################################################
##### Step 5: Clean up the files
#####################################################################################

# convert master list into a data frame
ECP_prelim <- do.call(rbind.data.frame, master) 

# rename the columns
colnames(ECP_prelim) <- c("reference_num", "npi", "street", "city", "state", "zip", "latitude", "longitude",
                          "url", "coded_state", "coded_county", "coded_confidence",
                          "coded_continent", "coded_city")

# attach back on the comma-separated categories list and the FTEs
ECP_dental_FTEs <- ECP_dental_sites %>%
  transmute(reference_num = ref_num, 
            site_name,
            FTE_dental,
            org_name,
            categories = category)

ECP_correct <- ECP_prelim %>%
  filter(latitude != "error" & longitude != "error") %>%
  filter(!grepl("http", latitude)) %>%
  left_join(ECP_dental_FTEs, by = c("reference_num", "reference_num")) %>%
  select(reference_num, npi, street, city, state, zip, latitude, longitude)


#####################################################################################
##### Step 6: Write to disk
#####################################################################################
write.csv(ECP_correct, "ECP_geocoded_2019.csv", row.names = FALSE, na = "")
