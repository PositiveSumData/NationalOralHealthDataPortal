# Health Resources & Services Administration (HRSA) Uniform Data System (UDS)

Federally-qualified health centers (FQHC's) are HRSA-designated non-profit community health centers meeting certain program criteria and receive federal funding. A condition of such funding is submission of annual service data. HRSA aggregates all the health center data into annual reports available for public download. 

## Utility

FQHCs serve primarily low-income families with primary care and (oftentimes) dental care. Analyzing annual UDS reports can give us insights into the type and counts of dental care services being provided. Data is reported at the FQHC organizational level which can be helpful for understanding community-level access, or data can be aggregated to state and national levels for broader analysis. The UDS is the source of one measure in the National Oral Health Surveillance System: "Population Receiving Oral Health Services at Federally Qualified Health Centers." 

### Questions this dataset could help answer

* What percent of FQHC patients in Minnesota received a dental service in 2018?
* How has the proportion of FQHC patients receiving emergency dental care changed over the past 10 years? 
* Has the number of FQHC Dentist FTEs changed much in California since 1996?
* Has the proportion of FQHCs offering on-site dental services changed considerably since 2004?
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
* **Table 3B**. Total patients served.
* **Table 5**. Medical and dental visit totals, FTEs.
* **Table 5A**. # FTEs for dentists, dental hygienists, and dental therapists.
* **Table 6A**. # of diagnoses and # people provided services dental: emergencies, oral exams, prophylaxis, sealants, fluoride treatment, restorative services, oral surgery, and rehabilitative services. 
* **Table 6B**. Children ages 6-9 at moderate to high risk for caries who receive a dental sealant.
* **Table6BClinicalMeasures**. Additional sealant information.
* **Table8A**. Operational costs of dental services.

### "Non-Proprietary and Proprietary with Consent"

HRSA does not make all of the UDS data public. They share only data they deemed as "non-proprietary" or data that is "proprietary with consent." As explained on their [website](https://www.hrsa.gov/foia/uds-public-use.html):

> The data in the blank rows of Tables 5, 8A, and 9D is being withheld under Exemption 4 of the FOIA, 5 U.S.C. 552(b)(4). This exemption protects against the release of proprietary confidential business and financial information, which, if disclosed, could provide potential competitors with an unfair advantage, including in future grant competitions.

For an FQHC to make their proprietary Table 5, 8A, or 9D data public, they need to actively consent. From an exploratory data analysis, we see that 69 FQHCs consented to sharing their Table 5 data in 2018, compared to 1293 who did not.  This ratio is so small that including these tables in our project for analysis is not valuable. We therefore choose to focus on only Table 6A and 6B non-proprietary dental reporting. Although it is not mentioned in the legal disclaimer, Table 5A appears to be considered proprietary as well, because so many FQHCs having missing informatino. 

A strategery for learning about these proprietary measures is to ask HRSA for state-aggregated data that shields the individual FQHCs. Another strategy is to pull these figures directly from health center data pages on the HRSA website. HRSA allows users to look up individual health centers and see top-line patient counts that are otherwise withheld from FOIAs.

### Data continuity

Consolidating all the annual UDS files into one database can be tricky because the UDS reporting structure has changed over time. Some of these examples include:
* Starting with the first available dataset in 1996,  dental services (including preventive, restorative, and emergency care) were recorded on Table 2. Rehabilitative dental services were added to Table 2 in 2001. These measures were used through 2007, at which point Table 2 was deleted from the UDS.
* The more comprehensive list of dental measures we know today began in 2004 in Table 6. They were moved to Table 6A in 2008.  From 2001-2007 there were dental services measures reported on both Table 2 and Table 6 until Table 2 was deleted entirely.
* The first oral health quality measures were included beginning in 2015 on Table6B. Table 6B was itself added in 2008.
* Dental operational costs do not appear to have been included pre-2000. 
* Dental therapist measures first appeared in 2016.
* Detailed site-level data began being collected in 2011. 
* Pre-2000 data are not presented by Table. Rather they are grouped into a fewer number of sheets with varying naming conventions.

We must also be careful of slight changes to column and sheet names over time. For example, from 2011-2018 table names use a simple syntax 'Table5, Table6, Table8A, etc.' From 200-1010 the syntax was 'tblTable5, tblTable6, tblTable8A, etc.'. Before 2000 there was an entirely different naming structure, with tables grouped into sheets with various titles that change each year. From 2004-2018 columns used all capitalized letters, but for 2000-2003 the table was lowercase. For example: t5_L15_C vs T5_L15_C. Pre-2000 columns were in all caps but without underscores. For a complete layout of the data structure evolution over time, see [this crosswalk document](https://github.com/PositiveSumData/NationalOralHealthDataPortal/blob/master/Data/HRSA_UDS/UDS%20crosswalk.xlsx). 

## Issues & decisions

### Ignoring Tables 5, 5A, and 8A

So few health centers elect to make their proprietary data public in TAbles 5, 5A, and 8A that we have decided it is not worth consolidating their data or producing dashboards.

### Reporting Granularity & Geocoding

Except for Table HealthCenterSiteInfo, which lists all a health centers locations, all other UDS data is aggregated to the organizational level. This helps us understand oral health care utilization within an organization, but cannot tell us about oral health care activities at the site level. We do not know which health center site locations offer dental services, nor do we know how dentist FTEs are distributed or what differences there might be in oral health care between sites. 

Therefore we have decided not to map individual FQHC site locations. Doing so might help convey a sense of service area, but we would not want to mislead users into thinking there are oral health services offered when there are not.

### Organizational Continuity

Within each UDS reporting year, FQHCs are assigned an ID number that helps link all the reporting tables together. This is called the BHCMISID in most recent years and the gi_lnggranteeid or Grantee ID in early years. These ID numbers change with new grant cycles. Health center funding is awarded in several-year chunks, and then a new number may be assigned in the next grant cycle if a health center keeps its funding. This cycling of FQHC ID's makes it challenging to examine an individual organization's oral health care trends over time, since there is not master index linking grant cycles. To address this issue, we submitted a FOIA request to HRSA on June 1, 2020 requesting a master key table to link organizations across years. This project will be updated if a master key is provided. Until then, the project will not design dashboards to show individual FQHC trends.

### Missing Denominator & Web-Scraping

Table 6A gives us the count of patients at every FQHC that received several types of oral health services. Ideally we would then calculate (1) the percent of patients at each FQHC who received each type of dental service, and (1) the percent of **dental** patients at each FQHC who received each type of dental service. These denominators are not located in Table 6A. The total count of health center patients is publicly available in Table 3B, but the total count of dental patients is hidden in Table 5, and therefore exempt from FOIAs. Interestingly, the data is publicly available on the HRSA website if one looks within the indiviual health center data pages. For example, we can see that Family Health Center, inc in Kalamazoo, Michigan served (9,580 dental patients)[https://bphc.hrsa.gov/uds/datacenter.aspx?q=d&bid=056230&state=MI&year=2018] in 2018. Years 2016 and 2017 data are also publicly displayed for all health centers on the HRSA webpage. 

By web-scraping the HRSA website (see R code), we have gathered all health-center level total dental patient counts for years 2016-2018. We had hoped this would allow us to use these values as denominators in a % total dental patients calculation. However, not enough health centers have such data on the website to make state-level aggregations reliable. Seeing a potential opportunity in accessing just this one piece of exempt, we submitted a FOIA request to HRSA on June 1, 2020 seeking data from previous years. Until then, we have chosen not to use these numbers in the Tableau Dashboards until we have more information.

### Restricing Scope to Years 2004-2018

In response to a FOIA request, HRSA provided data going back to 1996. However, the most useful dental services fields were not introduced until 2004, so we begin there. 

## Design

We produced three csv's of UDS data covering the years 2004-2018. These tables are described in LucidCharts [here](https://app.lucidchart.com/invitations/accept/eac15c34-7d40-4af5-beb9-8358162a6e5b). 

### table patients_and_visits

This table consolidates Tables 3B and 6A, which contain visit and patients counts for all and types of dental services.

### table healthcenterinfo

This table gives the name and address of each health center organization in each year. We include the year variable because we do not have a key linking health centers across years. 

### table6B_quality

This table gives the number at-risk children ages 6-9 (the denominator) and the number of at-risk children ages 6-9 who received a dental sealant (numerator) for each health center in each year since 2015, when this measure was introduced.


## Code

The R code in this repository will extract meaningful data from UDS spreadsheets and web-scrape data from the HRSA website.


## Project status & Next Steps

The data has been visualized with Tableau Public Dashboards [here](https://public.tableau.com/views/HRSAUDS/InterState?:display_count=y&publish=yes&:origin=viz_share_link), focusing on national and state level aggregations instead of showing organization-level data.

### Questions

* Decide if should only visualize FQHC data or include lookalikes as well
* Decide if should visualize funding type stratifications (e.g. homeless, migrant, public housing) or if having these is confusing

## Tutorial 

