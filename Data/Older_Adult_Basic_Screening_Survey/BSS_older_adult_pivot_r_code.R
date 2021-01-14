library(tidyverse)

setwd("E:/Postive Sum/ASTDD/BSS_older_adult")



BSS_older <- read_csv("BSS_older_adult.csv")

BSS_older_CI <- BSS_older %>% 
  arrange(`year(s)`) %>%
  select(id, lower_CI, upper_CI) %>%
  pivot_longer(cols=c("lower_CI", "upper_CI"), values_to = "confidence_value", names_to = "confidence_level") %>%
  mutate(order = ifelse(confidence_level == "lower_CI", 1:n(), 100000 - 1:n()))

write.csv(BSS_older_CI, "BSS_older_adult_CI.csv", row.names = FALSE, na="")