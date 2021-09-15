# Youth Risk Behavior Survey

The Youth Risk Behavior Survey (YRBS) is a biennial CDC-stewarded state-administered survey of adolescent health behaviors. One of the questions asks whether the interviewee had a dental visit in the last year.

## Examples of questions this dataset could help answer

* Which school districts had the highest percent of high school students with an annual dental visit?
* Has the rate of high school students with an annual dental visit in New York changed in the past decade?
* Do rates of annual dental visits among high school students vary by age or grade?

## Utility

The Youth Risk behavior survey offers state-level detail and occasionally school district-level detail of older public-school children. The wealth of other behavioral questions asked in the survey makes it possible to study correlations of dental visit behavior with other types of behaviors.

## Orientation & Stewardship  

YRBS is designed by the CDC and conducted in collaboration with states, school districts, and territories. Consolidated datasets are published on the [CDC YRBS website](https://www.cdc.gov/healthyyouth/data/yrbs/data.htm) every other year for national, state, and school district levels. The complex sample design requires statistical software for analysis. The [CDC's YRBS Explorer"](https://yrbs-explorer.services.cdc.gov/#/) tool computes some of the statistics for users automatically, providing population stratifications for a limited set of measures.

The YRBS explorer was used to obtain YRBS data for the National Oral Health Data Portal project. Data were downloaded in December 2020.

The CDC suggests the following citation when using the YRBS Explorer:
> Centers for Disease Control and Prevention (CDC). 1991-2019 High School Youth Risk Behavior Survey Data. Available at http://yrbs-explorer.services.cdc.gov/. Accessed on [date]


## Data Structure

The YRBS Explorer was used to obtain data tables for each race, grade, and year when available. The button for downloading state grade data was used to obtain a separate CSV for each year of data, which was manually combined together. The download button for race was not working, so data were copied out of the browser and compiled manually.

The following files are located in this Github repository folder:

* **YRBS_CDC_Query.csv**. Each row is a unique year-measure-geography. 

* **YRBS_CDC_Query_CI.csv**. Each row is a unique measure-geography-confidence bound. This file has been unpivoted such that an upper and lower 95% confidence interval is given for each year-measure-state. This file can be joined to the **YRBS_CDC_Query.csv** table in visualization or statistical software to help show confidence intervals. An "Order" column provides a sequence of numbers that visualization software could use to 'connect the dots' and draw a confidence line or polygon.

## Issues & decisions

The project may wish to go into raw YRBS files to obtain more population stratifications. To increase sample sizes for states or school districts that are otherwise suppressed, we could perhaps group multiple reporting years together.

## Tableu Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/ASTDDCOVID-19StateImpactDashboard/Orientation).

The current Tableau viz is presented as four dashboards. Two cover school district data and two cover state level data. For each geographic level there is a dashboard comparing different geographics and a dashboard showing details within a geography.

In the bottom left corner of both geographic comparison dashboards is a trend graph that appears once a user clicks on a geography from the dashboard.

## Status & Next Steps

Consider going into the raw files to group years together or expand population stratifications. This could help bring confidence intervals down.
