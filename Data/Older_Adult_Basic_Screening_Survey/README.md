# Older Adult Basic Screening Survey

The Basic Oral Health Screening Survey for Older Adults are periodically conducted by states to inspect the mouths of adults attending nursing homes, assisted living facilities, and congregate meal sites.

## Examples of questions this dataset could help answer

* What percent of California older adults need periodontal care?
* Are there differences by race/ethnicity of the percent of older adults in Nebraska nursing homes with untreated oral decay?
* What percent of Wisconsin older adults have no/early/urgent dental treatment needs?

## Utility

By having oral health providers record what they see in older adults' mouths, we see can learn more detail about the oral health of older adults than could be laerned from a self-reported survey or questionnaire.

## Orientation & Stewardship  

Several of the measures collected in the Older Basic Screening Survey are part of the National Oral Health Surveillance System (NOHSS). In a cooperative agreement between the CDC and ASTDD, maintains a Basic Screening Survey Toolkit and offers technical assistance to states to assist in designing the survey methodology and carrying out the logistics of visiting older adult living facilities. 

States are responsible for funding and conducting the Basic Screening Surveys. These are most often conducted for child populations, but occasionally states will survey older adults as well. Some measures are similar to the child surveys, such as assessming treatment needs and untreated tooth deacay. But older adults aren't measured for dental sealant placement, and children aren't measured for denture use or soft tissue conditions like oral lesions and perdiontal care needs. 

States often publish the results of their Basic Screening surveys as pdf documents primarily oriented for reading, with narrative text, small tables, and charts. Excel files or CSVs containing more database-structure data. 


## Data Structure

Original data structures are unique to each state's report. 

## Issues & decisions

**Variable consolidation**. In an effort to make the National Oral Health Data Portal as standardized as possible and promote comparisons between states, only frquently collected measures were consolidated into a common file. Only prevalence measures expressed as a percent were kept. Measures like counts of teeth (e.g. 'mean number of decayed teeth') were excluded because they were only asked by one or two states. The names of measures or categories were also changed to be consistent. For example, Michigan used the term 'immediate care' whereas Califonia used the term 'urgent care' describe the most severe class of treatment need. These have been consolidated to 'urgent care.'

**Few state surveys available**. Few states conduct older adult basic screening surveys. Only nine states have been included into one National Oral Health Data Portal dataset. These nine reflect states for which a survey was obtained that had been conducted since 2015. We chose 2015 as a cutoff for which data would still be useful for policy. To try to compare states on measures, all these state reports since 2015 have bene presented together. This is not ideal, since it cannot account for differences that may have arised between when Nebraska conducted their survey in 2019 and North Carolina conducted their survey in 2015-2016. 

**Comprability across residency setting**. States choose one setting in which to visit seniors and record their oral health. These settings are usually nursing, assisted living, or congregate meal site facilities. It may not be appropriate to compare one state's performance in nursing facilities to another state's performance in congregate meal sites. These reports cannot be used to extrapolate about the oral health of an entire state's older adults. These facility differences are recorded in the Tableau visualizations.

**Different dentition denominators**. State survey reports will usually indicate whether a prevalence applies to all the older adults it sampled or only to older adults of a certain dentition. For example, a state may present the percent, of older adults with at least one or more teeth, what percent had untreated decay. Whereas another state may record the prevalence of untreated decay among all adults sampled, regardless of whether they have any teeth. This presents a comparability challenge, because adults without any teeth are probably not going to have tooth decay. Such denominator differences are recorded in the Tableau visualizations. 

## Tableau Presentation

Two Tableau dashboards are presented:

* **State Details Dashboard**. For examining avilable information for a selected state without comparing to other states.

* **States Comparison Dashboard**. For examining differences between states. Since there are so few states and so many comparability challenges, we have chosen not to visualize a map. Rather, we present a table with the many different types of variables users should understand when comparing states against each other. 

## Status & Next Steps

If more state reports are available to be included in this project, please let us know and we'll add them in. 
