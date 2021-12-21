# Combined Scientist Survey Factor Analysis

## Title

Scientists attitudes toward sharing over time

## Authors

Borycz, Joshua D <joshua.d.borycz@vanderbilt.edu>

Bruce Grant <bwgrant@widener.edu>

Robert Olendorf <rkolendo@ncsu.edu>

## Description

This data is derived from three previous surveys performed by members of DataONE to gauge scientists' attitudes and practices
around data sharing and data management, and also to determine their satisfaction with the resources provided to them for sharing
and data management. The data and analysis here are a subset of the questions from those three surveys.

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

The data cleaning, analysis and visualizations are contained in separate files in the `script/` directory. The individuals 
scripts likely rely on objects created from previous scripts run in the sequence, and therefore probably cannot be run as 
stand alone scripts.

The data from the three surveys are in the `data/` directory `<nth>_scientists_survey.csv`.



## File Manifest

```
├── main.R    # Run this to perform the analysis                                              
├── README.md
├── data
│   ├── country_codes
│   │   └── regions_master_list.csv    # Used to align countries designations among the different surveys
│   ├── domains                        # Used to align research domains among the different surveys
│   │   ├── domain_recodes.xlsx     
│   │   ├── recoded_domain_mapping.csv
│   │   └── survey_one_domain_code.csv
│   ├── first_scientists_survey.csv   # Survey data 
│   ├── second_scientists_survey.csv
│   └── third_scientists_survey.csv
│   ├── questions                     # Questions used in the three surveys
│   │   ├── first_scientists_survey_questions.csv
│   │   ├── second_scientists_survey_questions.csv
│   │   └── third_scientists_survey_questions.csv
├── plots                             # Plots generated by the script and used in the manuscript
│   ├── domain_survey.png
│   ├── funding_agency_survey.png
│   ├── region_survey.png
│   └── work_sector_survey.png
└── scripts
    ├── cleanSurveys.R                # Cleans the data from the three survies
    ├── combineSurveys.R              # Combines the three surveys together
    ├── country_codes.R               # Aligns country codes from the three surveys
    ├── domain_recode.R               # Aligns research domains from the three survesy
    ├── load_data.R                   # Loads the data into R
    ├── multiFactorAnalysis.R         # Performs the factor analysis    
    └── temporary_analysis.R          
```

