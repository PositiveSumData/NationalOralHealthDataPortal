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

### AHRQ 

Some of the data we are collecting comes from the Agency for Healthcare Research and Quality's [HCUP project](https://www.ahrq.gov/data/hcup/index.html). HCUP is a collection of related hospital databases, including the Kid's Inpatient Database (KID), Nationwide Emergency Department Sample (NEDS), Nationwide Readmissions Database (NRD), State Inpatient Databases (SID), State Ambulatory Surgery and Services Databases (SASD), and State Emgerency Departmetn Databases (SEDD). These are each collections of state databases that may or may not have universal participation. HCUP facilitates the research of these datasets. To study individual-level data a researcher will need to purchase data from HCUP and sign data use agreements. 

These databases include samples of their state populations of hospital utilizers. They do not include everyone who visited an emergency department or ambulatory surgery center, so results should be interpreted with confidence intervals.

Our project is most interested in SEDD and NEDS, which illuminates state adn national-level ED visits that did not result in an admission. Hospital admission for dental conditions is a serious event that is rare enough to make statistically significant conclusions difficult. 

### HCUPnet

AHRQ offers the HCUPnet platform (https://hcupnet.ahrq.gov/#setup) for querying some of these databases. Queries are a manual process of selecting the appriate database, choosing types of results to display, selecting the year and code sets, and then fine-tuning with pouplation characteristics. Results are aggregated and censored to protect patient confidentiality when cell sizes are small. The results are provided as a downloadable CSV. No more than 15 states have data included in the HCUPnet system, and state availablility depends on the year and other selectors chosen. The only HCUPnet option with county or regional granularity is the 'Community' setting database, which unfortunately in our case only includes cases resulting in hospital admission. The HCUPnet CSVs must be cleaned up and reformatted before they can be entered in the ASTDD database.

### Citation

The citation recommendation attached to each HCUPnet CSV download is: 
```
Citation: HCUPnet, Healthcare Cost and Utilization Project. Agency for Healthcare Research and Quality, Rockville, MD. http://10.35.1.231/. For more information about HCUP data see http://www.hcup-us.ahrq.gov/
```

### Individual states

Data not available in HCUPnet or the wider HCUP project is usually available by direct relationship with a state. The steward of each state's ED data varies. It may be the department of health, or the hospital association, or another entity. They may charge various rates for obtaining their data, and data definitions may or may not be consistent between states. This section will be updated as more information on state-based entities becomes available.



# Tutorial
. 


owner
Data use agreement

## Structure

### Code sets
NTDC
Any dental
CPP

### Fields

### Database diagram
* states included, missing
* purpose and uses of the dataset
* questions the dataset could answer
* ERD diagram
* citation
* URL to HCUPnet
* backbone is HCUPnet
* code sets


## Heading 2

hello

```
test 1
```

### Heading 2.1

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

### Heading 2.2

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.


## Issues & Decisions
