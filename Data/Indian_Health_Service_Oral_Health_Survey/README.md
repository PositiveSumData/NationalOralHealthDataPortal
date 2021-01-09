# Indian Health Service Oral Health Survey

This dataset shows insights into the prevalence and tooth count of oral health conditions of American Indian and Alaska Native child populations in the United States.

## Examples of questions this dataset could help answer

* Does prevlanece of decay experience change across ages in AI / AN children?
* Which are higher among young AI / AN children: prevlence of untreated decay or prevlance of urgent care needed?
* Have the percent of AI / AN children with sealants on primary molars changed over time?
* Have the percent contributions of decayed, missing, and filled teeth to overall DMFT in AI / AN children changed over time or across ages?
* How many filled teeth did the average AI / AN child age 13-15 have in 2019-2020?

## Utility

* This survey is one of the few to illuminate oral health status among American Indian and Alaska Native populations, and one of the few in which dentists inspect peoples' mouths to record oral health status. 

## Orientation & Stewardship  

The survey has been conducted by the Indian Health Service (IHS) for many years in tribal and IHS dental clinics. Periodic reports, whether showing the latest survey wave or aggregating previous waves, are published on the IHS dental portal. The National Oral Health Data Portal collected data from two reports on the IHS dental portal:

* [**The Oral Health of 13-15 Year Old American Indian and Alaska Native (AI/AN) Dental Clinic Patients – A Follow-Up Report to the 2013 Survey**](https://www.ihs.gov/doh/documents/surveillance/2018-19%20Data%20Brief%20of%201-5%20Year-Old%20AI-AN%20Preschool%20Children.pdf)

* [**THE ORAL HEALTH OF AMERICAN INDIAN AND ALASKA NATIVE CHILDREN AGED 1-5 YEARS: RESULTS OF THE 2018-19 IHS ORAL HEALTH SURVEY**](https://www.ihs.gov/doh/documents/surveillance/IHS_Data_Brief_Oral_Health_13-15_Year_Old_Follow-Up_to_2013_Survey.pdf) 

#### Citation & Data use

The IHS surveys are available for public download on the IHS dental portal. 

The following citations are suggested within the text of each individual report:

**The Oral Health of 13-15 Year Old American Indian and Alaska Native (AI/AN) Dental Clinic Patients – A Follow-Up Report to the 2013 Survey**: 
Phipps KR, Ricks TL, Mork NP, and Lozon TL. The oral health of 13-15 year old American Indian and Alaska Native dental
clinic patients – a follow-up report to the 2013 survey. Indian Health Service data brief. Rockville, MD: Indian Health
Service. 2020. 

**THE ORAL HEALTH OF AMERICAN INDIAN AND ALASKA NATIVE CHILDREN AGED 1-5 YEARS: RESULTS OF THE 2018-19 IHS ORAL HEALTH SURVEY**: 
Phipps KR, Ricks TL, Mork NP, and Lozon TL. The oral health of American Indian and Alaska Native children aged
1-5 years: results of the 2018-19 IHS oral health survey. Indian Health Service data brief. Rockville, MD: Indian
Health Service. 2019.


## Original Data Structure

The data within each report were structured across several tables formatted for viewing within the PDF. 

## Converted Data Structure

The two reports have been manually consolidated into one CSV with the following sample structure:

| population | age | statistic | measure | year | estimate | se | lower_CI | upper_CI |
| ---------- | --- | --------- | ------- | ---- | -------- | -- | -------- | -------- |
| AI / AN children | 13 -15 years | mean | DMFT | year | estimate | se | lower_CI | upper_CI |

95% confidence intervals are shown. When standard errors were presented in the reports but not confidence intervals, confidence intervals were generated using a 1.96 x se method. Values below zero or above one were truncated to not exceed the range.

## Issues & decisions

Positive Sum would like to have combined the two reports into the same visualization to show prevlance of oral health conditions across ages for a single point in time, but because the survyes had a year or two between them, it was decided to keep them in separate graphs.

## Code

No code was used to automate the data collection process as the pdfs had unique structures more suitable to manual copying.

## Tableau Presentation

Two tableau dashboards are presented:

**Prevlance Dashboard**. For all prevalence measures that showed the percent of a population with a condition.

**DMFT Dashboard**. For all measures that used the count of teeth (decayed, missing, filled, etc..). This dashboard is presented in 4 windows showing permutations of data for [most current year only] vs [time series] and for [stacked area percent of total plot] vs [line plot]. The stacked area percent of total plots help show how the overal distributions of DMFT are changing over time or across ages. 


## Status & Next Steps

The Tableau vizes are up and feedback is welcome. Should we explore adding in additional reports on the IHS data portal?
