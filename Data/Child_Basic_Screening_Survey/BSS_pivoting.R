library(tidyverse)

setwd("E:/Postive Sum/ASTDD")

BSS <- read_csv("BSS_prime.csv")


BSS_CI <- BSS %>%
  select(state, report_years, years_max, base_population,
         category, subcategory, geo_unit, geography,
         measure_group, measure_value, indicator, estimate, 
         lower_CI, upper_CI) %>%
  arrange(years_max) %>%
  pivot_longer(cols = c("lower_CI", "upper_CI"), 
               values_to = "confidence_value", 
               names_to = "confidence_level") %>%
  mutate(order = ifelse(confidence_level == "lower_CI", 1:n(), 10000000 - 1:n()))

write.csv(BSS_CI, "BSS_CI.csv", row.names = FALSE)



