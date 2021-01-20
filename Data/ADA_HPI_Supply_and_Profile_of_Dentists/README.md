# American Dental Association Health Policy Institute Supply and Profile of Dentists dataset

The Supply and Profile of Dentists dataset gives counts and densities of professionally active dentists by country and state for each year since 2001.

## Examplse of questions this dataset could help answer

* How many dentists were practicing in West Virginia in 2019?
* Are counts of dentists increasing in Oklahoma since 2001? Going down? Flattening?
* Which state has the highest number of dentists per capita?

## Utility

This dataset gives a count of how many professionally active dentists there are in a state. The 'professionally active' designation helps distinguish from other datasets thay perhaps can tell how many dentists are licensed, but not necessarily how many are serving a meaningful number of patients.

## Orientation & Stewardship  

The American Dental Association's Health Policy Institute hosts the Supply and Profile of Dentists dataset.

#### Data use 

The dataset is publicly available for download from the HPI [website](https://www.ada.org/en/science-research/health-policy-institute/data-center/supply-and-profile-of-dentists). 

## Original Data Structure

Two files are available for download from the HPI website: 

**Supply of Dentists in the U.S.: 2001-2019**. "Includes the number of dentists in the United States by state from 2001 to 2019, U.S. population figures, the number of dentists per 100,000 population, and the supply of dentists in the U.S. by age, gender, and practice area/specialty." A 5-table spreadsheet catalogs information for states, separating dentist counts, population counts, and dentist-per-population density. Age, gender, and specialty breakouts are provided for the country overall.

**Dentist Profile Snapshot by State 2016**. "Report on state-by-state dentist demographic data, including breakdowns by age, race/ethnicity, Medicaid/CHIP participation, dental practice type affiliation, and supply per 100,000 population." Contains state breakouts by practice structure, public coverage acceptance, dentist race/ethnicity, dentist gender, and dentist age group. 

## Converted Data Structure

The sheets in the original spreadsheet were condensed into two files:

**ADA_HPI_supply_and_profile_of_dentists_national_characteristics.csv**. Contains national-only data.

**ADA_HPI_supply_and_profile_of_dentists_STATES.csv**. Contains state-specific data.

## Issues & decisions

The first file containing annual dentist counts and density has been incorporated into the National Oral Health Data Portal project; the second 2016 snapshot has not been incorporated because it is not as current. 

## Code

No code was used to modify or calculate data. Because the original spreadsheets had custom formatting per sheet, it was easier to process these manually.

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/ADAHPISupplyandProfileofDentists/Orientation).

Three dashboards have been created:

* **States Compare**. For comparing states on the dentist count or density measure in 2019.

* **State Historical Trends**. For comparing states across time on one of the two measures.

* **National Dentists by Age, Sex**. For examining national dentist counts by age and sex.

## Status & Next Steps

We may want to come back to the second more detailed file to add that to the project if 2016 data will be useful.

