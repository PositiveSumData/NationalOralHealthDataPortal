# HRSA National Survey of Children's Health

The National Survey of Children's Health (NSCH) is an annual household survey conducted by the Health Resources & Services Administration (HRSA). It collects wide ranging information about American children ages 0-17 and reports results at the state and national levels. 

## Utility

The NSCH is one of the rare datasets to explore oral health status. It covers topics such as presence of oral health problems, toothache, bleeding gums, difficulty chewing, and overall condition of teeth. It provides more population stratifications than most other public health datasets. Two of the measures are also components of the National Oral Health Surveillance System: **dental visits among children ages 1-17 years**, and **preventive dental visit among children age 1-17 years**.

### Questions this dataset could help answer

* Children from which type of family structure have the highest rates annual dental visits?
* Between North Carolina, South Carolina, or Virginia, which has lowest rate of low-income children experiencing oral health problems?
* Is there a significant difference in caries rates between Utah and the United States overall?
* What is the national trend in percent of children reporting bleeding gums since 2016?
* What is the rate of forgone dental care among children with special health care needs in Wisconsin?

## Orientation & Stewardship  

The NSCH is a federally funded survey conducted by the Maternal and Child Health Bureau at the Health Resources & Services Administration. Public use files are available to download from their [website](https://www.census.gov/programs-surveys/nsch.html). To make obtaining data easier, they have contracted with Johns Hopkins University Bloomberg School of Public Health to operate a [data query and visualization platform](https://www.childhealthdata.org/) that aggregates and calculates data quickly for the user. The platform enables a user to select one unique question-year-stratification at a time for one or two states at a time. For example, a user could select presence of toothaches, 2018, children with special healthcare needs in Colorado and/or Wyoming to see a chart of percentages, confidence intervals, population estimates, and the sample size. Johns Hopkins also allows a micro-data download of the NSCH data pending a data use agreement and approval from an internal review board.

The NSCH data used in the National Oral Health Data portal comes from the Johns Hopkins ChildHealthData data portal by extracting data from each of their pages that contains oral health information.

#### Data Use

On the ChildHealthData website Johns Hopkins suggests the following information about their data:

> Citation: Child and Adolescent Health Measurement Initiative. 2017-2018 National Survey of Children’s Health (NSCH) data query. Data Resource Center for Child and Adolescent Health supported by the U.S. Department of Health and Human Services, Health Resources and Services Administration (HRSA), Maternal and Child Health Bureau (MCHB).Retrieved [mm/dd/yy] from [www.childhealthdata.org].

## Original Data & Website Structure

The ChildHealthData portal lets users see a glimpse of data at a time: one survey question in one year for one population stratification for up to two states. For each selection we are given the percent of children responding with each answer, the 95% confidence interval, the sample count, and the estimated population size. The data are presented as a table on the webpage in html.

The ability to web scrape the data comes from the URL structure of the ChildHealthData website. There are 3 parameters in the URL: 
* **q**. The question-year(s). a 4-digit number ranging from 4561 to 8280. Even though the same questions are often asked across years, the developers have chosen to use a combined key representing a combination of year and question. There are 9 year(s) reported so far: 2016, 2017, 2018, 2016-2017, 2017-2018, 2018, 2018-2019, 2019, 2019-2020. The combined years will give lower confidence intervals because more data is included. 
* **r**. The geography. A number from 1-52. These include all states, the United States as a whole, and Washington DC.
* **g**. The population stratification. A 3-digit number ranging from 607 to 930. The codes represent a unique combination of year and group. Groups include names like 'family resilience', 'current insurance status', and 'well-functioning system of care'.

For a key to decoding the parameters, see this [file](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/National_Survey_of_Childrens_Health/Key.xlsx) in the Github repository.

Let's review an example url: https://www.childhealthdata.org/browse/survey/results?q=6846&r=3&g=723. Following this link leads us to a display where:
* q = 6846 = "During the past 12 months, has this child had oral health problems such as toothaches, bleeding gums, or decayed teeth or cavities?" in the years "2017-2018."
* r = 3 = Alaska
* g = 723 = Parental Nativity

Within the web page itself we see a table of the different parental nativity options going down the left side and the different survey responses going across the top of the table, with the 4 measures included: percent, CI, sample count, population estimate. Notice also the dark grey box around all responses associated with 'children born in the US, live with caregiver(s) other than parents.' The note at the bottom of the page warns us the grey box means we should interpret the result with caution because the confidence interval is wider than certain criteria. In other cases, Johns Hopkins deemed variance too small and withheld data altogether -- if perhaps there were not enough responses in a certain cell that the variance for the stratification was essentially zero. These cells may be dashed out with two dash marks "--". In other cases, all of the stratifications are dashed out so the website does not let you submit the query to visit the page. However, the URL sill works if you have the parameters. Decisions made about how to handle these special cases in the National Oral Health Data Portal Project are discussed below. 

## Processed Data Output & Design
Our [R code](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/National_Survey_of_Childrens_Health/NSCH%20r%20code.R) web-scrapes data from each oral health-related page on the ChildHealthData website. It first organizes the data into one table where each row is a unique state-year-question-answer-group-subgroup. It decodes the parameters by joining in our [key](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/National_Survey_of_Childrens_Health/Key.xlsx) and modifies some of the element names. We also add a column that shortens the long survey questions into shorter phrases.

We then split the data into two parts: 
* nsch_prime. Contains most of our data, organized where each row is a unique state-year-question-answer-group-subgroup and including columns for percent, sample size, and population estimate.
* nsch_CI. Contains the confidence interval data. Each row is a unique state-year-question-answer-group-subgroup-confidence bound. Because there are two bounds (upper and lower) for each estimate, we then get two rows for every row that was in nsch_prime. 

The reason for saving the confidence intervals in its own sheet is that data visualization software will need to read confidence intervals in a “tidy” format rather than a “wide” format. We will join the two tables on these ID fields and then draw lines between confidence intervals. Important for drawing these lines is an 'order' column we have added to the dataset. The order column assigns a value to each vertex in a polygon that would draw the confidence interval in a time series. The numbering system ensures that a graph plotting values over time in increasing order by a 'connect the dots' pattern draws a polygon representing our confidence interval.

The data model is available as a LucidChart [here](https://app.lucidchart.com/invitations/accept/bec22ad3-1e54-4bcc-b82a-7a82d09bf4a6). 

## Issues, Modifications & Decisions

The ChildHealthData website warns that we should 'interpret with caution' when estimates have a confidence interval wider than 1.2x the percent estimate or a width larger than 20 percentage points, and on their website they flag such data with a grey color. We have not implemented a comparable warning indicator in our Tableau dashboards, but we could if we receive feedback that it would be helpful. We decided not to suppress the data but to show the entire confidence interval width, which we hope will visually cue people to interpret with caution.

ChildHealthData goes a step farther when data has no variance, as in the case when all respondents report the same answer (e.g., 100% say 'yes' to a question). This tends to happen for rare and/or low sample size slices. ChildHealthData may suppress these data by 'dashing out' the table cells, though not always. If most of the data in a table is dashed out, they suppress the entire table so that you can only obtain the data by knowing the URL. In the National Oral Health Data Portal Project, we have chosen to suppress data when the lower confidence level equals the upper confidence level, indicating no variance. We suppressed the data inside the R code so it does not get entered into our output csv files. 

Sometimes the wording of population groupings or survey answers are not consistently labelled on ChildHealthData.org, making some longitudinal comparisons initially difficult. For example, in 2016 the question regarding presence of toothaches had a possible response of 'No toothache' whereas in 2018 the possible response was 'No toothaches' (plural). To draw any trend lines in Tableau we need them to be the same. In the future, based on feedback, we may decide to modify the underlying data to create more consistency.

To keep the names of variables consistent over time, we have modified the language scraped from the ChildHealthData.org website. It appears that the names of some answers, groups, and subgroups are slightly changed year to year but do not reflect actual changes to the survey instrument. For example, in some years there is a population group named "Care met medical home criteria," and in other years it is named "Care meets medical home criteria." Other examples are the answer "No toothache" compared to "No tootaches", or "Received both preventive care" compared to "Received both types of preventive care". To keep the original names would break our ability to observe trends over time in data visualization because the software would treat them as seaparate varaibles. We have modified some "original" fields to "final fields" in the excel key linked in this repository and have incorporated joins into our R code. These three sheets are "answer_mods", "subroupg_mods", and "group_mods".

## Code

[This R code](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/National_Survey_of_Childrens_Health/NSCH%20r%20code.R) reads in all the oral health-related data from ChildHealthData website, reformats it, and produces two CSV files.  

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/NationalSurveyofChildrensHealth_15929305430520/Orientation).

## Project Status & Next Steps

The dataset and dashboards should be updated when the next phase of data is released on ChildHealthData.org.
