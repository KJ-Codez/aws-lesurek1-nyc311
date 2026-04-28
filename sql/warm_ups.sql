-- This query counts the total number of complaints in the dataset. The expected result is 200,000 (as a single number).
SELECT COUNT(*) AS n_complaints
FROM nyc311_db.complaints;

-- Returns the date range of complaints in the dataset
SELECT 
  MIN(created_date) AS earliest,
  MAX(created_date) AS latest
FROM nyc311_db.complaints;

-- Counts the number of complaints per agency, then returns the top 10 agencies with the highest complaint volumes
SELECT agency, COUNT(*) AS n
FROM nyc311_db.complaints
GROUP BY agency
ORDER BY n DESC
LIMIT 10;

-- Counts the number of complaints for each combination of borough and problem type, then returns the top 20 most frequent borough-problem pairs
SELECT borough, problem, COUNT(*) AS n
FROM nyc311_db.complaints
GROUP BY borough, problem
ORDER BY n DESC
LIMIT 20;

-- Joins complaints with agency information to map agency codes to full names, counts the total number of complaints handled by each agency, and orders the results from highest to lowest complaint volume
SELECT 
  c.agency,
  a.agency_name,
  COUNT(*) AS n
FROM nyc311_db.complaints AS c
JOIN nyc311_db.agencies AS a
  ON c.agency = a.agency
GROUP BY c.agency, a.agency_name
ORDER BY n DESC;

