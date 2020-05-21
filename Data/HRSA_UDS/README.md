Skip to content
Search or jump to…

Pull requests
Issues
Marketplace
Explore
 
@PositiveSumData 
PositiveSumData
/
NationalOralHealthDataPortal
1
0
0
 Code
 Issues 0
 Pull requests 0 Actions
 Projects 0
 Wiki
 Security 0
 Insights
 Settings
NationalOralHealthDataPortal/Data/HRSA_UDS
@PositiveSumData PositiveSumData Create HRSA_UDS
a772b33 17 seconds ago
80 lines (50 sloc)  7.17 KB
  
# Health Resources & Services Administration (HRSA) Uniform Data System (UDS)

Federally-qualified health centers (FQHC's) are HRSA-designated non-profit community health centers meeting certain program criteria and receive federal funding. A condition of such funding is submission of annual service data. HRSA aggregates all the health center data into annual reports available for public download. 

## Utility

FQHCs serve primarily low-income families with primary care and (oftentimes) dental care. Analyzing annual UDS reports can give us insights into the type and counts of dental care services being provided. Data is reported at the FQHC organizational level which can be helpful for understanding community-level access, or data can be aggregated to state and national levels for broader analysis. The UDS is the source of one measure in the National Oral Health Surveillance System: "Population Receiving Oral Health Services at Federally Qualified Health Centers." 

### Questions this dataset could help answer

* What percent of FQHC patients in Minnesota received a dental service in 2018?
* How has the proportion of FQHC patients receiving emergency dental care changed in Arkansas over the past 10 years? 
* Has the number of FQHC Dentist FTEs changed much in California since 1996?
* Has the proportion of FQHCs offering on-site dental services changed considerably in Indiana since 2004?
* Which FQHCs have the highest rates of their patients receiving preventive dental care?
* Which FQHCs in Iowa provide restorative dental care?
* Which regions in Oregon have the lowest utilization of preventive dental care in FQHCs?

## Orientation & Stewardship  

HRSA posts annual UDS reports to their [Electronic Reading Room](https://www.hrsa.gov/foia/electronic-reading.html) in excel spreadsheets. As of May 2020, the most recently posted annual file was for 2018. The files are structured the same as the reporting form: with different 'tables' corresponding to different information categories listed as different sheets in a spreadsheet. Data previous to 2014 is only available by FOIA request, which HRSA provided going as far back as 1996.

#### Data use agreements

HRSA provides UDS data as-is on their website or by FOIA request. No data use agreement is required.

## Original Data Structure

Each annual UDS file is structured to replicate that year's reporting form. Each year's form has series of 'tables', each of which has reporting lines and columns. For example, in 2018 a health center reported the number of full and part time dentists on table 5A, line 16, column A. The annual reporting files in the Electronic Reading Room are structured with each table corresponding to a different sheet in an excel spreadsheet, with each FQHC organization occupying one row of each table. For the example above, the FQHC full and part time dentist value would be found in sheet 'Table5a' in the column T51_L16_Ca. 

There are many tables in the report. Most tables are not relevant to our project because they do not contain oral health-related information or patient totals we can use as denominators. Relevant tables and columns in 2018 include:

* **HealthCenterInfo**. Name and primary location of each health center organization.
* **HealthCenterSiteInfo**. Name and location of all sites belonging to an organization.
* **Table 5**. Medical and dental visit totals, FTEs.
* **Table 5A**. # FTEs for dentists, dental hygienists, and dental therapists.
* **Table 6A**. # of diagnoses and # people provided services dental: emergencies, oral exams, prophylaxis, sealants, fluoride treatment, restorative services, oral surgery, and rehabilitative services. 
* **Table 6B**. Children ages 6-9 at moderate to high risk for caries who receive a dental sealant.
* **Table6BClinicalMeasures**. Additional sealant information.
* **Table8A**. Operational costs of dental services.

### Missing Data

HRSA does not automatically make all of an FQHC's annual UDS report public. As explained on their [website](https://www.hrsa.gov/foia/uds-public-use.html):

> The data in the blank rows of Tables 5, 8A, and 9D is being withheld under Exemption 4 of the FOIA, 5 U.S.C. 552(b)(4). This exemption protects against the release of proprietary confidential business and financial information, which, if disclosed, could provide potential competitors with an unfair advantage, including in future grant competitions.

For an FQHC to make their Table 5, 8A, or 9D data public, they need to actively opt-in to sharing. From an exploratory data analysis, we see that so few FQHCs opt-in that it is not valuable to aggregate or visualize any individual FQHC data for those tables. From our analysis it appears also that Table 5A is covered under the special exemption, because so much of the data is missing. HRSA can provide data from those tables aggregated to the state-level, however, and they have done so in a separate FOIA request.

The valuable Tables 6A and 6B are not exempt from public reporting and therefore we can examine the different types of dental services being offered by all FHQC organizations.

### Data continuity

Consolidating all the annual UDS files into one database can be tricky because the UDS reporting structure has changed over time. Some of these examples include:
* Starting with the first available dataset in 1996,  dental services (including preventive, restorative, and emergency care) were recorded on Table 2. Rehabilitative dental services were added to Table 2 in 2001. These measures were used through 2007, at which point Table 2 was deleted from the UDS.
* The more comprehensive list of dental measures we know today began in 2004 in Table 6. They were moved to Table 6A in 2008.  From 2001-2007 there were dental services measures reported on both Table 2 and Table 6 until Table 2 was deleted entirely.
* The first oral health quality measures were included beginning in 2015 on Table6B. Table 6B was itself added in 2008.
* Dental operational costs do not appear to have been included pre-2000. 
* Dental therapist measures first appeared in 2016.
* Detailed site-level data began being collected in 2011. 
* Pre-2000 data are not presented by Table. Rather they are grouped into a fewer number of sheets with varying naming conventions.

We must also be careful of slight changes to column and sheet names over time. For example, from 2011-2018 table names use a simple syntax 'Table5, Table6, Table8A, etc.' From 200-1010 the syntax was 'tblTable5, tblTable6, tblTable8A, etc.'. Before 2000 there was an entirely different naming structure, with tables grouped into sheets with various titles that change each year. From 2004-2018 columns used all capitalized letters, but for 2000-2003 the table was lowercase. For example: t5_L15_C vs T5_L15_C. Pre-2000 columns were in all caps but without underscores. For a complete layout of the data structure evolution over time, see [this crosswalk document](must finish editing and upload). 

### Issues & decisions

### Design

This section to be updated as our Lucid Charts are designed

### Code

This section to be updated as R code is created to consolidate all the annual files into database tables and geocode all the site addresses.


## Project status


## Tutorial
(this section to be updated as tutorials are generated)
© 2020 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
