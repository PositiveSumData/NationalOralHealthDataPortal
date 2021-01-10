# load libraries and set working directory
library(tidyverse)

setwd("E:/Postive Sum/CDC/SEER")

# read in helper files for adding geographic detail later
state_fips <- read.csv("state_fips.csv", colClasses=c(rep("character", 5)))
county_fips <- read.csv("county_fips.csv", colClasses=c(rep("character", 5))) 


# prepare a list of files to be read from those downloaded in the CDC USCS zip file

infile_list <- c("BYSITE.TXT",
               "BYAREA_COUNTY.TXT",
               "BYAREA.TXT")

outfile_list <- list()

# loop over the three files, gather the data we need
for (file in infile_list) {
   infile <- read.delim(paste0("E:/Postive Sum/CDC/SEER/download/", file), header = TRUE, sep = "|")

   
   infile <- infile %>%
     mutate(file = file,

            STATE = ifelse(file == "BYSITE.TXT", "United States (all states)", 
                                  ifelse(file == "BYAREA.TXT", AREA, substr(AREA, 1, 2))),
            
            COUNTY = ifelse(file == "BYSITE.TXT", "(all counties)", 
                                   ifelse(file == "BYAREA_COUNTY.TXT", 
                                          str_extract(string = AREA,
                                                      pattern = "(?<=\\()[^()]*(?=\\))"),
                                          ifelse(file == "BYAREA.TXT", "(all counties)"))),
                                          
            GEOGRAPHIC_LEVEL = ifelse(file == "BYSITE.TXT", "COUNTRY",
                                             ifelse(file == "BYAREA.TXT", "STATE",
                                                    ifelse(file == "BYAREA_COUNTY.TXT", "COUNTY"))))
   
   if (file == "BYAREA_COUNTY.TXT") {
     infile <- left_join(infile, county_fips, by = c("COUNTY" = "FIPS_code")) %>%
                   mutate(COUNTY = short_name,
                          STATE = state_name) %>%
                   select(-full_name, 
                          -short_name,
                          -abbreviation,
                          -geographic_type) 
   }
   
   if (file == "BYAREA.TXT") {
     infile <- infile %>%
       filter(!AREA %in% c("East North Central", "East South Central", "Mountain",
                         "West North Central", "West South Central",
                         "(comparable to ICD-O-2)", "ICD-O-2)", "New England", 
                         "Middle Atlantic", "Mountain", "Midwest", "South Atlantic",
                         "United States (comparable to ICD-O-2)", "San Francisco-Oakland",
                         "San Jose-Monterey", "Seattle-Puget Sound", "Los Angeles",
                         "Detroit", "Northeast", "Atlanta", "Pacific", "South",
                         "West"))
   }
   
   outfile_list[[file]] <- infile
}

   

# condense the list of files into a data frame
SEER <- do.call(bind_rows, outfile_list)

# keep only oral cancer data
SEER_master <- SEER %>%
  filter(SITE == "Oral Cavity and Pharynx")


# prepare a dataframe with only the unadjusted data
SEER_unadj <- SEER_master %>%

  mutate(MEASURE_CALCULATION = "Crude",
         CI_LOWER = CRUDE_CI_LOWER,
         CI_UPPER = CRUDE_CI_UPPER,
         RATE = CRUDE_RATE) %>%
  filter(!is.na(RATE)) %>%
  select(COUNT, EVENT_TYPE, POPULATION, 
       RACE, SEX, YEAR, CI_LOWER,
       CI_UPPER, RATE, STATE, COUNTY, 
       GEOGRAPHIC_LEVEL, MEASURE_CALCULATION) 

# prepare a dataframe with only the adjusted data
SEER_adj <- SEER_master %>%
  mutate(MEASURE_CALCULATION = "Age-adjusted",
         CI_LOWER = AGE_ADJUSTED_CI_LOWER,
         CI_UPPER = AGE_ADJUSTED_CI_UPPER,
         RATE = AGE_ADJUSTED_RATE) %>%
  filter(!is.na(RATE)) %>%
  select(COUNT, EVENT_TYPE, POPULATION, 
       RACE, SEX, YEAR, CI_LOWER,
       CI_UPPER, RATE, STATE, COUNTY, 
       GEOGRAPHIC_LEVEL, MEASURE_CALCULATION) 

# put the adjusted and unadjusted data together
SEER_combined <- SEER_unadj %>%
  rbind(SEER_adj) %>%
  mutate(MEASURE = EVENT_TYPE,
         COUNTRY = "United States") %>%
  filter(RATE != "~",
         !is.na(COUNTY),
         STATE != "#N/A")


# keep only the data we need in the prime file (no CIs)
SEER_prime <- SEER_combined %>%
  select(YEAR,
         GEOGRAPHIC_LEVEL,
         COUNTRY,
         STATE,
         COUNTY,
         RACE,
         SEX,
         MEASURE,
         MEASURE_CALCULATION,
         RATE,
         POPULATION)

# create a confidence interval file with CIs unpivoted so that Tableau can read it
SEER_CI <- SEER_combined %>% 
  select(YEAR,
         GEOGRAPHIC_LEVEL,
         COUNTRY,
         STATE,
         COUNTY,
         RACE,
         SEX,
         MEASURE,
         MEASURE_CALCULATION,
         CI_LOWER,
         CI_UPPER) %>%
  pivot_longer(cols=c("CI_LOWER", "CI_UPPER"), values_to = "confidence_value", names_to = "confidence_level") %>%
  mutate(order = ifelse(confidence_level == "CI_Lower", 1:n(), 100000000 - 1:n()))


# write files to disk
write.csv(SEER_prime, "SEER_prime.csv", row.names = FALSE)
write.csv(SEER_CI, "SEER_CI.csv", row.names = FALSE)