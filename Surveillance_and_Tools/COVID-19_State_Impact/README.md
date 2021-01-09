# COVID-19 State Impact Dashboard

This visualization aggregates frequentl-collected datasets that together help show how a state's severity of COVID-19 and how employment and patient care have been impacted.

## Examples of questions this dataset could help answer

* What is trajectory of COVID-19 cases and deaths in New Mexico?
* Have the percent of dental practices in Mississippi that are open as usual decreased since before the pandemic?
* How has dental professional employment been impacted by the pandemic?
* Has a winter spike in cases resulted in fewer patient visits in Virginia?

## Utility

This dashboard helps bring several datasets together at once so that health system professionals don't need to look at datasets individually.

## Data Stewardship  

This dashboard aggregates datasets from three stewards:

[**Centers for Disease Control & Prevention COVID-19 case and death data tracker**](https://healthdata.gov/dataset/united-states-covid-19-cases-and-deaths-state-over-time). One of the many CDC COVID-19-tracking datasets being maintained, but perhaps the only one to contain state-level counts of both cases and deaths together. 

[**Bureau of Labor Statistics Quarterly Census of Employment & Wages**](https://data.bls.gov/cew/apps/data_views/data_views.htm#tab=Tables). Released every quarter, the QCEW will give total employment and wages for a selected industry. In our case, 'offices of dentists.' Employment is reported to the month while wages are reported to the the quarter. 

[**American Dental Asssociation Health Policy Institute COVID-19 Poll**](https://www.ada.org/en/science-research/health-policy-institute/covid-19-dentists-economic-impact?&utm_source=adaorg&utm_medium=hpialertbar&utm_content=cv-hpi-see-all-results&utm_campaign=covid-19). An ongoing survey administered to dentists updated every few weeks. Dentists report about many variables and the HPI releases state-level detail pertaining to practice status, patient volume, staffing levels, collections volume, and personal professional equipment stock. The patient volume survey question changed in September to allow more levels of detail among practices in the 76%-100% of normal range.

## Original Data Structures

**HPI COVID-19 poll data** is presented in a separate web-based report for each polling wave. HPI has also constructed a Tableau dashboard for state-level detail, but the data download feature is not enabled so it is easier to go directly to the web reports for data. The reports break out each question separately and then list the state responses. 

In the **CDC COVID-19 tracker** table, each row corresponds to a unique state-day. It gives a glimpse of how many [new and current], [confirmed and probable], and [cases and deaths] there are. 

Ideally **BLS QCEW data** may be downloaded via an API once a user requests and receives an API key. Positive Sum found it faster in this case to run a series of queries with the [CEW Data Viewer](https://data.bls.gov/cew/apps/data_views/data_views.htm#tab=Tables). The Data Viewer enables many types of queries but none that seem to return all states for all years for specific industries, so instead a "Geographic Cross-Section - All states, one industry" query was performed on "offices of dentists", running a separate query for each of years 2016, 2017, 2018, 2019, and 2020. Going so far back was overkill for COVID-19 data, but it is nice to the full time series for other projects. The query returns a unique row for each state for each quarter. Two files are generated: **BLS_quarterly.csv** which contains monthly employment counts, and **BLS_monthly.csv** which contains quarterly wage totals in dollars.

## Converted Data Structure
**HPI COVID-19 Poll data** was collected manually from each poll wave's individual report and then aggregated into the spreadsheet **ADA_HPI_COVID_survey_states.xlsx** which has 5 tabs corresponding to different sections in the original reports:
* practice_status
* paying_staff
* collections_volume
* patient_volume
* days_ppe

**CDC COVID-19 data** was processed with R code in this Github folder to remove some unnecessary columns and also add full state names by joining it to the crosswalk file in this Github folder. Otherwise the dataset only had state abbreviations. 

**BLS QCEW data** was obtained by querying each of the years as described above, manually stacking the files into one spreasheet, and then running R code to process the file into a more Tableau-friendly format.

## Issues & decisions

The CDC COVID-19 file contains both 'confirmed' and 'probable' cases and deaths. Positive Sum has used the 'probable' totals for now.

BLS QCEW data is released quarterly and on a delay of up to about 1.5 quarters, so it always will lag behind the other datasets.

## Code

R code for modifyin the CDC and BLS files is available in this Github folder.

## Tableau Presentation

Three dashboards are presented:
* **COVID-19 Overview**. Uses four windows to track (1) BLS employment and wages, (2) HPI practice status, (3) HPI patient volume, and (4) CDC COVID cases and deaths. The BLS and CDC data are set on the same time axis to aid the viewer. It begins early enough to show what employment and wages were before the pandemic hit. The HPI data is also on the same axis. The Patient Volume chart has a break and gradient change in September 2020 to reflect the change in survey instrument at that time.

* **Practice Staffing**. A stacked area percent of total plot showing a state's status of dental practices paying their staff fully, partially, or not at all. This chart didn't easily fit into the COVID-19 Overview dashboard so it sits here instead.

* **PPE**. Tracks the stock of PPE reported by state over time suing a stacked area percent of total plot.

## Status & Next Steps

The Tableau viz is up. Feedback is welcome. 

The dashboard needs to be maintained by updating the HPI COVID poll when a new one is released every few weeks and updating the BLS data after the quarterly release. The CDC data could be updated daily but more likely we will wait until BLS or HPI data has updates as well.  
