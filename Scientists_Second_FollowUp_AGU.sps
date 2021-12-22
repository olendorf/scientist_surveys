* Encoding: UTF-8.
/* Recompute age

compute Age = 118 - Q6.
EXECUTE.

/* Change Age to Age Group

recode Age (lo thru 29 = 1)(30 thru 39= 2)(40 thru 49= 3)(50 thru 59= 4)(60 thru 200= 5) into agegroup.
VARIABLE LABELS  AgeGroup ‘AgeGroup’.
VALUE LABELS
agegroup 
1 '0-29'
2 '30-39'
3 '40-49'
4 '50-59'
5 '60-Over'.
VARIABLE LEVEL AgeGroup (ordinal).
EXECUTE.

/* Rename disciplines

DO IF Q3_Other_text EQ 'Oceanography'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'oceanography'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'ocean sciences'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'Ocean Sciences'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'ocean science'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'Ocean Science'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'Marine Science'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'marine science'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'marine geology'. 
    RECODE Q3 (18=19)(else=copy).
ELSE IF Q3_Other_text EQ 'Heliophysics'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Space Science'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Space science'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'space science'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'space physics'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Planetary Science'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'planetary astronomy'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Space plasma physics'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Space geodesy'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Planetary Science'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Planetary'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Space Weather'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'space physics'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Space Physics'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'space weather/solar'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Space and Planetary Sciences'. 
    RECODE Q3 (18=20)(else=copy).
ELSE IF Q3_Other_text EQ 'Earth science'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Earth Science'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Earth Sciences'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Geophysics'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'geophysics'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Applied Geophysics'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Earth Surface Dynamics'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'earth sciences'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'geochemistry'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'whole Earth system'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Natural Hazards'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'seismology'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Seismology'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'geochemistry'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Geochemistry'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'biogeochemistry'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Mineralogy-Petrology-Geochemistry'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Geography'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Geodesy'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Glaciology'. 
    RECODE Q3 (18=10)(else=copy).
ELSE IF Q3_Other_text EQ 'Geodesy & Cryosphere'. 
    RECODE Q3 (18=2)(else=copy).
ELSE IF Q3_Other_text EQ 'Cryosphere'. 
    RECODE Q3 (18=2)(else=copy).
ELSE IF Q3_Other_text EQ 'air-sea interaction'. 
    RECODE Q3 (18=2)(else=copy).
ELSE IF Q3_Other_text EQ 'Environmental physics'. 
    RECODE Q3 (18=9)(else=copy).
ELSE IF Q3_Other_text EQ 'Chemistry'. 
    RECODE Q3 (18=9)(else=copy).
ELSE IF Q3_Other_text EQ 'Hydrogeology'. 
    RECODE Q3 (18=11)(else=copy).
ELSE IF Q3_Other_text EQ 'hydrometry'. 
    RECODE Q3 (18=11)(else=copy).
ELSE IF Q3_Other_text EQ 'Natural resources environment society'. 
    RECODE Q3 (18=1)(else=copy).
END IF.
VALUE LABELS
Q3
1 'Agriculture and Natural Resources'
2 'Atmospheric Science'
3 'Biology'
4 'Business'
5 'Computer Science'
6 'Ecology'
7 'Education'
8 'Engineering'
9 'Environmental Science'
10 'Geology'
11 'Hydrology'
12 'Information Science'
13 'Law'
14 'Medicine'
15 'Physical Sciences'
16 'Psychology'
17 'Social Sciences'
18 'Other'
19 'Marine/Ocean'
20 'Space and Planetary Sciences'.
EXECUTE.

/* Recode discipline

recode Q3 (12=5)(4,7,14,17 = 18)(9=6)(else=copy) into Q3_2.
VALUE LABELS
Q3_2 
1 'Agriculture and Natural Resources'
2 'Atmospheric Science'
3 'Biology'
5 'Information/Computer Science'
6 'Environmental Science/Ecology'
8 'Engineering'
10 'Geology/Earth Science'
11 'Hydrology'
13 'Law'
15 'Physical Sciences'
16 'Psychology'
18 'Other'
19 'Marine/Ocean'
20 'Space and Planetary Sciences'.
VARIABLE LEVEL 'Discipline' (ordinal).
EXECUTE.

/* Recode nationality

recode Q5 (31,182=1)(7,21,24,35,37,40,52,111,133,186=2)(2,10,11,17,45,48,60,62,66,68,76,77,82,84,100,121,126,135,136,140,141,160,166,167,178,180=3)(9,122=4)(14,20,36,78,79,86,88,91,104,118,120,134,138,154,169,171,187=5)
(1,30,53,56,58,67,80,81,83,125,127,128,159,168,175,179=6) into Q5_2.
VALUE LABELS
Q5_2 
1 'US/Canada'
2 'South and Central America'
3 'Europe/Russia'
4 'Australia/New Zealand'
5 'Asia/Southeast Asia'
6 'Africa/Middle East'.
EXECUTE.

begin program.
import spss, spssaux 
command1="FREQUENCIES VARIABLES=Q5_2c"
spss.Submit([command1])
end program.
/* Collect frequencies

data list free/v1 to v5.
begin data
end data.

begin program.
import spssaux
print spssaux.GetVariableNamesList()
end program.

begin program.
import spss, spssaux 
varList = ['Q2','Q3','Q4','Q5','Q6']
print varList
command1="FREQUENCIES VARIABLES=Q2 Q3 Q4 Q5 Q6 Q8 Q_D1_1 Q_D1_2_1"
command2="FREQUENCIES VARIABLES=Q_D1_3_1R_1 Q_D1_3_2R_1 Q_D1_3_3R_1 Q_D1_3_4R_1"
command3="FREQUENCIES VARIABLES=Q_D1_3_5R_1 Q_D1_3_6R_1 Q_D1_3_7R_1 Q_D1_3_8R_1"
command4="FREQUENCIES VARIABLES=D1_4_1R_1 D1_4_2R_1 D1_4_3R_1 D1_4_4R_1 D1_4_5R_1"
command5="FREQUENCIES VARIABLES=D1_4_6R_1 QD1_5 Q9 Q11"
command12="FREQUENCIES VARIABLES=Q12_1 Q12_2 Q12_3 Q12_4 Q12_5 Q12_6 Q12_7 Q12_8 Q12_9 Q12_10 Q12_11 Q12_12"
command14="FREQUENCIES VARIABLES=Q14_1 Q14_2 Q14_3 Q14_4 Q14_5"
command15="FREQUENCIES VARIABLES=Q15_1 Q15_2 Q15_3 Q15_4 Q15_5 Q15_6 Q15_7 Q15_8 Q15_9 Q15_10"
command16="FREQUENCIES VARIABLES=Q16_1 Q16_2"
command18="FREQUENCIES VARIABLES=Q18_1 Q18_2 Q18_3 Q18_4"
command19="FREQUENCIES VARIABLES=Q19_1 Q19_2 Q19_3 Q19_4 Q19_5 Q19_6 Q19_7 Q19_8"
command20="FREQUENCIES VARIABLES=Q20_1 Q20_2 Q20_3 Q20_4 Q20_5"
command21="FREQUENCIES VARIABLES=Q21_1 Q21_2 Q21_3 Q21_4 Q21_5"
command22="FREQUENCIES VARIABLES=Q22_1 Q22_2 Q22_3 Q22_4 Q22_5 Q22_6 Q22_7"
command23="FREQUENCIES VARIABLES=Q23"
spss.Submit([command1])
end program.

begin program.
import spss, spssaux 
command1="FREQUENCIES VARIABLES=Q13"
spss.Submit([command1])
end program.

/* Combine Q12

DO IF Q12_7 OR Q12_8 OR Q12_9 OR Q12_10 EQ 3. 
    RECODE Q12 (18=19)(else=copy) into Q12_normal.
ELSE IF Q3_Other_text EQ 'oceanography'. 
    RECODE Q3 (18=19)(else=copy).
END IF.
VARIABLE LABELS  Q12_normal ‘Q12_normal’.
VALUE LABELS
agegroup 
1 'None'
2 'Some'
3 'Most/All'
4 'Not Sure'
5 '60-Over'.
VARIABLE LEVEL Q12_normal (ordinal).
EXECUTE.



