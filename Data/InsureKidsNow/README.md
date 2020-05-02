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


| Data Element Name | Description | Required/Optional |
| ----------------- | ----------- | ----------------- |
| Provider_ID | UniqueProviderIdentifier | Required |
| Prov_AFF | ProviderAffiliation | Optional |
| First_Nm | Provider First Name | Required, if applicable |
| Middle_Nm | Provider Middle Name | Optional |

manadatory submission fields
additional added fields later
pipe separated text file

### Measures



* 



### Dimensions


### Database Design


#### 

Fields:
*
#### 


Fields:
* 

#### 


Fields:
* 

#### source_data_id 


Fields:
* 
#### FIPS

* 

## Issues & decisions
* 
## Project status


## Tutorial

