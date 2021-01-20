# Health Resources & Services Administration Dental Health Professional Shortage Areas

Geographic boundaries in the United States are determined to have a shortage of dental providers if they meet certain criteria established by the Health Resources & Services Administration. These designations help illuminate areas where certain populations may have difficulty obtaining needed dental care.


## Questions this dataset could help answer

* Which area in New Jersey has the highest designated shortage score?
* How many dentist FTEs would be needed to ensure Idaohans have adequate access to dental care?
* What shortage area in North Dakota has the highest proportion of people to dentist?
* How many dentist FTEs are currently servicing the low income population of Genessee County, Michigan?

## Utility

This dataset offers a helpful metric for identifying which areas of the country are in highest need of improved oral health care access. 

## Orientation & Stewardship  

HRSA designates shortage areas and maintains the data files. 

According to HRSA documentation in the Area Health Resource Files, an area can be designated as having a shortage of dentists if:

1.	The area has a population to full-time-equivalent dentist ratio of at least 5,000:1.
2.	The area has a population to full-time-equivalent dentist ratio of less than 5,000:1 but greater than 4,000:1 and has unusually high needs for dental services or insufficient capacity of existing dental  providers.

Once a designation is made, a score is assigned using a formula with [4 criteria](https://bhw.hrsa.gov/workforce-shortage-areas/shortage-designation/scoring):

* Population to provider ratio (out of 10 points)
* Percent of population below 100% of the federal poverty level (out 10 points)
* Whether the area has adequately fluoridated water (1 or no points)
* Average travel time to the nearest source of care outside the designation area (out of 5 points)

Dental areas can receive a score of up to 26 points. 

These dental scores directly influece the [HRSA National Health Service Corps and Indian Health Service loan repayment programs](https://nhsc.hrsa.gov/scholarships/requirements-compliance/jobs-and-site-search/hpsa-score-class-year), which requires an area to meet a certain DHPSA threshold to be eligible to receive a Service Corps placement or for a provider to be eligible for loan repayment. DHPSA scores can also impact HRSA grant decisions for Federally-Qualified Health Centers.

## Data Use

DHPSA data files are available for free public dowload from the [HRSA data downloads page](https://data.hrsa.gov/data/download).

## Original Data Structure

HRSA offers several file formats for obtaining DHPSA information on its data downloads page. The National Oral Health Data Portal project used 2 of them:

* The **All HPSAs- Excel** file, which downloads as "BCD_HPSA_FCT_DET_DH.xlsx".

* The **All HPSA Designation Boundaries - SHP** file, which is a zipped folder containing shapefiles. 

## Converted Data Structure

No modifications were made to the original HRSA files listed above. These were imported as-is into Tableau.

## Decisions & Tableau Dashboards

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/HRSADentalHealthProfessionalShortageAreas_16091923631950/Orientation).

In practice, DHPSAs are most often used to describe a geographiy's status: either being a DHPSA or not being a DHPSA. But there are so many deeper data points contained in the DHPSA files that can be useful, including the following measures:

* Population to dental provider ratio
* Total dental FTEs
* Addditional dental FTEs needed
* Population served by current dental workforce
* Percent of people unserved
* Population left unserved by inadequate dental workforce

The Tableau dasbhboard tries to bring awareness to this richness by allowing users to update the charts per each different measure. 

The dashboard also tries to help users understand that DHPSA designations may not apply to everyone living in an area. A DHPSA may apply to a specific population in a boundary, such as low income people or people who are migrant farmworkers. The Dashboard allows users to select by these features and filter the charts. 

The Tableau dashboards use a 7-shade continuous purple scale for each measure fixed on the the country-level so that the colors do not change if a state or other type of filter is applied.

## Code

No code was used to modify or calculate any aspects of this dataset.

## Project status & Next Steps

The Tableau dashboard as-is helps users compare individual DHPAs on different characteristics. It does not aggregate totals to the country or state such that a person could see how many total FTEs are needed in Louisiana overall. Such an additional dashboard hat would be a good next step to work on. 
