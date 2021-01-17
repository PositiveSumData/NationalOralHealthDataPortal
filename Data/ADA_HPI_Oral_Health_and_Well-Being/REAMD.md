# American Dental Association Health Policy Institute Oral Health & Well-being Survey

The ADA HPI's 2016 survey of adults in each state illuminates peoples' attitudes about oral health preventive care and how oral health impacts their lives. 

## Examples of questions this dataset could help answer

* What was the primary reason why Rhode Island adults did not go to the dentist?
* Are higher or lower income adults less likely to visit the dentist?
* Which state is most likely to have 'incomvenient time or location' as the most likely reason adults did not visit the dentist?
* In which states has peoples' oral health condition most impacted their ability to interview for a job?
* What percent of New Hampshire middle income adults say they have 'very good' oral health?
* In which state do the most high income adults report good or very good oral health?
* What percent of Iowa adults say their oral health rarely or never causes diffulty doing normal activities?
* In which states do the fewest percent of adults agree that they need to see a dentist twice a year?
* How do the percent adults who say life is less satisfying because of their oral health vary by income?

## Utility

The ADA HPI Oral Health & Well-being survey is one of the rare datasets that explores peopele's percentions of their oral health and how oral health impacts their lives.

## Orientation & Stewardship  

The Oral Health & Well-being Survey has so far been a one-time project from the ADA Health Policy Institute. Infographics and the underlying dataset are available on the [HPI website](https://www.ada.org/en/science-research/health-policy-institute/oral-health-and-well-being).

#### Data use agreements

The dataset is freely available for public download on the [ADA HPI website](https://www.ada.org/en/science-research/health-policy-institute/oral-health-and-well-being). 

## Original Data Structure

The HPI dataset comes down as a 13-sheet Excel spreadsheet, mostly alternating between national and state results for each of the survey topics. The topics are:
* Overall condition of mouth and teeth.
* Life in general is less satisfying due to condition of mouth and teeth.
* Appearance of mouth and teeth affects ability to interview for a job.
* How often have you experienced the following problems in the last 12 months dues to the condition of your mouth and teeth?
* Attitudes toward oral health adn dental care.
* Dental care utilization: what people say and what people do.
* Reasons for not visiting the dentist more frequently, among those without a visit in the last 12 months.

The state datasets are broken out by income levels.

The spreadsheet is designed to be viewed rather than incorporated into statistical software or a data visualization tool. The data needed to be reformatted. This was easier to achieve manually than using code since each page was unique.

## Converted Data Structure

The original 13-tab Excel file was converted into a 6-tab Excel file, **ADA_HPI_Oral_Health_and_Well-Being.xlsx**, with one tab for each topic except for 'dental care utiliation: what people say and what people do.' This topic was the only one not to contain state breakouts, so it was excluded for now.

## Issues & decisions

The project so far has focused on state breakouts, ignoring national data displays and comparisons.

## Code

No code was used to process or compute data withd this dataset. Due to the unique structure of the original Excel files, data was processed manually.

## Tableau Presentation

The Tableau viz has one 'story' for each of the 6 state topics tabs. The topics with more complex information recieve more dashboards within a story. The most common type of viz consists of side by side bar graphs for each state by each income level. If there are multiples types on answers inside of each bar (seen by multiple colors on the same bar), when a parameter feature is available at the top of the page to help users sort by different characteristics. 

## Status & Next Steps

It may be helpful to add in the national information and make national comparison dashboards.

