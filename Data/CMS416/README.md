# Insure Kids Now (IKN) dental provider database


## Utility


### Questions this dataset could help answer

* Are 

## Orientation & Stewardship  


#### Citation



#### Data use agreements


## Data Structure

state vs national. same within geo level.
how to read in across different sheets


### Fields


The technical documentation says the National Provider Identification number (NPI) is the preferred value for Provider_ID but that other 'persistent' and unique IDs are allowed. 

### Database Design

are mapped to the table where each row is unique. For instance, each provider_id should have the same name. Each plan should have the same name and program type. Each site should have the same address. Many fields are only specific to bridge table: accepting new patients, serving children with special needs, or having sedation services varies within a site, within a provider, and within a plan. A provider may be accepting new patients at one site but not another, and a site may have some but not all of its dentists accepting new patients, so the only unique table for ACCEPTS_NEW_PATIENTS_IND is the bridge table.  

#### ikn_provider_site_plan table

#### specialty and language tables

#### Organizations

## Issues & decisions

## Modifications & External Connections

## Project status


## Tutorial

