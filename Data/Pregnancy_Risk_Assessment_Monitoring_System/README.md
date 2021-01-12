# Pregnancy Risk Assessment Monitoring System

The [Pregnancy Risk Monitoring System (PRAMS)](https://www.cdc.gov/prams/index.htm) is a CDC-shepherded, state-administered, biennial state-administered survey of pregnant or recently pregnant individuals' health attitudes and behaviors, covering several oral health topics.

## Examples of questions this dataset could help answer

* What percent of pregnant people in Missouri reported difficulty getting dental care during their pregnancy?
* Were certain races or ethnicities in Tennessee more likely having had insurance to cover the cost of their pregnancies?
* Are people more likely to have had their teeth cleaned before their pregnancy than they are during their pregnancy?
* Has the percent of people who had their teeth cleaned before their pregnancy in South Dakota changed over time?

## Utility

PRAMS provides state-level data about oral health attitudes and service utilization for a a population group not covered by many other data sources. It asks more oral health questions than the other CDC surveys like the Behavior Risk Factor Surveillance System or the Youth Risk Behavior Survey.

## Orientation & Stewardship  

The PRAMS survey is designed by the Centers for Disease Control and Prevention and administered by states. States collect the data and contribute it to a national database [accessible to researchers](https://www.cdc.gov/prams/prams-data/researchers.htm) pending approved requests to the CDC. States may append their surveys with additional questions that may or may not become included in the national database. 

The dataset is part of a complex survey design that requires statistical software to analyze. Periodic [pre-analyzed reports](https://www.cdc.gov/prams/prams-data/mch-indicators.html) are published so interested people can monitor PRAMS indicators without data requests.

## Raw Data Structure
The National Oral Health Data Portal Project has submitted a data request to the CDC for a long list of state indicators over time. While the request is being processed, the more limited pre-analyzed reports are included in this project. Two reports have been consolidated:

* **[Selected 2016 thorugh 2017 Maternal and Child Health (MCH) Indicators]**(https://www.cdc.gov/prams/prams-data/mch-indicators.html). Includes the indicator [teeth cleaned during pregnancy by a dentist or dental hygienist].

* **[Selected 2012 through 2015 Maternal and Child Health (MCH) Indicators by State]**(https://www.cdc.gov/prams/prams-data/2015-mch-indicators.html). Include indicators [teeth cleaned during 12 months before pregnancy], [teeth cleaned during pregnancy], and [had dental insurance during pregnancy].


Questions available in the full research dataset include:
* Y2 | Have you ever had your teeth cleaned by a dentist or dental hygienist?
  * No
  * Yes

* Y3 | Since your new baby was born, have you had your teeth cleaned by a dentist or dental hygienist?
  * No
  * Yes

* Y5 | During your most recent pregnancy, what kind of problem did you have with your teeth or gums? For each item, check No if you did not have this problem during pregnancy or Yes if you did:
  * I had cavities that needed to be filled 
  * I had painful, red, or swollen gums
  * I had a toothache 
  * I needed to have a tooth pulled
  * I had an injury to my mouth, teeth ,or gums 
  * I had some other problem with my teeth or gums

* Y6 | Did any of the following things make it hard for you to go to a dentist or dental clinic during your most recent pregnancy?  For each item, check No if it was not something that made it hard for you or Yes if it was:
  * I could not find a dentist or dental clinic that would take pregnant patients
  * I could not find a dentist or dental clinic that would take Medicaid patients
  * I did not think it was safe to go to the dentist during pregnancy
  * I could not afford to go to the dentist or dental clinic
  
* Y7 | This question is about other care of your teeth during your most recent pregnancy. For each item, check No if it is not true or does not apply to you or Yes if it is true:
  * I knew it was important to care for my teeth and gums during my pregnancy
  * A dental or other health care worker talked with me about how to care for my teeth and gums 
  * I had insurance to cover dental care during my pregnancy
  * I needed to see a dentist for a problem 
  * I went to a dentist or dental clinic about a problem 
  
* Y8 | Did you get treatment from a dentist or another doctor for the problem that you were having during your pregnancy? Check ONE answer:
  * No
  * Yes, I got treatment during my pregnancy
  *  Yes, I got treatment after my pregnancy
  * Yes, I got treatment both during and after my pregnancy
  
## Consolidated Data Structure

Two files have been produced by consolidating the pre-analyzed reports from the CDC PRAMS website described above:

* **PRAMS.csv**. Each row is a unique state-measure-year, providing the estimates and confidence intervals.

* **PRAMS_CI.csv**. Twice as long as the PRAMS.csv file above, this file has been unpivoted such that an upper and lower 95% confidence interval is given for each year-measure-state. This file can be used by visualiation software to help show confidence intervals.  An "Order" column provides a sequence of numbers that visualization software could use to 'connect the dots' and draw a confidence line or polygon.

## Code

The file **PRAMS_CI_pivot_r_code.R** is available in this Github Repository folder. It takes in the PRAMS.csv file and outputs the PRAMS_CI.csv file.

## Issues & decisions

Language used in any Tableau visualizations has modified gendered terms like 'women' or 'mothers' to non-gendered terms like 'people' to be more inclusive of all populations.

Not all states have estimates in the reports used in the National Oral Health Data Portal thus far. These are reflected as missing in the Tableau dashboards. 

## Tableau Presentation

The current Tableau viz contains three dashboards:

* **National Dashboard**. 
* **State Details**. 
* **States Trend**. 

## Status & Next Steps

The PRAMS project will be updated pending the data request open with the CDC.

