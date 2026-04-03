# NYC 311 Modeling Plan

**Date created:** 4/2/2026

## Business question
Predict: 311 operators want to route incoming calls to the right agency faster. If a complaint comes in at 2am from a residential zip in the Bronx, what type of problem is it most likely to be?

## Data source
- **S3 path:** s3://cmse492-lesurek1-nyc311-339713112540-us-east-1-an/modeling_data.csv
- **Records:** 173851
- **Athena query:** sql/athena_to_modeling.sql

## Features (update/expand based on your query)
- agency (string)
- borough (string)
- incident_zip (int): represents zip incident occured in
- problem (string)
- day_of_week (int): number 1-7 based on day of the week  problem occured
- hour_of_day(int)
- same_day_complaint_volume (int): how many comlaints occured that day
- days_to_close(int)

## Target
- **Name:** Problem
- **Type:** Classification
- **Balance/Distribution:** Target distribution (problems):
problem
AHV Inspection Unit       2
APPLIANCE               641
Abandoned Bike           55
Abandoned Vehicle      2827
Air Quality             346
                       ... 
Water Conservation      781
Water Quality            42
Water System           3568
Wayfinding                1
Wood Pile Remaining      57
Name: count, Length: 147, dtype: int64

Target distribution (%)
problem
AHV Inspection Unit    0.00
APPLIANCE              0.37
Abandoned Bike         0.03
Abandoned Vehicle      1.63
Air Quality            0.20
                       ... 
Water Conservation     0.45
Water Quality          0.02
Water System           2.05
Wayfinding             0.00
Wood Pile Remaining    0.03
Name: count, Length: 147, dtype: float64
## Modeling approach (update based on your question and data)
- **Baseline:** Logistic regression (interpretable, fast to train)
- **Metrics:** Accuracy, precision, recall
- **Train/test split:** 80/20

## Data quality notes
- N/A

## Next steps (What you'll work on in the next class period; update/modify based on your plan)
- Train/test split
- Fit baseline logistic regression
- Evaluate and interpret results