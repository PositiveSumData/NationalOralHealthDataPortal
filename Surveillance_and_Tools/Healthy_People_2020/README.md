# Healthy People 2020



## Examples of questions this dataset could help answer


## Utility


## Data Stewardship  

Healthy People is a national health target-setting and progress monitoring project lead by the U.S. Department of Health and Human Services. At the close of each decade, national stakeholders determine the country's health priorities and what meaningful improvements could be made by the end of the following decade. Healthy People 2020 launched in 2010 with the following 33 oral health objectives: 

| objective # | objective description |
| ----------- | --------------------- |
| OH 1.1 | Reduce the proportion of children aged 3 to 5 years with dental caries experience in their primary teeth | 
| OH 1.2 | Reduce the proportion of children aged 6 to 9 years with dental caries experience in their primary or permanent teeth |
| OH 1.3 | Reduce the proportion of adolescents aged 13 to 15 years with dental caries experience in their permanent teeth |
directed by a dental professional with public health training |
| OH 2.1 | Reduce the proportion of children aged 3 to 5 years with untreated dental decay in their primary teeth | 
| OH 2.2 | Reduce the proportion of children aged 6 to 9 years with untreated dental decay in their primary or permanent teeth | 
| OH 2.3 | Reduce the proportion of adolescents aged 13 to 15 years with untreated dental decay in their permanent teeth |
| OH 3.1 | Reduce the proportion of adults aged 35 to 44 years with untreated dental decay |
| OH 3.2 | Reduce the proportion of adults aged 65 to 74 years with untreated coronal caries |
| OH 3.3 | Reduce the proportion of adults aged 75 years and older with untreated root surface caries | 
| OH 4.1 | Reduce the proportion of adults aged 45 to 64 years who have ever had a permanent tooth extracted because of dental caries or periodontal disease |
| OH 4.2 | Reduce the proportion of adults aged 65 to 74 years who have lost all of their natural teeth |
| OH 5 | Reduce the proportion of adults aged 45 to 74 years with moderate or severe periodontitis |
| OH 6 | Increase the proportion of oral and pharyngeal cancers detected at the earliest stage |
| OH 7 | Increase the proportion of children, adolescents, and adults who used the oral health care system in the past year | 
| OH 8 | Increase the proportion of low-income children and adolescents who received any preventive dental service during the past year |
| OH 9.1 | Increase the proportion of school-based health centers with an oral health component that includes dental sealants | 
| OH 9.2 | Increase the proportion of school-based health centers with an oral health component that includes dental care |
| OH 9.3 | Increase the proportion of school-based health centers with an oral health component that includes topical fluoride | 
| OH 10.1 | Increase the proportion of Federally Qualified Health Centers (FQHCs) that have an oral health care program |
| OH 10.2 | Increase the proportion of local health departments that have oral health prevention or care programs |
| OH 11 | Increase the proportion of patients who receive oral health services at Federally Qualified Health Centers (FQHCs) each year | 
| OH 12.1 | Increase the proportion of children aged 3 to 5 years who have received dental sealants on one or more of their primary molar teeth |
| OH 12.2 | Increase the proportion of children aged 6 to 9 years who have received dental sealants on one or more of their permanent first molar teeth | 
| OH 12.3 | Increase the proportion of adolescents aged 13 to 15 years who have received dental sealants on one or more of their permanent molar teeth |
| OH 13 | Increase the proportion of the U.S. population served by community water systems with optimally fluoridated water |
| OH 14.1 | Increase the proportion of adults who received information from a dentist or dental hygienist focusing on reducing tobacco use or on smoking cessation in the past year | 
| OH 14.2 | Increase the proportion of adults who received an oral and pharyngeal cancer screening from a dentist or dental hygienist in the past year |
| OH 14.3 | Increase the proportion of adults who were tested or referred for glycemic control from a dentist or dental hygienist in the past year |
| OH 15.1 | Increase the number of States and the District of Columbia that have a system for recording cleft lips and cleft palates |
| OH 15.2 | Increase the number of States and the District of Columbia that have a system for referral for cleft lips and cleft palates to rehabilitative teams | 
| OH 16 | Increase the number of States and the District of Columbia that have an oral and craniofacial health surveillance system |
| OH 17.1 | Increase the proportion of States (including the District of Columbia) and local health agencies that serve jurisdictions of 250,000 or more persons with a dental public health program directed by a dental professional with public health training | 
| OH 17.2 | Increase the number of Indian Health Service Areas and Tribal health programs that serve jurisdictions of 30,000 or more persons with a dental public health program 

Objectives were chosed that had reliable national datasets that could monitor achievement. State targets were not set, and most of the datasets used in HP 2020 do not have state breakouts. For example, the National Health & Nutrition Examination Survey (NHANES) doesn't have a large enough sample size to permit state-level reporting.

## Original Data Structures

HP 2020 oral health objectives, baselines, progress, and targets are shown on the HP 2020 website, which allows a user to [query](https://www.healthypeople.gov/2020/data-search/) for the oral health topic. Once the oral health topic is suggested, a list of all the objectives is shown. For each objective, users can "download all data for this HP2020 objective" by clicking on a button and recieving a spreadsheet. 

While we've reached the end of 2020, we can't say yet if any of the objectives are met because final reporting isn't yet available. Most of the datasets require pooling years together and presenting confidence intervals, so it may be a few years before datasets like NHANES are able to tell us if targets have been met.

## Converted Data Structure

Three files were generated based on data pulled from the HP2020 website:

* **HP2020_objectives.csv**. Each row is a unique objective. Columns describe details about each objective, the baseline, and the target.

* **HP2020_data.csv**. Each row is a unique objective-year. For every year of data on a given objective, there is a separate row; objectives with multiple progress years tracked on the HP2020 website will appear on many rows in this file. 

* **HP2020_CI.csv**. A file of stricly the 95% confidence intervals for each estimate in the HP2020_data file, un-pivoted such that each row is a unique objective-year-CI_level. This formatting allows Tableau to draw confidence interval bars on charts.

## Issues & decisions

It's too soon yet to determine if any objectives are officially met, but the Tableau dashboards are set up to show status (met/not met/possibly met) based on the latest datat available. An objective was considered 'not met' if the estimate has not surpassed the target boundary. An objective was considered 'possibly met' if the estimate crossed the target boundary but the 95% confidence interval did not. An objective was considered me if both the estimate and the 95% confidence interval crossed the target boundary.

Some of the objectives do have more current progress information available than shown on the HP2020 website, but for now Positive Sum has decided not to supplement official HP2020 monitoring with unofficial progress data. If the community recommends doing this it could be a good next step, or we could wait until more official updates are made on the HP2020 website.

## Code

The file **CI_code.R**, contained in this Github repository folder, helps produce the HP2020_CI.csv file based on HP2020_data.csv as input.

## Tableau Presentation

Two dashboards are presented:

* **Objectives Status**. Shows the target, baseline, status, and 'stats as of' date for each objective.

* **Objective Trends**. Allows a user to select an objective and see any progress since baseline.

## Status & Next Steps

* Should we manually add updated progress data or wait for official updates from HP2020?
