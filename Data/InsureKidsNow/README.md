# Insure Kids Now (IKN) dental provider database

The [InsureKidsNow.gov](https://www.insurekidsnow.gov/) website is designed to provide help inform caregivers about their Medicaid-enrolled child's dental benefit and to help them locate Medicaid-participating dentists. Given an address and search criteria, the website presents caregivers with a list of dentists and their contact information. A copy of this database was kindly provided to Positive Sum Health Informatics for the National Oral Health Data Portal project. The dataset could help illuminate access disparities, but it does have its limitations.

## Utility

There is no other public dataset can identify the number of Medicaid-participating dentists at specific sites or in a geographic area. The IKN database should be able to help us examine distances Medicaid-enrollees may need to travel to access dental care as well as characteristics of those dentists. The data can be used for point-level mapping or aggregated to city, county, state, or national levels.

### Questions this dataset could help answer

* Are there any dentists who speak Vietnamese in Wayne County, Michigan?
* How many different Medicaid plans are there in California? What are they?
* What is the top dentist in Minnesota by number of sites they service? 
* How many sites in Columbus, Ohio could a Hindi-speaking Medicaid-enrolled family could take children to?
* Which state has the highest rate out-of-state sites participating in its Medicaid program?
* Is it true there are no endodontists participating in Medicaid in Florida?
* Which dental specialty is most likely to have dentists who are accepting new patients?
* Is 116 Street Dental Care PLLC of New York, New York accepting new patients?
* Which plan would a Georgia family want to belong to have the most access to a pediatric dentist?
* Would a developmentally challenged child in Cook, County Illinois be able to find a dentist accepting new patients who offers sedation services?
* What single site in Arizona has the most dental providers practicing at it?
* Do any states list dental hygienists as providers in the InsureKidsNow database?


## Orientation & Stewardship  

The IKN database and the [dentist locator tool](https://www.insurekidsnow.gov/find-a-dentist/index.html) are owned and managed by the Centers for Medicare and Medicaid Services (CMS) in partnership with the Health Resources & Services Administration (HRSA). Data is uploaded on a quarterly basis to the IKN Data Management System by individual state Medicaid agencies according to specific data submission guidelines as outlined in a November 2019 [technical brief](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/InsureKidsNow/Insure%20Kids%20Now%20Technical%20Guidance_November%202019.pdf). 

Each state is required submit data according to a structure where each row is a unique combination of provider, coverage plan, and service location. This means a dentist enrolled in 2 plans at 3 sites would be represented on 6 rows.  

#### Data Use & Citation

CMS does not have a recommended citation listed on their website. The IKN database was provided to Positive Sum without requiring a data use agreement.

CMS provided the extract to our project in March, 2020. 

## Data Structure

The IKN database was emailed to Positive Sum as a pipe-delimited text file. The file included the 27 fields that states may submit to the IKN Data Management System:

### Fields

| Data Element Name | Description | Required/Optional |
| ----------------- | ----------- | ----------------- |
| Provider_ID | UniqueProviderIdentifier | Required |
| Prov_AFF | ProviderAffiliation | Optional |
| First_Nm | Provider First Name | Required, if applicable |
| Middle_Nm | Provider Middle Name | Optional |
| Last_Nm | Provider Last Name | Required, if applicable |
| Grp_Prac_nm | Group Practice Name | Required, if applicable |
| Fac_Nm | Facility Name | Required, if applicable |
| Lang_Spoken | Languages Spoken | Optional |
| Specialty | Provider Specialty | Required |
| Website | Website address of provider | Optional |
| Program_Type | Type of Program | Required |
| Program_Name | Name of Program | Required |
| Health_Plan_Name | Name of entity providing coverage | Required, if applicable |
| Phy_Street_Addr | Provider Physical Site Street Address | Required | 
| City | Provider City | Required |
| State_Abbr | Provider State | Required |
| ZIP | Provider ZIP Code | Required |
| Phone_Num | Phone Number | Required |
| FAX_Num | FAX Number | Optional |
| NEW_PATIENTS | Accepts New Patients | Required |
| Special_Needs | Can Accommodate Special Needs | Required |
| Active_Ind | Active Status | Required |
| Central_appointment_line | Central Appointment Line | Optional |
| License_Num | Dental License Number | Optional |
| Services_Mobility | Facility Can Provider Services for Children with Mobility Limitations | Optional |
| Sedation | Facility Can Provide Sedation for Children with Complex Medical or Behavioral Conditions | Optional |
| Services_Intellectual_Disability | Facility Can Provider Sedation for Children with Complex Medical or Behavioral Conditions | Optional |

These field names as described in the technical documentation do not directly line up with the fields in the file emailed to Positive Sum. The fields provided in the flat file are listed below, which include additions generated by IKN technical staff, most notably geographic identifiers like longitude, latitude, and electoral districts. There was no technical documentation attached.

| Field |
| ----- |
| ACCEPTS_NEW_PATIENTS_DESC |
| ACCEPTS_NEW_PATIENTS_IND |
| ACTIVE_IND |
| APPROX_VALUE_CD |
| CENTRAL_APPOINT_LINE |
| CITY |
| CONG_DIST_ID |
| CONG_DIST_NM |
| CONG_DIST_NUM |
| CONG_DIST_START_DT |
| COUNTY_DESC |
| COUNTY_FIPS_CD |
| COUNTY_ID |
| COUNTY_NM |
| COVERAGE_PLAN_NM |
| CURRENT_COUNTY_IND |
| CYCLE_NAME |
| DW_RECORD_CREATE_DT |
| DW_RECORD_CREATE_DT_TXT |
| FAC_NM |
| FAX_NUMBER |
| FILE_SUBMISSION_ID |
| GEOCODE_STATUS_IND |
| GRP_PRACTICE_NM |
| HEALTH_PLAN_NM |
| IKN_PHONE_ID |
| LANGUAGES_SPOKEN |
| LIC_NUM |
| LIST_BOX_COUNTY_NM |
| LISTING_TITLE |
| LOC_NAME_DESC |
| NAT_PROV_IDENT |
| PHONE_NUM |
| PHY_STREET_ADDRESS |
| PROGRAM_NM |
| PROGRAM_TYPE_NM |
| PROV_AFF |
| PROVIDER_FIRST_NM |
| PROVIDER_FULL_NM |
| PROVIDER_LAST_NM |
| PROVIDER_LAST_NM_SOUNDEX |
| PROVIDER_MIDDLE_NM |
| REGION_CD |
| REGION_ID |
| REGION_NM |
| REPORT_CYCLE_ID |
| REPRESENTATIVE_NM |
| REPRESENTATIVE_URL |
| SEDATION |
| SPECIAL_NEEDS_DESC |
| SPECIAL_NEEDS_IND |
| SPECIALTY |
| STATE_ABBR |
| STATE_COUNTY_FIPS_CD |
| STATE_FIPS_CD |
| STATE_FIPS_CD_CONG_DIST_NUM: |
| STATE_ID |
| STATE_IND |
| STATE_NM |
| SUBMITTING_STATE_ABBR |
| SUBMITTING_STATE_ID |
| SUBMITTING_STATE_NM |
| SVC_INTELLECT_DISABL |
| SVC_MOBILITY |
| US_SENATE_NM1 |
| US_SENATE_NM2 |
| WEBSITE |
| X |
| Y |
| ZIP |
| ZIP4 |
| ZIP5 |

The technical documentation says the National Provider Identification number (NPI) is the preferred value for Provider_ID but that other 'persistent' and unique IDs are allowed. 

### Database Design

The primary data submission guideline for states is that each row represents a unique provider at a unique site in a unique plan. Thinking in terms of a relational database, this means we are working with three unique types of entities that should each have their own tables: providers, plans, and sites. These three entities should be connected via a bridge table. Two additional tables are needed to normalize provider specialties and provider languages.

[This LucidChart](https://www.lucidchart.com/invitations/accept/07b9b85f-44cc-4ce0-873d-5513514fddf2) shows how we have broken the IKN flat file into 6 tables. 

Many fields available in the flat file were dropped as not being useful to our project. These include fields such as electoral district, submission date, provider name pronunciation, and region.

Fields are mapped to the table where each row is unique. For instance, each provider_id should have the same name. Each plan should have the same name and program type. Each site should have the same address. Many fields are only specific to a bridge table: accepting new patients; serving children with special needs; having sedation services varies within a site, within a provider, and within a plan. A provider may be accepting new patients at one site but not another, and a site may have some but not all of its dentists accepting new patients, so the only unique table for ACCEPTS_NEW_PATIENTS_IND is the bridge table.  

#### ikn_provider_site_plan table
This table bridges the plan, provider, and site tables, reflecting the original structure of the flat file. A primary key is generated but a composite primary key based on plan, provider, and site would also work.

#### ikn_site table
Similar challenges exist in the other tables. No unique site IDs are used. The FAC_NM (facility name) field is the closest field to providing a site ID, but the field is not named consistently (an exploratory data analysis finds alternative spellings are used for what appear to be the same site) and a large portion of these values are left NULL. 

Positive Sum decided to generate unique IDs for sites based on two criteria: places with the same X (longitude) and Y (latitude) coordinates and the same FAC_NM. This action rests on several potentially invalid assumptions: 
* Site addresses in the original data were accurate.
* X and Y coordinates were precisely and consistently assigned. Geocoding programs may assign slightly different decimal places of coordinates each time a query is run. If the same site is written with a very specific address in one row, and a less specific address in another row, then the decimal places may be off and the R code would assume these are two different sites.
* FAC_NM is spelled consistently across rows. If alternative spellings are used, each spelling will result in a different site ID. 
* If FAC_NM is NULL, then all providers at the same coordinates are working at the same site. This may not be true in large medical office complexes.

#### ikn_plan table
There are no unique plan IDs in the flat file so integer IDs were auto-assigned using R code based on unique plan names within a state. It was important to assign based on the state because many states have plans simply listed as "Medicaid" and we want to capture that Missouri Medicaid is not the same plan as New Mexico Medicaid.

This mapping rests on the assumption that plans are named consistently within a state. For example, the same plan is not name both Blue Cross and Blue Shield of Ohio and BSBC Ohio within the dataset. Otherwise, these would be assumed to be two different plans. Positive Sum feels fairly confident this field is named consistently.

#### ikn_provider table
This table is the trickiest to build. Theoretically each provider is already required to have a unique ID when states submitted their files to the management system, either as a Type I NPI or an alternative value determined by the state. However, there are many instances of this not happening. Some of the common discrepancies include:
* Type II NPIs (corresponding to organizations) being assigned to individual providers. Type II NPIs are unique to an organization. This means you have many providers sharing the same ID when they belong to the same organization.
* The same type I NPIs being assigned to different dentists. These are data entry errors.
* Missing provider IDs. Tens of thousands of provider IDs are NULL. In the case of California this appears to be because they have used the LIC_NUM (license number) field instead of the provider ID field. But in most other states it appears to be a data entry error.
* Puzzling alternative provider ID scheme. Missouri uses an alternative ID scheme where multiple different IDs are assigned to the same provider.

Positive Sum decided to auto-assign IDs using R code based on a logic scheme: if a type I NPI is present, keep that ID. If a type II NPI is present, delete it. If provider ID is not null, auto-assign a unique integer based on a unique first name, last name, license number (if present), and submitting state. This bases the provider ID on the provider's full name, hoping there are few providers of the same name in the same state, with ties hopefully decided by the license number. This logic may be ideal for now, but it fails for several additional reasons:
* It assumes the same provider working in different states are different people.
* It assumes the LIC_NUM (license number) field is used frequently enough to break ties.
* It assumes provider have the same full names across rows. This is categorically not true based on exploratory data analysis. Usually this fails because of different use of hyphenated names, alternative first names, or abbreviations.

Besides the provider_id field, the only other field retained in the provider table is mode_name. This field was created by Positive Sum as the most frequently used spelling of a unique provider_id, since some method was needed to decide what to do when there were alternative spellings used across rows. 

#### specialty and language tables
The two other provider-specific characteristic in the IKN flat file -- specialty and language -- receive their own tables. This is because providers may speak multiple languages and work in multiple specialties. These instances in the flat file are represented as comma-separated lists of specialties and languages. To make this information quotable, we need to normalize these fields. R code was used to manipulate the comma separated lists into unique rows.

#### Organizations
A fourth important type of entity is also present -- the provider organization -- but the dataset is not coded in a way to support indexing on organizations. The only relevant field, GRP_PRACTICE_NM (group practice name), corresponding to the name of the organization, is not named consistently across rows and is not unique across state lines. Ideally there would be a unique organization ID to address this, but it does not exist at this time.

## Modifications & External Connections
IDs for each table have been created when there weren't unique keys provided. Unique site IDs are created for unique organization names at unique latitudes and longitudes. Unique provider IDs are created from NPIs or other provider IDs in the database, or if these are missing then keys are generated based on unique names. When values for such fields as 'accepts new patients' or 'provides mobility services' are listed as 'U' or "u', these are coerced into null values. 

A new provider table field called 'fractions' is created to show how much weight to apply each provider when calculating a site "FTE" value. Since so many providers are listed at being at multiple sites, we create a site weight of 1/(total # provider sites) such that a dentist at 4 sites gets 0.25 FTE weight at each site. If there are 3 0.25 dentists at one site, that site has 0.75 dentist FTEs by this calculation. The ADA Health Policy Institute uses a similar deflator in its calculations from the InsureKidsNow database, but goes further by adjusting for provider age (older being less productive), but this project doesn't have access to provider ages.

## Issues & decisions

**Null values**. A user of the Tableau visualization will notice a high number of null values under each of the provider/site characteristic breakouts. These nulls represent either 'unknown' or missing entries in the raw database that was provided to Positive Sum. 

**Validity**. Positive Sum feels the IKN database is a fine tool for mapping where provider sites most likely are and what service characteristics they offer. But there are too many instances of providers being registered to a suspiciously large number of sites that this dataset is probably not so useful for calculating county counts or being relied upon too definitively for dental care access. For now, the project will limit this dataset to point location maps.

## code

The [Github repository folder](https://github.com/PositiveSumData/NationalOralHealthDataPortal/upload/master/Data/InsureKidsNow) for this dataset contains the R code file used to modify the original IKN data file into smaller files.

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/CMSInsureKidsNowDatabase/Orientation).

## Project Status & Next Steps
The Tableau dashboard is up. Feedback is welcome. We will request another copy of the database in 2021 to refresh.
