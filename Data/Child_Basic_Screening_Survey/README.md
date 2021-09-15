# Child Basic Screening Survey

The Basic Oral Health Screening Surveys for Children are periodic state surveys primarily of third grade public school children in which oral health providers inspect children's mouths and record oral health status using protocols developed by the Association of State & Territorial Dental Directors (ASTDD) and the Centers for Disease Control & Prevention (CDC). 

## Examples of questions this dataset could help answer

* What percent of third grade children in Missouri have untreated caries?
* Does the rate of dental sealants among Maine third graders differ by race / ethnicity?
* Has the rate of caries experience among Illinois third graders decreased over the past decade?
* What percent of Maryland third graders have ever had a cavity?

## Utility

The Basic Screening Survey for children is the gold standard survey for understanding state-level oral health disease prevalence in children. It involves calibrated clinicians inspecting children's mouths. This method contrasts with surveys like the National Survey of Children's Health or the Behavior Risk Factor Surveillance System which use respondent self-reporting to characterize disease status. 

## Stewardship & Data Structure

Many of the measures collected in the Basic Screening Survey are part of the National Oral Health Surveillance System (NOHSS). In a cooperative agreement between the CDC and ASTDD, ASTDD maintains a Basic Screening Survey Toolkit and offers technical assistance to states to assist in designing the complex survey methodology and carrying out the logistics of visiting schools and community locations to collect the data. 

States are responsible for funding and conducting the Basic Screening Surveys. These surveys usually focus on third grade public school children, but states may choose to survey additional populations. Kindergarten and Head Start are the next most common survey settings, but WIC programs, second graders, and sixth graders are occasionally surveyed as well. There is a special toolkit for surveying older adult populations, which is a dataset covered in a separate section of this Github repository. The Indian Health Service conducts a similar version of the Basic Screening Survey on American Indian / Alaska Native populations, which is covered in a separate section of this Github repository. 

States often publish the results of their Basic Screening surveys as pdf documents primarily oriented for reading. To obtain the data we must read narrative text, small tables, and charts. Excel files or CSVs containing more database-structured data are not usually available. Top-level (non-stratified) summary data are usually presented to ASTDD and the CDC to maintain a continuous record of the primary indicators:

* **Caries Experience**
* **Untreated Tooth Decay**
* **Dental Sealants** 

The next most common indicators included in the Basic Screening Surveys pertain to the prevalence of different levels of treatment need: such as 'no treatment need', 'early treatment need', and 'urgent treatment need.' Counts of diseased, missing, or filled teeth are occasionally recorded in that Basic Screening Surveys.


## Consolidated Data Structure

There is no common data structure among all the state reports. They are presented in various table or chart formats in PDFs. Beyond the primary three indicators described above, few additional indicators are regularly consolidated in a state's PDF report.

Records in the CDC's Basic Screening Survey dataset are all unstratified (i.e., one single number for the state caries rate in the survey year without race, gender, or behavioral breakouts). Thus, the National Oral Health Data Portal project aims to gather as much of the stratified data from the history of state surveys as possible. We would like to be able to compare caries prevalence by race across states, for example. The task is mainly manual, finding older reports and typing the data into a single spreadsheet. Most state reports have been processed into this project, but many still remain. We welcome any help obtaining copies of reports that may not yet be incorporated. 
 
Two files located in this Github repository folder have been created so far:

* **BSS_prime.csv**. The main file with each row representing a unique state-year(s)-population-category-subcategory-indicator.

* **BSS_CI.csv**. Twice as long as the BSS_prime file, this file unpivots the upper and lower 95% confidence intervals so that each state-year(s)-population-indicator-category-subcategory has two rows for each confidence level. This format can be joined to the BSS_prime file and used by data visualization software to present confidence intervals, with the help of the 'order column' which helps software draw confidence intervals in a 'connect the dots' fashion.

## Code

The R code titled **BSS_pivoting.R** takes in the BSS_prime file and outputs the unpivoted BSS_CI file.

## Issues & decisions

### Population stratification comparability
At least 165 state Basic Screening Surveys have been conducted in the past three decades per a tracking report from ASTDD. We'd like for the data to be standardized in a way that when a state releases a report then can check to see how their performance compares in the national context and with the state's own previous survey history. This is difficult to achieve with Basic Screening Survey reports because beyond the common indicators that are measured, the population stratifications are can be slightly or very different. Examples of such differences include:

#### Reporting results by similar but different ages and/or grades
Examples of ranges used in reports include: third grade | grades 2 + 3 combined | age 6 | age 7 | age 8 | age 9 | ages 6-8 | ages 6-9. In this project we keep all grades and ages as listed in their reports without changing them, even if it makes it difficult to compare on the same chart. 

#### Combining grades together
States sometimes report third grade + second grade together or third grade + kindergarten together in order to increase sample size. In this project we keep all grades and ages as listed in their reports without changing them, even if it makes it difficult to compare on the same chart. 

#### Different definitions of race and/or ethnicity 
Sometimes race and ethnicity are considered completely separate categories, such that a state will report estimates for Hispanic vs Non-Hispanic and then report by White, African American, and Asian. In this case, we don't know the estimate for non-Hispanic White populations. It is also common to see either the term 'Black' or 'African American'. This project consolidated 'Black' and 'African American' into one breakout: 'Black'. 

#### Insurance status
Sometimes the specific type of dental insurance is reported; sometimes it's the overall/medical insurance that is reported; one state breaks out both together.

#### 'School percent participation in the federal free or reduced lunch program' vs 'individual relationship with the federal free or reduced lunch program'
Reports often use federal lunch program information as a proxy for socio-economic status or household income. It's easier to collect this information about the school itself than to learn this about each child directly, which is probably why there are two common ways of seeing this information reported in Basic Screening Surveys:

* By school characteristics.
* By child characteristics.

The government program itself is labelled various ways in different reports but here it has been consolidated into a single name: 'school lunch program.' 

For the child-specific question, we see variation in the subcategories. Sometimes a child's 'participation' is reported; other times it is their 'eligibility', or their 'enrollment.' Each of these classifications is slightly different and may affect comparability. For this project we decided to consolidate 'participation' into 'enrollment'. 'Eligibility' is kept separate. For the school participation question, we usually see breakouts by percentage ranges, such as < 25%, 50-74%, >= 75%. The ranges may appear different in different reports, or sometimes the equals sign is on a different side of a boundary (such as > 75% vs >= 75%). In our case we have consolidated the boundaries into the same breakout to make data more comparable, assuming the difference is negligible.

### Levels of treatment need
Besides challenges in comparing across population stratifications across states, there is some challenge with the 'treatment need' indicator group. Up to four possible measures are recorded: [no treatment needed], [urgent treatment need], [early treatment need], [early or urgent treatment need]. It's most common for 'no treatment need' to be missing. 'Early or urgent treatment need' is often used instead of reporting either 'urgent treatment need' or 'early treatment need,' perhaps because of sample sizes. 

### Sample sizes
Some reports do not show sample sizes with their estimates.

### Significant digits
Most state Basic Screening Surveys report estimates to one decimal point. Some round to the nearest whole number.

### Comparability in light of reporting frequency
States release reports with different frequencies. How close in years should reports be to make them comparable on the same chart?

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/BasicScreeningSurvey/Orientation).

Comparability challenges caused us to keep the types of visual representations of Basic Screening Survey data fairly small. We show a **States Comparison** chart whereby an indicator is selected and states are sorted by their performance. Since there are not many states on this chart we chose not to show a map. On the dashboard we let users determine what the year threshold cutoff should be before which data are excluded; the threshold defaults to 2014, which means that any reports from before 2014 are excluded. The dashboard only takes the most recent survey of a state, so if a state has conducted multiple surveys since 2014 only the most recent one is used.

The **State Details** dashboard allows a user to select a state and indicator and see all population stratifications at once.

The **State Trends** dashboard shows a line plot for all indicators for all years a selected state. Confidence intervals can be shown.

The **Reporting Status** dashboard lists all reports in all states that are included in the dataset so far or are known to be missing. 

## Status & Next Steps

Help would be appreciated gathering any additional surveys that are not yet included in our consolidated file, no matter how far back the report goes.

The Report Status could be updated to provide hyperlinks directly to actual copies of the state reports if users desire that feature.
