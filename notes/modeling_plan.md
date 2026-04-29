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
- **Balance/Distribution:** Rightly Skewed
Target distribution (days_to_close):
days_to_close | amount
0     107909
1      17700
2      12346
...
47        16
48        19
49        12

Target distribution (%)
days_to_close
0     62.07
1     10.18
2      7.10
...
47     0.01
48     0.01
49     0.01
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