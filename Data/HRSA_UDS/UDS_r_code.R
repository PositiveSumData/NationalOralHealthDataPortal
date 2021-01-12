library('readxl') # for reading in excel spreadsheets
library('tidyverse')
library('rvest') # for web-scraping
library('httr') # for web-scraping


setwd("E:/Postive Sum/HRSA/UDS")
#################################################################################
########## Step 1: set up a list of UDS reports to be read
#################################################################################

# The file names below represent the raw file names as downloaded from the HRSA
# electronic reading room or provided via FOIA. Pre-2014 files were obtained by FOIA
# Pre-2012 files were provided as Microsoft Access files and have been converted 
# to xlsx files for ease of extraction. Original file names were preserved.
# For the converted MS Access files, only relevant tables were converted to xlsx.

xlsx_list <- c("UDS-2019-Full-Dataset-look-alikes.xlsx",
               "UDS-2019-Full-Dataset.xlsx",
               "UDS-2018-Full-Dataset-look-alikes.xlsx",
               "UDS-2018-Full-Dataset.xlsx",
               "UDS-2017-Full-Dataset-look-alikes.xlsx",
               "UDS-2017-Full-Dataset.xlsx",
               "UDS-2016-healthcenters-look-alikes.xlsx",
               "UDS-2016-Full-Dataset.xlsx",
               "UDS-2015-Full-Dataset.xlsx",
               "UDS-2014-Full-Dataset.xlsx",
               "UDS 2013 NonProprietaryandProprietaryWithConsent.xlsx",
               "UDS 2012-non-proprietary and proprietary with consent.xlsx",
               "UDS 2011 NonProprietaryandPropretaryWithConsent.xlsx",
               "UDS 2010 NonProprietaryandProprietaryWithConsent.xlsx",
               "UDS 2009 NonProprietaryandProprietaryWithConsent.xlsx",
               "UDS 2008  NonProprietaryandProprietaryWithConsent.xlsx",
               "UDS 2007  NonProprietaryandProprietaryWithConsent.xlsx",
               "UDS 2006  NonProprietaryandProprietaryWithConsent.xlsx",
               "UDS 2005  NonProprietaryandProprietaryWithConsent.xlsx",
               "UDS 2004  NonProprietaryandProprietaryWithConsent.xlsx")

#################################################################################
########## Step 2: Loop over all the UDS reports reading in the data
#################################################################################

# Initialize empty lists to be added to in the function below
list_HealthCenterInfo <- list()
list_3B <- list()   # for total FQHC patient counts
list_6A <- list()
list_6B <- list()


# Write our function that will do all the heavy lifting reading in the UDS reports
magic_xlsx <- function(file) {
  
  # extract the year from each file name to use as our year variable
  year_location <- str_locate(file, '20')[1]
  year <- as.integer(str_sub(file, year_location, year_location+3))
  
  # extract the type of health center (fqhc or lookalike) based on the file name
  hc_type <- ifelse(str_detect(file, "alike"), "lookalike", "fqhc")
  
  # Determine the number of initial rows to skip for tables 3 and 6 since
  # different years have different file formats
  skip_line <- case_when(year <= 2013 ~ 0,
                         year <= 2015 ~ 2,
                         year > 2015 ~ 1)  
  
  ####################### 
  # Health Center Info.
  # Loop over the healthcenterinfo tables, which contain organization name and locations
  
  # Prepare to extract the health center ID from the correct column depending on the year
  sheet_name <- case_when(year <= 2010 ~ 'tblGranteeInfo',
                          year <= 2011 ~ 'GranteeInfo',
                          year > 2011 ~ 'HealthCenterInfo')
  
  # Set the correct number of lines to skip reading in the healthcenterinfo table, 
  # which is usually different than the number of lines to skip for the other tables.
  skip_line_info <- ifelse(year == 2014 | year == 2015, 1, 0) 
  
  # For error checking, print out the sheet being read
  sheet_healthcenterinfo <- paste0('healthcenterinfo',hc_type, year)
  print(sheet_healthcenterinfo)
  
  # Read in the excel spreadsheet, add column names, and store as an item in a list 
  # for all healthcenterinfo tables
  list_HealthCenterInfo[[sheet_healthcenterinfo]] <<- read_excel(file, skip = skip_line_info, sheet = sheet_name,
                                                                 col_type = 'text', col_names = TRUE) %>%
                                                      rename_all(funs(str_replace_all(., " ", ""))) %>%
                                                      mutate(year = year, hc_type = hc_type)
  
  ########################  
  # Table 3B.
  # This table gives us the total count of fqhc patients we need for 
  # denominators in calculating the rate of patients receiving dental 
  # care. 
  
  # Save the name of the sheet depending on which years we're working with
  sheet_3B <- case_when(year <= 2010 ~ 'tblTable3B',
                        year > 2010 ~ 'Table3B')
  
  # Have our function loop over the different types of Table 3B sheets depending
  # on funding type. These other funding types are homeless, migrant, and pubic
  # housing.
  for (fund in c('',"HO","MHC","PH")){
    
    # For error checking, print out the current sheet being read
    sheet_name <- paste(sheet_3B, fund, sep="")
    id <- paste0("Table_3b", hc_type, fund, year)
    print(id)
    
    # Skip the loop when it's set for lookalikes and HO/MHC/PH because
    # these tables don't exist.
    if (hc_type == 'lookalike' & fund != '') {next}
  
    # Store the results in a list 
    list_3B[[id]] <<- read_excel(file, skip = skip_line, sheet = sheet_name, col_type = 'text', 
                                 col_names = TRUE)  %>%
                      mutate(year = year, fund_type = fund, hc_type = hc_type)
  }
  
  ######################## 
  # Table 6A
  # This table gives us visit and patient counts by dental service
  
  # Save the sheet name depending on which year it is
  sheet_6A <- case_when(year <= 2007 ~ 'tblTable6',
                        year <= 2010 ~ 'tblTable6A',
                        year > 2010 ~ 'Table6A')
  
  # Loop over the different funding types
  for (fund in c('',"HO","MHC","PH")){
    
    # Print the current table for error checking
    sheet_name <- paste(sheet_6A, fund, sep="")
    id <- paste0(sheet_name, hc_type,  year)
    print(id)
    
    # Skip if the table doesn't exist
    if (hc_type == 'lookalike' & fund != '') {next}

    # Store as a list
    list_6A[[id]] <<- read_excel(file, skip = skip_line, sheet = sheet_name, col_type = 'text', 
                                 col_names = TRUE)  %>%
                      mutate(year = year, fund_type = fund, hc_type = hc_type)

  }
  
  ######################## 
  # Table 6B. 
  
  # This table gives us the dental sealant quality measure
  sheet_6B <- paste0("Table6B", year)
  
  # Since this is a newer measure and only exists since 2015, don't bother
  # reading in years before 2015. Store as a list of data frames.
  if(year >= 2015){
    print(paste0(sheet_6B, hc_type, year))
    list_6B[[sheet_6B]] <<- read_excel(file, skip = skip_line, sheet = 'Table6B', 
                                       col_type = 'text', col_names = TRUE) %>%
                            mutate(year = year, fund_type = fund, hc_type = hc_type)
    }
  
  }


# Run our magic function over the list of UDS reports!!

for (file in xlsx_list) {magic_xlsx(file)}



##################
# HealthCenterInfo

# We do two interesting things here that will be caried over to the other sheets below: 
# (1) We delete records for two health center lookalikes that for some strange reason 
# are also listed in other reports as being full FQHCs. To avoid breaking our data tables
# we only include their FQHC data, not their lookalike data.
# (2) We add an apostrophe before all health center IDs. This is to make our lives easier
# in Excel or Google Sheets. Many of the health center IDs start with leading zeros, which
# spreadsheet software will automatically chop off, ruining our IDs. By adding apostrophes 
# we tell the software to keep the leading zeros. 

table_HealthCenterInfo <- do.call(bind_rows, list_HealthCenterInfo) %>%
  transmute(hc_id = case_when(year <= 2010 ~ gi_lngGranteeID,
                              year > 2010 ~ BHCMISID),
            year, 
            hc_type,
            HealthCenterName = case_when(year >= 2012 ~ HealthCenterName,
                                         year >= 2011 ~ GranteeName,
                                         year >= 2004 ~ gi_txtName), 
            HealthCenterState = case_when(year >= 2012 ~ HealthCenterState,
                                          year >= 2011 ~ GranteeState,
                                          year >= 2004 ~ gi_txtState)
  ) %>%
  filter(!((hc_type == "lookalike" & hc_id == "09E00004")|
           (hc_type == "lookalike" & hc_id == "03E00360"))) %>%
  mutate(hc_id = paste0("'", hc_id))

##################
# Table 3B


table_3B <- do.call(bind_rows, list_3B) %>%
  transmute(hc_id = case_when(year <= 2009 ~ gi_lngGranteeID,
                              year == 2010 ~ gi_lnggranteeid,
                              year > 2010 ~ BHCMISID), 
            year, 
            hc_type,
            fund_type = case_when(
                            fund_type == '' ~ 'general',
                            fund_type == 'MHC' ~ 'migrant',
                            fund_type == 'HO' ~ 'homeless',
                            fund_type == 'PH' ~ 'public housing'),
            line = 'total all FQHC service types',
            patients = T3b_L8_Cd,
            visits = NA) %>%
  filter(!((hc_type == "lookalike" & hc_id == "09E00004")|
           (hc_type == "lookalike" & hc_id == "03E00360"))) %>%
  select(-hc_type) %>%
  mutate(hc_id = paste0("'", hc_id))
            
##################
# Table 6A

table_6A <- do.call(bind_rows, list_6A) %>%
  transmute(hc_id = case_when(year <= 2009 ~ gi_lngGranteeID,
                              year == 2010 ~ gi_lnggranteeid,
                              year > 2010 ~ BHCMISID),
            hc_type,
            year, 
            # What follow are the columns corresponding to dental services
            T6a_L27_Ca, T6a_L27_Cb, T6a_L28_Ca, T6a_L28_Cb, T6a_L29_Ca, T6a_L29_Cb,
            T6a_L30_Ca, T6a_L30_Cb, T6a_L31_Ca, T6a_L31_Cb, T6a_L32_Ca, T6a_L32_Cb,
            T6a_L33_Ca, T6a_L33_Cb, T6a_L34_Ca, T6a_L34_Cb,
            fund_type = case_when(
                            fund_type == '' ~ 'general',
                            fund_type == 'MHC' ~ 'migrant',
                            fund_type == 'HO' ~ 'homeless',
                            fund_type == 'PH' ~ 'public housing')) %>%
  pivot_longer(cols = starts_with('T6a'), names_to = 'TLC', values_to = 'value') %>%
  separate(TLC, into = c('table', 'line', 'column'), sep='_') %>%
  filter(!((hc_type == "lookalike" & hc_id == "09E00004")|
           (hc_type == "lookalike" & hc_id == "03E00360"))) %>%
  pivot_wider(names_from = column, values_from = "value") %>%
  mutate(visits = Ca, patients = Cb) %>%
  select(-Ca, -Cb, -table) %>%
  # Rename the different reporting lines to the dental service they describe
  mutate(line = case_when(
                line == 'L27' ~ 'dental emergency',
                line == 'L28' ~ 'oral exam',
                line == 'L29' ~ 'oral prophylaxis',
                line == 'L30' ~ 'dental sealants',
                line == 'L31' ~ 'fluoride',
                line == 'L32' ~ 'dental restorative',
                line == 'L33' ~ 'oral surgery',
                line == 'L34' ~ 'dental rehabilitative'),
         hc_id = paste0("'",hc_id)
  ) %>% 
  select(-hc_type) 



############
# Table 6B.
# Combine all the list of table 6B tables into one dataframe. Drop the two lookalikes
# as above and add an apostrophe prefix to the hc_id column.

table_6B <- do.call(bind_rows, list_6B) %>%
  transmute(hc_id = BHCMISID, year, hc_type, identified_high_risk_6_9 = T6b_L22_Ca,
            sealants_high_risk_6_9 = T6b_L22_Cc) %>%
  filter(!((hc_type == "lookalike" & hc_id == "09E00004")|
             (hc_type == "lookalike" & hc_id == "03E00360"))) %>%
  filter(!is.null(patients) | !is.na(patients)) %>%
  select(-hc_type) %>%
  mutate(hc_id = paste0("'", hc_id))


#################################################################################
########## Step 6: Combine Tables 3B, 6A into one patient-visits frame
#################################################################################


patients_and_visits <- bind_rows(table_3B, table_6A) 

# Replace all dashes with NAs to ensure we have numeric fields
patients_and_visits[patients_and_visits == '-'] <- NA

patients_and_visits <- patients_and_visits %>%
  mutate(patients = as.numeric(patients),
         visits = as.numeric(visits))

#################################################################################
########## Step 7: Write files to disk
#################################################################################

# Write our 3 dataframes to csv, replacing NAs with empty cells

write.csv(patients_and_visits, "patients_and_visits.csv", row.names=FALSE, na= "")

write.csv(table_HealthCenterInfo, "healthcenterinfo.csv", row.names=FALSE, na="")

write.csv(table_6B, "table6B_quality.csv", row.names=FALSE, na = "")




