# Analysis Of Combined Scientist Surveys One, Two & Three

## Description

## Provenance Notes

Questions from the three surveys varied in question identifier number. Additionally, some questions were modified, added, and/or deleted on follow-up surveys. Choices for answers also varied slightly across surveys. For this analysis we only used questions that remained substantially unchanged across surveys, although all of the data from all questions are included in these survey files (see additional comments below). Because question numbers varied across surveys, we manually re-aligned questions across surveys. The survey instruments  and answer choices are found in the `documentation/instruments` directory.

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
