library(tidyverse)


setwd("E:/Postive Sum/ASTDD/State Synopses")

infile <- read_csv("ASTDD_Synopses_of_State_Oral_Health_Programs_-_Selected_indicators.csv")

SS <- infile %>%
  transmute(year = Year,
            geo_abr = LocationAbbr,
            geo_name = LocationDesc,
            question = Question,
            value = Data_Value,
            topic = Topic, 
            unit = Data_Value_Unit,
            break_out = Break_Out) 

SS_prime <- SS %>% 
  filter(question != "Prevention Programs",
         question != "Special populations programs",
         question != "Number of health agencies serving jurisdictions of 250,000+ population",
         question != "Number of full-time equivalent (FTE) employees or contractors funded by state dental health program",
         question != "State dental director/program manager position requirement",
         question != "Statutory requirement or authority",
         question != "System for children with cleft lips/cleft palates") %>%
  pivot_wider(names_from = question, values_from = value)  
write_csv(SS_prime, "state_prime.csv", na="")



SS_all <- SS %>%
  mutate(indicator = ifelse(question %in% c("Prevention Programs",
                                            "Special populations programs",
                                            "Number of health agencies serving jurisdictions of 250,000+ population",
                                            "Number of full-time equivalent (FTE) employees or contractors funded by state dental health program",
                                            "State dental director/program manager position requirement",
                                            "Statutory requirement or authority",
                                            "System for children with cleft lips/cleft palates"),
                            paste0(question, ": ", break_out),
                            question),
         indicator = ifelse(indicator = "Number of full-time equivalent (FTE) employees or contractors funded by state dental health program",
                            "FTE ")) %>%
  

write_csv(SS_all, "state_synopsis_all.csv", na="")
