library(readxl) # for reading in excel spreadsheets
library('tidyverse') 

#################################################################################
########## Step 1: Read prepare to read in all the spreadsheets
#################################################################################

# Create a list of all the spreadsheets that we can loop over later.
# This assumes all the files are stored in main R directory.

file_list_year <- c("pir_export_2019.xlsx",
                    "pir_export_2018.xlsx",
                    "pir_export_2017.xlsx",
                    "pir_export_2016.xlsx",
                    "pir_export_2015.xlsx",
                    "pir_export_2014.xls",
                    "pir_export_2013.xls",
                    "pir_export_2012.xls",
                    "pir_export_2011.xls",
                    "pir_export_2010.xls",
                    "pir_export_2009.xls",
                    "pir_export_2008.xls")

#################################################################################
########## Step 2: Write the function that will read in and combine the sheets
#################################################################################

# Start by initializing empty data frames that our magic function is going to 
# access and add to in our loops. These three data frames corresponde to 
# our three spreadsheet sheets: 
#     frame_details -- Program Details
#     frame_enrollment -- Section A
#     frame_dental -- Section C

frame_details <- data.frame(stringsAsFactors=FALSE)
frame_enrollment <- data.frame(stringsAsFactors=FALSE)
frame_dental <- data.frame(stringsAsFactors=FALSE)

# Our function is where all the magin happens.
# It will read in each spreadsheet, extract our desired information from each 
# sheet, and append that information to our empty data frames from above.
magic <- function(file, frame_details, frame_enrollment, frame_dental) {
  
  # Extract the year associated with each file, which is pulled out of the file
  # name. The year is found in characters 12, 13, 14, 15.
  year = str_sub(file, 12, 15)

  
  # frame_enrollment AKA Section A
  # Read in Section A from the spreadsheet, skipping the first row and keeping the 
  # column names. The name_repair parameter replaces spaces with dots.
  frame_a <- read_excel(file, skip = 1, sheet = 'Section A', col_names = TRUE, .name_repair = 'universal')
  
  # Which columns we want to read depends on what years we have
  # Years 2008, 2009, 2010
  if (year %in% c(2008, 2009, 2010)) {
    frame_a <- transmute( frame_a,
                          grant_number = Grant.Number,
                          program_number = Program.Number,
                          year = year,
                          total_pregnant = A.11,
                          total_children = A.10.a + A.10.b + A.10.c + A.10.d + A.10.e + A.10.f
              )
  }
  # Years 2011, 2012, 2013, 2014
  else if (year %in% c(2011, 2012, 2013, 2014)) {
    frame_a <- transmute( frame_a,
                          grant_number = Grant.Number,
                          program_number = Program.Number,
                          year = year,
                          total_pregnant = A.13,
                          total_children = A.12.a + A.12.b + A.12.c + A.12.d + A.12.e + A.12.f
              )
    }
  # Years 2015, 2016, 2017, 2018, 2019
  else if(year %in% c(2015, 2016, 2017, 2018, 2019)) {
    frame_a <- transmute( frame_a,
                          grant_number = Grant.Number,
                          program_number = Program.Number,
                          year = year,
                          total_pregnant = A.14,
                          total_children = A.13.a + A.13.b + A.13.c + A.13.d + A.13.e + A.13.f
              )
    }         

  # Append this file's data to the accumulator frame_enrollment data frame.
  frame_enrollment <<- bind_rows(frame_a, frame_enrollment)  
  
  
  # frame_dental AKA Section C
  # Read in the spreadsheet sheet Section C, skipping the first row, keeping column names, and fixing names.
  frame_temp <- read_excel(file, skip = 1, sheet = 'Section C', col_names = TRUE, .name_repair = 'universal')
    
  # Years 2008, 2009, 2010, 2011
  if (year %in% c(2008, 2009, 2010, 2011)) {
  
      # Here we create two temporary data frames that we'll join later. The issue is the 'reason' why 
      # children didn't get dental care. For years 2008-2014 these are capture across many columns 
      # that we'll need to unpivot into a single 'reason' column as is the format in years 2015-2019.
      frame_measure <- transmute(frame_temp,
                                grant_number = Grant.Number,
                                program_number = Program.Number,
                                year,
                                dental_start_enrollment = C.15.1, # note this was changed from c.15-1 by .name_repair
                                dental_end_enrollment = C.15.2, # note this was changed from c.15.2 by .name_repair,
                                preventive_dental = C.16,
                                completed_oral_exam = C.17,
                                diagnosed_need_treatment = C.17.a,
                                received_or_receiving_treatment = C.17.a.1,
                                migrant_dental = C.18,
                                pregnant_dental = C.19) 
      
      frame_reason <- transmute(frame_temp,
                                grant_number = Grant.Number,
                                program_number = Program.Number,
                                year,
                                reason_insurance =             C.17.b.2,
                                reason_care_unavailable =      C.17.b.2,
                                reason_Medicaid_not_accepted = C.17.b.3,
                                reason_no_dentists_3_5 =       C.17.b.4,
                                reason_parents_appointment =   C.17.b.5,
                                reason_left_program =          C.17.b.6,
                                reason_future_appointment =    C.17.b.7) %>%
                      pivot_longer(cols = contains("reason"),
                                   names_to = "reason",
                                   values_to = "indicator") %>%
                      # These 'reason' columns were structured to have either "Yes" or "No" answers only.
                      # We only want to keep the Yes's, except we want the column headings, not the Yes's 
                      # themselves. So we filter for "Yes" and then drop the indictor column entirely.
                      filter(indicator == "Yes") %>%
                      select(-indicator)
      
      # We now join the data frame with the reasons onto our data frame with the rest of the dental data.
      # We separated and rejoined the data like this because otherwise we run into problems with the 
      # pivot_longer function multiplying rows on us.
      frame_together <- left_join(frame_measure, frame_reason, by=c("program_number", "grant_number", "year"))
                      
      # Append our dental data into the accumulator dental data frame.
      frame_dental <<- bind_rows(frame_dental, frame_together) 
      }
    
    # Years 2012, 2013, 2014
    # Pretty much the same thing as the previous step but some of the column names are different
    else if (year %in% c(2012, 2013, 2014)) {
    
      frame_measure <- transmute(frame_temp,
                                grant_number = Grant.Number,
                                program_number = Program.Number,
                                year,
                                dental_start_enrollment = C.17.1, # note this was changed from c.17-1 by .name_repair
                                dental_end_enrollment = C.17.2, # note this was changed from c.17.2 by .name_repair,
                                preventive_dental = C.18,
                                completed_oral_exam = C.19,
                                diagnosed_need_treatment = C.19.a,
                                received_or_receiving_treatment = C.19.a.1 ,
                                migrant_dental = C.20,
                                pregnant_dental = C.21
                                ) 
      
      frame_reason <- transmute(frame_temp,
                                grant_number = Grant.Number,
                                program_number = Program.Number,
                                year,
                                reason_insurance = C.19.b.1,
                                reason_care_unavailable = C.19.b.2,
                                reason_Medicaid_not_accepted = C.19.b.3,
                                reason_no_dentists_3_5 = C.19.b.4,
                                reason_parents_appointment = C.19.b.5,
                                reason_left_program = C.19.b.6,
                                reason_future_appointment = C.19.b.7,
                                reason_transportation = C.19.b.8,
                                reason_other = C.19.b.9) %>%
        pivot_longer(cols = contains("reason"),
                     names_to = "reason",
                     values_to = "indicator") %>%
        filter(indicator == "Yes") %>%
        
        select(-indicator)
      
      frame_together <- left_join(frame_measure, frame_reason, by=c("program_number", "grant_number", "year"))
      
      frame_dental <<- bind_rows(frame_dental, frame_together) 
      }
    
    # Years 2015, 2016, 2017, 2018, 2019
    else if (year %in% c(2015, 2016, 2017, 2018, 2019)) {
      # Here the data is already neatly formatted into the 'reason' column for us. No pivoting required.
      frame_temp <- transmute(frame_temp,
                              grant_number = Grant.Number,
                              program_number = Program.Number,
                              year,
                              dental_start_enrollment = C.17.1, # note this was changed from c.17-1 by .name_repair
                              dental_end_enrollment = C.17.2, # note this was changed from c.17.2 by .name_repair,
                              preventive_dental = C.18,
                              completed_oral_exam = C.19,
                              diagnosed_need_treatment = C.19.a,
                              received_or_receiving_treatment = C.19.a.1 ,
                              reason = C.19.b,
                              migrant_dental = C.20,
                              pregnant_dental = C.21)
      
      frame_dental <<- bind_rows(frame_dental, frame_temp) 
      }
  
  # Program Details sheet 
  # This grabs the program details we'll need for geocoding, as well as names and classifiers
  frame_temp <- read_excel(file, skip = 0, sheet = 'Program Details',col_names = TRUE, .name_repair = 'universal') %>%
    transmute(grant_number = Grant.Number, 
              program_number = Program.Number,
              year = year,
              program_type = Program.Type,
              grantee_name = Grantee.Name,
              program_name = Program.Name,
              agency_type = Program.Agency.Type,
              address = Program.Address.Line.1,
              city = Program.City,
              state = Program.State,
              zip = Program.ZIP.Code)
 
  frame_details <<- bind_rows(frame_details, frame_temp)
  
  }


#################################################################################
########## Step 3: Call the function over all our spreadsheets
#################################################################################

# These two simple lines call our magic function and apply over each 
# spreadsheet in our list

for (file in file_list_year) {
  magic(file, frame_details, frame_enrollment, frame_dental)}

#################################################################################
########## Step 4: Clean up the 'reason' column
#################################################################################

# This step standardizes the different reason why children did not get dental 
# care, which had various names. 

frame_dental <- frame_dental %>%
  mutate(reason_main = case_when(grepl("reason_left_program", reason) ~ "Children left the program before their appointment date",
                                 grepl("reason_no_dentists_3_5", reason) ~ "Dentists in the area do not treat 3 - 5 year old children",
                                 grepl("reason_parents_appointment", reason) ~ "Parents did not keep/make appointment",
                                 grepl("reason_Medicaid_not_accepted", reason) ~ "Medicaid not accepted by dentist",
                                 grepl("reason_care_unavailable", reason) ~ "No dental care available in local area", 
                                 grepl("reason_insurance", reason) ~ "Health insurance doesn't cover dental treatment", 
                                 grepl("reason_future_appointment", reason) ~ "Appointment is scheduled for future date",
                                 grepl("Other", reason) ~ "Other",
                                 grepl("other", reason) ~ "Other",
                                 grepl("Children left the program before their appointment date", reason) ~ "Children left the program before their appointment date",
                                 grepl("Dentists in the area do not treat 3 - 5 year old children", reason) ~ "Dentists in the area do not treat 3 - 5 year old children",
                                 grepl("Parents did not keep/make appointment", reason) ~ "Parents did not keep/make appointment",
                                 grepl("Medicaid not accepted by dentist", reason) ~ "Medicaid not accepted by dentist",
                                 grepl("No dental care available in local area", reason) ~ "No dental care available in local area", 
                                 grepl("Health insurance doesn't cover dental treatment", reason) ~ "Health insurance doesn't cover dental treatment", 
                                 grepl("Appointment is scheduled for future date", reason) ~ "Appointment is scheduled for future date",
                                )
  ) %>%
  select(-reason)

#################################################################################
########## Step 4: Create agency & program tables
#################################################################################



#################################################################################
########## Step 4: Geocoding & FIPS codes
#################################################################################

#file_list_year <- c( "pir_export_2019.xlsx")

#fips <- as.data.frame(
#  read_csv(
#    "https://raw.githubusercontent.com/PositiveSumData/NationalOralHealthDataPortal/master/Data/universal/FIPS_codes.csv"
#    )
#  )




#################################################################################
########## Step 5: 
#################################################################################




#write.csv(descriptors, CMS416_dental_descriptions_key.csv, row.names = FALSE)
