# Combined Scientist Survey Factor Analysis
### Papers and data used in this work
Data from the [1st scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0021101)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.6t94p)

Data from the [2nd scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0134826)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.1ph92)

Data from the [3rd scientists survey paper](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2018EA000461)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.sv6t740)

### Main multiple factor analysis script for all common survey questions combined
  * mfa_surveys_combined_v001.R 

### Data
#### Folder containing survey data from all three surveys and related questions
  * first_scientists_survey.csv
  * second_scientists_survey.csv
  * third_scientists_survey.csv
  * first_scientists_survey_questions.csv
  * second_scientists_survey_questions.csv
  * third_scientists_survey_questions.csv
  * regions_master_list.csv :: location of origin recoding for all 3 surveys
  * survey_one_domain_code.csv :: domain/discipline recoding for all 3 surveys
  
### CSV Files
  * **individuals.csv** contains the points from the fviz_mfa_var() biplot.
  * **correlated_dim1_quali_vars.csv & correlated_dim1_vars_category.csv** most correlated variables information for dimension 1
  * **correlated_dim2_quali_vars.csv & correlated_dim2_vars_category.csv** most correlated variable information for dimension 2

### Plots and Figures
#### Folders containing graphs resulting from the above R scripts (pptx, pdf, png)

### Coordinates and Loadings
  * **all_loadings.csv** contains the coordinates and loadings computed from the **mfa_surveys_combined_v001.R** script on lines 308 to 313.
  
### Scripts
#### Folder containing common scripts for all the analysis and recoding of each survey
  * country_codes.R :: countries recoded in data.frame
  * domain_recode.R :: domains recoded in data.frame
  * load_date.R :: header script that loads csv data
