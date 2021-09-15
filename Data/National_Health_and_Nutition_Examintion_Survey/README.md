# CDC National Health & Nutrition Examination Survey (NHANES) via CDC Oral Health Surveillance Reports

The CDC periodically releases a report of national oral health status trends. In [2019 a report](https://www.cdc.gov/oralhealth/publications/OHSR-2019-list-of-tables.html) titled "Trends in dental caries and sealants, tooth retention, and edentulism, United States 1999-2004 to 2011-206 was released, updating the previous [2007 report](https://www.cdc.gov/nchs/data/series/sr_11/sr11_248.pdf) titled "Trends in oral health status: United States, 1988-1994 and 1999-2004". Both reports use the National Health & Nutrition Examination Survey (NHANES) as the primary dataset. For the Oral Health Data Portal project, both reports have been combined to present trends across the three time periods: 1988-1994, 1999-2004, 2011-2016.

## Utility

NHANES is the primary survey for understanding oral health status in the United States. Dentists join CDC-led NHANES mobile screening units, collecting oral health status information on participants after reviewing their dentition. Since the survey is part of the wider NHANES project, hundreds of variables are also collected about participants lifestyles, health behaviors, and demographic characteristics. The CDC Oral Health Surveillance reports do not present every possible oral health status indicator or stratify by every possible population characteristic within NHANES, but the amount of detail is still very helpful in understanding trends in the country's oral health.  

### Example questions the 2019 Surveillance Report can help answer

* What is the prevalence of edentulism among American adults over the age of 65?
* Are there differences in caries prevalence among young children by race and ethnicity?
* Has the mean number of dental sealants per child who has dental sealants changed since the 1990s?
* Which types of teeth are most likely to be decayed, missing, or filled, given that a person has any decayed, missing, or filled teeth?

## Orientation & Stewardship  

The 2019 CDC Oral Health Surveillance Report presents some, but not all of the oral health measures that are available within the greater NHANES survey. The report focuses on prevalence indicators and counts of dental sealants or decayed, missing, or filled teeth. Researchers may be able to answer more oral health questions by going directly to the CDC NHANES dataset and performing their own analysis. The 2007 Oral Health Surveillance Report hints at some of the additional analyses that may be available, as the older report contains many more data tables and measures. 

For the National Oral Health Data portal project, data from the 2007 and 2019 reports were combined to be able to add another time point. The earlier report covered two time points: 1988-1994 and 1999-2004. The later report also covered 1999-2004 but added 2011-2016. All data points from the 2007 report were kept. Only the 1988-1994 data points were kept from the 2007 report to avoid data duplication for 1999-2004. While all tables from 2019 were kept, only tables that were comparable to 2019 were kept from 2007. 

The 36 tables in the 2019 report and the comparable 2007 tables were consolidated into one single CSV file to allow for more complex analysis and data visualization than is be possible from any of the single tables.  

## Citation
The NHANES data in the National Oral Health Data Portal comes from tables in either the 2007 or 2019 CDC reports. Raw NHANES dataset was not used. The 2019 report suggests the following citation:

> Centers for Disease Control and Prevention. Oral Health Surveillance Report: Trends in Dental Caries and Sealants, Tooth Retention, and Edentulism, United States, 1999–2004 to 2011–2016. Atlanta, GA: Centers for Disease Control and Prevention, US Dept of Health and Human Services; 2019.


### Original Data Structure

Two types of measures have been gathered from the 2019 report: prevalence and counts. The prevalence measures are percentages indicating how many people out of 100 have each condition (caries, dental sealants, edentulism, or untreated decay). Count measures give the number of sealed teeth or number of decayed/missing/filled teeth of people. A third type of measure was reported in the original 2017 report that was not copied into the National Oral Health Data Portal: "Mean percentage contribution of untreated decayed (% dt/dft) or filled (% ft/dft) primary teeth." 

Not all measures were reported for each age group. For example, there are no edentulism measures for children, and no dental sealant measures for older adults.

Measures in the report were stratified by the following population characteristics: total, sex (male, female), race and ethnicity (White, non-Hispanic; Black, non-Hispanic; Mexican American), poverty status (< 200% FPL, >= 200% FPL), and poverty status (<100% FPL, 100-199% FPL, >=200% FPL). Two additional categories were included for adult populations: education (< high school, high school, > high school) and cigarette smoking history (current smoker, former smoker, never smoked). 

In the Tableau data visualizations of these data tables for the National Oral Health Data Portal, only the two-level poverty status variable was presented. The three-level poverty status variable tended to have wide confidence intervals and so was hidden to make the presentation cleaner. 

### Consolidated file

The various tables from the CDC report have been consolidated into one main CSV file named **cdc_surveillance_prime.csv** with the following variable structure:

* **data_id**. A unique number assigned to each row in the consolidated file. It's used so that when a separate confidence-interval CSV is generated to be able to visualize confidence intervals, Tableau knows how to join the two CSVs together. 
* **table_2019_benchmark**. The table number from the 2019 report, or the table from 2019 that the earlier 2007 report corresponds to. For example, table 10 ("t10") from 2007 corresponds to table 9 ("t09") in 2019. Both are listed as "t09" in this column.
* **table_actual**. The actual table name in either of the reports. Using the example above, the value would be "t10" for 2007 and "t09" for 2019.
* **base_population**. The age group for each table section in the report. The base populations are: 2-5, 6-8, 6-11, 12-19, 20-64, 65+.
* **ages**. The specific ages for each row. While the report includes the base populations listed above, it also breaks out some of these base populations by sub-ages. For example, within a data table for the 12-19 base population, data are shown broken out by ages 12-15 and 16-19. Only the overall prevalence is given for these narrower ages; race and ethnicity are not given, likely because of statistical power. 
* **ages_min**. When ages are given as a range, this column gives the minimum value of that range. For example, if the range is 12-15, then the value in this column is 12. This is used to help generate a confidence interval CSV for Tableau order the data by ascending age. It needs a numerical variable (12) instead of a character variable ("12-15").
* **indicator_specific**. The full name of the indicator as per the CDC report.
* **indicator_abbr**. A hyper-abbreviated label for each indicator that may be appropriate for labeling charts or used in dashboard filters.
* **indicator_short**. A shortened version of the indicator more appropriate for including in a dashboard.
* **tooth_location**. The type of tooth being measured: anteriors, first molars, second molars, etc...
* **dentition_set**. Primary or secondary teeth.
* **category**. The population category. If none, then 'total' is assigned. Otherwise, options are race and ethnicity, poverty status (2 levels), poverty status (3 levels), etc...
* **subcategory**. The specific type of population within each category. Like "Black, non-Hispanic" within the "race and ethnicity" category.
* **years**. One of the three time points in the reports: 1988-1994, 1999-2004, 2011-2016.
* **statistic**. The way each indicator is measured. The options are mean or percent.
* **estimate_value**. The number corresponding to each indicator.
* **estimate_SE**. The standard error corresponding to each indicator.
* **lower_CI**. The lower 95% confidence interval.
* **upper_CI**. The upper 95% confidence interval.

A second CSV named **cdc_surveillance_CI.csv** contains confidence interval data from the **prime** file un-pivoted such that there are two rows for every estimate in **prime**: a lower and upper 95% confidence interval. This file is used to help Tableau display confidence intervals and is joined to the **prime** file. An 'order' column is also added to this confidence interval file to aid Tableau in drawing points.

### Standard Errors & 95% Confidence Intervals

Standard errors for each estimate were provided in each report. Ninety-five percent confidence intervals were generated manually by adding and subtracting 1.96 times the standard. If intervals dipped below zero or above 1, values were recoded as zero or 1. 

### Censoring or Missing Values

The CDC reports censored estimates when confidence intervals were exceptionally wide, reporting the value "NR". In the consolidated file, "NR" was replaced with an empty cell. So, while it appears data is missing, it is rather 'not reported.'  

## Issues, Decisions, and Modifications
The indicator "Mean percentage contribution of untreated decayed (% dt/dft) or filled (% ft/dft) primary teeth" was not included in the consolidated file. When this indicator was reported in tables within the 2019 report, it was broken out by % decayed teeth or % filled teeth, but not by % missing teeth. Since "missing" teeth was omitted, a user would not be able to stack the precents on top of each other to see the percent overall. If a user did want to do this, it would be possible to calculate these indicators directly from data in other tables. Stacked area charts were used in the Tableau dashboard to show the different contributions of each type of tooth status to overall DMFT. These percent did not always sum to 100% because of rounding within the reports themselves.

## Code
The consolidated CSV file was compiled manually by copy-pasting data from the original CDC reports and then manipulating with Excel. Code was not used to generate the consolidate file, but code was used to create a secondary consolidated file that prepares confidence intervals in a structure that Tableau can use for drawing polygons. This file is available [here](https://raw.githubusercontent.com/PositiveSumData/NationalOralHealthDataPortal/master/Surveillance%20%26%20Reports/cdc_surveillance_pivoting.R). 

## Data Tables
The consolidated data file lives in [this](https://github.com/PositiveSumData/NationalOralHealthDataPortal/tree/master/Data/National_Health_and_Nutition_Examintion_Surveyy) Github folder.

## Tableau Viz

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/NationalHealthNutritionExaminationSurveyNHANES/Orientation
).

The Tableau viz contains 3 'stories' consisting of several dashboards each:

* **Prevalence Measures**. For percentage rates of oral health conditions per population.

* **Decayed, Missing, Filled Teeth**. For NHANES measures pertaining to the number of teeth with different conditions per person with any conditions.

* **Sealed Teeth**. For NHANES measures pertaining to the number of sealed teeth in people.


## Project Status & Next Steps

A more comprehensive analysis of oral health measures could be conducted with an original analysis using raw NHANES data.
