USE customer_churn_db;

SELECT *
FROM customer_churn
LIMIT 10;

SELECT COUNT(*) AS Total_Customers                       # Count Total Customers
FROM customer_churn;

SELECT customerID,                                        # Check for Duplicate Customers
       COUNT(*) AS Duplicate_Count
FROM customer_churn
GROUP BY customerID
HAVING COUNT(*) > 1;

SELECT                                               # Check for NULL Values
SUM(customerID IS NULL) AS customerID,
SUM(gender IS NULL) AS gender,
SUM(SeniorCitizen IS NULL) AS SeniorCitizen,
SUM(Partner IS NULL) AS Partner,
SUM(Dependents IS NULL) AS Dependents,
SUM(tenure IS NULL) AS tenure,
SUM(MonthlyCharges IS NULL) AS MonthlyCharges,
SUM(TotalCharges IS NULL) AS TotalCharges,
SUM(Churn IS NULL) AS Churn
FROM customer_churn;

SELECT *                                 
FROM customer_churn
WHERE TRIM(TotalCharges) = '';

SELECT DISTINCT Churn                               # Check Distinct Values
FROM customer_churn;         

SELECT Churn,                                   # Understand the Data Distribution
COUNT(*) AS Customers
FROM customer_churn
GROUP BY Churn;           

SELECT
    COUNT(*) AS Total_Customers,                      # first KPI
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn;    

Drop table customer_churn;