# Analysis Of Combined Scientist Surveys One - Three

## Description

## Provenance Notes

Questions from the three surveys varied in question number. Additionally, questions were added and subtracted on follow-up surveys. Choices for answers also varied slightly across surveys. For this analysis we only used questions that remained substantially unchanged across surveys. Because question numbers varied across surveys we manually matched questions across surveys. The questions and and answers are found in the `documentation/instruments` directory.

## Usage

Run the `main.R` to run the analysis.

## File Structure

```
project
│   README.md
│   main.r # Main analysis script 
│
└───data  # Data files. See main.R to see where they are used.
│   │   
|   |   first_scientist_survey.csv
|   |   second_scientist_survey.csv
|   |   third_scientist_survey.csv
│   │
│   └───country_codes  # Look up tables to map numeric country codes to countries and
|        |              # geographic regions
│        │   survey_three.csv
│        │   survey_one_two.csv
│   
└───documentation 
    │
    └─── instruments # Raw files of survey instruments
```

foo