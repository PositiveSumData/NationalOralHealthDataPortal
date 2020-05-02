# Insure Kids Now (IKN) dental provider database

The [InsureKidsNow.gov](https://www.insurekidsnow.gov/) website is designed to provide help inform caregivers about their Medicaid-enrolled child's dental benefit and to help them locate Medicaid-participating dentists. Given an address and search criteria, the website presents caregivers with a list of dentists and their contact information. A copy of this database was kindly provided to Positive Sum Health Informatics for the National Oral Health Data Portal project. The dataset could illuminate all sorts of aspects of our dental safety net. Although, as the database was not designed for public health analysis, it has its issues. The technical team at CMS is looking into these issues so that we can reliably include it in our portal. 

## Utility

There is no other public dataset can can identify the number of Medicaid-participating dentists at specific sites or in a geographic area. The IKN database should be able to help us examine distances Medicaid-enrollees may need to travel to access dental care as well as characteristics of those dentists. The data can be used for point-level mapping or aggregated to city, county, state, or national levels.

### Questions this dataset could help answer

* Are there any dentists who speak Vietnamese in Wayne County, Michigan?
* How many different Medicaid plans are there in California? What are they?
* What is the top dentist in Minnesota by number of sites they service? 
* How many sites in Columbus, Ohio could a Hindi-speaking Medicaid-enrolled family could take children to?
* Which state has the highest rate out-of-state sites participating in its Medicaid program?
* Is it true there are no endodontists participating in Medicaid in Florida?
* Which dental specialty is most likely have dentists who are accepting new patients?
* Is 116 Street Dental Care PLLC of New York, New York accepting new patients?
* Which plan would a Georgia family want to belong to have the most access to a pediatric dentist?
* Would a developmentally-challenged child in Cook, County Illinois be able to find a dentist accepting new patients who offers sedation services?
* What single site in Arizona has the most dental providers practicing at it?
* Do any states list dental hygienists as providers in the InsureKidsNow database?


## Orientation & Stewardship  

The IKN database and the [dentist locator tool](https://www.insurekidsnow.gov/find-a-dentist/index.html) is owned and managed by the Centers for Medicare and Medicaid Services (CMS) in partnership with the Health Resources & Services Administration (HRSA). Data is uploaded on a quarterly basis to the IKN Data Management System by individual state Medicaid agencies according to specific data submission guidelines as outlined in a Nov. 2019 [technical brief](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/InsureKidsNow/Insure%20Kids%20Now%20Technical%20Guidance_November%202019.pdf). 

Each record submitted is a uniqe combination of provider, coverage plan, and service location. This means a dentist enrolled in 2 plans at 3 sites would be represented on 6 rows. 

#### Citation

CMS does not have a recommended citation listed on their webiste. Positive Sum has inquired to see if there is a citation style they prefer.
```

```

#### Data use agreements

The IKN database was provided to Positive Sum without requiring a data use agreement.

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
| Lang_Spoken | Langauges Spoken | Optional |
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
| Special_Needs | Can Accomodate Special Needs | Required |
| Active_Ind | Active Status | Required |
| Central_appointment_line | Central Appointment Line | Optional |
| License_Num | Dental License Number | Optional |
| Services_Mobility | Facility Can Provider Services for Children with Mobility Limitations | Optional |
| Sedation | Facility Can Provide Sedation for Children with Complex Medical or Behavioral Conditions | Optional |
| Services_Intellectual_Disability | Facility Can Provider Sedation for Children with Complex Medical or Behavioral Conditions | Optional |

These field names as described in the technical documentation do not directly line up with the fields in the file emailed to Positive Sum. The fields provided are listed below, which inlcude additions generated by IKN technical staff, most notably geographic identifiers like longitude, latitude, and electoral districts.

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

[This LucidChart](https://www.lucidchart.com/invitations/accept/07b9b85f-44cc-4ce0-873d-5513514fddf2) shows how we have broken the IKN flat file into 6 tables. 

#### 

Fields:
*
#### 


* 

## Issues & decisions
* 
## Project status


## Tutorial

