library("readxl") # for reading in excel spreadsheets
library('tidyverse') 

setwd("E:/Postive Sum/CMS/CMS416")

#################################################################################
########## Step 1: Prepare to read in all the spreadsheets
#################################################################################

# CMS hosts EPSDT data in separate spreadsheets for each geography(state and national)
# and each year. These area available on the EPSDT website for download. The code
# below assumes you have downloaded all of the files into your working R directory.

# First we will create a list of all the files we'll be reading in so that we 
# can loop over it. The file names as of Feb 2020 are listed below. Note we are
# building separate lists for state and national data, as each geo level's spreadsheet
# is structured differently. Although thankfully within each geo level the structure
# stays the same across years.

file_list_state <- c("2019EPSDT_StateRpt_20201112.xlsx",
                     "2016 EPSDT State Report_2019 3 14.xlsx",
                     "2017 EPSDT State Report_2019 3 12.xlsx",
                     "2018EPSDT_State Rpt2019v2.xlsx",
                     "EPSDT 2010 State--11_19_14.xlsx",
                     "EPSDT 2011 State--01_07_14.xlsx",
                     "EPSDT 2012 State--10_22_14.xlsx",
                     "EPSDT 2013 State--10_22_14.xlsx",
                     "EPSDT 2014 State--4_28_2016.xlsx",
                     "EPSDT 2015 State--09292016.xlsx")

file_list_nat <- c("2019EPSDT_NtlRprt_20201112.xlsx",
                   "EPSDT 2015 National--09292016.xlsx",
                   "EPSDT 2014 National--4_28_16.xlsx",
                   "EPSDT 2013 National--10_22_14.xlsx",
                   "EPSDT 2012 National--10_22_14.xlsx",
                   "EPSDT 2011 National--01_07_14.xlsx",
                   "EPSDT 2010 National--11_19_14.xlsx",
                   "2018EPSDTNtl_Rpt_2019v2.xlsx",
                   "2017 EPSDT National Report_2019 3 12.xlsx",
                   "2016 EPSDT National Report_2019 3 14.xlsx")

# We also need to read in our FIPS codes for standardizing our geographies in our 
# master database. The file is available on our GitHub repository.
fips <- as.data.frame(read_csv("https://raw.githubusercontent.com/PositiveSumData/NationalOralHealthDataPortal/master/Data/universal/FIPS_codes.csv"))



# We also want a key to describe what the different lines mean. We write 
# short and long descriptors.
line <- c("12a", "12b", "12c", "12d", "12f", "12e", "12g")

line_description_long <- c("Total Eligibles Receiving Any Dental Services",
                      "Total Eligibles Receiving Preventive Dental Services",
                      "Total Eligibles Receiving Dental Treatment Services",
                      "Total Eligibles Receiving a Sealant on an Permanent Molar Tooth",
                      "Total Eligibles Receiving Oral Health Services Provided by a Non-Dentist Provider",
                      "Total Eligibles Receiving Dental Diagnostic Services",
                      "Total Eligibles Receiving Any Dental or Oral Health Service"
)
line_description_short <- c("Any Dental",
                       "Preventive Dental",
                       "Dental Treatment",
                       "Sealant on a Permanent Molar",
                       "Oral Health bya Non-Dentist",
                       "Dental Diagnostic",
                       "Any Dental or Oral Health"
)
descriptors <- data.frame(line, line_description_long, line_description_short)




#################################################################################
########## Step 2: Creating our function to loop over and read-in the spreadsheets
#################################################################################

# The biggest challenge reading in data from the spreadsheets is that there are 
# so many sheets in each state file (one sheet for every state). 
# We create a function, 'magic', that when used on each sheet extracts the data
# we need into a data frame.

#Initialize an empty data frame that will be added on to in the loop below
frame_full <- data.frame(stringsAsFactors=FALSE)

# create our magic function which reads excel sheets, makes Year, geography
# columns from sheet name, and combine into one mega dataframe
magic <- function(sheet, file, skip_num, frame_full) {
  frame_new <- read_excel(file, skip = skip_num, sheet = sheet, col_types = "text") %>%
    # create year column based on last element in the sheet name list
    mutate(year = word(sheet, -1)) %>%
    # create State column based on removing last element in the sheet name 
    #(breaking sheet name into pieces, removing last, collapsing back together)
    mutate(geography = paste(head(unlist(strsplit(sheet, "\\ ")), -1), collapse = " ")) %>%
    # convert from National to United States, which is the wording in our FIPS key
    mutate(geography = ifelse(geography == "National", "United States", geography)) %>%
    # connect to our fips crosswalk
    left_join(fips, by = c("geography" = "geo_short_name")) %>%
    mutate(cat = Cat) #%>%
    #select(-Cat, -geo_full_name, -geo_abbreviation, -geography)

  # add frame_new into frame_full
  frame_full <<- bind_rows(frame_new, frame_full)
}


#################################################################################
########## Step 3: Reading spreadsheets into a data frame
#################################################################################

# Here we use our magic function on the state files and the national files, separately.

# State files. Note skip_num = 4 because the first 4 rows of the spreadsheet are header.
# The function first loops over years, then within years it loops over sheets.
for (file in file_list_state) {
  for (sheet in excel_sheets(file)) {
    magic(sheet, file, skip_num = 4, frame_full)
  }
}

# National files. Note skip_num = 3 because the first 3 rows of the spreadsheet are header.
# The function first loops over years, then within years it loops over sheets.
for (file in file_list_nat) {
  for (sheet in excel_sheets(file)) {
    magic(sheet, file, skip_num = 3, frame_full)
  }
}

#################################################################################
########## Step 4: Tidying the data frame & adding line descriptions
#################################################################################

# The excel data is structured with each year in a separate column. We want to 
# tidy it up, unpivot these columns.

frame_full <- frame_full %>%
  separate(col = "Description", into = c("line", "description"), sep = "\\. ") %>%
  pivot_longer(cols = c(Total,"< 1", "1-2", "3-5", "6-9", "10-14", "15-18", "19-20"), 
               values_drop_na = TRUE, 
               names_to = "age", 
               values_to = "value") %>%
  left_join(descriptors, by = c("line" = "line")) %>%
  select(-description) %>%
  # remove the Total age category so in Tableau we know if we sum the age column it 
  # gives us the correctsum of all the ages
  filter(age != 'Total') %>%
  mutate(age = str_replace(age,"-", "--"))



#################################################################################
########## Step 5: Writing data frames to disk
#################################################################################

# We break our dataframe into two smaller ones: one for dental lines and the 
# other for total_eligibles. This way we can more easily calculate % utilization 
# by dividing one column by another after the two tables are joined.

# create and write csv that only includes dental lines
frame_dental <- frame_full %>%
  filter(line %in% c("12", "12a", "12b", "12c", "12d", "12f", "12e", "12g")) %>%
  rename(utilizer90 = value)
write.csv(frame_dental,"CMS416_dental90.csv", row.names = FALSE)

# create and write csv that only includes total eligibles
frame_total_eligible <- frame_full %>%
  filter(line == "1b") %>%
  select(-line, - line_description_long, -line_description_short) %>%
  rename(eligible90 = value)
write.csv(frame_total_eligible, "CMS416_eligible90.csv", row.names = FALSE)
