# Emergency Department Oral Health Data

States collect emergency emergency department data to understand utilization patterns, cost, and reasons people access health care. The Agency for Healthcare Research & Quality (AHRQ) consolidates some of these state datasets into the Health Care Cost and Utilization Project (HCUP). Some of the data is free and publicly queryable in the HCUPnet online database. Most states do not participate. ED data collection therefore requires coordinating with many states individually. They may or may not use standardized reporting fields, somewhat complicating consolidation into our database. States may charge fees as well.

## Utility

The emergency department is not the ideal acces point for most oral health conditions. The dental office is usually much more appropriate, where dentists have the expertise to manage traumatic and non-traumatic dental cases. Emergency department care is much more expensive than dental office care. Emergency department use for dental reasons may illuminate gaps in health literacy, dental insurance coverage, or the availability of dentists. States often turn to ED data to see if utilization changes as result of changes to Medicaid dental coverage, the thought being that when people don't have dental insurance they are less likely to see a dentist and more likely to go to a hospital. 

### Questions this dataset could help answer

* What was the count of non-traumtic dental conditions in my state in 2016?
* What was the rate of visits to the emergency department for any dental reason in 2015 per 100,000 people?
* Which race/ethnicity and which income levels are most likely to visit the emergency room for a preventable dental condition?
* How does my state compare to other states on ED dental utilization?
* What were the total charges for dental ED visits in my state in 2016?
* Did national rates of ED visits change before and after 2018?

## Orientation & Stewardship  

There are generally two paths people take when they visit an emergency department. They are treated in the ED and then (1) 'discharged' to go home or they are (2) 'admitted' to the hospital for a longer-term inpatient stay. The main ED measures are therefore visits, discharges, admissions, and cost for setting.

A very thorough background on ED data can be found in the ASTDD document authored by Mike Manz, [Recommended Guidelines for Surveillance of Non-Traumatic Dental Care in Emergency Departments] ().

### AHRQ 

Some of the data we are collecting comes from the Agency for Healthcare Research and Quality's [HCUP project](https://www.ahrq.gov/data/hcup/index.html). HCUP is a collection of related hospital databases, including the Kid's Inpatient Database (KID), Nationwide Emergency Department Sample (NEDS), Nationwide Readmissions Database (NRD), State Inpatient Databases (SID), State Ambulatory Surgery and Services Databases (SASD), and State Emgerency Departmetn Databases (SEDD). These are each collections of state databases that may or may not have universal participation. HCUP facilitates the research of these datasets. To study individual-level data a researcher will need to purchase data from HCUP and sign data use agreements. 

These databases include samples of their state populations of hospital utilizers. They do not include everyone who visited an emergency department or ambulatory surgery center, so results should be interpreted with confidence intervals.

Our project is most interested in SEDD and NEDS, which illuminates state adn national-level ED visits that did not result in an admission. Hospital admission for dental conditions is a serious event that is rare enough to make statistically significant conclusions difficult. 

#### HCUPnet

AHRQ offers the HCUPnet platform (https://hcupnet.ahrq.gov/#setup) for querying some of these databases. Queries are a manual process of selecting the appriate database, choosing types of results to display, selecting the year and code sets, and then fine-tuning with pouplation characteristics. Results are aggregated and censored to protect patient confidentiality when cell sizes are small. The results are provided as a downloadable CSV. No more than 15 states have data included in the HCUPnet system, and state availablility depends on the year and other selectors chosen. The only HCUPnet option with county or regional granularity is the 'Community' setting database, which unfortunately in our case only includes cases resulting in hospital admission. The HCUPnet CSVs must be cleaned up and reformatted before they can be entered in the ASTDD database.

#### Citation

The citation recommendation attached to each HCUPnet CSV download is: 
```
HCUPnet, Healthcare Cost and Utilization Project. Agency for Healthcare Research and Quality, Rockville, MD. http://10.35.1.231/. For more information about HCUP data see http://www.hcup-us.ahrq.gov/
```

#### Data use agreements

To download HCUPnet datasets, users must agree to a user agreement that they will not attempt to identify individuals with the data. More strict user agreements come attached with micro data from HCUP or individual states.

### Individual states

Data not available in HCUPnet or the wider HCUP project is usually available by direct relationship with a state. The steward of each state's ED data varies. It may be the department of health, or the hospital association, or another entity. They may charge various rates for obtaining their data, and data definitions may or may not be consistent between states. This section will be updated as more information on state-based entities becomes available.

## Data Structure

The trickiest part of managing emergency department data is that it comes from so many different stewards, each of whom may have different formats, definitions, and availability. As a projet we must also balance our data needs and wants, because some of the more complicated data requests require a lot more time and money to purchase.

### Measures

There are 4 main situations we want to measure:

* Visits
* Visits resulting in discharge
* Visits resulting in admission
* Visit charges ($) 

Because hospital admissions due to dental conditions is so low, we proritize the visit measure. Cost is the second priority, but cost is usually attached to admission than it is to ED in these databases, so cost may or may not be available.

HCUPnet makes available an additional measure, length of stay, that is not a priority in oral health research and therefore we have chosen to de-prioritize.

Within visits, we want to examine three measures:
* Counts. E.g. the total # of people who visited the ED for a dental condition
* ED rates. E.g. the # of people who visited the the ED for a dental condition / 10,000 people who visited the ED for any reason
* Population rates. E.g. the # of people who visited the ED for a dental condition / 100,000 population 

### Reasons & Code sets

We determine when people visit the ED for a dental condition based on the ICD 10 diagnosis code assigned by hospital staff during the visit. These ICD10 codes are kept as part of the patient record and are included as part of the datasets. Researchers must decide if they want to query for every diagnosis code related to oral health or if a more narrow set of codes is more appropriate. ASTDD's Mike Manz has identified three code sets that researchers may wish to use. These code sets are available in this folder as CSV files.

* [Any dental condition](). These would include diagnoses for any reason that pertains to oral health for any reason. 
* [Non-traumtic dental conditions (NTDC)](). By excluding trauma-related diagnoses, researchers may get a better sense of how often the ED is utilized for sub-optimal reasons. It's understandable when someone visits the ED for breaking a tooth falling off a bike. It's less ideal when someone visits the ED for cavities that have been developing over time.
* [Caries / Perio / Prevention (CPP)](). These are a subset of NTDC restricted only to conditions that are commonly addressed by routine access to general dental care.

### Diagnosis Priorities

Patients can present with multiple conditions at the same time. All of these conditions are all recorded as ICD10 diagnosis codes. When patients express the main reason for their ED visit, this reason is econded as the 'principal' or 'first-listed' diagnosis. If someone visits the ED for stomach pain but the physician then notics a cavity, the cavity would **not** be listed as the primary reson, but it will still be recorded. Researchers must choose if they wish to query for when oral health was the main reason someone visited the emergency department, or all instances when oral health was recorded. Both are valuable to our project and can be selected during an HCUPnet query.

### Dimensions

HCUPnet allows users to query by a few population characteristics:
* All visits
* Age group (1-17 | 18-44 | 45-64 | 65-84)
* Sex (Male | Female)
* Payer (Medicare | Medicaid | Private Insurance | Other)
* Race/ethnicity (White | Black | Hispanic | Native American)

We plan to use these characteristics as the base query from which to reqest data from states not in HCUPnet.

### Database Design

The entity relationship diagram (ERD) for this dataset is available online as a [Lucid Chart](https://www.lucidchart.com/invitations/accept/695abb67-018e-4000-b1e4-271ba776d26a). We have constructed 4 tables, one of which comes directly from the ED data itself and three of which describe data as foreign keys or are used to find population rates.

#### ED_visit
This table is the meat of our ED data. It contains our visit counts for each unique combination of geography, year, code set, reason priority, and population subgroup. Since the geography can be state, country, county, region, or city, we have used the federal FIPS code identifier. A table of expounding on the FIPS code is described below.

Fields:
* data_id (PK)
* FIPS_code (FK)
* px_group
* px_subgroup
* year
* code_set
* priority
* count_visit

#### ED_population

To determine rates of ED visit per 100,000 people, we need to obtain separate census data. We store the census data in a separate table. To obtain the population rates we join the two takes on the fields they have in common and then divide count_visits / pop_count *100,000.

Fields:
* data_id (PK)
* FIPS_code (FK)
* px_group
* px_subgroup
* year
* code_set
* priority
* pop_count

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

## Issues & Decisions
* Standardizing data across states will be important for showing comparisons. We have decided to use the formatting and variable definitions in HCUPnet as our base for querying other states. We hope that age categories and race/ethnicity and payer groups will be defined consistently across states not in HCUPnet.
* We have decided not to use the length of stay or hospital admissions measures, since these are such rare occurences.
* HCUP and the state emergency department databases do not use the same race/ethnicity categories as the US census. This makes calculating population rates by race/ethnicity difficult. We will need to find another solution.
* HCUPnet can be difficult to query when using many filters, so we may need to work with HCUPnet staff if there are any problems with our data processing. There is already an issue of 2016 state-level data disappearing from the database but as of 4/30 they tell me they are working on fixing it.
* We have chosed to focus only on ICD10 codes. The earlier ICD9 codes were used in US hospitals until 2015, at which point they switched to ICD10 codes. There were significant cahnges in codes, with ICD10 beign much more expansive. There are crosswalks for mapping ICD9 codes to ICD10 codes. But the change was abrupt enought to cause some validation issues with comparing pre-2015 ICD9 analysis with post-2015 ICD10 queries. We have chosen to start fresh with 

## Tutorial

This section to be updated with a video tutorial as more data becomes available
