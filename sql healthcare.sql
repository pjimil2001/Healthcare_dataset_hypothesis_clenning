CREATE DATABASE health_db;
USE health_db;

-- Billing amount difference by gender

SELECT 
  gender, 
  COUNT(*) AS total_patients,
  AVG(billing_amount) AS average_billing,
  MAX(billing_amount) AS max_billing,
  STDDEV(billing_amount) AS stddev_billing
FROM healthcare_dataset_cleaned
GROUP BY gender;


-- Correlation between age and number of visits

WITH patient_visits AS (
  SELECT 
    name, 
    age, 
    COUNT(*) AS visit_count
  FROM healthcare_dataset_cleaned
  GROUP BY name, age
)

SELECT 
  age, 
  AVG(visit_count) AS avg_visits_per_age,
  STDDEV(visit_count) AS stddev_visits
FROM patient_visits
GROUP BY age
ORDER BY age;



-- Billing amount comparison by chronic condition
SELECT 
  CASE 
    WHEN LOWER(medical_condition) LIKE '%chronic%' THEN 'Chronic'
    ELSE 'Non-Chronic'
  END AS condition_type,
  COUNT(*) AS total_patients,
  AVG(billing_amount) AS average_billing,
  STDDEV(billing_amount) AS stddev_billing
FROM healthcare_dataset_cleaned
GROUP BY condition_type;