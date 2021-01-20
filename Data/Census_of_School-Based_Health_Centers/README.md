# The Census of School-Based Health Centers

The School-Based Health Alliance's Census of School-Based Health Centers tracks health access information at schools across the country. 

## Utility

School-based health centers are an important access point for oral health care in many communities. This dataset helps us understand how many school-based health centers are providing oral healthcare in states.

The Census of School-Based Health Centers has 3 indicators that are part of the National Oral Health Surveillance System:
* School-based health centers providing dental sealants
* School-based health centers providing dental care
* School-based health centers providing topical fluoride

### Questions this dataset could help answer

* How many school-based health centers in Alaska provided dental sealants in 2016-2017?
* Did any states not have any school-based health centers providing dental services in 2016-2017?
* Did Georgia have more school-based health centers providing topical fluoride or dental sealants?
* Which state has the highest proportion of school-based health centers providing dental sealants?

## Orientation & Stewardship  

The Census of School-Based Health Centers is conducted by the School-Based Health Alliance on a periodic bases. The [most recent survey](https://www.sbh4all.org/wp-content/uploads/2019/05/2016-17-Census-Report-Final.pdf) was conducted during the 2016-2017 school year. Counts of state SBHCs were pulled from this national report. Counts of state SBHCs providing types of oral health services were not included in the report but were provided separately by the School-Based Health Alliance for this project.

## Data Structure

The file provided to ASTDD contains 4 columns: 
* State
* Count of SBHCs providing any oral health service
* Count of SBHCs providing dental sealants
* Count of SBHCs providing topical fluoride

## Consolidated Data Structure

Included in this Github respository folder is the file **School Based Health Centers.csv** which contains three columns: [state], [service], and [school_count].

The file **census_counts_all_sbhcs.csv** contains state counts of SBHCs. 

## Code

No code was necessary to process the data before visualization. The 3 service columns were unpivoted in Microsoft Excel to have a database format to read into Tableau.

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/CensusofSchool-BasedHealthCenters/Orientation).

Two dashboards are presented:

* **States Service Comparison**. Showing all how all states perform on percent of SBHCs providing one of the three selected oral health services.

* **States All Services Comparison**. Showing how all states perform on percent of SBHCs providng all three types of oral health services at once.


