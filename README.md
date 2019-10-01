# Combined Scientist Survey Factor Analysis
### Papers and data used in this work
Data from the [1st scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0021101)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.6t94p)

Data from the [2nd scientists survey paper](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0134826)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.1ph92)

Data from the [3rd scientists survey paper](https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2018EA000461)

  * Survey data used in this paper is available on [Dryad](https://datadryad.org/stash/dataset/doi:10.5061/dryad.sv6t740)


### Correspondence analysis of selection of likert type questions from all three surveys
  * ca_likert_qs_v20190823.R

### Survey data from all three surveys and related questions
  * first_scientists_survey.csv
  * second_scientists_survey.csv
  * third_scientists_survey.csv
  * first_scientists_survey_questions.csv
  * second_scientists_survey_questions.csv
  * third_scientists_survey_questions.csv
  

### Multiple factor analysis script of questions from survey 1 grouped by question type (yes/no, likert, multiple choice)
  * mfa_survey1_grouped_v20190926.R
  
### Multiple Factor analysis scripts for each Survey without grouping
  * mfa_survey1_v20190927.R
  
  * mfa_survey2_v20190927.R
  
  * mfa_survey3_v20190927.R

### Plots
#### Folder containing graphs resulting from the above R scripts (pptx, pdf, png)
**Old correspondence analysis Plots**. 
  * ca_*_biplot.png
  * ca_*_contrib_all.png
  * ca_*_scree.png

**Correspondence analysis of likert questions from 3 surveys**
  * ca_likert_*.png

**Multiple factor analysis of all relevant questions from each survey**
  * mfa_survey1_plots.pdf :: PDF with all plots of survey 1 data in low resolution
  * mfa_survey1_plots00*.png :: High resolution versions of these plots (scree, biplot, dimensions, loadings)
mfa_survey2_plots.pdf :: PDF with all plots of survey 2 data in low resolution
  * mfa_survey2_plots00*.png :: High resolution versions of these plots (scree, biplot, dimensions, loadings)
mfa_survey3_plots.pdf :: PDF with all plots of survey 3 data in low resolution
  * mfa_survey3_plots00*.png :: High resolution versions of these plots (scree, biplot, dimensions, loadings)
