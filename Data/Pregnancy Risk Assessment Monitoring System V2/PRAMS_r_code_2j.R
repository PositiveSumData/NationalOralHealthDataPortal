library(tidyverse)
library(haven) # for importing SAS file
library(survey) # for handling complex survey design
library(srvyr)

# Suppress output informing every time a grouping happens
options(dplyr.summarise.inform = FALSE)

# Increase memory allotment and add parallel processing for speed
memory.limit(50000)
doParallel::registerDoParallel()

# Set working directory
setwd("E:/UMich/PRAMS/OMalley_2016_2018")

###################################################################
# Read in data and change names
###################################################################

# Read in the raw data file (in this case named OMalley_2016_2018.sas7bdat)
PRAMS <- read_sas("E:/UMich/PRAMS/OMalley_2016_2018/OMalley_2016_2018.sas7bdat") %>%
  transmute(##################################
            # TECHNICAL
            ##################################
            ID,
            # combine current upstate NY label and New York City label into one NY variable
            state = case_when(STATE == "YC" ~ "NY",
                              TRUE ~ STATE),
            state_Medicaid_comprehensiveness = case_when(
              STATE %in% c("TN", "AL") ~ "none",
              STATE %in% c("AK", "AZ", "TX", "OK", "GA", "ME", "NH") ~ "emergency",
              STATE %in% c("NV", "WY", "SD", "NE", "KS", "MN", "AR", "LA",
                           "MS", "FL", "IN", "KY", "MI", "WV", "PA", "SC",
                           "MD", "DE") ~ "limited",
              STATE %in% c("WA", "OR", "CA", "ID", "UT", "CO", "NM", "ND", 
                           "IA", "MO", "IL", "WI", "OH", "VA", "NC", "NY", 
                           "CT", "MA", "RI", "NJ", "VT", "MT") ~ "extensive"),
            # create a country == 1 variable for estimates on all sites
            country = "all sites",
            TOTCNT,
            weights = WTANAL,
            strata = SUD_NEST,
            
            ##################################
            # DEMOS
            ##################################
            INCOME8,
            EVER_MAR, # ever married?
            MOMCIG, # cigs per day
            PAY4 = case_when(PAY == 1 ~ 1, # Medicaid
                             PAY == 2 ~ 2, # private
                             PAY == 3 ~ 3, # self-pay)
                             PAY == 4 | PAY == 5 | PAY == 6 | PAY == 8 ~ 4), # other gov
            POB, # place of birth
            MM_DIAB, # diabetes?
            MM_NOMD, # No medical risk factors?
            ED = case_when(MAT_ED == 1 | MAT_ED == 2 ~ 1, # less than high school
                           MAT_ED == 3 ~ 2, # high school
                           MAT_ED == 4 | MAT_ED == 5 ~ 3), # some college or more
            MAT_WIC,
            MM_HBP,
            URB_RUR,
            MM_HBP,
            age = case_when(MAT_AGE_NAPHSIS == 1 | MAT_AGE_NAPHSIS == 2 ~ 1, # <= 19
                            MAT_AGE_NAPHSIS == 3 ~ 2, # 20-24
                            MAT_AGE_NAPHSIS == 4 ~ 3, # 25-29
                            MAT_AGE_NAPHSIS == 5 ~ 4, # 30-34
                            MAT_AGE_NAPHSIS == 6 | MAT_AGE_NAPHSIS == 7 ~ 5), # 35+,
            race_eth4 = case_when(HISPANIC == 2 ~ 1, # Hispanic
                                  HISPANIC == 1 & MAT_RACE == 2 ~ 2, # White
                                  HISPANIC == 1 & MAT_RACE == 3 ~ 3, # Black
                                  HISPANIC == 1 & MAT_RACE > 3 ~ 4), # Other / multiple race
            race_eth8 = case_when(HISPANIC == 2 ~ 1, # Hispanic
                                  HISPANIC == 1 & MAT_RACE == 2 ~ 2, # White
                                  HISPANIC == 1 & MAT_RACE == 3 ~ 3, # Black
                                  HISPANIC == 1 & (MAT_RACE == 4 | MAT_RACE == 10) ~ 4, # American Indian / AN
                                  HISPANIC == 1 & MAT_RACE == 8 ~ 5, #Hawaiian
                                  HISPANIC == 1 & (
                                    MAT_RACE == 1 | MAT_RACE == 5 | MAT_RACE == 6 | MAT_RACE == 7) ~ 6, # Asian
                                  HISPANIC == 1 & MAT_RACE == 11 ~ 7, # multiple
                                  HISPANIC == 1 & MAT_RACE == 9 ~ 8), # other
                                  
            MOMSMOKE,
            all = 1,
            
            ##################################
            # ORAL HEALTH
            ##################################
            # Teeth cleaned
            DDS_CLN,
            # Dentist visit
            TYP_DDS,
            # Teeth cleaned
            DDS_BORN,
            # Problem
            DDS_CAV = case_when(DDS_CAV == 2 & DDS_PROB > 0 ~ 2,
                                DDS_CAV == 1 & DDS_PROB > 0 ~ 1,
                                state %in% c("KY", "MS", "NH", "NYS", "PR", "UT", "WV") & DDS_PROB > 0 ~ 1),
            DDS_GUM = case_when(DDS_GUM == 2 & DDS_PROB > 0 ~ 2,
                                DDS_GUM == 1 & DDS_PROB > 0 ~ 1,
                                state %in% c("KY", "MS", "NH", "NYS", "PR", "UT", "WV") & DDS_PROB > 0 ~ 1),
            DDS_ACHE = case_when(DDS_ACHE == 2 & DDS_PROB > 0 ~ 2,
                                 DDS_ACHE == 1 & DDS_PROB > 0 ~ 1,
                                 state %in% c("KY", "MS", "NH", "NYS", "PR", "UT", "WV") & DDS_PROB > 0 ~ 1),
            DDS_PULL = case_when(DDS_PULL == 2 & DDS_PROB > 0 ~ 2,
                                 DDS_PULL == 1 & DDS_PROB > 0 ~ 1,
                                 state %in% c("KY", "MS", "NH", "NYS", "PR", "UT", "WV") & DDS_PROB > 0 ~ 1),
            DDS_INJ = case_when(DDS_INJ == 2 & DDS_PROB > 0 ~ 2,
                                DDS_INJ == 1 & DDS_PROB > 0 ~ 1,
                                state %in% c("KY", "MS", "NH", "NYS", "PR", "UT", "WV") & DDS_PROB > 0 ~ 1),
            DDS_OTH = case_when(DDS_OTH == 2 & DDS_PROB > 0 ~ 2,
                                DDS_OTH == 1 & DDS_PROB > 0 ~ 1,
                                state %in% c("KY", "MS", "NH", "NYS", "PR", "UT", "WV") & DDS_PROB > 0 ~ 1),
            #DDS_WHAT,
            # Barriers
            DDS_ACPT8,
            # Modify DDS_MEDI8 variable so denominator is only people enrolled in Medicaid
            DDS_MEDICAID = case_when(PAY4 == 1 & DDS_MEDI8 == 2 ~ 2,
                                     PAY4 == 1 & DDS_MEDI8 == 1 ~ 1),
            DDS_SAFE8,
            DDS_COST8,
            DDS_FEAR8,
            DDS_TIME8,
            DDS_TRAN8,
            DDS_NTWT8,
            # Knew it was important
            DDS_CARE,
            # care person talked to me about OH
            DDS_TALK,
            # Insurance to cover care
            DDS_INS,
            # Had a problem
            DDS_PROB,
            # Went to a dentist
            DDSWENT,
            # Received treatment
            DDS_TRT_of_any = case_when(DDS_TRT > 1 & DDS_PROB > 0 ~ 2,
                                       DDS_TRT == 1 & DDS_PROB > 0 ~ 1,
                                       state %in% c("KY", "NYS") & DDS_PROB > 0 ~ 1),
            DDS_TRT_of_DDS_PROB = case_when(DDS_TRT > 1 & DDS_PROB == 2 ~ 2,
                                            DDS_TRT == 1 & DDS_PROB > 0 ~ 1),
            DDS_TRT_of_DDS_WENT = case_when(DDS_TRT > 1 & DDSWENT == 2 ~ 2,
                                            DDS_TRT == 1 & DDSWENT == 2 ~ 1),
            # Florida unique
            # FL_ask_about = ORAL_ASK,
            # FL_look = ORAL_LOOK,
            # FL_talk = ORAL_TALK,
            # FL_help = ORAL_HELP,
            # FL_info = ORAL_INFO,
            # FL_infobb = ORAL_INFOBB,
            # Maine uniqe
            DENT_INS,
            # COHSII Indicator W1. 
            # 2 is had a barrier
            # 1 is did not have a barrier
            # denominator is answered the question
            W1 = case_when((DDS_ACPT8 == 2 |
                            DDS_MEDI8 == 2 |
                            DDS_SAFE8 == 2 |
                            DDS_COST8 == 2 |
                            DDS_FEAR8 == 2 |
                            DDS_TRAN8 == 2 |
                            DDS_NTWT8 == 2) ~ 2,
                           (DDS_ACPT8 >= 0 |
                            DDS_MEDI8 >= 0 |
                            DDS_SAFE8 >= 0 |
                            DDS_COST8 >= 0 | 
                            DDS_FEAR8 >= 0 | 
                            DDS_TRAN8 >= 0 |
                            DDS_NTWT8 >= 0) ~ 1),
            # Same indicator as above but uses the 'needed to see a dentist about
            # a problem variable to determine problem rather than tallying any 
            # problem. 
            DDSWENT_of_DDS_PROB = case_when(
              (DDSWENT == 2 & DDS_PROB == 2) ~ 2,
               (DDSWENT == 1 & DDS_PROB == 2) ~ 1),
            # Shows who had a toothache problem and went vs not went
            DDSWENT_of_DDS_ACHE = case_when(
              (DDSWENT == 2 & DDS_ACHE == 2) ~ 2,
              (DDSWENT == 1 & DDS_ACHE == 2) ~ 1),
            # Shows who had a cavity problem and went vs not went
            DDSWENT_of_DDS_CAV = case_when(
              (DDSWENT == 2 & DDS_CAV == 2) ~ 2,
              (DDSWENT == 1 & DDS_CAV == 2) ~ 1),
            # Shows who had a gum problem and went vs not went
            DDSWENT_of_DDS_GUM = case_when(
              (DDSWENT == 2 & DDS_GUM == 2) ~ 2,
              (DDSWENT == 1 & DDS_GUM == 2) ~ 1),            
            # Shows who needed a tooth pulled and went vs not went
            DDSWENT_of_DDS_PULL = case_when(
              (DDSWENT == 2 & DDS_PULL == 2) ~ 2,
              (DDSWENT == 1 & DDS_PULL == 2) ~ 1),
            # Shows who had a dental injury and went vs not went
            DDSWENT_of_DDS_INJ = case_when(
              (DDSWENT == 2 & DDS_INJ == 2) ~ 2,
              (DDSWENT == 1 & DDS_INJ ==2) ~ 1),
            # Calculate dental visit rates experienced by various barrier denominators
            DDS_CLN_of_DDS_MEDI8 = case_when(
              (DDS_CLN == 2 & DDS_MEDI8 == 2) ~ 2,
              (DDS_CLN == 1 & DDS_MEDI8 == 2) ~ 1),
            DDS_CLN_of_DDS_ACPT8 = case_when(
              (DDS_CLN == 2 & DDS_ACPT8 == 2) ~ 2,
              (DDS_CLN == 1 & DDS_ACPT8 == 2) ~ 1),
            DDS_CLN_of_DDS_SAFE8 = case_when(
              (DDS_CLN == 2 & DDS_SAFE8 == 2) ~ 2,
              (DDS_CLN == 1 & DDS_SAFE8 == 2) ~ 1),
            DDS_CLN_of_DDS_COST8 = case_when(
              (DDS_CLN == 2 & DDS_COST8 == 2) ~ 2,
              (DDS_CLN == 1 & DDS_COST8 == 2) ~ 1),
            DDS_CLN_of_DDS_FEAR8 = case_when(
              (DDS_CLN == 2 & DDS_FEAR8 == 2) ~ 2,
              (DDS_CLN == 1 & DDS_FEAR8 == 2) ~ 1),
            DDS_CLN_of_DDS_TRAN8 = case_when(
              (DDS_CLN == 2 & DDS_TRAN8 == 2) ~ 2,
              (DDS_CLN == 1 & DDS_TRAN8 == 2) ~ 1),
            DDS_CLN_of_DDS_NTWT8 = case_when(
              (DDS_CLN == 2 & DDS_NTWT8 == 2) ~ 2,
              (DDS_CLN == 1 & DDS_NTWT8 == 2) ~ 1),
            DDS_CLN_of_W1 = case_when(
              DDS_CLN == 2 & W1 == 2 ~ 2,
              DDS_CLN == 1 & W1 == 2 ~ 1))
            
  

###################################################################
# List states to loop over
###################################################################
# Creates list of distinct states in the dataset

states <- PRAMS %>%
  distinct(state)

geo_list <- list()

for (line in 1:nrow(states)) {
  geo_list[[line]] <- states$state[line]
}

geo_list <- append(geo_list, "all sites")

remove(states)


###################################################################
# List demographic and health variables for cross section
###################################################################
demo_cat_list <- list(
  "EVER_MAR", # ever married?
  "age", # maternal age 7 groups
  "PAY4", # method of payment
  "race_eth4",
  "race_eth8",
  "MM_DIAB", # diabetes?
  "MM_NOMD", # No medical risk factors?
  "ED", # maternal education 5 cats
  "MAT_WIC", # mother get WIC food during pregnancy?
  "MM_HBP", # high blood pressure
  "MOMSMOKE", # mom smokes
  "URB_RUR", # urban or rural
  "all", # dummy variable set to 1 so loops can generate 'all total' estimate
  # Oral indicators that may be interesting to stratify on for
  # other oral health indicators
  "DDS_ACPT8",
  "DDS_SAFE8",
  "DDS_COST8",
  "DDS_CARE",
  "DDS_INS"
  )




###################################################################
# List the oral health outcomes indicators
###################################################################
OH_outcomes_list <- list(
  "TYP_DDS",
  "DDS_BORN",
  "DDS_CLN",
  "DDS_CAV",
  "DDS_GUM",
  "DDS_ACHE",
  "DDS_PULL",
  "DDS_INJ",
  "DDS_PROB", # maybe don't need to report this one?
  #"OH_problem_what", # don't need to loop over this
  "DDS_ACPT8",
  "DDS_MEDICAID",
  "DDS_SAFE8",
  "DDS_COST8",
  #"DDS_FEAR8",
  #"DDS_TIME8",
  #"DDS_TRAN8",
  #"DDS_NTWT8",
  "DDS_CARE",
  "DDS_TALK",
  "DDS_INS",
  "DDS_OTH",
  "DDSWENT",
  "DDS_TRT_of_any",
  "DDS_TRT_of_DDS_PROB",
  "DDS_TRT_of_DDS_WENT",
  # ORAL_ASK,
  # ORAL_LOOK,
  # ORAL_TALK,
  # ORAL_HELP,
  # ORAL_INFO,
  # ORAL_INFOBB,
  # Maine uniqe
  #"ME_ins",
  ###############################
  # Custom / composite indicators
  ###############################
  "W1",
  "DDSWENT_of_DDS_PROB",
  "DDSWENT_of_DDS_ACHE",
  "DDSWENT_of_DDS_CAV",
  "DDSWENT_of_DDS_GUM",
  "DDSWENT_of_DDS_PULL",
  "DDSWENT_of_DDS_INJ",
  "DDS_CLN_of_DDS_MEDI8",
  "DDS_CLN_of_DDS_ACPT8",
  "DDS_CLN_of_DDS_SAFE8",
  "DDS_CLN_of_DDS_FEAR8",
  "DDS_CLN_of_DDS_COST8",
  "DDS_CLN_of_DDS_TRAN8",
  "DDS_CLN_of_W1")





###################################################################
# Function to extract demographic variables list
###################################################################
# A function to produce a list of possible values to be looped over 
# within each demo category. For example, given the MAT_WIC variable
# the function will return a list containing 1 and 2, the two possible 
# values respondents could select excluding unknown/refused/skipped

val_list <-function(demo) {

  if (demo == "age") {
  val_list <- list(1, 2, 3, 4, 5)
  } else if (demo == "ED") {
  val_list <- list(1, 2, 3)
  } else if (demo == "race_eth4") { 
  val_list <- list(1, 2, 3, 4)
  } else if (demo == "race_eth8") { 
    val_list <- list(1, 2, 3, 4, 5, 6, 7, 8)
  } else if (demo == "MAT_WIC") {
  val_list <- list(1, 2)
  } else if (demo == "MM_DIAB") {
  val_list <- list(1, 2)
  } else if (demo == "MM_HBP") {
  val_list <- list(1, 2)
  } else if (demo == "MM_NOMD") {
  val_list <- list(1, 2)
  } else if (demo == "EVER_MAR") {
  val_list <- list(1, 2)
  } else if (demo == "MOMSMOKE") {
  val_list <- list(1, 2)
  } else if (demo == "PAY4") {
  val_list <- list(1, 2, 3, 4) 
  } else if (demo == "URB_RUR") {
  val_list <- list(1, 2)
  } else if (demo == "all") {
  val_list <- list(1) 
  } else if (demo == "DDS_ACPT8") {
  val_list <- list(1, 2)
  } else if (demo == "DDS_SAFE8") {
  val_list <- list(1, 2)
  } else if (demo == "DDS_COST8") {
  val_list <- list(1, 2)
  } else if (demo == "DDS_CARE") {
  val_list <- list(1, 2)
  } else if (demo == "DDS_INS") {
    val_list <- list(1, 2)
  }
  
  # Return the list we want
  return(val_list)
}



###################################################################
# Set survey design
###################################################################
# Create the survey object using the sampling weights and strata

PRAMS_design <- svydesign(ids = ~0, 
                          strata = ~strata, 
                          fpc = ~TOTCNT, 
                          weights = ~weights, 
                          data = PRAMS)


###################################################################
# Prepare empty list
###################################################################
# Create an empty list to compile all the rows into

master <- list()


###################################################################
# Loop the Loops
###################################################################

  
  for (geo in geo_list) {
    
    # Determine whether we need to call on the state column or 
    # if we are calculating over all sites
    geo_variable <- if_else(geo == "all sites", "country", "state")
    
    for (outcome in OH_outcomes_list) {
      
      for (demo in demo_cat_list) {
        
        if (outcome == demo) {
          next 
        }
        
        factors_test <- eval(parse(text = paste0(
          "PRAMS %>% filter(",
          geo_variable,
          " == '",
          geo,
          "', !is.na(",
          demo,
          "), !is.na(",
          outcome,
          ")) %>% group_by(",
          demo,
          ", ",
          outcome,
          ") %>% summarize(num = n())")))
        
        col1_test <- n_distinct(factors_test[ ,1])
        col2_test <- n_distinct(factors_test[ ,2])
        
        
        
        
        p_value <- NA
        significance <- NA
        
        if (col1_test >= 2 & col2_test >= 2) {
          
          
          
          chi_sub <- eval(parse(text= paste0("subset(PRAMS_design, ",
                                             geo_variable, 
                                             " == '",
                                             geo,
                                             "' & !is.na(",
                                             demo,
                                             ") & !is.na(",
                                             outcome,
                                             "))")))
          
          try({chi <- eval(parse(text= paste0("svychisq(~",
                                              outcome,
                                              "+",
                                              demo,
                                              ", chi_sub)"))) 
          p_value <- chi$p.value
          significance = if_else(p_value <= 0.05, "significant differences", "no significant differences")})
        }
        
        demo_val_list <- val_list(demo)
        
        for (val in demo_val_list) {
          
          
          
          for (dir in c(1, 2)) {
            
            # Skip to next loop if the outcome variable is the same
            # as the demo/independent variable
            
            
            
            header <- paste(geo, outcome, dir, demo, val, sep = "|")
            
            print(header)
            
            
            
            # Calculate number of unweighted responses within the state, demo, 
            # value, outcome. 
            sample_size_unweighted <- eval(parse(text = paste0(
              "PRAMS %>% filter(",
              geo_variable,
              " == '",
              geo,
              "', ",
              demo,
              " == ",
              val,
              ", !is.na(",
              outcome,
              ")) %>% summarize(n())"
            )))[[1,1]]
            
            # Calculate the number of responses within the cell
            cell_size_unweighted <- eval(parse(text = paste0(
              "PRAMS %>% filter(",
              geo_variable, 
              " == '",
              geo,
              "', ",
              demo,
              " == ",
              val,
              ", ",
              outcome,
              " == ",
              dir,
              ") %>% summarize(n())"
            )))[[1,1]]        
            
            # Calculate number of missing responses. Making sure only to tally
            # cases when a response was expected but not given. We don't want 
            # to count as missing a case when a question was skipped by logic or
            # the person was a teen mom and not asked the question. The is_tagged_na
            # function picks up the special attributes that an NA can be as 
            # translated from the original SAS file.
            missing_count <- eval(parse(text = paste0(
              "PRAMS %>% filter(",
              geo_variable,
              " == '",
              geo,
              "', ",
              demo,
              " == ",
              val,
              ", (is_tagged_na(PRAMS$",
              outcome,
              ", '.B') | is_tagged_na(PRAMS$",
              outcome,
              ", '.M') | is_tagged_na(PRAMS$",
              outcome, 
              ", '.N'))) %>% summarize(n())"
            )))[[1,1]]
            
            
            # If there aren't any responses for our selection, then we want to skip
            # to the next loop because otherwise R will throw an error
            if (cell_size_unweighted > 0) {
              
              
              # Create the design object
              sub <- eval(parse(text= paste0("subset(PRAMS_design, ",
                                             geo_variable, 
                                             " == '",
                                             geo,
                                             "' & ",
                                             demo,
                                             " == ",
                                             val,
                                             " & !is.na(",
                                             outcome,
                                             "))")))
              
              
              # Calculate the estimated proportion
              prop <- eval(parse(text= paste0("svyciprop(~I(",
                                              outcome,
                                              " == ",
                                              dir,
                                              "), design=sub, level=.95)")))
              
              # Calculate the estimated total
              cell_size_weighted <- as.integer(
                eval(parse(text= paste0("svytotal(~I(",
                                        outcome,
                                        " == ",
                                        dir,
                                        "), design=sub, level=.95)"))))[2]
              
              
              # Store output
              proportion <- prop[[1]]
              prop_lower_ci <- attr(prop, "ci")[[1]]
              prop_upper_ci <- attr(prop, "ci")[[2]]
              total <- cell_size_weighted
              
              
              
            } else {
              
              cell_size_weighted <- NA
              proportion <- NA 
              prop_lower_ci <- NA
              prop_upper_ci <- NA
              total <- NA
              
              
            }    
            
            # Read all the data points into a named list stored in Master
            master[[header]] <- list(geography = geo,
                                     group = demo,
                                     subgroup = val,
                                     indicator = outcome,
                                     direction = dir,
                                     category_sample_size_unweighted = sample_size_unweighted,
                                     total_unweighted = cell_size_unweighted,
                                     missing_unweighted = missing_count,
                                     proportion = proportion, 
                                     prop_lowerCI = prop_lower_ci,
                                     prop_upperCI = prop_upper_ci,
                                     total = total,
                                     p_value = p_value,
                                     significance = significance)
            
          }}}}}


###################################################################
# Convert the Master list into a dataframe, modify, save
###################################################################

# Read in labels for demographic variables
demos <- read_csv("group_subgroup_variables.csv")

# Read in labels for oral health indicators
indicators <- read_csv("indicator_variables.csv")

# Remove subgroup reporting for certain indicators with low responses
PRAMS_prime <- bind_rows(master) %>% 
  mutate(flag = case_when(indicator %in% 
             c("DDSWENT_of_DDS_PROB", "DDSWENT_of_listed_problem", 
               "DDSWENT_of_DDS_ACHE", "DDSWENT_of_DDS_CAV",
               "DDSWENT_of_DDS_PULL", "DDSWENT_of_DDS_INJ",
               "DDS_CLN_of_DDS_MEDI8", "DDS_CLN_of_DDS_ACPT8",
               "DDS_CLN_of_DDS_SAFE8", "DDS_CLN_of_DDS_FEAR8",
               "DDS_CLN_of_DDS_TRAN8", "DDS_CLN_of_W1") & geography != "all sites" &
               group != "all" ~ "flag")) %>%
  filter(is.na(flag)) %>%
  select(-flag) %>%
  # Join in labels for variables from external spreadsheet
  left_join(demos, by = c("group" = "group_variable_original", 
                          "subgroup" = "subgroup_value")) %>%
  left_join(indicators, by = c("indicator" = "indicator_variable_original",
                               "direction" = "indicator_value_number")) %>%
  mutate(PRAMS_id = row_number()) %>%
  select(-group,
         -subgroup,
         -direction,
  ) %>%
  # rename columns and tidy the dataframe
  rename(group = group_variable_labelled,
         subgroup = subgroup_labelled,
         custom_variable = indicator) %>%
  filter(category_sample_size_unweighted > 10) %>%
  select(-missing_unweighted, -X5, -X6, -X7, -X8, -X9)

# Save table to disk
write_csv(PRAMS_prime, "PRAMS_prime.csv", na="")



###################################################################
# Create a pivoted confidence interval version of PRAMS_prime
###################################################################
# Create a file twice as long as PRAMS_prime where the confidence 
# intervals are pivoted such that each row in PRAMS_prime gets two
# rows in PRAMS_CI: one for upper CI and one for lower CI. This helps
# read into data visualization software.

PRAMS_CI <- PRAMS_prime %>% 
  select(PRAMS_id,
         prop_lowerCI,
         prop_upperCI) %>%
  pivot_longer(cols=c("prop_lowerCI", 
                      "prop_upperCI"),
               values_to = "confidence_value", 
               names_to = "confidence_level") %>%
  # Separate confidence_level into two columns, one of which gets pivoted back
  #separate(confidence_level, c("statistic", "level"), sep = "_") %>%
  #pivot_wider(names_from = "statistic", 
  #            values_from = "confidence_value") %>%
  # Count upwards if lowerCI, cound downwards if upperCI
  mutate(order = ifelse(confidence_level == "lowerCI", 1:n(), 10000000 - 1:n()))


write_csv(PRAMS_CI, "PRAMS_CI.csv", na="")


