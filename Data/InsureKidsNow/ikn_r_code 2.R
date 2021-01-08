library(tidyverse)
library(modeest)
'%!in%' = Negate('%in%')

setwd("E:/Postive Sum/CMS/InsureKidsNow")
#memory.limit()
#memory.limit(size=56000)
#################################################################################
########## Step 1: Reading in the NPI provider file
#################################################################################
# Later in our processing we'll want to double-check that we have all type I provider
# NPIs instead of type II NPIs, so we'll need access to the CMS NPI registry. 
# We've already downloaded it to our working directory as a csv. Read it in and
# correct column names that have spaces in them.

NPI <- read_csv("npidata_pfile_20050523-20200308.csv")
colnames(NPI) <- make.names(colnames(NPI))

# Read in a separate list of all the dental-related provider taxonomy codes.
dentist_taxonomy_codes <- read_csv("NPI_Provider_Taxonomy_Codes.csv")

# Subset our giant NPI file to only contain dental NPIs. First we'll have to 
# unpivot our many provider taxonomy columns into one column.

NPI_by_provider_taxonomy_code <- NPI %>%
  select(NPI, Entity.Type.Code, contains('Healthcare.Provider.Taxonomy')) %>%
  pivot_longer(cols = contains('Healthcare.Provider.Taxonomy'), 
               names_to = 'tax_num' , 
               values_to = 'code', 
               values_drop_na = TRUE) %>%
  semi_join(dentist_taxonomy_codes, by = c('code' = 'Code'))

# Pull out a list of distinct dentists. Without calling 'distinct' we'll get
# duplicates whenever a provider has more than one specialty listed
NPI_is_dentist <- distinct(NPI_by_provider_taxonomy_code, NPI, Entity.Type.Code)


#gc()
remove(NPI)
#################################################################################
########## Step 1: Reading in ikn flat file
#################################################################################
# The ikn flat file is pipe-delimited, so we'll read it in using the read_delim function.

infile <- as.data.frame(read_delim("IKN_PROVIDER_DATA_EXTRACTION.TXT", delim = '|', guess_max = 5000, trim_ws = TRUE))


# The ikn flat file has a ton of fields we won't be using, so let's unselect them
ikn <- infile %>%
  select(-PHONE_NUM,
         -IKN_PHONE_ID, 
         -CONG_DIST_ID, 
         -CONG_DIST_START_DT,
         -REPRESENTATIVE_NM, 
         -REPRESENTATIVE_URL,  
         -STATE_FIPS_CD_CONG_DIST_NUM,
         -WEBSITE,                    
         -FAX_NUMBER,
         -REPORT_CYCLE_ID,
         -CYCLE_NAME, 
         -DW_RECORD_CREATE_DT,
         -DW_RECORD_CREATE_DT_TXT,
         -CENTRAL_APPOINT_LINE,
         -LOC_NAME_DESC,
         -APPROX_VALUE_CD,
         -ZIP4,
         -US_SENATE_NM1,
         -US_SENATE_NM2,
         -REGION_NM,
         -REGION_CD,
         -REGION_ID,
         -CONG_DIST_NUM,
         -CONG_DIST_NM,
         -SUBMITTING_STATE_ID,
         -FILE_SUBMISSION_ID,
         -GEOCODE_STATUS_IND,
         -PROVIDER_MIDDLE_NM,
         -PROVIDER_LAST_NM_SOUNDEX,
         -LIST_BOX_COUNTY_NM,
         -CURRENT_COUNTY_IND,
         -STATE_IND,
         -PROV_AFF,
         -SPECIAL_NEEDS_DESC
         ) %>%
  # We only want active dentists
  filter(ACTIVE_IND %in% c('y', 'Y')) %>%
  # And then we can delete that column now that we're done filtering on it
  select(-ACTIVE_IND) %>%
  # Reorganize many of the fields
  mutate(PROVIDER_LAST = toupper(PROVIDER_LAST_NM)) %>%
  mutate(PROVIDER_LAST = word(PROVIDER_LAST, 1)) %>%
  mutate(PROVIDER_FIRST = toupper(PROVIDER_FIRST_NM)) %>%
  mutate(PROVIDER_FIRST = word(PROVIDER_FIRST, 1)) %>%
  mutate(PROVIDER_FULL_NM = toupper(PROVIDER_FULL_NM)) %>%
  mutate(COVERAGE_PLAN_NM = toupper(COVERAGE_PLAN_NM)) %>%
  mutate(PROGRAM_TYPE_NM = toupper(PROGRAM_TYPE_NM)) %>%
  # If a group practice is listed as 'no name provided' we'll coerce that to NA.
  mutate(GRP_PRACTICE_NM = ifelse(GRP_PRACTICE_NM == 'No name provided', NA, toupper(GRP_PRACTICE_NM))) %>%
  # Same for facility name
  mutate(FAC_NM = ifelse(FAC_NM == 'No name provided', NA, toupper(FAC_NM))) %>%
  # And provider name
  mutate(PROVIDER_FULL_NM = ifelse(PROVIDER_FULL_NM == 'No name provided', NA, PROVIDER_FULL_NM)) %>%
  # If a provider is listed with a Type II NPI then we'll delete it. We only want Type I NPIs to have 
  # a unique identifier for each dentist.
  left_join(NPI_is_dentist, by = c('NAT_PROV_IDENT' = 'NPI')) %>%
  mutate(NAT_PROV_IDENT = ifelse(Entity.Type.Code == 2, NA, NAT_PROV_IDENT)) %>%
  mutate(PROVIDER_LAST = ifelse(is.na(PROVIDER_FIRST)
                                & is.na(PROVIDER_LAST) 
                                & is.na(LIC_NUM) 
                                & is.na(NAT_PROV_IDENT), 'UNKNOWN', PROVIDER_LAST)) %>%
  # When providers don't have a unique ID, we'll auto-assign one. The following code assigns a unique ID
  # for each provider based on state, ID if available, first name, last name, and license number when available. 
  # There are lots of problems with auto-assigning on these fields that we'll discuss on Github.
  group_by(NAT_PROV_IDENT, SUBMITTING_STATE_ABBR, PROVIDER_FIRST, PROVIDER_LAST, LIC_NUM) %>%
  mutate(provider_id = ifelse(NAT_PROV_IDENT < 1000000000 | NAT_PROV_IDENT >= 9999999999 | is.na(NAT_PROV_IDENT), group_indices()+1000000, NAT_PROV_IDENT)) %>%
  ungroup() %>%
  # Auto-assign group practice IDs
  group_by(GRP_PRACTICE_NM, X, Y) %>%
  mutate(site_id = group_indices()+1000000000) %>%
  ungroup() %>%
  # Auto-assign plan IDs
  group_by(SUBMITTING_STATE_ABBR, COVERAGE_PLAN_NM) %>%
  mutate(plan_id = group_indices()+100000) %>%
  ungroup() %>%
  select(-PROVIDER_FIRST_NM, -PROVIDER_LAST_NM) 
   
  
# A quick function to help us calculate the mode in a column
calculate_mode <- function(x) {
  uniqx <- unique(x)
  uniqx[which.max(tabulate(match(x, uniqx)))]}

# Assign the same name to every provider with the same provider ID. The most common name
# i.e. the mode gets assigned to all of them using the function from above.
provider <- ikn %>%
  group_by(provider_id) %>%
  summarize(mode_name = calculate_mode(PROVIDER_FULL_NM),
            appearances = n(),
            fraction = 1/n())
  write_csv(provider, 'provider.csv', na="")

# Create a language table with unique language IDs for each provider-language pair.
# Langauges are listed as comma-separated strings in the flat file, so we must unpivot them.
language <- ikn %>%
  select(provider_id, LANGUAGES_SPOKEN) %>%
  separate(LANGUAGES_SPOKEN, into = c('a','b','c','d','e','f','g','h','i','j','k','l','m'), sep = ',') %>%
  pivot_longer(c(a, b, c, d, e, f, g, h, i, j, k, l, m), names_to = 'cols', values_to = 'language') %>%
  select(-cols) %>%
  distinct(provider_id, language) %>%
  mutate(provider_language_id = row_number()) %>%
  filter(!is.na(language)) %>%
  select(provider_language_id, provider_id, language) 
  write_csv(language, "language.csv", na="")

# Create a specialty table for each unqiue provider-specialty pair. As with language,
# specialties are comma-separated strings in the flat file that must be unpivoted.
specialty <- ikn %>%
  select(provider_id, SPECIALTY) %>%
  separate(SPECIALTY, into = c('a','b','c','d','e','f','g','h','i','j','k','l','m'), sep = ', ') %>%
  pivot_longer(c(a, b, c, d, e, f, g, h, i, j, k, l, m), names_to = 'cols', values_to = 'specialty') %>%
  select(-cols) %>%
  distinct(provider_id, specialty) %>%
  filter(!is.na(specialty)) %>%
  mutate(provider_specialty_id = row_number()) %>%
  select(provider_specialty_id, provider_id, specialty) %>%
  write_csv("specialty.csv", na="")

# Create a table for plans
plan <- ikn %>%
  distinct(plan_id, SUBMITTING_STATE_ABBR, PROGRAM_TYPE_NM, COVERAGE_PLAN_NM) %>%
  write_csv("plan.csv", na="")
    
  
# Create a table for sites
site <- ikn %>%
  transmute(site_id,
         GRP_PRACTICE_NM,
         FAC_NM,
         PHY_STREET_ADDRESS,
         CITY,
         ZIP,
         COUNTY_ID,
         COUNTY_FIPS_CD,
         COUNTY_DESC,
         STATE_ID,
         STATE_ABBR,
         STATE_FIPS_CD,
         STATE_NM,
         STATE_ID,
         X,
         Y,
         link = 0) %>%
  group_by(site_id) %>%
  summarize_all(calculate_mode) 
  write_csv(site, "site.csv", na="")

# Create a table for providers
provider_site_plan <- ikn %>%
  distinct(IKN_FACT_ID, 
           provider_id, 
           site_id, 
           plan_id, 
           ACCEPTS_NEW_PATIENTS_IND, 
           SPECIAL_NEEDS_IND, 
           SVC_MOBILITY, 
           SVC_INTELLECT_DISABL,
           SEDATION) %>%
  mutate(
    SEDATION = case_when(
      SEDATION == "n" ~ "no",
      SEDATION == "N" ~ "no",
      SEDATION == "y" ~ "yes",
      SEDATION == "Y" ~ "yes",
      SEDATION == "U" ~ "",
      SEDATION == "u" ~ ""),
    SPECIAL_NEEDS_IND = case_when(
      SPECIAL_NEEDS_IND == "n" ~ "no",
      SPECIAL_NEEDS_IND == "N" ~ "no",
      SPECIAL_NEEDS_IND == "y" ~ "yes",
      SPECIAL_NEEDS_IND == "Y" ~ "yes",
      SPECIAL_NEEDS_IND == "U" ~ "",
      SPECIAL_NEEDS_IND == "u" ~ ""),
    ACCEPTS_NEW_PATIENTS_IND = case_when(
      ACCEPTS_NEW_PATIENTS_IND == "n" ~ "no",
      ACCEPTS_NEW_PATIENTS_IND == "N" ~ "no",
      ACCEPTS_NEW_PATIENTS_IND == "y" ~ "yes",
      ACCEPTS_NEW_PATIENTS_IND == "Y" ~ "yes",
      ACCEPTS_NEW_PATIENTS_IND == "U" ~ "",
      ACCEPTS_NEW_PATIENTS_IND == "u" ~ ""),
    SVC_INTELLECT_DISABL = case_when(
      SVC_INTELLECT_DISABL == "n" ~ "no",
      SVC_INTELLECT_DISABL == "N" ~ "no",
      SVC_INTELLECT_DISABL == "y" ~ "yes",
      SVC_INTELLECT_DISABL == "Y" ~ "yes",
      SVC_INTELLECT_DISABL == "U" ~ "",
      SVC_INTELLECT_DISABL == "u" ~ ""),
    SVC_MOBILITY = case_when(
      SVC_MOBILITY == "n" ~ "no",
      SVC_MOBILITY == "N" ~ "no",
      SVC_MOBILITY == "y" ~ "yes",
      SVC_MOBILITY == "Y" ~ "yes",
      SVC_MOBILITY == "U" ~ "",
      SVC_MOBILITY == "u" ~ ""))

  write_csv(provider_site_plan, "provider_site_plan.csv", na="")


