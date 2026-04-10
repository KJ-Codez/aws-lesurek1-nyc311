# NYC 311 Service Request Analysis Project

  - Analysis of NYC 311 service requests to identify patterns in complaint types by agency and borough.

---

## Data Source and Provenance

- **Source**: [NYC Open Data — 311 Service Requests](https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2020-to-Present/erm2-nwe9/)
- **Time period**: Jan 29–Mar 21, 2026 (Q1 2026)
- **Sampling**: Instructor-generated random sample of 200k complaints from 15 agencies
- **Files**:
  - `raw/complaints.csv` — 200k rows, ~50 MB, main requests table
  - `raw/agencies.csv` — 12 rows, ~1 KB, unique agencies lookup table

---

## Project Structure

```
aws-lesurek1-nyc311/
├── README.md                 # This file — data source, S3 paths, assumptions
├── DATA_DICTIONARY.md        # Full column-level schema
├── raw/                      # Local copies of S3 data (not committed to git)
│   ├── complaints.csv
│   └── agencies.csv
├── sql/                      # Athena queries
├── notes/                    # Observations and decisions log
└── reports/                  # Stakeholder-ready outputs and summaries
```

---
 
## Stakeholder Question
 
> **Estimate how many days it will take a 311 complaint to close.**
 
This is a regression/estimation problem. The target variable is resolution time in days, calculated as:
 
```
days_to_close = closed_date - created_date
```
 
Records where `closed_date` is empty are open/unresolved and are excluded from model training.
 
**Modeling approach**: SageMaker Linear Learner (`predictor_type='regressor'`, `normalize_label=True`)
 
**Features used**:
 
| Type | Columns |
|------|---------|
| Categorical (one-hot encoded) | `agency`, `borough`, `problem` |
| Numeric (passed through) | `day_of_week`, `hour_of_day`, `same_day_complaint_volume` |
 
**Target**: `days_to_close` (continuous, float)
 
**Evaluation**: Linear Learner predictions are compared against a naive baseline (predicts training-set mean for every row) using MAE, RMSE, and R².
 
**Key join**: `complaints.agency = agencies.agency`
 
---
 
## Assumptions and Known Issues
 
| Issue | Detail |
|-------|--------|
| Open requests | Empty `closed_date` = unresolved; exclude from days-to-close calculations |
| ZIP code quality | `incident_zip` may be 0 or null for some rows |
| Date format | Dates are strings — use `DATE_PARSE(created_date, '%Y-%m-%d %H:%i:%S')` in Athena |
| Resolution text | `resolution_description` is free text, verbose, and sometimes empty |
| Borough values | Includes BRONX, MANHATTAN, QUEENS, BROOKLYN, STATEN ISLAND |
 