# Emergency Department Oral Health Data

States collect emergency department data to understand utilization patterns, cost, and reasons people access health care. States choose to house their data in their own unique database system, or they choose to participate in the national State Emergency Department Databases (SEDD).

## Utility

The emergency department is not an ideal access point for most oral health conditions. The dental office is usually much more appropriate, where dentists have the expertise to manage traumatic and non-traumatic dental cases. Emergency department care is much more expensive than dental office care. Emergency department use for dental reasons may illuminate gaps in health literacy, dental insurance coverage, or the availability of dentists. States often turn to ED data to see if utilization changes as result of changes to Medicaid dental coverage, the thought being that when people don't have dental insurance they are less likely to see a dentist and more likely to go to a hospital. 

### Questions this dataset could help answer

* What was the count of non-traumatic dental conditions in my state in 2016?
* What was the rate of visits to the emergency department for any dental reason in 2015 per 100,000 people?
* Which race/ethnicity and which income levels are most likely to visit the emergency room for a preventable dental condition?
* How does my state compare to other states on ED dental utilization?
* What were the total charges for dental ED visits in my state in 2016?
* Did national rates of ED visits change before and after 2018?

## Orientation & Stewardship  

Two very helpful resources about these databases and how to query them are available from ASTDD:
* [Guidance on Assessing Emergency Department Data for Non-Traumatic Dental Conditions](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/ed2/Data/EmergencyDepartment/ed-data-analysis-guidance-july-6-2017.docx). Primary author Kathy Phipps. Updated September 2017. 
* [Recommended Guidelines for Surveillance of Non-Traumatic Dental Care in Emergency Departments](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/ed2/Data/EmergencyDepartment/ed-dental-care-protocols-w-appendices-july-6-2017.pdf). Primary author Mike Manz. Updated September 2017. 

States organize their ED data in one of two ways: 
* Through the State Emergency Department Databases (SEDD) maintained as part of the Agency for Healthcare Research & Quality (AHQR) Health Care Cost & Utilization Project (HCUP).
* Through their own state-maintained databases.

### AHRQ 
Approximately 35 states include their data into a system developed by the Agency for Healthcare Research & Quality (AHRQ) ]Health Care Cost and Utilization Project (HCUP)](https://www.ahrq.gov/data/hcup/index.html). Called the *State Emergency Department Databases* or *SEDD*, research will find commonly used fields so that the same queries usually work across states. SEDD data may be purchased through the central HCUP distributer. States charge variable rates depending on the year and the type of organization requesting the data.    

These databases include samples of their state populations of hospital utilizers. They do not include everyone who visited an emergency department or ambulatory surgery center, so results should be interpreted with confidence intervals.

Limitations of SEDD data include:
* No admission data. The SEDDs only contain records for patients who presented to the ED and then were discharged to go home. Severe visits that resulted in a hospital stay are not captured in SEDD.

#### AHRQ HCUPnet

Some of the SEDD-participating states make aggregated queries available through AHRQ's HCUPnet tool. HCUPnet is an online platform allowing users to submit many types of queries for free without ever seeing confidential patient health data. Queries are a manual process of selecting the appropriate database, choosing types of results to display, selecting the year and code sets, and then fine-tuning with population characteristics. Results are aggregated and censored to protect patient confidentiality when cell sizes are small. The results are provided as a downloadable CSV. No more than 15 states have data included in the HCUPnet system, and state availability depends on the year and other selectors chosen. The only HCUPnet option with county or regional granularity is the 'Community' setting database, which unfortunately in our case only includes cases resulting in hospital admission. The HCUPnet CSVs must be cleaned up and reformatted before they can be entered into a useable database.

While HCUPnet can be a great tool for conducting quick and free queries, it also has some major limitations:
* Timeliness. SEDD data is often on a 4-year delay or more. As of May 2020, the most recent year for which national data was available was 2016. 2016 state-level data was still not yet available.
* Subgroup categories. HCUPnet has pre-set population subgroups that do not match with the ASTDD-recommended subgroups, especially for age.
* Completeness. Fewer than 20 states have queryable HCUPnet data.


#### Citations

The citation recommendation attached to each HCUPnet CSV download is: 
```
HCUPnet, Healthcare Cost and Utilization Project. Agency for Healthcare Research and Quality, Rockville, MD. http://10.35.1.231/. For more information about HCUP data see http://www.hcup-us.ahrq.gov/
```

#### Data use agreements

To download HCUPnet datasets, users must agree to a user agreement that they will not attempt to identify individuals with the data. More strict user agreements come attached with micro data from HCUP or individual states. 

Much more strict data use agreements will be necessary to access any of the SEDD microdata.


### Other state databases
Some states choose not to participate in the HCUP SEDD project. The steward of each state's ED data varies. It may be the department of health, or the hospital association, or another entity. They may charge various rates for obtaining their data, and data definitions may or may not be consistent between states. 

## Data Structure

High participation in the HCUP SEDD project means we have consistent data structures across most states for commonly queries. We know what is available and how to ask for it. Querying the non-participating states may be more complicated.

### Measures
There are generally two paths people take when they visit an emergency department. They are treated in the ED and then (1) 'discharged' to go home or they are (2) 'admitted' to the hospital for a longer-term inpatient stay. The main ED measures are therefore visits, discharges, admissions, and total charges. SEDD does not contain information on visits that resulted in hospital admission, so for the sake of our dataset we will choose only to focus on **visits resulting in discharge and total charges**. This is acceptable because hospital admissions due to dental conditions, while serious, are thankfully rare. 

HCUPnet examines an additional situation, length of hospital stay, but since we have chosen not to study admissions we will not prioritize that measure.

Within discharges, we want to examine four measures:
* Counts. E.g. the total # of discharges for a dental condition
* ED rates. E.g. the # of people who were discharged from the ED for a dental condition / 10,000 people who visited the ED for any reason
* Population rates. E.g. the # of people who were discharged from the ED for a dental condition / 100,000 population 
* Total charges. Used as an indicator of the overall cost of utilizing dental care in a hospital setting.

### Reason or diagnosis

We determine when people have visited the ED for a dental condition in one of two ways: if hospital staff have *diagnosed* the patient with an oral health complication through an ICD 10 code, or if hospital staff record the patient's chief *reason* for visiting the ED. The main reason and main diagnosis are usually the same, but may be different. Both can be important public health indicators. 

We have chosen to focus on physician diagnosis for this project because it is more commonly contained in state datasets than the patient's reason code. 

### First-listed or any-listed

Patients are typically assigned a primary, or "first-listed", ICD 10 diagnosis code that serves as the patient’s most serious health issue at the time. But patients may present with multiple health issues at once. Oral health researchers must decide if they want to study whether oral health was the first-listed diagnosis or any of the listed diagnoses. ASTDD feels both measures are important, so we will be asking for both measures from states.

### Code sets

Researchers must also choose what defines an oral health visit. Should they study any type of visit that pertained to the oral cavity? Or perhaps visits that were likely preventable? ASTDD's Mike Manz has developed three code sets for these situations:

* [Any dental condition](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/EmergencyDepartment/ICD10_codes_any_dental.csv). These would include diagnoses for any reason that pertains to oral health. 
* [Non-traumatic dental conditions (NTDC)](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/EmergencyDepartment/ICD10_codes_NTDC.csv). By excluding trauma-related diagnoses, researchers may get a better sense of how often the ED is utilized for sub-optimal reasons. It's understandable when someone visits the ED for breaking a tooth falling off a bike. It's less ideal when someone visits the ED for cavities that have been developing over time.
* [Caries / Perio / Prevention (CPP)](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/EmergencyDepartment/ICD10_codes_CPP.csv). These are a subset of NTDC restricted only to conditions that are commonly addressed by routine access to general dental care.

### Dimensions

HCUP's SEDDs allow us to query for specific sub-populations by age, sex, payer, and race/ethnicity. Will model our data as follows:
* All visits
* Age group (< 20, 20-44, 45-64, 65+)
* Sex (Male | Female)
* Payer (Medicare | Medicaid | Private Insurance | Other)
* Race/ethnicity (White | Black | Hispanic | Native American)

### Database Design

The entity relationship diagram (ERD) for this dataset is available online as a [Lucid Chart](https://www.lucidchart.com/invitations/accept/695abb67-018e-4000-b1e4-271ba776d26a). We have constructed 5 tables, one of which comes directly from the ED data itself and four of which describe data as foreign keys or are used to find population rates.

#### ED_discharge
This table is the meat of our ED data. It contains our discharge counts for each unique combination of geography, year, code set, reason priority, and population subgroup. Since the geography can be state, country, county, region, or city, we have used the federal FIPS code identifier. A table of expounding on the FIPS code is described below.

Fields:
* data_id (PK)
* FIPS_code (FK)
* px_group
* px_subgroup
* year
* code_set
* priority
* count_visit
* total_charges

#### source

This table includes information pertaining to each dataset we have in our larger project. Each row is a different dataset, which has a steward (e.g. AHRQ), title (HCUPnet), and a url to where additional information can be found online and where a project description is located in our Github folder. This table gets linked to every dataset in our larger database. 

Fields:
* source_id
* source_steward
* source_title
* citation
* source_url
* source_git

#### source_data_id 

This is a bridge table, linking our ED_visit and E_population tables to our source table. The bridge table exists so that we only need to modify a given source once if, say, their url needs updating.

Fields:
* source_id
* data_id

#### FIPS

FIPS codes are federally-assigned, unique IDs for nearly every geography in the country. The FIPS code is a number for every geography except the country itself, which for international standardization reasons is simply *US*. Therefore the FIPS code can't be an integer.

* FIPS_code
* geographic_type
* short_name
* full_name
* abbreviation

## Issues & decisions
* We have decided not to include HCUPnet data in our portal project. In addition to the data be untimely, the age subgroupings do not match those deemed to match other important oral health datasets by ASTDD. We prefer to have the following age groupings: <20, 20-44, 45-64, 65+. But HCUPnet groups age by: 1-17, 18-44, 45-64, 65-84, 85+.
* We have decided not to study patient admission to the hospital or length of stay. This information is not included in SEDD.
* HCUP and the state emergency department databases do not use the same race/ethnicity categories as the US census. This makes calculating population rates by race/ethnicity difficult. We will need to find another solution for calculating population rates by race/ethnicity.
* We have chosen to focus only on ICD10 codes. The earlier ICD9 codes were used in US hospitals until 2015, at which point they switched to ICD10 codes. There were significant changes in codes, with ICD10 being much more expansive. There are crosswalks for mapping ICD9 codes to ICD10 codes. But the change was abrupt enough to cause some validation issues with comparing pre-2015 ICD9 analysis with post-2015 ICD10 queries. We have chosen to start fresh with.

## Tableau Presentation

There is no Tableau presentation yet. We are still gathering data.

## Project status

We are gathering state data directly since HCUPnet does not have many states' datasets or timely data.
