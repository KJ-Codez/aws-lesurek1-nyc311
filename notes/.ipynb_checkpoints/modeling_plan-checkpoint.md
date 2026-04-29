# NYC 311 Modeling Plan

**Date created:** 4/2/2026

## Business question
Predict: Agency directors want a tool that estimates expected resolution time at the moment a complaint is filed, so they can set realistic expectations with residents. What factors drive that time?

## Data source
- **S3 path:** s3://cmse492-lesurek1-nyc311-339713112540-us-east-1-an/modeling/modeling_data.csv
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
- **Name:** days_to_close
- **Type:** Regression
- **Balance/Distribution:** Target distribution (days_to_close):

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

## Baseline Model Results

- **Model:** Logistic Regression
- **Features used:** ['agency', 'borough', 'incident_zip', 'problem', 'day_of_week', 'hour_of_day', 'same_day_complaint_volume', 'days_to_close']
- **Target:** [problem]
- **Train/test split:** 80/20, random_state=42

### Metrics
- Accuracy:  [0.99]
- Precision: [0.99]
- Recall:    [0.99]

### Interpretation
[Your interpretation: the model performs with an accuracy rate of 99%, meaning that if the model is given features like day_of_week, agency, etc, it can predict what the problem would be 99% of the time. So the model performs almost perfectly. Precision is also probably more important since we want the sytem to be reliable more than catching all the complaint types ]

### Limitation
[Target Classes are imbalanced]