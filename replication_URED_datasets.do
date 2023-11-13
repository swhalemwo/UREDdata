/*----------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
Code for replicating the Urban-Rural Electoral Divides dataset
	
Note: 

1. All countries have separate .do-files for preparing the election outcome data 
in a harmonised format. These .do-files are named

harmonise_[country_code] 


2. After getting the data in the right format, all countries have separate 
.do-files for harmonising the data further. These .do-files are named

data_merge_[country_code]

3. All above mentioned .do-files can be executed in this replication .do-file, 
but if you need to modify them, you can do so in the original .do files. 

4. For this replication .do-file to work correctly, 
please make sure to save all abovementioned .do-files in a folder that 
corresponds to the current working directory that is specified below.


Outline of this replication .do-file

1. 	Create datasets that include all available election results for each 
	country separately in a shared format: country-year-region-party
2. 	Harmonize the country-specific data further in the country-year-region-party
	formats and also aggregate to a country-year-party format
3. 	Merge all harmonized country-specific datasets into both a 
	country-year-region-party format and ...
4. 	... into a country-year-party, and ...
5. 	... aggregate to the election level: country-year format

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------*/	


* set  path 
global path "C:\Users\twan_\OneDrive\Documents\PhD project\paper 4b"

*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	note: change all paths in the separate .do-files


/*----------------------------------------------------------------------------
------------------------------------------------------------------------------
1. Create datasets that include all available election results for each 
country separately in a shared format: country-year-region-party
------------------------------------------------------------------------------
-----------------------------------------------------------------------------*/	

*!!! NOTE:	Please consult all .do-files below to make sure you have downloaded
* 			all necessary election outcome data first

* Run all harmonise_[country_code] files
clear all 

* Australia
do "$path\Data\AUS\harmonise_AUS.do"
do "$path\Data\AUS\harmonise_AUS_round2.do"

* Austria 
do "$path\Data\AT\harmonise_AT.do"
do "$path\Data\AT\harmonise_AT_pres.do"


* Canada
do "$path\Data\CA\harmonise_CA.do"

* Switzerland 
do "$path\Data\CH\harmonise_CH.do"

* Denmark
do "$path\Data\DK\harmonise_DK_7922.do"

* Spain 
do "$path\Data\ES\harmonise_ES.do"

* France 
do "$path\Data\FR\harmonise_FR.do"
do "$path\Data\FR\harmonise_FR2.do"
do "$path\Data\FR\harmonise_FR_pres.do"
do "$path\Data\FR\harmonise_FR_pres2.do"
do "$path\Data\FR\harmonise_FR_cst.do"
do "$path\Data\FR\harmonise_FR2_cst.do"



* Germany 
do "$path\Data\GE\harmonise_GE.do"
do "$path\Data\GE\harmonise_GE_vote2.do"
do "$path\Data\GE\harmonise_GE_kreise.do"
do "$path\Data\GE\harmonise_GE_kreise_vote2.do"
do "$path\Data\GE\harmonise_GE_wahlkreise.do"
do "$path\Data\GE\harmonise_GE_wahlkreise_vote2.do"

* Italy 
do "$path\Data\IT\harmonise_IT.do"

* Netherlands
do "$path\Data\NL\harmonise_NL.do"

* Norway
do "$path\Data\NO\harmonise_NO.do"

* New Zealand
do "$path\Data\NZ\harmonise_NZ_gen.do"

* Sweden 
do "$path\Data\SE\harmonise_SE.do"

* UK
do "$path\Data\UK\harmonise_UK.do"

* US
do "$path\Data\US\harmonise_US_pres.do"
do "$path\Data\US\harmonise_US_cong.do"
do "$path\Data\US\harmonise_US_dist_130423.do"


/*----------------------------------------------------------------------------
------------------------------------------------------------------------------
2. Harmonize the country-specific data further into  
(a) country-year-region-party format: 	region-level dataset
(b) country-year-party format:			party-level dataset
------------------------------------------------------------------------------
-----------------------------------------------------------------------------*/	
clear all 

* Run the PartyFacts file: 

*!!! NOTE:	Please consult the Partyfacts .do-file first to make sure you have 
*			downloaded all necessary files first

do "$path\link_partyfacts.do"

* Run the Democratic Electoral Systems Around the World file 

do "$path\link_DES.do"


* Run all data_merge_[country_code] files 

* Australia
do "$path\Data\AUS\data_merge_AUS10.do"
do "$path\Data\AUS\data_merge_AUS_round2_10.do"

* Austria 
do "$path\Data\AT\data_merge_AT.do"
do "$path\Data\AT\data_merge_ATpres.do"


* Canada
do "$path\Data\CA\data_merge_CA10_q.do"

* Switzerland 
do "$path\Data\CH\data_merge_CH_10.do"

* Denmark
do "$path\Data\DK\data_merge_DK_7922.do"

* Spain 
do "$path\Data\ES\data_merge_ES10.do"

* France 
do "$path\Data\FR\data_merge_FR10.do"
do "$path\Data\FR\data_merge_FR2_10.do"
do "$path\Data\FR\data_merge_FR10_pres.do"
do "$path\Data\FR\data_merge_FR10_pres2.do"
do "$path\Data\FR\data_merge_FR10_cst.do"
do "$path\Data\FR\data_merge_FR2_10_cst.do"

* Germany 
do "$path\Data\GE\data_merge_GE_10.do"
do "$path\Data\GE\data_merge_GE_vote2_10.do"
do "$path\Data\GE\data_merge_GE_kreise.do"
do "$path\Data\GE\data_merge_GE_kreise_vote2.do"
do "$path\Data\GE\data_merge_GE_wahlkreise.do"
do "$path\Data\GE\data_merge_GE_wahlkreise_vote2.do"

* Italy 
do "$path\Data\IT\data_merge_IT_10.do"

* Netherlands
do "$path\Data\NL\data_merge_NL10.do"

* Norway
do "$path\Data\NO\data_merge_NO.do"

* New Zealand
do "$path\Data\NZ\data_merge_NZ.do"

* Sweden 
do "$path\Data\SE\data_merge_SE_10.do"

* UK
do "$path\Data\UK\data_merge_UK_10.do"

* US
do "$path\Data\US\data_merge_US.do"
do "$path\Data\US\data_merge_US_congress.do"
do "$path\Data\US\data_merge_US_dist_130423.do"


/*----------------------------------------------------------------------------
------------------------------------------------------------------------------
3. Merge all country-year-region-party datasets into one file
------------------------------------------------------------------------------
-----------------------------------------------------------------------------*/	

*Australia
use "$path\Data\AUS\cyr_AUS.dta", clear 
append using "$path\Data\AUS\cyr_AUS_r2.dta", force

keep country country_code year region_code regionname popdens urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation vote_q1 vote_q2 vote_q3 vote_q4 vote_q5 vote_q6 vote_q7 vote_q8 vote_q9 vote_q10 valid_urb partyvote party_english party_native type totalvote electorate partyfacts_id cabinet_party *seats area_id


* Austria
append using "$path\Data\AT\cyr_AT.dta", force
append using "$path\Data\AT\cyr_ATpres.dta", force

keep country country_code year region_code regionname popdens urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation vote_q1 vote_q2 vote_q3 vote_q4 vote_q5 vote_q6 vote_q7 vote_q8 vote_q9 vote_q10 valid_urb partyvote party_english party_native type totalvote electorate partyfacts_id cabinet_party *seats area_id


*Canada 
append using "$path\Data\CA\cyr_CA.dta", force

keep country country_code year region_code regionname popdens urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation vote_q1 vote_q2 vote_q3 vote_q4 vote_q5 vote_q6 vote_q7 vote_q8 vote_q9 vote_q10 valid_urb partyvote party_english party_native type totalvote electorate partyfacts_id cabinet_party *seats area_id


*Denmark
append using "$path\Data\DK\cyr_DK.dta", force

keep country country_code year region_code regionname popdens urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation vote_q1 vote_q2 vote_q3 vote_q4 vote_q5 vote_q6 vote_q7 vote_q8 vote_q9 vote_q10 valid_urb partyvote party_english party_native type totalvote electorate partyfacts_id cabinet_party *seats area_id



*France
append using "$path\Data\FR\cyr_FR.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats area_id



append using "$path\Data\FR\cyr_FR_r2.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats area_id

append using "$path\Data\FR\cyr_FR_cst.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats area_id

append using "$path\Data\FR\cyr_FR2_cst.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats area_id


append using "$path\Data\FR\cyr_FR_pres.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


append using "$path\Data\FR\cyr_FR_pres2.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


* Germany
append using "$path\Data\GE\cyr_GE.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


append using "$path\Data\GE\cyr_GE_v2.dta", force

keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


append using "$path\Data\GE\cyr_GE_kreise.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


append using "$path\Data\GE\cyr_GE_kreise_v2.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


append using "$path\Data\GE\cyr_GE_WK.dta", force			
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


append using "$path\Data\GE\cyr_GE_WK_2v.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


*Italy 
append using "$path\Data\IT\cyr_IT.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


*Sweden
append using "$path\Data\SE\cyr_SE.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


*Switzerland 
append using "$path\Data\CH\cyr_CH.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id

*Netherlands 
append using "$path\Data\NL\cyr_NL.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id

*Norway 
append using "$path\Data\NO\cyr_NO.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id

*New Zealand 
append using "$path\Data\NZ\cyr_NZ.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id

*United Kingdom 
append using "$path\Data\UK\cyr_UK.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id
 
*Spain
append using "$path\Data\ES\cyr_ES.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id

*United States
append using "$path\Data\US\cyr_US.dta", force
replace country_code = "US_pres" if country_code=="US"
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id


append using "$path\Data\US\cyr_US_congress.dta", force
replace country_code = "US_cong" if country_code=="US"
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10 *valid_urb *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id

append using "$path\Data\US\cyr_US_dist.dta", force
keep country country_code year region_code regionname *popdens *urban10 validvote nat_valid nat_vote nat_voteshare party_abbreviation *vote_q1 *vote_q2 *vote_q3 *vote_q4 *vote_q5 *vote_q6 *vote_q7 *vote_q8 *vote_q9 *vote_q10  *partyvote party_english party_native type totalvote *electorate partyfacts_id cabinet_party *seats cand_name area_id
drop cst_*
sort country_code year region_code party_abbreviation


drop party_english



label variable country "Country name"
label variable year  "Election year"
label variable party_abbreviation  "Party abbreviation"
label variable country_code  "Country code"
label variable nat_voteshare  "Party's national vote share"
label variable nat_vote  "Party's total nr of votes in election"
label variable vote_q1  "Party's nr of votes in 1st density decile"
label variable vote_q2  "Party's nr of votes in 2nd density decile"
label variable vote_q3  "Party's nr of votes in 3rd density decile"
label variable vote_q4  "Party's nr of votes in 4th density decile"
label variable vote_q5  "Party's nr of votes in 5th density decile"
label variable vote_q6  "Party's nr of votes in 6th density decile"
label variable vote_q7  "Party's nr of votes in 7th density decile"
label variable vote_q8  "Party's nr of votes in 8th density decile"
label variable vote_q9  "Party's nr of votes in 9th density decile"
label variable vote_q10  "Party's nr of votes in 10th density decile"
label variable party_native  "Party name"
label variable partyfacts_id  "PartyFacts ID"
label variable region_code "Region code"
label variable popdens "Population density"
label variable urban10 "Density decile"
label variable validvote "Nr of valid vote in region"
label variable nat_valid "Total nr of valid votes in election"
label variable partyvote "Party's nr of votes in region"
label variable regionname "Region name"
label variable type "Type of election"
label variable totalvote "Total nr of votes in region"
label variable electorate "Size of electorate in region"
label variable cabinet_party "Party is member of government (coalition) after election (0/1)"
label variable seats "Party's nr of seats after election"
label variable cand_name "Presidental candidate's name"
label variable area_id "ID for the higher-level geogr. unit the mun./const. belongs to"

keep country country_code year region_code regionname popdens urban10 validvote totalvote electorate party_abbreviation party_native cand_name partyvote nat_vote nat_voteshare partyfacts_id cabinet_party seats  type nat_valid area_id

order country country_code year region_code regionname area_id popdens urban10 validvote totalvote electorate party_abbreviation cand_name partyvote nat_vote nat_voteshare partyfacts_id cabinet_party seats  type nat_valid 


save "$path\data_share\URED_regions.dta", replace
outsheet using "$path\data_share\URED_regions.csv" , comma  nolabel replace

/*----------------------------------------------------------------------------
------------------------------------------------------------------------------
4. Merge all party-level datasets into one file, and compute
electoral urban-rural divide measures
------------------------------------------------------------------------------
-----------------------------------------------------------------------------*/	

clear all
cd "$path"


*Australia
use "$path\Data\AUS\cyp_urdiff_AUS.dta", clear 
append using "$path\Data\AUS\cyp_urdiff_AUS_r2.dta", force

* Austria
append using "$path\Data\AT\cyp_urdiff_AT.dta", force
append using "$path\Data\AT\cyp_urdiff_ATpres.dta", force


*Canada 
append using "$path\Data\CA\cyp_urdiff_CA.dta", force

*Denmark
append using "$path\Data\DK\cyp_urdiff_DK.dta", force

*France
append using "$path\Data\FR\cyp_urdiff_FR.dta", force
append using "$path\Data\FR\cyp_urdiff_FR_r2.dta", force
append using "$path\Data\FR\cyp_urdiff_FR_pres.dta", force
append using "$path\Data\FR\cyp_urdiff_FR_pres2.dta", force
append using "$path\Data\FR\cyp_urdiff_FR_cst.dta", force
append using "$path\Data\FR\cyp_urdiff_FR2_cst.dta", force


* Germany
append using "$path\Data\GE\cyp_urdiff_GE.dta", force
append using "$path\Data\GE\cyp_urdiff_GE_v2.dta", force
append using "$path\Data\GE\cyp_urdiff_GE_kreise.dta", force
append using "$path\Data\GE\cyp_urdiff_GE_kreise_2v.dta", force
append using "$path\Data\GE\cyp_urdiff_GE_WK.dta", force
append using "$path\Data\GE\cyp_urdiff_GE_WK_2v.dta", force

*Italy 
append using "$path\Data\IT\cyp_urdiff_IT.dta"

*Sweden
append using "$path\Data\SE\cyp_urdiff_SE.dta", force

*Switzerland 
append using "$path\Data\CH\cyp_urdiff_CH.dta", force

*Netherlands 
append using "$path\Data\NL\cyp_urdiff_NL.dta", force

*Norway 
append using "$path\Data\NO\cyp_urdiff_NO.dta", force

*New Zealand 
append using "$path\Data\NZ\cyp_urdiff_NZ.dta", force

*United Kingdom 
append using "$path\Data\UK\cyp_urdiff_UK.dta", force
 
*Spain
append using "$path\Data\ES\cyp_urdiff_ES.dta", force

*United States
append using "$path\Data\US\cyp_urdiff_US.dta", force
replace country_code = "US_pres" if country_code=="US"
append using "$path\Data\US\cyp_urdiff_US_congress.dta", force
replace country_code = "US_cong" if country_code=="US"
append using "$path\Data\US\cyp_urdiff_US_dist.dta", force

*!!!!!!! NOTE: DECIDE WHAT TO INCLUDE AND WHAT TO DROP !!!!!!!!!!!!!!!!!!!!!!!!!!


**** Merge to manifesto data key
	replace partyfacts_id = 211 if party_abbreviation=="CDU"  & (country_code=="GE" | country_code=="GE2")

	merge m:1  partyfacts_id using "$path/manifesto_key"
	
	drop if _merge==2
	drop _merge

	drop manifesto_country manifesto_dataset_key manifesto_name_short manifesto_name manifesto_name_english manifesto_year_first manifesto_year_last manifesto_share manifesto_share_year manifesto_description manifesto_comment manifesto_created manifesto_modified manifesto_external_id manifesto_linked


/*
**** Merge to DES data 

Download 'Democratic Electoral Systems around the world, 1946-2011' data

Reference:Bormann, Nils-Christian & Matt Golder. Forthcoming. “Democratic Electoral Systems Around the
World, 1946-2020,” Electoral Studies.

*/

merge m:1 country_code year using "$path\Data\DES_data.dta"
drop if _merge==2
sort country_code party_abbreviation year
foreach x of varlist legislative_type elecrule nr_of_seats tier1_avemag tier1_districts tier2_districts tier3_districts tier4_districts enep enep_others enep1 enpp {
	by country_code party_abbreviation: replace `x' = `x'[_n-1] if `x'==.
}

	
/*------------------------------------------------------------------------------
Compute vote shares in urbanisation categories 
------------------------------------------------------------------------------*/
drop voteshare*


* Party's valid votes per decile
foreach x of numlist 1/10 {
bysort country_code year: egen tot_vote_q`x' = total(vote_q`x')

}

foreach x of numlist 1/10 {
	replace vote_q`x'=0 if vote_q`x'==.

}


* Party's vote share per quintile
gen voteshare_quint1 = (vote_q1+vote_q2)/(tot_vote_q1+tot_vote_q2)
gen voteshare_quint2 = (vote_q3+vote_q4)/(tot_vote_q3+tot_vote_q4)
gen voteshare_quint3 = (vote_q5+vote_q6)/(tot_vote_q5+tot_vote_q6)
gen voteshare_quint4 = (vote_q7+vote_q8)/(tot_vote_q7+tot_vote_q8)
gen voteshare_quint5 = (vote_q9+vote_q10)/(tot_vote_q9+tot_vote_q10)

*Goverment support per quintile

gen contr_quint1_gov = ((vote_q1+vote_q2)*cabinet_party)/(tot_vote_q1+tot_vote_q2)
gen contr_quint2_gov = ((vote_q3+vote_q4)*cabinet_party)/(tot_vote_q3+tot_vote_q4)
gen contr_quint3_gov = ((vote_q5+vote_q6)*cabinet_party)/(tot_vote_q5+tot_vote_q6)
gen contr_quint4_gov = ((vote_q7+vote_q8)*cabinet_party)/(tot_vote_q7+tot_vote_q8)
gen contr_quint5_gov = ((vote_q9+vote_q10)*cabinet_party)/(tot_vote_q9+tot_vote_q10)

foreach x of numlist 1/5 {
	bysort country_code year: egen govsup_quint`x' = total(contr_quint`x'_gov)
}

* National vote share for goverment
bysort country_code year party_abbreviation: ///
gen contr_gov_nat_vs = nat_voteshare*cabinet_party
bysort country_code year: egen nat_voteshare_gov = sum(contr_gov_nat_vs)  


* Government support based on presidential votes (& win in pres elections)
gen pres_win = .
replace pres_win = 0 if country_code=="FR_pres" | country_code=="FR_pres2" | country_code=="US_pres" | country_code=="US_dist"

	*France
replace pres_win = 1 if cand_name == "CHIRAC" & year==1995
replace pres_win = 1 if cand_name == "CHIRAC" & year==2002
replace pres_win = 1 if cand_name == "SARKOZY" & year==2007
replace pres_win = 1 if cand_name == "HOLLANDE" & year==2012
replace pres_win = 1 if cand_name == "MACRON" & year==2017
replace pres_win = 1 if cand_name == "MACRON" & year==2022
	
	*US 
replace pres_win = 1 if year ==1972 & party_abbreviation=="REP" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==1976 & party_abbreviation=="DEM" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==1980 & party_abbreviation=="REP" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==1984 & party_abbreviation=="REP" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==1988 & party_abbreviation=="REP" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==1992 & party_abbreviation=="DEM" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==1996 & party_abbreviation=="DEM" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==2000 & party_abbreviation=="REP" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==2004 & party_abbreviation=="REP" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==2008 & party_abbreviation=="DEM" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==2012 & party_abbreviation=="DEM" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==2016 & party_abbreviation=="REP" & (country_code=="US_pres" | country_code=="US_dist")
replace pres_win = 1 if year ==2020 & party_abbreviation=="DEM" & (country_code=="US_pres" | country_code=="US_dist")


gen contr_quint1_pres = ((vote_q1+vote_q2)*pres_win)/(tot_vote_q1+tot_vote_q2)
gen contr_quint2_pres = ((vote_q3+vote_q4)*pres_win)/(tot_vote_q3+tot_vote_q4)
gen contr_quint3_pres= ((vote_q5+vote_q6)*pres_win)/(tot_vote_q5+tot_vote_q6)
gen contr_quint4_pres= ((vote_q7+vote_q8)*pres_win)/(tot_vote_q7+tot_vote_q8)
gen contr_quint5_pres= ((vote_q9+vote_q10)*pres_win)/(tot_vote_q9+tot_vote_q10)


foreach x of numlist 1/5 {
	bysort country_code year: egen pressup_quint`x' = total(contr_quint`x'_pres)
}

*** Recent missing seat shares 
* Sweden
replace seats = 68 if country_code=="SE" & year==2022 & party_abbreviation=="MP"
replace seats = 19  if country_code=="SE" & year==2022 & party_abbreviation=="CDP"
replace seats = 16 if country_code=="SE" & year==2022 & party_abbreviation=="LIB"
replace seats = 73 if country_code=="SE" & year==2022 & party_abbreviation=="SD"
replace seats = 107 if country_code=="SE" & year==2022 & party_abbreviation=="SDP"
replace seats = 24 if country_code=="SE" & year==2022 & party_abbreviation=="LP"
replace seats = 24 if country_code=="SE" & year==2022 & party_abbreviation=="CP"
replace seats = 18 if country_code=="SE" & year==2022 & party_abbreviation=="GREEN"

* Spain 
replace seats = 2 if country_code=="ES" & year==2020 & party_abbreviation=="CCaPNCNC"
replace seats = 2 if country_code=="ES" & year==2020 & party_abbreviation=="CUPPR"
replace seats = 9 if country_code=="ES" & year==2020 & party_abbreviation=="Cs"
replace seats = 6 if country_code=="ES" & year==2020 & party_abbreviation=="EAJPNV"
replace seats = 5 if country_code=="ES" & year==2020 & party_abbreviation=="EHBildu"
replace seats = 13 if country_code=="ES" & year==2020 & party_abbreviation=="ERCSOBIRANISTES"
replace seats = 4 if country_code=="ES" & year==2020 & party_abbreviation=="JxCATJUNTS"
replace seats = 2 if country_code=="ES" & year==2020 & party_abbreviation=="MÁSPAÍS"
replace seats = 1 if country_code=="ES" & year==2020 & party_abbreviation=="MÉSCOMPROM"
replace seats = 0 if country_code=="ES" & year==2020 & party_abbreviation=="PACMA"
replace seats = 22 if country_code=="ES" & year==2020 & party_abbreviation=="PODEMOS"
replace seats = 88 if country_code=="ES" & year==2020 & party_abbreviation=="PP"
replace seats = 120 if country_code=="ES" & year==2020 & party_abbreviation=="PSOE"
replace seats = 52 if country_code=="ES" & year==2020 & party_abbreviation=="VOX"


****************** check minority governments  

* double-check total nr of seats
replace nr_of_seats = 736 if country_code=="GE" & year==2021


bysort country_code year : egen coalition_seats = total(seats) if cabinet_party==1
gen min_gov = .
replace min_gov = 1 if coalition_seats < (0.5*nr_of_seats)
replace min_gov = 0 if coalition_seats >= (0.5*nr_of_seats)
replace min_gov = . if nr_of_seats==.
replace min_gov = . if coalition_seats==0


/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
COMPUTE URBAN-RURAL POLARIZATION MEASURES
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

************ Bottom vs highest decile

*** Parties
gen voteshare_low1 = (vote_q1)/(tot_vote_q1)
gen voteshare_high1 = (vote_q10)/(tot_vote_q10)

gen urb_high1 = .
replace urb_high1 = 1 if voteshare_high1>voteshare_low1
replace urb_high1 = 0 if voteshare_high1<voteshare_low1

gen ur_pol1 = .
replace ur_pol1 = voteshare_high1/(voteshare_high1+voteshare_low1) if urb_high==1
replace ur_pol1 = voteshare_low1/(voteshare_low1+voteshare_high1) if urb_high==0

replace ur_pol1= (ur_pol1-.5)*2 // normalize between 0 and 1

gen ur_pol_dir1 = 2*((voteshare_high1/(voteshare_high1+voteshare_low1))-0.5)


************ Bottom TWO vs highest TWO deciles

*** Parties
gen urb_high = .
replace urb_high = 1 if voteshare_quint5>voteshare_quint1
replace urb_high = 0 if voteshare_quint5<voteshare_quint1

gen ur_pol = .
replace ur_pol = voteshare_quint5/(voteshare_quint5+voteshare_quint1) if urb_high==1
replace ur_pol = voteshare_quint1/(voteshare_quint1+voteshare_quint5) if urb_high==0

replace ur_pol= (ur_pol-.5)*2 // normalize between 0 and 1

gen ur_pol_dir = 2*((voteshare_quint5/(voteshare_quint5+voteshare_quint1))-0.5)

*** Government support
gen urb_high_gov = .
replace urb_high_gov = 1 if govsup_quint5>govsup_quint1
replace urb_high_gov = 0 if govsup_quint5<govsup_quint1

gen ur_pol_gov= .
replace ur_pol_gov = govsup_quint5/(govsup_quint5+govsup_quint1) if urb_high_gov==1
replace ur_pol_gov = govsup_quint1/(govsup_quint1+govsup_quint5) if urb_high_gov==0

replace ur_pol_gov= (ur_pol_gov-.5)*2 // normalize between 0 and 1

gen ur_pol_gov_dir = 2*((govsup_quint5/(govsup_quint5+govsup_quint1))-0.5)


************ Bottom THREE vs highest THREE deciles

* Party's vote share
gen voteshare_low3 = (vote_q1+vote_q2+vote_q3)/(tot_vote_q1+tot_vote_q2+tot_vote_q3)
gen voteshare_high3 = (vote_q8+vote_q9+vote_q10)/(tot_vote_q8+tot_vote_q9+tot_vote_q10)

gen urb_high3 = .
replace urb_high3 = 1 if voteshare_high3>voteshare_low3
replace urb_high3 = 0 if voteshare_high3<voteshare_low3

gen ur_pol3 = .
replace ur_pol3 = voteshare_high3/(voteshare_high3+voteshare_low3) if urb_high3==1
replace ur_pol3 = voteshare_low3/(voteshare_low3+voteshare_high3) if urb_high3==0

replace ur_pol3= (ur_pol3-.5)*2 // normalize between 0 and 1

gen ur_pol_dir3 = 2*((voteshare_high3/(voteshare_high3+voteshare_low3))-0.5)


*Goverment support 

gen contr_gov_low3 = ((vote_q1+vote_q2+vote_q3)*cabinet_party)/(tot_vote_q1+tot_vote_q2+tot_vote_q3)
gen contr_gov_high3 = ((vote_q8+vote_q9+vote_q10)*cabinet_party)/(tot_vote_q8+tot_vote_q9+tot_vote_q10)

bysort country_code year: egen govsup_low3 = total(contr_gov_low3)
bysort country_code year: egen govsup_high3 = total(contr_gov_high3)

gen urb_high_gov3 = .
replace urb_high_gov3 = 1 if govsup_high3>govsup_low3
replace urb_high_gov3 = 0 if govsup_high3<govsup_low3

gen ur_pol_gov3= .
replace ur_pol_gov3 = govsup_high3/(govsup_high3+govsup_low3) if urb_high_gov3==1
replace ur_pol_gov3 = govsup_low3/(govsup_low3+govsup_high3) if urb_high_gov3==0

replace ur_pol_gov3= (ur_pol_gov3-.5)*2 // normalize between 0 and 1

gen ur_pol_gov_dir3 = 2*((govsup_high3/(govsup_high3+govsup_low3))-0.5)

************ Bottom FOUR vs highest FOUR deciles
gen voteshare_low4 = (vote_q1+vote_q2+vote_q3+vote_q4)/(tot_vote_q1+tot_vote_q2+tot_vote_q3+tot_vote_q4)
gen voteshare_high4 = (vote_q7+vote_q8+vote_q9+vote_q10)/(tot_vote_q7+tot_vote_q8+tot_vote_q9+tot_vote_q10)

gen urb_high4 = .
replace urb_high4 = 1 if voteshare_high4>voteshare_low4
replace urb_high4 = 0 if voteshare_high4<voteshare_low4

gen ur_pol4 = .
replace ur_pol4 = voteshare_high4/(voteshare_high4+voteshare_low4) if urb_high4==1
replace ur_pol4 = voteshare_low4/(voteshare_low4+voteshare_high4) if urb_high4==0

replace ur_pol4= (ur_pol4-.5)*2 // normalize between 0 and 1

gen ur_pol_dir4 = 2*((voteshare_high4/(voteshare_high4+voteshare_low4))-0.5)

*Goverment support 

gen contr_gov_low4 = ((vote_q1+vote_q2+vote_q3+vote_q4)*cabinet_party)/(tot_vote_q1+tot_vote_q2+tot_vote_q3+tot_vote_q4)
gen contr_gov_high4 = ((vote_q7+vote_q8+vote_q9+vote_q10)*cabinet_party)/(tot_vote_q7+tot_vote_q8+tot_vote_q9+tot_vote_q10)

bysort country_code year: egen govsup_low4 = total(contr_gov_low4)
bysort country_code year: egen govsup_high4 = total(contr_gov_high4)

gen urb_high_gov4 = .
replace urb_high_gov4 = 1 if govsup_high4>govsup_low4
replace urb_high_gov4 = 0 if govsup_high4<govsup_low4

gen ur_pol_gov4= .
replace ur_pol_gov4 = govsup_high4/(govsup_high4+govsup_low4) if urb_high_gov4==1
replace ur_pol_gov4 = govsup_low4/(govsup_low4+govsup_high4) if urb_high_gov4==0

replace ur_pol_gov4= (ur_pol_gov4-.5)*2 // normalize between 0 and 1

gen ur_pol_gov_dir4 = 2*((govsup_high4/(govsup_high4+govsup_low4))-0.5)


************ Bottom FIVE vs highest FIVE deciles
gen voteshare_low5 = (vote_q1+vote_q2+vote_q3+vote_q4+vote_q5)/(tot_vote_q1+tot_vote_q2+tot_vote_q3+tot_vote_q4+tot_vote_q5)
gen voteshare_high5 = (vote_q6+vote_q7+vote_q8+vote_q9+vote_q10)/(tot_vote_q6+tot_vote_q7+tot_vote_q8+tot_vote_q9+tot_vote_q10)

gen urb_high5 = .
replace urb_high5 = 1 if voteshare_high5>voteshare_low5
replace urb_high5 = 0 if voteshare_high5<voteshare_low5

gen ur_pol5 = .
replace ur_pol5 = voteshare_high5/(voteshare_high5+voteshare_low5) if urb_high4==1
replace ur_pol5 = voteshare_low5/(voteshare_low5+voteshare_high5) if urb_high5==0

replace ur_pol5= (ur_pol5-.5)*2 // normalize between 0 and 1

gen ur_pol_dir5 = 2*((voteshare_high5/(voteshare_high5+voteshare_low5))-0.5)

************ Weighted average
gen ur_pol_w = (ur_pol5 +(0.8*ur_pol4) + (0.6*ur_pol3) + (0.4*ur_pol) + (0.2*ur_pol1))/3
gen ur_pol_dir_w = (ur_pol_dir5 +(0.8*ur_pol_dir4) + (0.6*ur_pol_dir3) + (0.4*ur_pol_dir) + (0.2*ur_pol_dir1))/3


*****************************************************************************
******* Compute urban-rural divides at the constituency level in CH, ES & FR 

* valid votes per decile
foreach x of numlist 1/10 {
gen tot_vote_q`x'_cst = .
}
local cst_countries "FR FR2 CH FR_pres FR_pres2 ES"
foreach c of local cst_countries {
foreach x of numlist 1/10 {
bysort country_code year: egen tot_vote_q`x'_cst_`c' = total(vote_q`x'_cst)  if country_code=="`c'"
replace tot_vote_q`x'_cst = tot_vote_q`x'_cst_`c'  if country_code=="`c'"
drop   tot_vote_q`x'_cst_`c' 

}


foreach x of numlist 1/10 {
	replace vote_q`x'_cst=0 if vote_q`x'_cst==. & country_code=="`c'"
}

}

* Top 4 / bottom 4
gen voteshare_low4_cst = (vote_q1_cst+vote_q2_cst+vote_q3_cst+vote_q4_cst)/(tot_vote_q1_cst+tot_vote_q2_cst+tot_vote_q3_cst+tot_vote_q4_cst)
gen voteshare_high4_cst = (vote_q7_cst+vote_q8_cst+vote_q9_cst+vote_q10_cst)/(tot_vote_q7_cst+tot_vote_q8_cst+tot_vote_q9_cst+tot_vote_q10_cst)

gen urb_high4_cst = .
replace urb_high4_cst = 1 if voteshare_high4_cst>voteshare_low4_cst
replace urb_high4_cst = 0 if voteshare_high4_cst<voteshare_low4_cst

gen ur_pol4_cst = .
replace ur_pol4_cst = voteshare_high4_cst/(voteshare_high4_cst+voteshare_low4_cst) if urb_high4_cst==1
replace ur_pol4_cst = voteshare_low4_cst/(voteshare_low4_cst+voteshare_high4_cst) if urb_high4_cst==0

replace ur_pol4_cst= (ur_pol4_cst-.5)*2 // normalize between 0 and 1

gen ur_pol_dir4_cst = 2*((voteshare_high4_cst/(voteshare_high4_cst+voteshare_low4_cst))-0.5)

replace ur_pol4_cst = . if ur_pol4_cst==0
replace ur_pol_dir4_cst = . if ur_pol_dir4_cst==0


* Top 2 / bottom 2
gen voteshare_low2_cst = (vote_q1_cst+vote_q2_cst)/(tot_vote_q1_cst+tot_vote_q2_cst)
gen voteshare_high2_cst = (vote_q9_cst+vote_q10_cst)/(tot_vote_q9_cst+tot_vote_q10_cst)

gen urb_high2_cst = .
replace urb_high2_cst = 1 if voteshare_high2_cst>voteshare_low2_cst
replace urb_high2_cst = 0 if voteshare_high2_cst<voteshare_low2_cst

gen ur_pol2_cst = .
replace ur_pol2_cst = voteshare_high2_cst/(voteshare_high2_cst+voteshare_low2_cst) if urb_high2_cst==1
replace ur_pol2_cst = voteshare_low2_cst/(voteshare_low2_cst+voteshare_high2_cst) if urb_high2_cst==0

replace ur_pol2_cst= (ur_pol2_cst-.5)*2 // normalize between 0 and 1

gen ur_pol_dir2_cst = 2*((voteshare_high2_cst/(voteshare_high2_cst+voteshare_low2_cst))-0.5)

replace ur_pol2_cst = . if ur_pol2_cst==0
replace ur_pol_dir2_cst = . if ur_pol_dir2_cst==0


sum ur_pol*cst



** Contribution to election-level measure, weighted by vote share
gen contr_urp1 = nat_voteshare*ur_pol1
gen contr_urp = nat_voteshare*ur_pol
gen contr_urp3 = nat_voteshare*ur_pol3
gen contr_urp4 = nat_voteshare*ur_pol4
gen contr_urp5 = nat_voteshare*ur_pol5
gen contr_urpw = nat_voteshare*ur_pol_w
*gen contr_z_b = nat_voteshare*(sqrt(z_b*z_b))

gen contr_urp4_cst = nat_voteshare*ur_pol4_cst
gen contr_urp2_cst = nat_voteshare*ur_pol2_cst

*gen contr_urp4_imp = nat_voteshare_imp*ur_pol4_imp

* label year variable for plotting
label define _year ///
1955 "55"	///
1959 "59"	///
1964 "64"	///
1966 "66"	///
1969 "69"	///
1970 "70"	///
1971 "71"	///
1972 "72"	///
1973 "73"	///
1974 "74"	///
1975 "75"	///
1976 "76"	///
1977 "77"	///
1978 "78"	///
1979 "79"	///
1980 "80"	///
1981 "81"	///
1982 "82"	///
1983 "83"	///
1984 "84"	///
1985 "85"	///
1986 "86"	///
1987"87"	///
1988 "88"	///
1989 "89"	///
1990 "90"	///
1991 "91"	///
1992 "92"	///
1993 "93"	///
1994 "94"	///
1995 "95"	///
1996 "96"	///
1997 "97"	///
1998 "98"	///
1999 "99"	///
2000 "00"	///
2001 "01"	///
2002 "02"	///
2003 "03"	///
2004 "04"	///
2005 "05"	///
2006 "06"	///
2007 "07"	///
2008 "08"	///
2009 "09"	///
2010 "10"	///
2011 "11"	///
2012 "12"	///
2013 "13"	///
2014 "14"	///
2015 "15"	///
2016 "16"	///
2017 "17"	///
2018 "18"	///
2019 "19"	///
2020 "20"	///
2021 "21"	///
2022 "22"	///
2023 "23"

label values year _year



* label relevant variables 


label variable country "Country name"
label variable year  "Election year"
label variable party_abbreviation  "Party abbreviation"
label variable country_code  "Country code"
label variable nat_voteshare  "Party's national vote share"
label variable nat_vote  "Party's total nr of votes in election"
label variable vote_q1  "Party's nr of votes in 1st density decile"
label variable vote_q2  "Party's nr of votes in 2nd density decile"
label variable vote_q3  "Party's nr of votes in 3rd density decile"
label variable vote_q4  "Party's nr of votes in 4th density decile"
label variable vote_q5  "Party's nr of votes in 5th density decile"
label variable vote_q6  "Party's nr of votes in 6th density decile"
label variable vote_q7  "Party's nr of votes in 7th density decile"
label variable vote_q8  "Party's nr of votes in 8th density decile"
label variable vote_q9  "Party's nr of votes in 9th density decile"
label variable vote_q10  "Party's nr of votes in 10th density decile"
label variable party_english  "Party name (English)"
label variable party_native  "Party name"
label variable partyfacts_id  "PartyFacts ID"
label variable govsup_q1  "Government(-coalition)'s vote share in 1st density decile"
label variable govsup_q2  "Government(-coalition)'s vote share in 2nd density decile"
label variable govsup_q3  "Government(-coalition)'s vote share in 3rd density decile"
label variable govsup_q4  "Government(-coalition)'s vote share in 4th density decile"
label variable govsup_q5  "Government(-coalition)'s vote share in 5th density decile"
label variable govsup_q6  "Government(-coalition)'s vote share in 6th density decile"
label variable govsup_q7  "Government(-coalition)'s vote share in 7th density decile"
label variable govsup_q8  "Government(-coalition)'s vote share in 8th density decile"
label variable govsup_q9  "Government(-coalition)'s vote share in 9th density decile"
label variable govsup_q10  "Government(-coalition)'s vote share in 10th density decile"
label variable cabinet_party  "Member of government coalition after election (0/1)"
label variable seats  "Party's nr of seats after election"
label variable cand_name "Name of Presidential candidate" 
label variable vote_q1_cst  "Party's nr of votes in 1st density decile at higher geogr level"
label variable vote_q2_cst  "Party's nr of votes in 2nd density decile at higher geogr level"
label variable vote_q3_cst  "Party's nr of votes in 3rd density decile at higher geogr level"
label variable vote_q4_cst  "Party's nr of votes in 4th density decile at higher geogr level"
label variable vote_q5_cst  "Party's nr of votes in 5th density decile at higher geogr level"
label variable vote_q6_cst  "Party's nr of votes in 6th density decile at higher geogr level"
label variable vote_q7_cst  "Party's nr of votes in 7th density decile at higher geogr level"
label variable vote_q8_cst  "Party's nr of votes in 8th density decile at higher geogr level"
label variable vote_q9_cst  "Party's nr of votes in 9th density decile at higher geogr level"
label variable vote_q10_cst  "Party's nr of votes in 10th density decile at higher geogr level"
label variable manifesto_dataset_party_id  "Manifesto Project party ID"
drop legislative_type 
drop elecrule
label variable nr_of_seats  "Total nr of seats in parliament/congress"
drop tier1_avemag
drop tier1_districts
drop tier2_districts
drop tier3_districts
drop tier4_districts
drop enep
drop enep_others
drop enep1
drop enpp
drop _merge
label variable tot_vote_q1 "Total nr of votes in 1st density decile" 
label variable tot_vote_q2 "Total nr of votes in 2nd density decile"
label variable tot_vote_q3 "Total nr of votes in 3rd density decile"
label variable tot_vote_q4 "Total nr of votes in 4th density decile"
label variable tot_vote_q5 "Total nr of votes in 5th density decile"
label variable tot_vote_q6 "Total nr of votes in 6th density decile"
label variable tot_vote_q7 "Total nr of votes in 7th density decile"
label variable tot_vote_q8 "Total nr of votes in 8th density decile"
label variable tot_vote_q9 "Total nr of votes in 9th density decile"
label variable tot_vote_q10 "Total nr of votes in 10th density decile"
drop voteshare_quint*
drop govsup_quint*
label variable nat_voteshare_gov  "Government(-coalition)'s national vote share "
label variable pres_win  "Candidate won presidential election (0/1)"
label variable pressup_quint1  "President's vote share in 1st density quintile"
label variable pressup_quint2  "President's vote share in 2nd density quintile"
label variable pressup_quint3  "President's vote share in 3rd density quintile"
label variable pressup_quint4  "President's vote share in 4th  density quintile"
label variable pressup_quint5  "President's vote share in 5th  density quintile"
label variable coalition_seats  "Government(-coalition)'s nr of seats"
label variable min_gov  "Minority government after election (0/1)"
label variable ur_pol1  "Party's U-R polarization (t1/b1) (abs.)"
label variable ur_pol_dir1 "Party's U-R polarization (t1/b1) (dir.)" 
label variable ur_pol  "Party's U-R polarization (t2/b2) (abs.)"
label variable ur_pol_dir "Party's U-R polarization (t2/b2) (dir.)" 
label variable ur_pol3  "Party's U-R polarization (t3/b3) (abs.)"
label variable ur_pol_dir3 "Party's U-R polarization (t3/b3) (dir.)" 
label variable ur_pol4  "Party's U-R polarization (t4/b4) (abs.)"
label variable ur_pol_dir4 "Party's U-R polarization (t4/b4) (dir.)" 
label variable ur_pol5  "Party's U-R polarization (t5/b5) (abs.)"
label variable ur_pol_dir5 "Party's U-R polarization (t5/b5) (dir.)" 
label variable ur_pol_w  "Party's U-R polarization weighted (abs.)"
label variable ur_pol_dir_w "Party's U-R polarization (weighted) (dir.)" 
label variable ur_pol4_cst  "Party's U-R polarization (t4/b4) (abs.) higher geogr level"
label variable ur_pol_dir4_cst "Party's U-R polarization (t4/b4) (dir.) higher geogr level" 

rename ur_pol ur_pol2
rename ur_pol_dir ur_pol_dir2

label variable ur_pol_gov  "Government(-coalition)'s U-R polarization (t2/b2) (abs.)"
label variable ur_pol_gov_dir "Government(-coalition)'s U-R polarization (t2/b2) (dir.)"
label variable ur_pol_gov3  "Government(-coalition)'s U-R polarization (t3/b3) (abs.)"
label variable ur_pol_gov_dir3 "Government(-coalition)'s U-R polarization (t3/b3) (dir.)" 
label variable ur_pol_gov4 "Government(-coalition)'s U-R polarization (t4/b4) (abs.)"
label variable ur_pol_gov_dir4 "Government(-coalition)'s U-R polarization (t4/b4) (dir.)"

rename ur_pol_gov ur_pol_gov2
rename ur_pol_gov_dir ur_pol_gov_dir2

label variable tot_vote_q1_cst  "Total nr of votes in 1st density decile at higher geogr level" 
label variable tot_vote_q2_cst  "Total nr of votes in 2nd density decile at higher geogr level"
label variable tot_vote_q3_cst  "Total nr of votes in 3rd density decile at higher geogr level"
label variable tot_vote_q4_cst  "Total nr of votes in 4th density decile at higher geogr level"
label variable tot_vote_q5_cst  "Total nr of votes in 5th density decile at higher geogr level"
label variable tot_vote_q6_cst  "Total nr of votes in 6th density decile at higher geogr level"
label variable tot_vote_q7_cst  "Total nr of votes in 7th density decile at higher geogr level"
label variable tot_vote_q8_cst  "Total nr of votes in 8th density decile at higher geogr level"
label variable tot_vote_q9_cst  "Total nr of votes in 9th density decile at higher geogr level"
label variable tot_vote_q10_cst "Total nr of votes in 10th density decile at higher geogr level"


label variable contr_urp1  	"Party's contribution to election-level UR-pol. (t1/b1)"
label variable contr_urp   	"Party's contribution to election-level UR-pol. (t2/b2)"
label variable contr_urp3  	"Party's contribution to election-level UR-pol. (t3/b3)"
label variable contr_urp4  	"Party's contribution to election-level UR-pol. (t4/b4)"
label variable contr_urp5  	"Party's contribution to election-level UR-pol. (t5/b4)"
label variable contr_urpw  	"Party's contribution to election-level UR-pol. (weighted)"
label variable contr_urp4_cst "Party's contribution to election-level UR-pol. (t4/b4) higher geogr. level" 
label variable contr_urp2_cst "Party's contribution to election-level UR-pol. (t2/b2) higher geogr. level"

drop contr_quint1_gov  
drop contr_quint2_gov  
drop contr_quint3_gov  
drop contr_quint4_gov  
drop contr_quint5_gov  
drop contr_gov_nat_vs  
drop contr_quint1_pres  
drop contr_quint2_pres  
drop contr_quint3_pres  
drop contr_quint4_pres  
drop contr_quint5_pres  
drop voteshare_low1  
drop voteshare_high1  
drop urb_high1  
drop urb_high  
drop urb_high_gov  
drop voteshare_low3  
drop voteshare_high3  
drop urb_high3  
drop contr_gov_low3  
drop contr_gov_high3  
drop govsup_low3  
drop govsup_high3  
drop urb_high_gov3  
drop voteshare_low4  
drop voteshare_high4  
drop urb_high4  
drop voteshare_low5  
drop voteshare_high5  
drop urb_high5  
drop voteshare_low4_cst  
drop voteshare_high4_cst  
drop urb_high4_cst  
drop voteshare_low2_cst  
drop voteshare_high2_cst  
drop urb_high2_cst  
drop ur_pol2_cst  
drop ur_pol_dir2_cst  
drop contr_gov_low4 contr_gov_high4 govsup_low4 govsup_high4 urb_high_gov4

order country country_code year party_abbreviation party_english party_native partyfacts_id cand_name nat_voteshare nat_vote ur_pol1 ur_pol_dir1 ur_pol2 ur_pol_dir2 ur_pol3 ur_pol_dir3 ur_pol4 ur_pol_dir4 ur_pol5 ur_pol_dir5 ur_pol_w ur_pol_dir_w 
 
 
save "$path\data_share\URED_parties.dta", replace
outsheet using "$path\data_share\URED_parties.csv" , comma replace nolabel


/*----------------------------------------------------------------------------
------------------------------------------------------------------------------
5. Collapse the party-level datafiles to the election level: country-year format
------------------------------------------------------------------------------
-----------------------------------------------------------------------------*/	
* collapse data to election level
cd "$path\data_share"

use "$path\data_share\URED_parties.dta", clear

bysort country_code year: egen tot_ur_pol1 = total(contr_urp1)
bysort country_code year: egen tot_ur_pol = total(contr_urp)
bysort country_code year: egen tot_ur_pol3 = total(contr_urp3)
bysort country_code year: egen tot_ur_pol4 = total(contr_urp4)
bysort country_code year: egen tot_ur_pol5 = total(contr_urp5)
bysort country_code year: egen tot_ur_polw = total(contr_urpw)

bysort country_code year: egen tot_ur_pol4_cst = total(contr_urp4_cst)
bysort country_code year: egen tot_ur_pol2_cst = total(contr_urp2_cst)
replace tot_ur_pol4_cst=. if tot_ur_pol4_cst==0
replace tot_ur_pol2_cst=. if tot_ur_pol2_cst==0

*bysort country_code year: egen tot_ur_pol4_imp = total(contr_urp4_imp)
*replace tot_ur_pol4_imp=. if tot_ur_pol4_imp==0


* save country-year (= election) level dataset 
collapse (firstnm) country govsup_q* nat_voteshare_gov tot_ur_pol* ///
 nr_of_seats coalition_seats min_gov ///
, by(country_code year)




label variable country "Country name"
label variable year  "Election year"
label variable country_code  "Country code"
label variable govsup_q1  "Government(-coalition)'s vote share in 1st density decile"
label variable govsup_q2  "Government(-coalition)'s vote share in 2nd density decile"
label variable govsup_q3  "Government(-coalition)'s vote share in 3rd density decile"
label variable govsup_q4  "Government(-coalition)'s vote share in 4th density decile"
label variable govsup_q5  "Government(-coalition)'s vote share in 5th density decile"
label variable govsup_q6  "Government(-coalition)'s vote share in 6th density decile"
label variable govsup_q7  "Government(-coalition)'s vote share in 7th density decile"
label variable govsup_q8  "Government(-coalition)'s vote share in 8th density decile"
label variable govsup_q9  "Government(-coalition)'s vote share in 9th density decile"
label variable govsup_q10  "Government(-coalition)'s vote share in 10th density decile"
label variable nat_voteshare_gov  "Government(-coalition)'s national vote share "
label variable min_gov  "Minority government after election (0/1)"
label variable nr_of_seats  "Total nr of seats in parliament/congress"
label variable coalition_seats  "Government(-coalition)'s nr of seats"
label variable tot_ur_pol1 "Election-level Urban-Rural divide (t1/b1)"
label variable tot_ur_pol "Election-level Urban-Rural divide (t2/b2)"
label variable tot_ur_pol3 "Election-level Urban-Rural divide (t3/b3)" 
label variable tot_ur_pol4 "Election-level Urban-Rural divide (t4/b4)"
label variable tot_ur_pol5 "Election-level Urban-Rural divide (t5/b5)"
label variable tot_ur_polw "Election-level Urban-Rural divide (weighted)"
label variable tot_ur_pol4_cst "Election-level Urban-Rural divide (t4/b4) at higher geogr level"
label variable tot_ur_pol2_cst "Election-level Urban-Rural divide (t2/b2) at higher geogr level"


save "$path\data_share\URED_elections.dta", replace
outsheet using "$path\data_share\URED_elections.csv" , comma replace nolabel


