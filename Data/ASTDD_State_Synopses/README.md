# Association of State & Territorial Dental Directors State Synopses

The ASTDD State Synopses are aggregated surveys from state dental directors describing state oral health program characteristics. 


## Examples of questions this dataset could help answer

* Which states operate oral health programs specifically to serve older adults?
* Do any states require a public health degree to serve as a state dental director?
* Has the number of state oral health programs offering fluoride varnish preventive programs changed over time?
* How have oral health program characteristics of Maine changed since 2011?
* How many FTEs does the South Dakota oral health program have?

## Utility

The ASTDD state synopses are timely glimpses into the diversity of oral health programs being offered by states. 

## Orientation & Stewardship  

ASTDD annually administers surveys to dental directors, aggregating the findings into reports owned by ASTDD. These reports are posted on the ASTDD website and also shared with the CDC. The CDC aggregates some of the reporting measures into a single file on the [Chronic Disease data portal](https://chronicdata.cdc.gov/Oral-Health/ASTDD-Synopses-of-State-Oral-Health-Programs-Selec/vwmz-4ja3/data). 

For the National Oral Health Data Portal Project, we have used the CDC data file for most visualization since the file does most of the work of aggregating years of ASTDD PDF reports. Importantly, one indicator not included in the CDC portal is whether or not states have an ongoing oral health surveillance system in place approved by the Council of State & Territorial Epidemiologists (CSTE). This is the lone 'infrastructure indicator' in the State Oral Health Surveillance System. To report on this indicator, we have gone directly to the [2020 ASTDD State Synopsis Summary Report](https://www.astdd.org/docs/2020-synopses-report.pdf).

#### Data Use

The historical dataset is publicly available for download on the CDC Chronic Disease Data Portal. More complete annual files are available from ASTDD.

## Original Data Structure

Each row in the CDC download file is a unique state-year-question-breakout. "Breakouts" are the term they use to describe when questions have multiple possible categorical answers. 

Questions without a breakout include:

|question | 
| ------- | 
| Dental director position type	| 
| Oral health (open-mouth) surveys using Basic Screening Survey protocol	| 
| Requirement or mandate for a dental health screening or certificate at school entry	| 
| Statewide, broad-based oral health coalition	| 
| Years in current dental director position	| 

Questions with breakouts include:
|question | breakout |
| ------- | ------- | 
| Number of full-time equivalent (FTE) employees or contractors funded by state dental health program	| Not directly supervised by state health agency staff |
| Number of full-time equivalent (FTE) employees or contractors funded by state dental health program	| Total |
| Number of full-time equivalent (FTE) employees or contractors funded by state dental health program	| Directly supervised by state health agency staff |
| Number of health agencies serving jurisdictions of 250,000+ population | With a dental program directed by a dental professional with graduate degree in public health |
| Number of health agencies serving jurisdictions of 250,000+ population | With a dental program directed by a dental professional |
| Number of health agencies serving jurisdictions of 250,000+ population | With a dental program |
| Number of health agencies serving jurisdictions of 250,000+ population | Total |
| Prevention Programs | Dental screening programs |
| Prevention Programs | Fluoride varnish programs |
| Prevention Programs | Early Childhood Caries (ECC) prevention programs |
| Prevention Programs | School-based or school-linked sealant programs |
| Special populations programs | For older adults |
| Special populations programs | For pregnant women |
| State dental director/program manager position requirement | Full-time |
| State dental director/program manager position requirement | Public health experience |
| State dental director/program manager position requirement | Public health degree |
| Statutory requirement or authority | For state dental director |
| Statutory requirement or authority | For oral health program for oral health program |
| System for children with cleft lips/cleft palates | System for referring children with cleft lips/cleft palates to rehabilitative teams |
| System for children with cleft lips/cleft palates | System for recording children with cleft lips, palates, and other craniofacial anomalies |


## Converted Data Structure

To make the dataset wieldier in Tableau, questions and breakouts have been combined such that the question-breakout pair "Prevention Programs - Dental screening programs" becomes a single unique question in the question column. The breakout column is deleted.

The converted file is located in this [Github repository folder](https://github.com/PositiveSumData/NationalOralHealthDataPortal/tree/master/Data/ASTDD_State_Synopses) as **state_synopses_all.csv**

## Issues & decisions

Not all questions are answered for each state in a given year, but the missing values are few so this does not impact the usefulness of the dataset.

## Code

R code for modifying the original data file into the format used in the Tableau viz is available in this [Github repository folder](https://github.com/PositiveSumData/NationalOralHealthDataPortal/tree/master/Data/ASTDD_State_Synopses). 


## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/ASTDDStateSynopses/Orientation).

The Tableau viz offers three dashboards, offering ways of presenting the main 3 variables: year, state, and indicator. 

* **2020 National Dashboard** fixes the most recent year to show the status of all indicators for all states.
* **Indicators over Time** fixes the state to see how all the indicators perform over all the years in the dataset.
* **States over Time** fixes the indicator to show how all states perform on that indicator over time.


## Status & Next Steps

The Tableau viz is up and open for feedback.

Should we incorporate fields available in the annual ASTDD files that are not included in the CDC historical file?
