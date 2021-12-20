# Combined Scientist Survey Factor Analysis

## Authors

Borycz, Joshua D <joshua.d.borycz@vanderbilt.edu>
Bruce Grant <bwgrant@widener.edu>
Robert Olendorf <rkolendo@ncsu.edu>

## Data Sources

The data for this analysis was taken from three previous surveys of scientists' attitudes and paractices 
concerning data management and sharing.


Data from the [1st scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0021101)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.6t94p)

Data from the [2nd scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0134826)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.1ph92)

Data from the [3rd scientists survey paper](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2018EA000461)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.sv6t740)
  
## Usage

To rerun the entire analysis 

```r
source('path/to/main.R')
```

The data cleaning, analysis and visualizations are contained in separate files in the `script/` directory.



## Main multiple factor analysis script for all common survey questions combined  
* **main.R**  
  * Pulls code from the **scripts** folder  
     * **load_data.R** Load data from original CSV file  
        * **first_scientists_survey.csv**  
        * **second_scientists_survey.csv**  
        * **third_scientists_survey.csv**  
         * **country_codes.R** align country codes between surveys    
              * **data/country_codes/regions_master_list.csv**  
         * **domain_recode.R** align domain codes between surveys    
              * **data/domains/survey_one_domain_code.csv**  
              * **data/domains/recoded_domain_mapping.csv**  
         * **cleanSurveys.R** align questions and answer types between surveys   
         * **combineSurveys.R** combine dataframes for MFA   
         * **multiFactorAnalysis.R** perform MFA and extract data  


### **data** folder  
* **country_codes** folder  
    * **regions_master_list.csv** list of regions included in cleanSurveys  
* **domains** folder   
    * **domain_recodes.csv** recoding of domains for combined survey  
    * **recoded_domain_mapping.csv** aggregate domains for combined survey analysis    
    * **survey_one_domain_code.csv** recode domains in 1st survey  
* questions (questions for all 3 surveys)
    * **first_scientists_survey_questions.csv**
    * **second_scientists_survey_questions.csv**
    * **third_scientists_survey_questions.csv**
* **first_scientists_survey.csv** data from 1st survey  
* **second_scientists_survey.csv** data from 2nd survey  
* **third_scientists_survey.csv** data from 3rd survey  
