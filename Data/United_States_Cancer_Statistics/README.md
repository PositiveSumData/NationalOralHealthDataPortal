# Centers for Disease Control & Prevention United States Cancer Statistics 

The United States Cancer Statistics program at the CDC provides national, state, and county-level incidence and mortality of many types of cancers, including oral and pharyngeal cancer.

## Examples of questions this dataset could help answer

* Is the incidence of oral or pharyngeal cancer higher in Lake or Cook counties in Illinois?
* Which state has the highest mortality from oral or pharyngeal cancer? 
* Are men or women more likely to have died from oral or pharyngeal cancer in Utah for 2013-2017?

## Utility

The United States Cancer Statistics ("UCS") program aggregates cancer data from several projects like the national SEER program and individual state-based cancer surveillance registries. It provides standardized data tables that allows comparisons across geographies.

## Orientation & Stewardship  

The CDC provides several ways to view or receive United States cancer data. The simplest method is a [dataviz tool](https://www.cdc.gov/cancer/uscs/dataviz/index.htm) for viewing quick maps. The do-it-yourself method involves requesting [raw data](https://seer.cancer.gov/data/access.html) in the SEER registry. In our case we used [pre-analyzed data tables](https://www.cdc.gov/cancer/uscs/dataviz/download_data.htm) where all the measures are already calculated in a delimited ASCII file.

#### Data Use

The following disclaimer is posted on the [USCS Download Tables webpage](https://www.cdc.gov/cancer/uscs/dataviz/download_data.htm):

> These data are provided for statistical reporting and analysis purposes only.
> CDC’s Policy on Releasing and Sharing Data prohibits linking these data with other data sets or information for the purpose of identifying an individual.
> All material in the reports are in the public domain and may be reproduced or copied without permission. However, a citation is requested.

## Original Data Structure

By downloading the 1999-2017 zip file, users receive 11 pipe-delimited text files covering different aggregations by age, sex, geography, and cancer type. The typical format is for each row to be a unique state-race-age-cancer_type-measure. Adjusted and un-adjusted rates are in separate columns and must be unpivoted manually.

Estimates are given for each year going back to 1999. Estimates are also given for some grouped years, like 2013-2017, which helps reduce the width of confidence intervals.

## Converted Data Structure

We take data from three of the zipped text files:
* **BYSITE.TXT**. Provides national estimates.
* **BYAREA_COUNTY.TXT**. Provides county estimates.
* **BYAREA.TXT**. Provides state estimates.

Using statistical software, we modify each file and aggregate them together. We unpivot the adjusted and unadjusted columns so that there is just one column describing the adjustment used. Then we save a version that contains all the estimates (SEER_prime.csv) and a file containing the 95% confidence intervals unpivoted such that the upper and lower confidence intervals each get their own row for each state-race-sex-measure-adjustment. 

Our **SEER_CI.csv** was too large to save in this repository so it has been saved in a [Google Drive folder](https://drive.google.com/file/d/1HURIwjabAUeyVWq7K9LHXR4iVyj2-qvw/view?usp=sharing).

## Issues & decisions

We decided not to present a time-series in Tableau. The confidence intervals seem quite wide, even for the combined 2013-2017 estimates, so it may not be that helpful to see individual year data. Instead, only the grouped 2013-2017 estimates are shown.

Most United States counties are not included in the county-level dataset because of data. But we show counties that do have data on a map.

## Code

The R code **CANCER_master.R** found in this GitHub repository folder takes in three USCS text files and outputs the two CSVs described above.

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/UnitedStatesCancerStatisticsOralPharyngealCancer/Orientation).

The Tableau presentation has three tabs: 

* States Comparison
* Counties Comparison
* Race / Sex Comparison


