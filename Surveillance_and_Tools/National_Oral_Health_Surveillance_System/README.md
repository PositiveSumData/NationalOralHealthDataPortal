
# The National Oral Health Surveillance System

A dashboard for monitoring state performance on official indicators in the National Oral Health Surveillance System

## Utility

This dashboard aggregates 12 data sources covering 32 of the 36 NOHSS indicators, showing how a state performs on all indicators in one view and how the state compares to other states.

## Data Stewardship  

The National Oral Health Surveillance System is a suite of indicators approved by the Council of State & Territorial Epidemiologists (CSTE) to represent a comprehensive portrayal of a state's oral health status and system performance. The Associaton of State & Territorial Dental Directors (ASTDD) has taken the lead in helping develop and maintain these indicators over time, growing fron an initial suite of 9 indicators in the late 1990s to 36 today. 

The current list of indicators are stewarded by 5 separate agencies and organizations plus the basic screening survey, which states conduct individually, usually with assistance from ASTDD. 

| Steward | Data Source | Indicator |
| ----------- | ------------ | ------------ |
| ASTDD | ASTDD State Synopsis | State-based Oral Health Surveillance System in place |
| CDC | BRFSS | Dental Visit Among Adults Aged ≥18 Years |
| CDC | BRFSS | Dental Visit Among Adults Aged ≥18 Years with Diabetes |
| CDC | BRFSS | No Tooth Loss Among Adults Aged 18-64 Years |
| CDC | BRFSS | Six or More Teeth Lost Among Adults Aged ≥65 Years |
| CDC | BRFSS | All Teeth Lost Among Adults Aged ≥65 Years |
| CDC | PRAMS | Teeth Cleaning Among Women During Pregnancy |
| CDC | PRAMS | Teeth Cleaning Among Women Before Pregnancy |
| CDC | Cancer Registries | Incidence of Invasive Cancer of the Oral Cavity or Pharynx |
| CDC | Cancer Registries | Mortality from Invasive Cancer of the Oral Cavity or Pharynx |
| CDC | YRBS | Dental Visit Among Adolescents in Grades 9-12 |
| CDC | CDC WFRS | Population Served by Community Water Fluoridation |
| CMS | CMS-416 | Preventive Dental Service for Children Aged 1-20 Years Enrolled in Medicaid or Children’s Health Insurance Programs (CHIP) Medicaid Expansion |
| CMS | CMS-416 | Any Dental Service for Children Aged 1-20 Years Enrolled in Medicaid or CHIP Medicaid Expansion |
| CMS | CMS-416 | Dental Sealant Use Among Children Aged 6-9 Years Enrolled in Medicaid or CHIP Medicaid Expansion |
| CMS | CMS-416 | Dental Sealant Use Among Children Aged 10-14 Years Enrolled in Medicaid or CHIP Medicaid Expansion |
| HRSA | NSCH | Dental Visit Among Children Aged 1-17 Years |
| HRSA | NSCH | Preventive Dental Visit Among Children Aged 1-17 Years |
| HRSA | UDS | Population Receiving Oral Health Services at Federally Qualified Health Centers |
| SBHA | Census of School-Based Health Centers (CSBHC)) | School-Based Health Centers that Provide Dental Sealants |
| SBHA | Census of School-Based Health Centers (CSBHC)) | School-Based Health Centers that Provide Dental Care |
| SBHA | Census of School-Based Health Centers (CSBHC)) | School-Based Health Centers that Provide Topical Fluoride |
| States | BSS | Urgent Dental Treatment Need Among Children Aged 3-5 Years Attending Head Start |
| States | BSS | Urgent Dental Treatment Need Among Children Attending Kindergarten |
| States | BSS | Urgent Dental Treatment Need Among 3rd Grade Children |
| States | BSS | Dental Caries Experience Among Children Aged 3-5 Years Attending Head Start |
| States | BSS | Untreated Dental Caries Among Children Aged 3-5 Years Attending Head Start |
| States | BSS | Dental Caries Experience Among Children Attending Kindergarten |
| States | BSS | Dental Caries Experience Among 3rd Grade Children |
| States | BSS | Untreated Dental Caries Among Children Attending Kindergarten |
| States | BSS | Untreated Dental Caries Among 3rd Grade Children |
| States | BSS | Untreated Dental Caries Among Adults Aged ≥65 Years Residing In Long-Term Care or Skilled Nursing Facilities |
| States | BSS | Untreated Dental Caries Among Adults Aged ≥65 Years Attending Congregate Meal Sites |
| States | BSS | Dental Treatment Need Among Adults Aged ≥65 Years Residing In Long-Term Care or Skilled Nursing Facilities ( |
| States | BSS | Dental Treatment Need Among Adults Aged ≥65 Years Attending Congregate Meal Sites |
| States | BSS | Dental Sealant Among 3rd Grade Children |

The CDC tracks the NOHSS oral health indicators for which it is the data steward on their [Oral Health Data Portal](https://chronicdata.cdc.gov/browse?category=Oral+Health). The CDC also makes some state Basic Screening Survey data available, having consolidated it from states with the assistance of ASTDD. Adult Basic Screening Survey data is not available on the CDC Data Portal, however, and it is not includeded in the National Oral Health Data Portal Project either, for reasons described below.

The other data stewards do not appear to explicitly track or display NOHSS performance on their respesctive indicators.

To learn more about the history of NOHSS indicators, please see the pdf in this folder title "state-based-oral-health-surveillance-systems-cste-whitepaper-oct-2013.pdf". A word doc in this folder also contains an official list of the current indicators.

## Original Data Structures

To learn more about each of the data sources in NOHSS and how they were incorporated into the National Oral Health Data Portal project, please visit each the Github reposotory page of each dataset individually.

## Converted Data Structure

Two files have been created to consolidate the NOHSS indicators:

* **NOHSS_prime.csv**. Each row is a uniqe state-indicator-year. 

* **NOHSS_CI.csv**. Each row is a unique state-indicator-year-confidence_level. This file is twice as tall as the 'prime' file because it has been unpivoted to contain a separate row for each data point in the 'prime' file so that data visualization software can display confience intervals.

## Issues & decisions

### Older Adult Basic Screening Survey

The Older Adults Basic Screening Survey is the only data source not currently represented in this NOHSS dashboard. The primary reasons are:
* There are so few states that have conducted the survey that most users won't see any data or won't be able to compare their state's performance.
* For the surveys that are conducted, differences in population denominators (e.g. dentulum status, service location), and non-representativeness of the surveys mean that results are likely not comparable between states.

### 'no data' for Child Basic Screening Survey 

More states have conducted child Basic Screening Surveys than adult Basic Screening Surveys. However, this is still the dataset in our NOHSS dashboard with the most missing values. When a state does not have BSS data on an indicator, it is represented as "no data" on the dashboard.

### Using Most Recent Date

In an effort to make what BSS is available comparable between states, the dasbhoard currently uses the most recent survey data available, even if it is quite old. This could be changed to only use a cutoff threshold if users suggest a good threshold. 

The same applies accross datasets: the most recent year available is used. This means that the dashboard is showing data from different years at the same time. Users should be careful to look at the dashboard tooltips more more information on which dates they are seeing displayed for each data point.

### Dealing with Different Axes

Almost all the indicators are computed as a percent. This makes it easy to visualize most indicators on the same access in the same chart. Three indicators use a different unit, and can be somewhat difficult to incorporate into the dashboard with the other indicators:

* ASTDD State Synopses - Presence of an Approved Oral Health Surveillance System. This isa binary 'yes' / 'no' indicator. Therefore there is no data displayed on the continuous Gandt Chart in pink/blue. In the dashboard maps, colors are used to show the binary possibilities. In the bar charts states either have 100=yes or 0=no. 

* Rates of oral cancer mortality or incidence per 100,000 people. These indicators are perhaps most appropriately displayed on their own log scale. But we are a bit lucky that the rates for these two indicators range between zero and 100 so that we can use them on the same chart as the other indicators, even if they are rather squished onto the lower end of the axis. For a more appropriate visualization of these indicators, please see the USCS dataset page of the National Oral Health Data Portal. 

### No Population Stratifications for Now

Our NOHSS dashboard currently only displays top-level indicator data for all populations together. It will not break out data by race/ethnicity, age, income, etc. That may be a good feature to add in the future if users desire.

### HRSA FQHC Patient Dental Service Rates

Obtaining the percent of state FQHC patients who received dental care is one of the trickier indicators to report on, because the information is somewhat hidden on the HRSA website. These data are not obtainable from a FOIA request and are not included in the Uniform Data System FOIA files in the [Electronic Reading Room](https://www.hrsa.gov/foia/electronic-reading.html) or the [HRSA Data Warehouse] (https://data.hrsa.gov/) as much other UDS oral health data is. The way to obtain the data is to look up each state's [program awardee data](https://data.hrsa.gov/tools/data-reporting/program-data) and download the "__state__ Aggregated Health Center Data" spreadsheet. This spreadsheet contains some information not available in raw UDS FOIA data, including the percent of each FQHC's patients who received dental care. FOIA data will tell you about patients receiving types of dental services, but not 'any dental service' overall. To obtain state aggregations we multiply the percent of patients at each FQHC who received a dental service by the number of total patients they had in the year. Then we sum this across FQHCs and divide by the total state FQHC patient count. 

### Oral Cancer

In their United States Cancer Statistics microsite, the source for oral cancer data in this dashboard, the CDC presents both age-adjusted and un-adjusted oral and pharyngeal cancer mortality and incidence. For this dashboard, only the age-adjusted rates are used, since this makes it more comparable between states. To see raw rates instead, please see the USCS dataset page in the National Oral Health Data Portal.

## Code

The file **NOHSS_consolidator.R**, stored in this Github repository folder, helps produce the **NOHSS_CI.csv** file based on **NOHSS_prime.csv** as input.

## Status & Next Steps

* Consider adding in population stratifications? 
* Await feedback for any desired changes to the dashboard layout?
