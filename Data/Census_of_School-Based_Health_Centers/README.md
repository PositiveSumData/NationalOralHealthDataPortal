# The Census of School-Based Health Centers

The School-Based Health Alliance's Census of School-Based Health Centers provides information tracks health access information at schools across the country. 

## Utility

School-based health centers are an important access point for oral health care in many communities. This dataset helps us understand how many school-based health centers are providing oral healthcare in states.

The Census of School-Based Health Centers has 3 indicators that are part of the National Oral Health Surveillance System:
* Number of school-based health centers providing dental sealants
* Number of school-based health centers providing dental care
* Number of school-based health centers providing topical fluoride

### Questions this dataset could help answer

* How many school-based health centers in Alaska provided dental sealants in 2016-2017?
* Which states did not have any school-based health centers providing dental services in 2016-2017?
* Did Georgia have more school-based health centers providing topical fluoride or dental sealants?

## Orientation & Stewardship  

The Census of School-Based Health Centers is conducted by the School-Based Health Alliance on a periodic bases. The [most recent survey](https://www.sbh4all.org/school-health-care/national-census-of-school-based-health-centers/) was conducted during the 2016-2017 school year. State level data is not available on their website for public download but a file was provided to ASTDD for this project.

## Data Structure

The file provided to ASTDD contains 4 columns: 
* State
* Count of SBHCs providing any oral health service
* Count of SBHCs providing dental sealants
* Coutn of SBHCs providing topical fluoride

## Consolidated Data Structure

Included in this Github respository folder is the file "School Based Health Centers.csv" which contains three columns: [state], [service], and [school_count].

## Code

No code was necessary to process the data before visualization. The 3 service columns were unpivoted in Microsoft Excel to have a database format to read into Tableau.

## Tableau Viz

Two dashboards are presented:

* **States Comparison**. How do states compare by the count of schools providing a given oral health service?

* **State Services**. A dashboard showing state counts of school providing all three types of oral health services at once.


