# HRSA National Survey of Children's Health

The National Survey of Children's Health is a an annual household survey conducted by the Health Resources & Services Administration (HRSA). It collects wide ranging information about American children ages 0-17 and reports results to the state and national levels. 

## Utility

The NSCH informs about state-level children's oral health access and is one of the rare datasets to explore oral health status, covering topics such as presence of oral health problems, toothache, bleeding gums, difficulty chewing, and overall condition of teeth. It provides more population stratifications than most other public health datasets.


### Questions this dataset could help answer

* Children from which type of family structure have the highest rates annual dental visits?
* Between North Carolina, South Carolina, or Virginia, which has lowest rate of low-income children experiencing oral health problems?
* Is there a significant difference in caries rates between Utah and the United States overall?
* What is the trend in national bleeding gums rates among children from 2016-2018?
* What is the rate of forgone dental care among children with special health care needs in Wisconsin?

## Orientation & Stewardship  

The NSCH is a federally-funded survey conducted by the Maternal and Child Health Bureau at the Health Resources & Services Administration. Public use files are available to download from their [website](https://www.census.gov/programs-surveys/nsch.html). To make obtaining data easier, they have contracted with Johns Hopkins University Bloomberg School of Public Health to operate a [data query and visualization platform](https://www.childhealthdata.org/) that aggregates and calculates data quickly for the user. The platform enables a user to select one unique question-year-stratification at a time for one or two states at a time. For example, a user could select presence of toothaches, 2018, children with special healthcare needs in Colorado and/or Wyoming to see a chart of percentages, confidence intervals, population estimates, and the sample size. Johns Hopkins also allows a micro-data download of the NSCH data pending a data use agreement and approval from an internal review board.

The NSCH data used in the National Oral Health Data portal comes from the Johns Hopkins ChildHealthData data portal by web-scraping their pages by simulating individual query submissions with computer code.

#### Citatations & Data use agreements

On the ChildHealthData website Johns Hopkins suggests the following information about their data:

Data Source: National Survey of Children’s Health, Health Resources and Services Administration, Maternal and Child Health Bureau. https://mchb.hrsa.gov/data/national-surveys

Citation: Child and Adolescent Health Measurement Initiative. 2017-2018 National Survey of Children’s Health (NSCH) data query. Data Resource Center for Child and Adolescent Health supported by the U.S. Department of Health and Human Services, Health Resources and Services Administration (HRSA), Maternal and Child Health Bureau (MCHB).Retrieved [mm/dd/yy] from [www.childhealthdata.org].

## Original Data & Website Structure

The ChildHealthData portal produces a glimpse of one survey question in one year for one population stratification at at time, and up to two states at a time. The table formatting on the page is different when showing one state or two -- to make it easier we submit queries for one state at a time. The results are shown in a table with possible answers across the top of the table (e.g. one or more oral health problems | no oral health problems) and the population stratifications down the side of the table (e.g. parents born in the US | any parent born outside the US | children born in the US live with caregivers other than parents). Measures are also shown on the left side of the table, including percent, sample size, population estimate, and confidence intervals. 

The ability to web scrape this data comes from the url structure of the ChildHealthData website. There are 3 parameters in the URL: 
* q. The question-year(s). a 4-digit number ranging from 4561 to 7558. Even though the same questions are often asked across years, the developers have chosed to use a combined key representing a combination of year and question. Therea are 5 year(s) reported so far: 2016, 2017, 2018, 2016-2017, 2017-2018. The combined years will give lower confidence intervals because more data is included. 
* r. The geography. A number from 1-52. These include all states, the United States as a whole, and Washington DC.
* g. The population stratification. A 3-digit number ranging form 607 to 779. The codes represent a uniqe combination of year and group. Groups include names like 'familiy resilience', 'current insurance status', and 'well-functioning system of care'.

For a key to decoding the parameters, see this [file](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/National_Survey_of_Childrens_Health/Key.xlsx) in the Github repository.

Let's review an example url: https://www.childhealthdata.org/browse/survey/results?q=6846&r=3&g=723. Following this link leads us to a display where:
* q = 6846 = "During the past 12 months, has this child had oral health problems such as toothaches, bleeding gums, or decayed teeth or cavities?" in the years "2017-2018."
* r = 3 = Alaska
* g = 723 = Parental Nativity

Within the web page itself we see a table of the different parental nativity options going down the left side and the different survey responses going across the top of the table, with the 4 measures included: percent, CI, sample count, population estimate. Notice also the dark grey box around all responses associated with 'children born in the US, live with caregiver(s) other than parents.' The note at the bottom of the page warns us the grey box means we shoudl interpret the result with caution because the confidence interval is wider than certain criteria. In other cases Johns Hopkins deemed variance too small and withheld data altogether -- if perhaps there were not enough responses in a certain cell that the variance for the stratification was essentially zero. These cells may be dashed out with two dash marks "--". In other cases all of the stratifications are dashed out so the website does not let you submit the querty to visit the page. However, the url sill works if you have the parameters. Decisions made about how to handle these special cases in the National Oral Health Data Portal Project is discussed below. 

### Processed Data Output & Design
The R code we have written web-scrapes all the data from each oral health-related page on the ChildHealthData website. It first organizes the data into one table where each row is a unique state-year-question-answer-group-subgroup. It decodes the parameters by joining in our [key](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/National_Survey_of_Childrens_Health/Key.xlsx) and modifies some of the element names. We also add a column that shortens the long survey questions into shorter phrases.

We then split the data into two parts: 
* nsch_prime. Contains most of our data, organized where each row is a unique state-year-question-answer-group-subgroup and including columns for percent, sample size, and population estimate.
* nsch_CI. Contains the confidence interval data. Each row is a unique state-year-question-answer-group-subgroup-confidence bound. Because there are two bounds (upper and lower) for each estimate, we then get two rows for every row that was in nsch_prime. 

The reason for structuring the confidence intervals in its own sheet is helping prepare the data to be visualized in Tableau. We will join the two tables on these ID fields and then draw lines between confidence intervals. Important for drawing these lines is an 'order' column we have added to the dataset. The order column assigns a value to each vertex in a polygon that would draw the confidence interval in a time series. The numbering system ensures that a graph plotting values over time in increasing order by a 'connect the dots' pattern draws a polygon representing our confidence interval.

The data model is available as a LucidChart [here](https://app.lucidchart.com/invitations/accept/bec22ad3-1e54-4bcc-b82a-7a82d09bf4a6). 

### Issues & decisions

The ChildHealthData website warns that we should 'interpret with caution' when estimates have a confidence interval wider than 1.2x the percent estimate or a width larger than 20 percentage points, and on their website they flag such data with a grey color. We have not implemented a comparable warning indicator in our Tableau dasbhoards, but we could if we receive feedback that it would be helpful. We decided not to suppress the data but to show the entire confidence interval width, which we hope will visually cue people to interpret with caution.

ChildhealthData goes a step farther when data has no variance, as in the case when all responsdants report the same answer (e.g. 100% say 'yes' to a question). This tends to happen for rare and/or low sample size slices. ChildHealthData may suppress these data by 'dashing out' the table cells, though not always. If most of the data in a table is dashed out, they suppress the entire table so that you can only obtain the data by knowing the url. In the National Oral Health Data Portal Project we have chosen to suppress data when the lower confidence level equals the upper confidence level, indicating no variance. We suppressed the data inside the R code so it does not get entered into our output csv files. 


### Code

[This R code](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/National_Survey_of_Childrens_Health/NSCH%20r%20code.R) reads in all the oral health-related data from ChildHealthData website, reformats it, and produces two CSV fils.  

Major additions to the data include:
* 
## Tableau Dashboard
A beta version of our Tableau dasbhoard is available [here](https://public.tableau.com/views/NationalSurveyofChildrensHealth_15929305430520/StateComparisonDash?:language=en&:display_count=y&:origin=viz_share_link). 


