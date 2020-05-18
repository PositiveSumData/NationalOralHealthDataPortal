# CMS 416 Reports



## Utility

State CMS416 reports are the best publicly available source for Medicaid and CHIP dental care utilization data at the state level. It's the only source for utilization data outside of querying states individually or paying for private datasets.

### Questions this dataset could help answer

* Which states have the highest count of EPSDT children receiving dental sealants among 6-9 year olds?
* What is the rate of EPSDT preventive dental care in Ohio children under 6?
* How does the rate of any dental visit change in Nevada in raw EPSDT data compared to age-adjusted EPSDT data?
* Which ages tend to have the highest EPSDT utilization?

## Orientation & Stewardship  

States annually submit children’s Medicaid and CHIP utilization data to the Centers for Medicare and Medicaid Services (CMS). The submission forms are called 'CMS 416 reports,' and the collective dataset has become knowns as CMS416. The annual collections are made available on the CMS 'EPSDT' [website](https://www.medicaid.gov/medicaid/benefits/early-and-periodic-screening-diagnostic-and-treatment/index.html). The data are presented as spreadsheets. Data are periodically revised over time as states update their submissions or catch up to the submission process. For instance, as of May 2, 2020, the FY 2016, 2017, and 2018 files were all updated in 2019. 

#### Citation
```
Insert citation once it is determined
```

#### Data use agreements

The data is provided as-is by direct download. No user agreement is required.

## Data Structure

Each year of the data is grouped in a different zip file on the CMS website. These must be downloaded separately. Inside each zip file are pdf and excel spreadsheet versions of the national file and state file for the year. The state file is structured so each state is a separate sheet within the state spreadsheet. This structure goes back until year 2010. Data are available before 2010 in a separate ZIP file but because of methodology differences in the earlier data we choose to stop at 2010 data.

To make the data into a workable database we must do quite a bit of data manipulation. We use R code to read in data from each sheet in each spreadsheet for each year, extracting the relevant headings and tidying it into the structure outlined in this [Lucid]Chart(https://app.lucidchart.com/invitations/accept/4dbb90e5-3649-4baa-a42f-29088772b47e). 

### CMS416_dental90 & CMS41_eligible90 tables

We have split the utilization and eligibility information into separate tables. This is because they represent fundamentally different measures. Also, when calculating rates, utilization will become our numerator and eligibility our denominator -- to compute this we join the two tables together by their common fields in SQL or Tableau.

The measure column in the CMS416_dental column is the number of utilizers of dental services who had been enrolled for 90 days. The 90-day enrollment window is the only one CMS uses when reporting dental utilization. Therefore, we must make also set our denominator to have 90-day enrollment. This is captured on line 1b of the dataset. We ignore line 1a, which is enrollment for any amount of time during the year. 

The dental utilization measures all come from line 12 of the CMS416 form. They are:

|Line | Description |
| ---| ---|
| 12a | Total eligibles receiving any dental service |
| 12b | Total eligibles receiving preventive dental services |
| 12c | Total eligibles receiving a sealant on a permanent molar tooth |
| 12d | Total eligibles receiving dental treatment services | 
| 12e | Total eligibles receiving dental diagnostic services | 
| 12f | Total eligibles receiving oral health services by a non-dentist provider |
| 12g | Total eligibles receiving any dental or oral health service |

States report their CMS416 counts in three types of enrollee categories: categorically needy (CN), medically needy (MN), and total. The categorically needy category includes most enrollees -- it denotes those people eligible for EPSDT benefits by virtue of their age and income categories. Medically needy enrollees are those receiving assistance paying medical costs through optional state programs outside of the regular EPSDT program. Many states will show zeros across their MN values because they do not offer MN benefits. A good explanation of the difference is found at the [West Virginia Department of Health and Human Resources](https://www.wvdhhr.org/bcf/policy/imm/new_manual/immanual/manual_pdf_files/chapter_16/ch16_4%20.pdf). 

CMS416 reports capture data across 7 age groups: under 1, 1--2, 3--5, 6--9, 10--14, 15--18, 19--20, as well as a total aggregation column. A double-dash has been used instead of single dash here to avoid a spreadsheet assuming a date format. We deleted the "Total" age column so that to obtain the total we must add up all the separate ages together. Otherwise we risk double-counting people when we sum across the age column in Tableau. 

The different 'lines' in the original dataset reflect different lines on the CMS416 submission form. We added a shorthand version of each line to make it easier to read.

### 2018_cms_416_age_weights table

To be able to compare different states on utilization we will need to age-adjust our values. Utilization varies greatly depending on child age, so that states with different population distributions would likely see different utilization rates by that factor alone. To age-adjust we introduce a small table where each age gets a weight. The weights across ages add to 1. The weights are based on the age distribution of 2018 United States CMS 416 total enrollees:

| Age_str | Age_int | Total_Enrollment | Percent_of_Total |
| ---| --- | --- | --- |
| <1 | 2 | 1708364 | 0.042705136 |
| 1--2 | 2 | 4459999 | 0.158883002 |
| 3--5 | 3 | 6355910 | 0.204350156 |
| 6--9 | 4 | 8174765 | 0.24680739 |
| 10--14 | 5 | 9873212 | 0.17085429 |
| 15--18 | 6 | 6834806 | 0.111489626 |
| 19--20 | 7 | 2596657 | 0.0649104 |

Since these data do appear in the CMS_416_eligible90 table, this weights table isn't entirely necessary but it's a lot easier in Tableau to have this table pre-made and joined-in rather than recreated using Level of Detail expressions.

### grid_xy table

The basic Tableau presentation for states is to show states as their actual shapes on a map. We probably don't want to show an actual map of the United States that gives Alaska and Texas such large real estate compared to Rhode Island and Delaware. Instead we want a tesselated tile grid. We use a new table titlled 'grid_xy' that assigns each state a horizontal and vertical value tiling states into a rough representation of the countr. 

## Issues, decisions, and modifications
CMS416 reports include 24 reporting lines across 14 topics. We have only kept oral health and total eligibility lines. For example, lines pertaining to blood lead tests, screening ratios, and periodicity schedules have been removed.

The "Total" age value was removed. To retrieve the total number of children on a given measure we instead sum across ages.

We include a couple of geography columns to help the user: the full name of the geography, the abbreviation, the FIPS code, and the type of geography. The type field can be used to filter for only the country level or territory level, for example. 


## Code
The R code used to read in all the data and output our tables is located on our GitHub repository [here](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/CMS416/CMS416_r_code.R). 

## Tableau dashboard
The beta stage Tableau dashboard is availble on [Tableau Public](https://public.tableau.com/views/CMS416OralHealthReport/CMS416?:display_count=y&publish=yes&:origin=viz_share_link).

## Project status
The Tableau dashboard needs a graphic design makeover and must be embedded into the website.

## Tutorial
* [Orientation](https://youtu.be/lEROp70c4mM). A navigation to the CMS 416 data page and disscussion the original data structure.
* [Data Processsing](https://youtu.be/BIblZX4pDKs). A walkthrough of the R code used to consolidate and process the original CMS 416 tables.
* [Data portal structure](https://youtu.be/XIZ5swLuQkw). An overview of the 4-table structure of our CMS 416 data.
* [Tableau dashboard navigation](https://youtu.be/lC940vvc28w). A walkthrough of the beta version of the CMS 416 dashboard. 
