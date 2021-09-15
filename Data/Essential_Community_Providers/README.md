# Centers for Medicare & Medicaid Services list of Essential Community Providers

This file from CMS lists locations of dental access sites serving low-income or otherwise disadvantaged individuals.


## Questions this dataset could help answer

* Where are Indian Health Service sites offering dental services in the United States?
* How many FTE dental ECPs are in the state of South Carolina?
* Which site in Nevada has the most dental FTEs?
* How has a particular FQHC organization in Nebraska distributed their dentists across all their sites with dental services?

## Utility

The ECP list is one of the few datasets that give locations of practicing dentists, and the only one to give the number of FTEs per site.

## Orientation & Stewardship  

CMS creates a non-exhaustive list of "essential community providers" or "ECP's" for health plans that wish to participate in the exchanges established by the Affordable Care Act. ECPs are providers that serve [low-income and disadvantaged individuals](https://www.kff.org/other/state-indicator/definition-of-essential-community-providers-ecps-in-marketplaces/?currentTimeframe=0&sortModel=%7B%22colId%22:%22Location%22,%22sort%22:%22asc%22%7D). "Qualified Health Plans" must include at "[at least 20 percent of all available ECPS](https://www.qhpcertification.cms.gov/s/ECP%20and%20Network%20Adequacy)" in an area in order to participate in the program. The official list of ECPs is updated annually by CMS. 

The CMS ECP list describes service sites by the number of hospital beds, medical FTEs, and dental FTEs. 

The ECP list is mostly composed of federally-qualified health centers, Indian Health Service, Ryan White, and other federally-supported providers, although some private facilities are also on the list. 

#### Data Use

The annual ECP file is freely and publicly available for download from their [website](https://www.qhpcertification.cms.gov/s/ECP%20and%20Network%20Adequacy).

## Original Data Structure

The original data file contains one row for each site. The address and contact information are provided, as are the number of medical FTEs, dental FTEs, and hospital beds. The type of ECP (e.g., FQHC, Indian Health Service, etc.) is listed in a single comma-separated column since sites usually have multiple designations. No longitude or latitudes are attached.

## Converted Data Structure

For the National Oral Health Data Portal project, we have broken the original file into two:

* [**ECP_geocoded_2019.csv**](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/Essential_Community_Providers/ECP_geocoded_2019.csv). Each row is a unique site with geocoded latitude and longitude. Only sites with dental ECPs are kept. The comma-separated list of provider types is removed; instead, it is used in the second file...

* [**ECP_categories_2019.csv**](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/Essential_Community_Providers/ECP_categories_2019.csv). Each row is a unique site-type pair. This can be joined to the ECP_geocoded_2019.csv file to indicate the many types of providers designations a site has.


## Issues & decisions

### Geocoding failures

The PositionStack API had a lot of trouble with the ECP addresses. About 400 of the dental 2,734 sites failed to parse. Positive Sum will go back to manually geocode them at a later date, but for now these sites are not in the Tableau viz.

### Accuracy of dental FTEs

The FTE counts at some sites raise important questions about the accuracy of this dataset. From Positive Sum's personal experience, there are more FTEs listed at some sites than are physically possible given the few chairs there are. 


## Code

The R code for modifying the original files, geocoding, and saving as two separate files is located in the [Github folder](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/Essential_Community_Providers/ECP_r_code.R) for this dataset.

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/CMSEssentialCommunityProviders/Orientation).

## Project status & Next Steps

The missing 400 sites that could not be automatically geo-coded need to be added manually.

It would be good to learn how accurate are these dental FTEs are and how they are calculated.

