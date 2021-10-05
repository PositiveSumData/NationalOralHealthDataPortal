# Pregnancy Risk Assessment Monitoring System

The [Pregnancy Risk Monitoring System (PRAMS)](https://www.cdc.gov/prams/index.htm) is a CDC-stwearded, state-administered, biennial state-administered survey of people in states who recently had a live birth. It gathers inforamtion about health attitudes and behaviors that covering several oral health topics.

## Examples of questions this dataset could help answer

* What percent of pregnant people in Missouri reported difficulty getting dental care during their pregnancy?
* Were certain races or ethnicities in Tennessee more likely to have had insurance to cover the cost of their pregnancies?
* Are people more likely to have had their teeth cleaned before their pregnancy than they are during their pregnancy?
* Has the percent of people who had their teeth cleaned before their pregnancy in South Dakota changed over time?
* In which states do most people with a recent live birth report having had insurance to cover the cost of dental care during their pregnancy?

## Utility

PRAMS provides state-level data about oral health attitudes and service utilization for a a population group not covered by many other data sources. It asks more oral health questions than the other CDC surveys like the Behavior Risk Factor Surveillance System or the Youth Risk Behavior Survey.

## Orientation & Stewardship  

The PRAMS survey is designed by the Centers for Disease Control and Prevention and administered by states. States collect the data and contribute it to a national database [accessible to researchers](https://www.cdc.gov/prams/prams-data/researchers.htm) pending approved requests to the CDC. States may append their surveys with additional questions that may or may not become included in the national database. 

The dataset is part of a complex survey design that requires statistical software to analyze. Periodic [pre-analyzed reports](https://www.cdc.gov/prams/prams-data/mch-indicators.html) are published so interested people can monitor PRAMS indicators without data requests. For the data portal project, Positive Sum Health Informatics requested access to raw data files to be able to report more indicator estimates with more population stratifications. Access was granted in early 2021. The data tables and data visualizations generated from the analysis are currently under review by the PRAMS workgroup. Therefore these analyses cannot yet be shared publicly and should not be cited.

### Citation

This presentation of PRAMS data was made possible because of data released by the PRAMS Workgroup. The workgroup consists of representatives of the state PRAMS teams that submit their data to the CDC for aggregating into research tables.    

## Questionnaire
Positive Sum requested data pertaining to Phase 8, the most recent phase of the PRAMS survey. A new phase demarcates when questions may be have been updated to improve the quality of the survey, although this can make it difficult to compare data across phases. 

The Phase 8 core PRAMS survey, which all participating states use, asks two oral health related questions: did the person received dental care before pregnancy, and did they receive dental care during pregnancy. 

Outside of the core questions, it is up to each state to decide which additional questions they will adopt from the pool of questions the CDC has prepared. The available options are:

* Since your new baby was born, have you had your teeth cleaned by a dentist or dental hygienist?
* During your most recent pregnancy, what kind of problem did you have with your teeth or gums? For each item, check No if you did not have this problem during pregnancy or Yes if you did.
* Did any of the following things make it hard for you to go to a dentist or dental clinic during your most recent pregnancy?
* This question is about the other care of your teeth during your most recent pregnancy.
* Did you get treatment from a dentist or another doctor for the problem that you were having during your pregnancy

Florida has a special question on they use: During your most recent pregnancy, did a doctor, nurse, or other health care worker do any of the things listed below?. And Maine has a question only they use: Do you have any insurance that pays for some or all of your dental care?

The file **variables_tracker** located in this repository has been generated to more easily outline which states asked which questions in Phase 8, what the possible responses were, and how these correspond to variables in the raw data file. 

## Raw Data Structure
The CDC PRAMS team provided Positive Sum Health Informatics with a single SAS file containing the datapoints necessary for conducting our analysis. Each row in the dataset corresponds to a unique responder. All of that person's responses to PRAMS survey questions are encoded numerical values across 460 columns. Cluster and strata variables are used to account for complex sample design. 

Since the PRAMS survey is mostly multiple-choice, each possible answer in the raw data is encoded as a number. To decipher what answer the number corresponds to, several PDF manuals were provided to Positive Sum Health Informatics (included in this repository):

* **Core P9 Questionnaire Analytic Codebook** & **PRAMS Research Dataset Codebook**. The keys for the variables inlcuded in the standard questionnaire. 
* **PRAMS Phase 8 Standard Section Y Codebook***. The codebook for specific oral health questions not part of the core questionnaire. 

For an exmaple of how to read these keys, take the variable MAT_ED, which pertains to the amount of maternal education. The raw dataset contains 5 possible responses, labelled 1-5. By reading the manuals, we learn that number 2 corresponds to "9-11 years" and number 3 corresponds to "12 years".

Positive Sum transcribed these codebooks into spreadsheets to be read into R code to generate a fully-labelled data file. These spreadsheets are named as follows (and attached to this repository):

* **group_subgroup_variables**. This spreadsheet can be joined to the raw dataset using *group_variable_original* and *subgroup_value*. 
* **indicator_variables**. This spreadsheet can be joined ot the raw dataset using *indicator_variable_original* and *indicator_value_number*. In additional to including labels to decipher the indicator variables in the raw data, this spreadsheet categorizes indicators into groups, explains the survey question where the variable came from, and translates the responses into desired directionality. For example, the if DDS_GUM = 2, this means *had painful, red, or swollen gums" and higher values of this are not desired. If DDS_GUM = 1, this means "did not have painfrul, red, or swollen gums" and higher values are desired.



## Consolidated Data Structure

Two files have been produced by consolidating the pre-analyzed reports from the CDC PRAMS website described above:

* **PRAMS.csv**. Each row is a unique state-measure-year-direction, providing the estimates and confidence intervals.

| field | description |
| ----- | ----------- |
| geography | the state unit |
| custom_variable | the name of the variable in the raw data or a custom name if it was created as a composite variable |
| category_sample_size_unweighted | the total number of people who answered the question in any direction (yes or no), not taking into account the sample design |
| total_unweighted | the number of people responding to the question within the survey in that particular direction (yes or no), not taking into account the sample design |
| proportion | the estimate, as accounting for the survey design |
| prop_lowerCI | the lower 95% confidence interval of the estimate |
| prop_upperCI | the upper 95% confidence interval of the estimate |
| total | the total number of people in the group-subgroup giving the indicator response, exptrapolated to the population level |
| p_value | the p value associated with a chi square test of significant differences among estimates within the same state-group-subgroup-indicator. The p value will repeat among all lines within this same grouping  |
| significance | an interpretation of the p value at the 95% confidence level | 
| group | the population group label. e.g. maternal age or race/ethnicity |
| subgroup | the population subgroup. e.g. which maternal age or which race/ethnicity |
| variable_origin | whether the indicator was based entirely from a single variable in the raw data divided by the survey population, or if there was some sort of question logic or denominator restriction used |
| indicator_category | logical groupings of indicator variables as decided by Positive Sum | 
| Denominator | the population included in the indicator denominator. Most will be "people of child-bearing age with a live birth" but some are more restricted if they used question logic |
| indicator_general | the indicator expressed as a general category, without directionality. See indicator_specific to name the indicator re-written with a direction (either deisred or undesired) |
| indicator_question_number | which survey question(s) the indicator was generated from |
| before_during_after_pregnancy | the time period for which the indicator applies. Possible values are before; during; after; during or after | 
| indicator_value_label | the response the survey question as "yes" or "no" |
| numerator| a shortened label for the oral health indicator indicator |
| indicator_specific |  a longer, more description label for the oral health indicator |
| desired_direction | possible values are desired or undesired. These correspond to the two directional versions of each indicator |
| PRAMS_id | used to join the PRAMS.csv file to the PRAMS_CI.csv file. |


* **PRAMS_CI.csv**. Twice as long as the PRAMS.csv file above, this file has been unpivoted such that an upper and lower 95% confidence interval is given for each year-measure-state. This file can be used by visualiation software to help show confidence intervals.  An "Order" column provides a sequence of numbers that visualization software could use to 'connect the dots' and draw a confidence line or polygon.

## Code

The file **PRAMS_r_code_2j.R** is available in this Github repository folder. It takes in the raw PRAMS data file and several reference spreadsheets file and outputs the PRAMS_prime.csv and PRAMS_CI.csv files.

## Issues & Decisions

Estimates are calculated as the number of yes's (or the number of no's) divided by the total number of people answering the question. Missing or "unsure" respones were excluded in accordance with the measure criteria of most COHSII indicators.

The language used in any Tableau visualizations has modified gendered terms like 'women' or 'mothers' to non-gendered terms like 'people' to be more inclusive of all populations.

Not all states participate in PRAMS or ask the majority of PRAMS oral health questions. This means calculating "national estimates" is not appropriate from the PRAMS raw data. Rather, we can published estimatse for "all states" that do report for a given question. When comparing across aggregated "all site" estimates, it will be important to know if the the number of states in the denominators is the same. For example, the estimate of one "all sites" indicator may be generated based on 30 states, while another "all sites" indicator is based on data from just 6 states. 

Estimates for which there were 10 or fewer people in the denominator have been filtered out of the aggregated data tables. If other estimates still have wide confidence intervals, we have not suppressed them. Rather it will be up to the user to correctly interpret what the width of confidence intervals might mean in the context of their question. 

P values are included in the data tables, but not in the Tableau Workbook. The P values correspond to the chi-square test of significance for an estimate within the state-group-subgroup. A significance column interprets the p value as signficant or not significant at the 95% confidence interval. We present these data points to assist users in interpreting the information, but we caution that p values alone may not be sufficient in drawing insights from the data.

## Tableau Presentation

The Tableau workbook for this dataset will be linked to here when the presetnation has been approved by the PRAMS workgroup.

The current Tableau viz contains three dashboards:

* **Orientation**. A slide deck walking users through important aspects of the dataset so they can better interact with the other dashboards.
* **States Comparison Dashboard**. A snapshot of all states performances on a seleted indicator and population subgroup.
* **States Indicators Dashboard**. A presentation of a state's performance across many indictors for a single selected population group-subgroup.
* **State Populations Dashboard**. A presentation of a state's performance on a selected indicator across all population groups and subgroups.
* **Insights**. High-level observations focusing on Medicaid populations across all sites.

