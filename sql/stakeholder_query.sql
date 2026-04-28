-- "Where should the city prioritize resources based on the most frequent complaints by agency, borough, and problem type?""

-- Identifies the highest-demand service areas by combining agency, borough, and problem type, helping prioritize resource allocation based on complaint volume
SELECT
  c.agency,
  a.agency_name,
  c.borough,
  c.problem,
  COUNT(*) AS total_complaints
FROM nyc311_db.complaints AS c
JOIN nyc311_db.agencies AS a
  ON c.agency = a.agency
GROUP BY
  c.agency,
  a.agency_name,
  c.borough,
  c.problem
ORDER BY total_complaints DESC
LIMIT 20;