library(tidyverse)

setwd("E:/Postive Sum/CDC/PRAMS")

PRAMS <- read_csv("PRAMS.csv")

PRAMS_CI <- PRAMS %>% 
  arrange(year) %>%
  select(-sample_size, -estimate) %>%
  pivot_longer(cols=c("ci_lower", "ci_upper"), values_to = "confidence_value", names_to = "confidence_level") %>%
  mutate(order = ifelse(confidence_level == "ci_lower", 1:n(), 10000 - 1:n()))

write.csv(PRAMS_CI, "PRAMS_CI.csv", row.names = FALSE)