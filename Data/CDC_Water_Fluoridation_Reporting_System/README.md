# Centers for Disease Control & Prevention Water Fluoridation Reporting System

Many states participate in the CDC's Water Fluoridation reporting System (WFRS), providing community-level counts of people using public water systems and the fluoridation levels of those systems. 

## Examples of questions this dataset could help answer

* Which New Hampshire counties have the highest percentage of people on adequately flouridated community water systems?
* What percent of people in Indiana are on adquately fluoridate community water systems?
* Which states have the highest rates of people with adequately fluoridated community water systems?

## Utility

This is the only national dataset containing state and community level fluoridation data.

## Orientation & Stewardship  

The [Water Fluoridation Reporting System](https://www.cdc.gov/fluoridation/data-tools/reporting-system.html) is maintained by the CDC based on reports periodically sent to them by individual states. The public may access the data through the [CDC's My Water's Fluoride microsite](https://nccd.cdc.gov/DOH_MWF/Default/Default.aspx). 



#### Data Use

The My Water's Fluoride 'About' page suggests the following citation:

> Division of Oral Health: My Water's Fluoride web application. U.S. Department of Health and Human Services, Centers for Disease Control and Prevention (CDC), National Center for Chronic Disease Prevention and Health Promotion, Atlanta, GA, 2016. Available at http://www.cdc.gov/oralhealth/.

They include this paragraph for more information:

> For information about the content presented by MWF, please contact your state’s oral health program. Find your state’s oral health program at the Association of State and Territorial Dental Programs. The information presented in MWF is provided by each State’s oral health program and represents the most recent data update provided by the State.

## Original Data Structure

Detailed community data is found on the microsite by by navigating to the [State Fluoridation Reports page](https://nccd.cdc.gov/DOH_MWF/Reports/Default.aspx). From here select a state and then click "Fluoridation Status Report" to reach a detailed data table. The table is formatted as follows with sample data from Iowa:

| PWS ID | PWS Name | County | Population Served | Fluoridated | Fluoride Conc. |
| ------ | -------- | ------ | ----------------- | ----------- | -------------- |
| IA-0105002 | Adair Municipal Water Supply | Adair (Primary) | 781 | No | 0.45 |
| IA-0135046 | Fontanelle Water Works | Adair (Primary) | 742 | Yes | 0.70 |

Each row is a unique year-water system. There are multiple row per county. These tables may be downloaded manually as an Excel file with the **Export** link. 

The year of the fluoridation report reflects year from which the data was pulled from the WFRS database, not the year for which the data was submitted. The year of data submission is not shown and can be many years old

The CDC courteously provided a separate file for us in the Fall of 2020 containing the date of last data update so that dataviz users could filter data based on how recent the data is. This file, titled **WFRS_update_status.csv** is located in this Github repository folder.

## Converted Data Structure

In the Summer of 2020, reports for each state were dowloaded from MyWatersFluoride and aggregated manually into the file **fluoride_1.csv**, located in this Github repository folder. The same structure was maintained from what was downloaded from the CDC microsite.

## Issues & decisions

A threshold of 0.7 mg/L was used to mark the fluoridation adequacy of community water systems based on recommendations from the [Public Health Service](https://www.cdc.gov/fluoridation/faqs/public-service-recommendations.html).

It's great that we get community-level data with this dataset. If shapefiles can be located to map all these water systems, we could create some very detailed maps. Until then, we limit our dataviz presentations to the state and county levels.

Many states do not report to WFRS, so their data is not presented in the Tableau vizzes.

The oldest data that we downloaded in the WFRS system comes from 2011 (Arizona, Wyoming, and Wasington DC). Feeling this might be too old for surveillance and policy-making, we felt we needed a cut-off date to show in the Tableau vizzes. We chose Jan 18, 2016, marking approximately 5 years old.

## Code

No code was needed to process or calculate data.

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/CDCWaterFluoridationReportingSystem_16086462873310/Orientation).

Three dashboards are presented:

* **State Comparison**. 

* **County Comparison**. To show county-level aggregations. 

* **Date Data Last Updated**. To show the recency of data updates.

## Status & Next Steps

New data will need to be downloaded periodically fron the CDC My Water's Fluoride Page, and periodically-refreshed 'update status' data from the CDC would be very helpful.
