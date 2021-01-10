library(tidyverse)
library(LaF)
library(data.table)

setwd("E:/Postive Sum/HRSA/AHRF/DATA")


ahrf <- fread("E:/Postive Sum/HRSA/AHRF/DATA/AHRF2019.asc",
           sep = NULL,
           header = FALSE)


################################333


library(tidyverse)
library(LaF)
library(data.table)

setwd("E:/Postive Sum/HRSA/AHRF/DATA")


ahrf <- fread("E:/Postive Sum/HRSA/AHRF/DATA/AHRF2019.asc",
              sep = NULL,
              header = FALSE)




##################################################



ahrf_vars <- ahrf %>%
  mutate(state_name = str_trim(substr(V1, 45, 63)),
         state_abbrev = substr(V1, 64, 65),
         county_name = str_trim(substr(V1, 66, 90)),
         state_fips = substr(V1, 121, 122),
         county_fips = substr(V1, 123, 0125),
         state_county_fips = paste0(state_fips, county_fips),
         dentists_2017_fed.and.non.fed_total.active = as.integer(substr(V1, 9853, 9857)),
         dentists_2017_fed.and.non.fed_total.active = as.integer(substr(V1, 9853, 9857)),
         dentists_2016_fed.and.non.fed_total.active = as.integer(substr(V1, 9858, 9862)),
         dentists_2015_fed.and.non.fed_total.active = as.integer(substr(V1, 9863, 9867)),
         dentists_2014_fed.and.non.fed_total.active = as.integer(substr(V1, 9868, 9872)),
         dentists_2013_fed.and.non.fed_total.active = as.integer(substr(V1, 9873, 9877)),
         dentists_2010_fed.and.non.fed_total.active = as.integer(substr(V1, 9878, 9883)),
         dentists_2017_non.fed_private.practice_total = as.integer(substr(V1, 9884, 9888)),
         dentists_2016_non.fed_private.practice_total = as.integer(substr(V1, 9889, 9893)),
         dentists_2015_non.fed_private.practice_total = as.integer(substr(V1, 9894, 9898)),
         dentists_2014_non.fed_private.practice_total = as.integer(substr(V1, 9899, 9903)),
         dentists_2013_non.fed_private.practice_total = as.integer(substr(V1, 9904, 9908)),
         dentists_2010_non.fed_private.practice_total = as.integer(substr(V1, 9909, 9914)),
         dentists_2017_non.fed_state.or.local.gov_total  = as.integer(substr(V1, 9915, 9916)),
         dentists_2016_non.fed_state.or.local.gov_total = as.integer(substr(V1, 9917, 9918)),
         dentists_2015_non.fed_state.or.local.gov_total  = as.integer(substr(V1, 9919, 9920)),
         dentists_2014_non.fed_state.or.local.gov_total  = as.integer(substr(V1, 9921, 9922)),
         dentists_2013_non.fed_state.or.local.gov_total  = as.integer(substr(V1, 9923, 9924)),
         dentists_2010_non.fed_state.or.local.gov_total  = as.integer(substr(V1, 9925, 9929)),
         dental.staff_2017_non.fed_total = as.integer(substr(V1, 9930,	9931)),
         dental.staff_2016_non.fed_total = as.integer(substr(V1, 9932,	9933)),
         dental.staff_2015_non.fed_total = as.integer(substr(V1, 9934,	9935)),
         dental.staff_2014_non.fed_total = as.integer(substr(V1, 9936,	9937)),
         dental.staff_2013_non.fed_total = as.integer(substr(V1, 9938,	9939)),
         dental.staff_2010_non.fed_total = as.integer(substr(V1, 9940,	9944)),
         dentists_2017_non.fed_grad.students.and.residents_total = as.integer(substr(V1, 9945,	9947)),
         dentists_2016_non.fed_grad.students.and.residents_total  = as.integer(substr(V1, 9948,	9950)),
         dentists_2015_non.fed_grad.students.and.residents_total  = as.integer(substr(V1, 9951,	9953)),
         dentists_2014_non.fed_grad.students.and.residents_total  = as.integer(substr(V1, 9954,	9956)),
         dentists_2013_non.fed_grad.students.and.residents_total  = as.integer(substr(V1, 9957,	9959)),
         dentists_2010_non.fed_grad.students.and.residents_total  = as.integer(substr(V1, 9960,	9964)),
         dentists_2017_fed_armed.forces.and.fed.service_total  = as.integer(substr(V1, 9965, 9967)),
         dentists_2016_fed_armed.forces.and.fed.service_total  = as.integer(substr(V1, 9968, 9970)),
         dentists_2015_fed_armed.forces.and.fed.service_total  = as.integer(substr(V1, 9971, 9973)),
         dentists_2014_fed_armed.forces.and.fed.service_total  = as.integer(substr(V1, 9974, 9976)),
         dentists_2013_fed_armed.forces.and.fed.service_total  = as.integer(substr(V1, 9977, 9979)),
         dentists_2010_fed_armed.forces.and.fed.service_total  = as.integer(substr(V1, 9980, 9984)),
         dentists_2017_non.fed_dental.school.faculty_total  = as.integer(substr(V1, 9985,	9987)),
         dentists_2016_non.fed_dental.school.faculty_total  = as.integer(substr(V1, 9988,	9990)),
         dentists_2015_non.fed_dental.school.faculty_total  = as.integer(substr(V1, 9991,	9993)),
         dentists_2014_non.fed_dental.school.faculty_total  = as.integer(substr(V1, 9994,	9996)),
         dentists_2013_non.fed_dental.school.faculty_total  = as.integer(substr(V1, 9997,	9999)),
         dentists_2010_non.fed_dental.school.faculty_total  = as.integer(substr(V1, 10000, 10004)),
         dentists_2017_non.fed_employment.status_part.time.faculty.or.practice = as.integer(substr(V1, 10005,	10007)),
         dentists_2016_non.fed_employment.status_part.time.faculty.or.practice = as.integer(substr(V1, 10008,	10010)),
         dentists_2015_non.fed_employment.status_part.time.faculty.or.practice = as.integer(substr(V1, 10011,	10013)),
         dentists_2014_non.fed_employment.status_part.time.faculty.or.practice = as.integer(substr(V1, 10014,	10016)),
         dentists_2013_non.fed_employment.status_part.time.faculty.or.practice = as.integer(substr(V1, 10017,	10019)),
         dentists_2010_non.fed_employment.status_part.time.faculty.or.practice = as.integer(substr(V1, 10020,	10022)),
         dentists_2017_non.fed_employment.status_seeking.employment = as.integer(substr(V1, 10023,	10024)),
         dentists_2016_non.fed_employment.status_seeking.employment = as.integer(substr(V1, 10025,	10026)),
         dentists_2015_non.fed_employment.status_seeking.employment = as.integer(substr(V1, 10027,	10028)),
         dentists_2014_non.fed_employment.status_seeking.employment = as.integer(substr(V1, 10029,	10030)),
         dentists_2014_non.fed_employment.status_seeking.employment = as.integer(substr(V1, 10031,	10032)),
         dentists_2014_non.fed_employment.status_seeking.employment = as.integer(substr(V1, 10033,	10034)),
         dentists_2017_non.fed_employment.status_other.occupation = as.integer(substr(V1, 10035, 10036)),
         dentists_2016_non.fed_employment.status_other.occupation = as.integer(substr(V1, 10037, 10038)),
         dentists_2015_non.fed_employment.status_other.occupation = as.integer(substr(V1, 10039,	10040)),
         dentists_2014_non.fed_employment.status_other.occupation = as.integer(substr(V1, 10041,	10042)),
         dentists_2013_non.fed_employment.status_other.occupation = as.integer(substr(V1, 10043,	10044)),
         dentists_2010_non.fed_employment.status_other.occupation = as.integer(substr(V1, 10045,	10049)),
         dentists_2017_non.fed_employment.status_no.longer.in.practice = as.integer(substr(V1, 10059,	10052)),
         dentists_2016_non.fed_employment.status_no.longer.in.practice = as.integer(substr(V1, 10053,	10055)),
         dentists_2015_non.fed_employment.status_no.longer.in.practice = as.integer(substr(V1, 10056,	10058)),
         dentists_2014_non.fed_employment.status_no.longer.in.practice = as.integer(substr(V1, 10059,	10061)),
         dentists_2013_non.fed_employment.status_no.longer.in.practice = as.integer(substr(V1, 10062,	10064)),
         dentists_2010_non.fed_employment.status_no.longer.in.practice = as.integer(substr(V1, 10065,	10069)),
         dentists_2017_non.fed_employment.status_unknown.occupation = as.integer(substr(V1, 10070,	10071)),
         dentists_2016_non.fed_employment.status_unknown.occupation = as.integer(substr(V1, 10072,	10073)),
         dentists_2015_non.fed_employment.status_unknown.occupation = as.integer(substr(V1, 10074,	10075)),
         dentists_2017_private.practice_employment.status_full.time = as.integer(substr(V1, 10076,	10080)),
         dentists_2016_private.practice_employment.status_full.time = as.integer(substr(V1, 10081,	10085)),
         dentists_2015_private.practice_employment.status_full.time = as.integer(substr(V1, 10086,	10090)),
         dentists_2014_private.practice_employment.status_full.time = as.integer(substr(V1, 10091,	10095)),
         dentists_2013_private.practice_employment.status_full.time = as.integer(substr(V1, 10096,	10100)),
         dentists_2010_private.practice_employment.status_full.time = as.integer(substr(V1, 10101,	10106)),
         dentists_2017_private.practice_employment.status_part.time = as.integer(substr(V1, 10107,	10110)),
         dentists_2016_private.practice_employment.status_part.time = as.integer(substr(V1, 10111,	10116)),
         dentists_2015_private.practice_employment.status_part.time = as.integer(substr(V1, 10115,	10118)),
         dentists_2014_private.practive_employment.status_part.time = as.integer(substr(V1, 10119,	10122)),
         dentists_2013_private.practice_employment.status_part.time = as.integer(substr(V1, 10123,	10126)),
         dentists_2010_private.practice_employment.status_part.timee = as.integer(substr(V1, 10127,	10132)),
         dentists_2017_private.practice_gender_male = as.integer(substr(V1, 10133,	10136)),
         dentists_2016_private.practice_gender_male = as.integer(substr(V1, 10137,	10140)),
         dentists_2015_private.practice_gender_male = as.integer(substr(V1, 10141,	10144)),
         dentists_2014_private.practice_gender_male = as.integer(substr(V1, 10145,	10148)),
         dentists_2013_private.practice_gender_male = as.integer(substr(V1, 10149,	10152)),
         dentists_2010_private.practice_gender_male = as.integer(substr(V1, 10153,	10158)),
         dentists_2017_private.practice_gender_female = as.integer(substr(V1, 10159,	10162)),
         dentists_2016_private.practice_gender_female = as.integer(substr(V1, 10163,	10166)),
         dentists_2015_private.practice_gender_female = as.integer(substr(V1, 10167,	10170)),
         dentists_2014_private.practice_gender_female = as.integer(substr(V1, 10171,	10174)),
         dentists_2013_private.practice_gender_female = as.integer(substr(V1, 10175,	10178)),
         dentists_2010_private.practice_gender_female = as.integer(substr(V1, 10179,	10184)),
         dentists_2017_private.practice_gender_unknown = as.integer(substr(V1, 10185,	10187)),
         dentists_2016_private.practice_gender_unknown = as.integer(substr(V1, 10188,	10190)),
         dentists_2015_private.practice_gender_unknown = as.integer(substr(V1, 10191,	10193)),
         dentists_2014_private.practice_gender_unknown = as.integer(substr(V1, 10194,	10196)),
         dentists_2013_private.practice_gender_unknown = as.integer(substr(V1, 10197,	10199)),
         dentists_2010_private.practice_gender_unknown = as.integer(substr(V1, 10200,	10202)),
         dentists_2017_private.practice_specialty_general.practice = as.integer(substr(V1, 10203,	10207)),
         dentists_2016_private.practice_specialty_general.practice = as.integer(substr(V1, 10208,	10212)),
         dentists_2015_private.practice_specialty_general.practice = as.integer(substr(V1, 10213,	10217)),
         dentists_2014_private.practice_specialty_general.practice = as.integer(substr(V1, 10218,	10222)),
         dentists_2013_private.practice_specialty_general.practice = as.integer(substr(V1, 10223,	10227)),
         dentists_2010_private.practice_specialty_general.practice = as.integer(substr(V1, 10228,	10233)),
         dentists_2017_private.practice_specialty_other = as.integer(substr(V1, 10234,	10237)),
         dentists_2016_private.practice_specialty_other = as.integer(substr(V1, 10238,	10241)),
         dentists_2015_private.practice_specialty_other = as.integer(substr(V1, 10242,	10245)),
         dentists_2014_private.practice_specialty_other = as.integer(substr(V1, 10246,	10249)),
         dentists_2013_private.practice_specialty_other = as.integer(substr(V1, 10250,	10253)),
         dentists_2013_private.practice_specialty_other = as.integer(substr(V1, 10254,	10259)),
         dentists_2017_private.practice_age_under.35 = as.integer(substr(V1, 10260,	10262)),
         dentists_2016_private.practice_age_under.35 = as.integer(substr(V1, 10263,	10265)),
         dentists_2015_private.practice_age_under.35 = as.integer(substr(V1, 10266,	10268)),
         dentists_2014_private.practice_age_under.35 = as.integer(substr(V1, 10269,	10272)),
         dentists_2013_private.practice_age_under.35 = as.integer(substr(V1, 10272,	10274)),
         dentists_2010_private.practice_age_under.35 = as.integer(substr(V1, 10275,	10280)),
         dentists_2017_private.practice_age_35.to.44 = as.integer(substr(V1, 10281,	10284)),
         dentists_2016_private.practice_age_35.to.44 = as.integer(substr(V1, 10285,	10288)),
         dentists_2015_private.practice_age_35.to.44 = as.integer(substr(V1, 10289,	10292)),
         dentists_2014_private.practice_age_35.to.44 = as.integer(substr(V1, 10293,	10296)),
         dentists_2013_private.practice_age_35.to.44 = as.integer(substr(V1, 10297,	10300)),
         dentists_2010_private.practice_age_35.to.44 = as.integer(substr(V1, 10301,	10306)),
         dentists_2017_private.practice_age_45.to.54 = as.integer(substr(V1, 10309,	10310)),
         dentists_2016_private.practice_age_45.to.54 = as.integer(substr(V1, 10311,	10314)),
         dentists_2015_private.practice_age_45.to.54 = as.integer(substr(V1, 10315,	10318)),
         dentists_2014_private.practice_age_45.to.54 = as.integer(substr(V1, 10319,	10322)),
         dentists_2013_private.practice_age_45.to.54 = as.integer(substr(V1, 10323,	10326)),
         dentists_2010_private.practice_age_45.to.54 = as.integer(substr(V1, 10327,	10332)),
         dentists_2017_private.practice_age_55.to.64 = as.integer(substr(V1, 10333,	10336)),
         dentists_2016_private.practice_age_55.to.64 = as.integer(substr(V1, 10337,	10340)),
         dentists_2015_private.practice_age_55.to.64 = as.integer(substr(V1, 10341,	10344)),
         dentists_2014_private.practice_age_55.to.64 = as.integer(substr(V1, 10345,	10348)),
         dentists_2013_private.practice_age_55.to.64 = as.integer(substr(V1, 10349,	10352)),
         dentists_2010_private.practice_age_55.to.64 = as.integer(substr(V1, 10353,	10358)),
         dentists_2017_private.practice_age_65.plus = as.integer(substr(V1, 10359,	10362)),
         dentists_2016_private.practice_age_65.plus = as.integer(substr(V1, 10363,	10366)),
         dentists_2015_private.practice_age_65.plus = as.integer(substr(V1, 10367,	10370)),
         dentists_2014_private.practice_age_65.plus = as.integer(substr(V1, 10371,	10374)),
         dentists_2013_private.practice_age_65.plus = as.integer(substr(V1, 10375,	10378)),
         dentists_2010_private.practice_age_65.plus = as.integer(substr(V1, 10379,	10384)),
         dentists_2017_private.practice_age_unknown = as.integer(substr(V1, 10385,	10388)),
         dentists_2016_private.practice_age_unknown = as.integer(substr(V1, 10389,	10392)),
         dentists_2015_private.practice_age_unknown = as.integer(substr(V1, 10393,	10396)),
         dentists_2014_private.practice_age_unknown = as.integer(substr(V1, 10397,	10400)),
         dentists_2013_private.practice_age_unknown = as.integer(substr(V1, 10401,	10404)),
         dentists_2013_private.practice_age_unknown = as.integer(substr(V1, 10405,	10409))) %>%
  select(-V1)


         


ahrf_output <- ahrf_vars %>%
  pivot_longer(cols = starts_with("dent"),
               values_to = "count",
               names_to = c("unit", "year", "workforce", "variable1", "variable2"),
               names_sep = "_") %>%
  mutate(workforce = str_replace_all(workforce, "\\.", " "),
         variable1 = str_replace_all(variable1, "\\.", " "),
         variable2 = str_replace_all(variable2, "\\.", " "))




ahrf_pop_vars <- ahrf %>%
  mutate(state_name = str_trim(substr(V1, 45, 63)),
         state_abbrev = substr(V1, 64, 65),
         county_name = str_trim(substr(V1, 66, 90)),
         state_fips = substr(V1, 121, 122),
         county_fips = substr(V1, 123, 0125),
         state_county_fips = paste0(state_fips, county_fips),
         "2017" = substr(V1, 16425, 16432),
         "2016" = substr(V1, 16433, 16440),
         "2015" = substr(V1, 16441, 16448),
         "2014" = substr(V1, 16449, 16456),
         "2013" = substr(V1, 16457, 16464),
         "2010" = substr(V1, 16481, 16488)) %>%
  select(-V1)




ahrf_pop <- ahrf_pop_vars %>%
  pivot_longer(cols = starts_with("20"),
               values_to = "population",
               names_to = c("year"))




write.csv(ahrf_output, "ahrf.csv", row.names = FALSE)

write.csv(ahrf_pop, "ahrf_pop.csv", row.names = FALSE)


