# Combined Scientist Survey Factor Analysis
### Papers and data used in this work
Data from the [1st scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0021101)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.6t94p)

Data from the [2nd scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0134826)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.1ph92)

Data from the [3rd scientists survey paper](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2018EA000461)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.sv6t740)

### Main multiple factor analysis script for all common survey questions combined
  * main.R
        * References data in the **scripts** folder  
            * **load_data.R** Load data from original CSV file  
                * **first_scientists_survey.CSV**  
                * **second_scientists_survey.CSV** 
                * **third_scientists_survey.CSV**  
            * **country_codes.R** align country codes between surveys    
            * **domain_recode.R** align domain codes between surveys    
            * **cleanSurveys.R** align questions and answer types between surveys   
            * **combineSurveys.R** combine dataframes for MFA   
            * **multiFactorAnalysis.R** perform MFA and extract data   
            * **mainPlots.R** generate plots from MFA   
            * **biplotAnalysis.R** generate biplots comparing Qs   
            * **statsSurveyComp.R** MANOVAs and biplots   

### CSV results files are in the **data** folder
  * **individuals.csv** contains the points from the fviz_mfa_var() biplot 
  * **correlated_dim1_quali_vars.csv & correlated_dim1_vars_category.csv** most correlated variables information for dimension 1   
  * **correlated_dim2_quali_vars.csv & correlated_dim2_vars_category.csv** most correlated variable information for dimension 2   
  * **MANOVA_dim1.csv** DIM1 MANOVA results between surveys and significant MFA questions   
  * **MANOVA_dim2.csv** DIM2 MANOVA results between surveys and significant MFA questions   
