# Behavior Risk Factor Surveillance System

The Behavior Risk Factor Surveillance System (BRFSS) is a CDC-stewarded, state-administered phone survey of American adults that can help us learn about the prevalence of health conditions, including dental visits and tooth loss severity.

## Examples of questions this dataset could help answer

* What percent of New Mexico adults have any/severe/complete tooth loss?
* Are any race/ethnicities in Pennsylvania more likely to have visited the dentist than others?
* Has the percent of Rhode Island adults who visited the dentist changed over time?
* Which metro areas have the highest prevelance of complete tooth loss?

## Utility

BRFSS is the main source for monitoring rates of adult annual dental visits and severe tooth loss. It can be used for state-level estimates and, if sample sizes are large enough, counties or metropolitan areas.

## Orientation & Stewardship  

The BRFSS survey is designed by the CDC and carried out by states. The CDC collects survey responses from the states and makes them available through their [BRFSS microsite](https://www.cdc.gov/brfss/annual_data/annual_2019.html) as annual files. As a complex survey, statistical software is needed to analyze the raw data. [Their Web-Enabled Analysis Tool (WHEAT)](https://nccd.cdc.gov/weat/#/analysis) helps users query BRFSS data without needing statistical software. 

States may append the standard BRFSS questionnaire with their own additional questions, and these may or may not appear in the CDC BRFSS database, so states can sometimes have additional useful data if contacted directly.

The CDC recommends the following citation when using their online BRFSS database:

> Centers for Disease Control and Prevention (CDC). Behavioral Risk Factor Surveillance System Survey Data. Atlanta, Georgia: U.S. Department of Health and Human Services, Centers for Disease Control and Prevention, [appropriate year].

The analyzed BRFSS data used in this National Oral Health Data project is a combination of reports downloaded from the CDC WEAT query system, and from data in 2020 by Kathy Phipps, PhD, data consultant to the Association of State & Territorial Dental Directors.

## Data Structure

BRFSS data is presented in two files in this Github repository folder:

* **BRFSS_prime.csv**. Contains all the prevalence estimates for dental visits and tooth loss severity in one file. Each row is a unique year-geography-question-response-population_catogery-population_subcategory. 

* **BRFSS_CI.csv**. Contains confience interval data unpivoted such that there are twice as many rows as in the BRFSS_prime file, with an upper 95% confidence interval row and a lower 95% confidenced interval row for every unique pair from BRFSS_prime. This file is formatted for data visualization software to draw confidence intervals. The CI_order column counts upwards from the lowest year in the lower CI, then the highest year in the lower CI, then the highest year in the upper CI, then the lowest year in the upper CI. This helps a program like Tableau 'connect the dots' in the shape of a polygon. 

## Issues & decisions

Users should be aware that data is based on self-reported phone surveys. Clinicians have not verified reponsdent's tooth loss severity and administrative records cannot verifity dental visit frequency.

Sample sizes in BRFSS can be quite low in states, leading to unstable estimates at the county level or lower, especially when slicing by population characteristics. Kathy Phipps has provided estimates for many large metropolitan areas without population stratifications because adding stratifications would reduce samples sample size. 

## Tableau Presentation

The presentation is located on [Tableau Public](https://public.tableau.com/profile/association.of.state.territorial.dental.directors#!/vizhome/BehaviorRiskFactorSurveillanceSystem/Welcome).

Four dashboards are presented:
* **State Compare**. For comparing states on a selected measure and population characteristic.
* **State Details**. For examining all state characteristics in a single year at once.
* **State Historical**. For examining trends in a selected state measure and population.
* **State Tooth Loss Severity**. For examining any/severe/total tooth loss by population characteristic in a state at the same time.
* **Metro Compare**. For comparing metropolitan areas on a selected measure (without population stratifications)

## Status & Next Steps

Because of sample size issues the confidence intervals on many estimates is quite large or even prohibited some analyses altogether (e.g. counties and many metro areas). Perhaps years could be grouped together to increase sample size in a future analysis.

