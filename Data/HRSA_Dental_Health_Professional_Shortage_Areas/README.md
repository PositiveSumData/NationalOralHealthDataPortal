# Health Resources & Services Administration Dental Health Professional Shortage Areas

Areas in the United States are determined to have a shortage of dental providers if they meet certain criteria established by the Health Resources & Services Administration. These designations help illuminate areas where certain populations may have difficulty obtaining needed dental care.


## Questions this dataset could help answer

* Which area in New Jersey has the highest designated shortage score?
* How many dentist FTEs would be needed to ensure Idaohans have adequate access to dental care?
* What shortage area in North Dakota has the highest proportion of people to dentist?
* How many dentist FTEs are currently service the low income population of Genessee County, Michigan?

## Utility



## Orientation & Stewardship  

HRSA designates shortage areas and maintains the data files. Dental health professional shortage areas are [designated based on 4 criteria](https://bhw.hrsa.gov/workforce-shortage-areas/shortage-designation/scoring):
* Population to provider ratio (out of 10 points)
* Percent of population below 100% of the federal poverty level (out 10 points)
* Whether the area has adequately fluoridated water (1 or no points)
* Average travel time to the nearest source of care outside the designation area (out of 5 points)

Dental areas can receive a score of up to 26 points. 

These dental scores direclty influece the [HRSA National Health Service Corps and Indian Health Service loan repayment programs](https://nhsc.hrsa.gov/scholarships/requirements-compliance/jobs-and-site-search/hpsa-score-class-year), which require an area meet a certain DHPSA threshold to be eligible to receive a Service Corps placement or for a provider to be eligible for loan repayment. DHPSA scores can also impact HRSA grant decisions for Federally-Qualified Health Centers

#### Data Use

DHPSA data files are available for free public dowload from the [HRSA data downloads page](https://data.hrsa.gov/data/download).

## Original Data Structure

HRSA offers several file formats for obtaining DHPSA information on its data downloads page. The National Oral Health Data Portal Project used 2 of them:

* The **All HPSAs- Excel** file, which downloads as "BCD_HPSA_FCT_DET_DH.xlsx".

* The **All HPSA Designation Boundaries - SHP** file, which is a zipped folder containing shapefiles. 

## Converted Data Structure

No modifications were made to the original HRSA files listed above. There were imported as-is into Tableau.

## Issues & decisions

DHPSAs are most often used in regular conversation to describe a location's status: either being a DHPSA or not being a DHPSA. But there are so many deeper data points contained in the DHPSA files that can be useful, including the following measures:

* Population to dental provider ratio
* Total dental FTEs
* Addditional dental FTEs needed
* Population served by current dental workforce
* Percent of people unserved
* Population left unserved by inadequate dental workforce

The Tableau dasbhboard tries to bring awareness to this richness by allowing users to update the charts per each different measure. 

The dashboard also tries to help users understand that DHPSA designations may not apply to everyone living in an area. A DHPSA may apply to a specific population in a boundary, such as low income people or people who are migrant farmworkers. The Dashboard allows users to select by these features and filter the charts. 

## Code

No code was used to modify or calculate any aspects of this dataset.

## Project status & Next Steps

The Tableau dashboard as-is helps users compare individual DHPAs on different characteristics. It does not aggregate totals to the country or state such that a person could see how many total FTEs are needed in Louisiana overall. Such an additional dashboard hat would be a good next step to work on. 
