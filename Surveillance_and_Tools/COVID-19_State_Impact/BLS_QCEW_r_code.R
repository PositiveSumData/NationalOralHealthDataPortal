library(tidyverse)


setwd("E:/Postive Sum/BLS")

infile <- read_csv("BLS_QCEW_raw.csv")

BLS_fips <- read_csv("BLS_fips_file.csv")

# create monthly file

BLS_monthly <- infile %>%
  transmute(fips = as.character(area_fips), 
            year, 
            quarter = qtr,
            month_1 = month1_emplvl,
            month_2 = month2_emplvl,
            month_3 = month3_emplvl) %>%
  pivot_longer(cols = c("month_1", "month_2", "month_3"), 
               names_to = "month",
               values_to = "employment") %>%
  mutate(month_quarter = as.numeric(str_sub(month, 7, 7)),
         month_num = case_when(
           quarter == 1 & month_quarter == 1 ~ 1,
           quarter == 1 & month_quarter == 2 ~ 2,
           quarter == 1 & month_quarter == 3 ~ 3,
           quarter == 2 & month_quarter == 1 ~ 4,
           quarter == 2 & month_quarter == 2 ~ 5,
           quarter == 2 & month_quarter == 3 ~ 6,
           quarter == 3 & month_quarter == 1 ~ 7,
           quarter == 3 & month_quarter == 2 ~ 8,
           quarter == 3 & month_quarter == 3 ~ 9,
           quarter == 4 & month_quarter == 1 ~ 10,
           quarter == 4 & month_quarter == 2 ~ 11,
           quarter == 4 & month_quarter == 3 ~ 12),
         month_name = case_when(
           month_num == 1 ~ "January",
           month_num == 2 ~ "February",
           month_num == 3 ~ "March",
           month_num == 1 ~ "April",
           month_num == 2 ~ "May",
           month_num == 3 ~ "June",
           month_num == 1 ~ "July",
           month_num == 2 ~ "August",
           month_num == 3 ~ "September",
           month_num == 1 ~ "October",
           month_num == 2 ~ "November",
           month_num == 3 ~ "December"),
         date_approx = paste0(year, "-", month_num, "-15")) %>%
  left_join(BLS_fips, by = c("fips" = "fips_code"))



write.csv(BLS_monthly, "BLS_monthly.csv", row.names = FALSE, na = "")


# create quarterly file

BLS_quarterly <- infile %>%
  transmute(fips = as.character(area_fips),
            year, 
            quarter = qtr,
            establishments = qtrly_estabs,
            wages = total_qtrly_wages,
            date_approx = paste0(year, "-", case_when(
              quarter == 1 ~ 2,
              quarter == 2 ~ 5,
              quarter == 3 ~ 8,
              quarter == 4 ~ 11),
              "-15"))

write.csv(BLS_quarterly, "BLS_quarterly.csv", row.names = FALSE, na = "")
            

