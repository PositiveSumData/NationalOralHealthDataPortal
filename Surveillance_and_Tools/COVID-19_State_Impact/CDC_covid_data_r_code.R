library(tidyverse)

setwd("E:/Postive Sum/CDC/COVID")

# file downloadeable here: https://healthdata.gov/dataset/united-states-covid-19-cases-and-deaths-state-over-time

infile <- read_csv("United_States_COVID-19_Cases_and_Deaths_by_State_over_Time.csv")

crosswalk <- read_csv("state_abr_crosswalk.csv")

# for pivoting measures into single column
# COVID <- infile %>%
#   transmute(date = submission_date,
#             state,
#             cases = prob_cases + conf_cases,
#             deaths = new_death + pnew_death) %>%
#   pivot_longer(cols = c("cases", "deaths"), 
#                names_to = "measure",
#                values_to = "count")

COVID <- infile %>%
  transmute(date = submission_date,
            state,
            cases = prob_cases + conf_cases,
            deaths = new_death + pnew_death) %>%
  left_join(crosswalk, by = c("state" = "state_abr"))


write.csv(COVID, "US_COVID_cases_and_deaths.csv", row.names = FALSE, na = "")