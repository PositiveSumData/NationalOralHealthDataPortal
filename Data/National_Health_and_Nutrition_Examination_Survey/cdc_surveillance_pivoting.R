library(tidyverse)

setwd("E:/Postive Sum/CDC/NHANES")



surveillance <- read_csv("cdc_surveillance_prime.csv")


surveillance_CI <- surveillance %>%

  arrange(years, ages_min) %>%
  pivot_longer(cols = c("lower_CI", "upper_CI"), 
               values_to = "confidence_value", 
               names_to = "confidence_level") %>%
  mutate(order = ifelse(confidence_level == "lower_CI", 1:n(), 100000 - 1:n())) %>%
  select(-estimate_value,
         -estimate_SE)

write.csv(surveillance_CI, "cdc_surveillance_CI.csv", row.names = FALSE)


