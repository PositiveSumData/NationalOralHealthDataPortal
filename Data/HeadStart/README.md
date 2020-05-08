# Head Start Program Information (PIR) Reports

Head Start is a federally-funded early childhood education program. Organizations receiving Head Start funding owe annual "Program Information Reports" that describes enrollment, staffing, provided services. These reports are aggregated and posted in an annual file on the Head Start Website. There several oral health-related fields for children and pregnant women.

## Utility

Head Start sites serve primarily low-income children who may face increased barriers to accessing oral health care services. PIR reports are a rare insight into these children's oral health status and utilization trends. PIR reports can tell you in a location-specific way what percent of children needed dental treatment and received dental treatment. And for children who did not receive an oral health service, the reports will explain the primary reason why.

### Questions this dataset could help answer

* How many Head Start children in Delaware had an oral examination in 2017?
* Of the Head Start children in Minnesota in 2019 who needed dental treatment services, what percent received them?
* Are Florida Head Start children more likely to have been diagnosed needing dental treatment between 2009 and 2019?
* Which Head Start sites in Oregon have the highest rates of completed oral health examinations?
* Are there geographic disparities in the primary reason why children did not receive oral health exams in Texas?

## Orientation & Stewardship  

The Office of Head Start is part of the HHS Administration for Children and Families. Funding is provided to local agencies -- often non-profits, local governments, schools, religious institutions, or for-profit groups -- to operate early childhood education programs. Head Start programs officially serve children ages 3-5. "Early" Head Start programs serve children younger than three as well as pregnant women. Other special Head Start designations may be applied for migrant or Native American service areas.

Head Start PIR reports are available for download for free from the Head Start website. Researchers must first request a username and login to the database enterprise system by [emailing Head Start directly](https://eclkc.ohs.acf.hhs.gov/data-ongoing-monitoring/article/program-information-report-pir). Approval usually comes within a few hours. Once a username and password is set, users can [log-in](https://hses.ohs.acf.hhs.gov/pir/). Users are then able to query for particular records by region, state, grantee, or program. Full annual downloads are also available for all years 2008-2019.

#### Data use agreements

Positive Sum did not come across an explicit user agreement in obtaining Head Start PIR files, nor are there warnings in the [user guide](https://eclkc.ohs.acf.hhs.gov/sites/default/files/pdf/no-search/pir-reports-user-guide.pdf).  There is cautionary language at the log-in screen making users aware they are entering a government system and may be monitored. 

## Original Data Structure

### Excel spreadsheets & sheets
Head Start PIR files are contained in annual excel spreadsheets. Each annual spreadsheet contains multiple sheets. The spreadsheets and sheets naming schemes are helpfully consistent across years. There are 5 sheets in most years:
* Section A 
* Section B
* Section C
* Program Details
* Reference
* Configuration

The sheets for Sections A/B/C and Program Details share the same basic structure: each row is a unique program grant. Each row is a unique combination of a grant number and a program number. An organization may have multiple grants, and each grant may have several programs. For example, "Community Action Organization of Erie County" is a New York-based organization with one Head Start grant in 2019: grant number 02CH010329. Within that grant they have three programs:
* Program 000, "CAO Head Start" located at 45 Jewett Ave, Buffalo, NY
* Program 001, "Holy Cross Head Start" located at 150 Maryland St, Buffalo, NY
* Program 200 " Community Action Organization of Erie County, Inc" also located at 45 Jewett Ave, Buffalo, NY.

Each of these three programs receives a separate row in sheets Sections A/B/C and Program Details. Program Details contains contact information and grantee and program name details. Section A contains mostly enrollment information. Section B contains staffing information. Section C contains health and services information. 

The Reference sheet is a key for deciphering column headers and cross-walking with the PIR report question numbers. The Configuration sheet seems to describe how a few particular fields were formatted.

Information useful for our project are contained in:
* Section A -- enrollment information to use as denominators 
* Section C -- oral health services information
* Program Details -- address and naming information

### Fields

The first row of Sections A/B/C are descriptive columns headers. The second row has the complete field names listed in a format of Section.Question_group.Question_subgroup.etc. The actual data begins on row 3. The primary key across our tables is a composite of Grant Number and Program Number. 

The specific oral health questions being asked on forms has changed little between 2008 - 2019. The column headings have changed, however. For example, the number of children receiving preventive dental care is found in column C.16 for years 2008 - 2011, but in column C. 18 for years 2012 - 2019. There has also been major change to how the spreadsheet captures the primary reason why children did not receive dental care services. From 2008 - 2011 there were 7 separate 'reason' fields: 
* C.17.b.1 - Insurance does not cover treatment 
* C.17.b.2 - Dental care not available in local area
* C.17.b.3 - Medicaid not accepted by dentist
* C.17.b.4 - Dentists in area do not treat children age 3-5
* C.17.b.5 - Parents did not keep/make appointment 
* C.17.b.6 - Children left prior to appointment
* C.17.b.7 - Appointment date in future

These columns were formatted such that only one 'Yes' answer was found across the columns, indicating which one was the most important reason. The remaining columns contained 'No.' Often all the columns contained 'No'. 

In 2012, two new reason columns were introduced, but also all the reason columns changed from a C.17 to C.19 designation. 

In 2015, a new and preferred table structure was adopted, whereby a single field C.19.b contained the single most important reason. There were no other columns for each individual reason.

Sheet Section A had some column changes over the years as well. A crosswalk of relevant fields across years is available in this [repository](). Section A tells us child enrollment (calculated by summing across ages <1, 2, 3, 4, 5) and pregnant women enrollment.

The Program Details sheet has not changed over time.

### Issues & decisions

In a perfect world, we would design separate database tables to house each of our unique entities:
* Grants
* Grantees
* Programs
* Locations
* Grantee-Program-Year reports

The data as-is is not conducive to such comprehensive normalization. Tracking grants and programs are easy enough since these two entities have unique id numbers (grant numbers are unique, and program numbers concatenated with grant numbers are unique). But the names of the organizations receiving grants is not consistently entered over time. For example, the following five grantees all appear to be the same entity but have different spellings both inside and across grants:
* AREA FIVE AGENCY ON AGING & COMMUNITY SERVICES, INC.
* AREA FIVE AGENCY ON AGING AND COMMUNITY SERVICES, INC.
* AREA IV AGENCY ON AGING AND COMMUNITY ACTION PROGRAMS
* AREA IV AGENCY ON AGING AND COMMUNITY ACTION PROGRAMS,
* AREA IV AGENCY ON AGING AND COMMUNITY SERVICES

It would be easy enough to eyeball these rows and reformat them with the same name or assign a common grantee id value. But there are nearly 19,000 unique grantee-year pairings across the entire dataset. Doing this manually would be tedious and likely introduce human error. 

The program entity shares similar challenges. Names are not consistent. Unique grant-program ids last the duration of the grant and then new ids are assigned during the grant, so that a program that receives 3 grants over 10 years does not have a consistent id to help with trend analysis. 

We have decided to drop the idea of generating unique grantee and program tables for our project. Producing these tables would be a lot of work, certainly with incorrect judgment manually grouping names. Ignoring these entities still serves our overall project, however, because we are mostly interested in state-level aggregation and mapping. We do not need the ability to show utilization trends for a specific grantee or a specific program over time, and we are not trying to compare or analyze a Head Start sites' performance. 

Mapping may still be a little complicated. In the example from New York above, we have three programs across two different addresses. Are the two programs listed at 45 Jewett Ave in the same office? Or perhaps across the hall from each other in a larger office building. If we produce maps where these two locations are treated separately, then dots may overlap and obscure information we are trying to convey. 

We have made the decision to geocode all addresses for the most recent year. We expect users will only want to visualize a most recent map, so we can lessen the burden on our geocoder calls.

Most of our information then is already adequately normalized for unique grant-program-year reporting. We can combine our relevant oral health, enrollment, and contact information into one single sheet. A strong argument could be made for separating the dental measures and unpivoting them into a longer format. Instead, have decided the oral health units of measurement are diverse enough to warrant a wider format for now.

### Design

A LucidChart entity relationship diagram of our table structure is available. Additional tables were 

We use one main table combining Program Details and Sections A & B. Ancillary tables contain metadata for citation.

### Code

[R code]() reads in all the annual PIR report files, reformats them, combines them, and returns csv files for upload to our database. 

Major additions to the data include:
* Adding county FIPS codes and longitude and latitude
* Renaming the main reasons children did not receive dental care

## Project status
Awaiting geocoding and then upload to the database.

## Tutorial
(this section to be updated as tutorials are generated)
