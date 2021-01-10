# Health Resources & Services Administration Area Health Resource Files

HRSA's Area Health Resource Files (AHRFs) contain detailed characteristics of the dentist workforce at state and county levels. 

## Questions this dataset could help answer

* How many overall and private practice dentists were in Breathitt County, Kentucky in 2017?
* Where is the Minnesota dental workforce getting older / younger?
* Are Los Angeles County, California dentists evenly distributed by gender?

## Utility

AHRF gives detailed demographic and service characteristics of the dental workforce at the county level.

## Orientation & Stewardship  

AHRFs are maintained by the Health Resources & Services Administration, which obtains much of the data from government agencies like the U.S. Census Bureau or Centers for Medicare & Medicaid Services; and by purchasing access to private datasets like the American Medical Association Masterfile and the American Dental Association Masterfile. County level dental workforce data comes from the ADA masterfile, usually on 2-year delay (the 2020 AHRFs contained 2018 ADA masterfile data). AHRF state-level data comes from the Centers for Medicare & Medicaid Services National Plan and Provider Enumeration System National Provider Identifier registry. 

#### Data Use

The Area Health Resource File documentation requests the following citation:
> Area Health Resources Files (AHRF) 2018-2019. US Department of Health and Human Services, Health Resources and Services Administration, Bureau of Health Workforce, Rockville, MD.

The data use license agreement states that AHRF data may be sued for "scholarly, educational, or scientific research or professional use but in no case for sale." 

The 2018-2019 ARFT data file and documentation were downloaded from the HRSA [data downloads webpage](https://data.hrsa.gov/data/download).

## Original Data Structure

The raw AHRF data file is a massive space-delimited file where all data would read into a single column in a spreadsheet if attempted to open in Excel. The documentation explains where each column starts and stops by the number of spaces from the left. Each row is a unique geography-year-measure.

## Converted Data Structure

Statistical software was used to pull out just geographic, population, and oral health-related fields. Fields were renamed to make it easier to view. 

Two files were produced:

* **ahrf.csv**. Contains dental workforce data. This file is too large to host on Github so it's place in a [Google Drive folder](https://drive.google.com/file/d/1IegxMxYPn6-Gc1ghDkIejj9lsyk0zNZs/view?usp=sharing).

* **arhf_pop.csv**. Contains population counts.

## Issues & decisions

AHRF contains a TON of information and there's no way to visualize all that it contains. This project focused on county data only for now, since that's where most of the detail is. The state-level dental details is much more limited, coming from the NPI registry rather than the ADA masterfile. Positive Sum would like to know more about the validity of aggregating all county-level detail up to the state before making that visualization. Would it be ok to say that 23% of a state's dentists are under 35 if you add up all the dentists from all the counties and compute the share that are under 35?

## Code

The R file **ahrf_code.R** has been added to this Github repository folder. It reads in the 2018-2019 ahrf file and outputs the dental workforce and populations files.

## Project status & Next Steps

The project is currently using the 2018-2019 AHRF, which contains 2017 ADA masterfile dentist counts. The 2019-2020 updated file is available and needs to be incorporated into the project. Since the characater spaces will be entirely different than in the 2018-2019 file, it'll take some time to re-map them, it shouldn't be that time consuming.
