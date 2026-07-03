USe customer_churn_db;

# Total Customers
SELECT COUNT(*) AS Total_Customers
FROM customer_churn;

# Churn Distribution
SELECT Churn, COUNT(*) AS Customers
FROM customer_churn
GROUP BY Churn;

# Churn Rate
SELECT
    COUNT(*) AS Total_Customers,                      # first KPI
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS Active_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn; 

# Gender Distribution
SELECT
    gender,
    COUNT(*) AS Customers
FROM customer_churn
GROUP BY gender;

# Senior Citizens
SELECT
    SeniorCitizen,
    COUNT(*) AS Customers
FROM customer_churn
GROUP BY SeniorCitizen;

# Contract Distribution
SELECT
    Contract,
    COUNT(*) AS Customers
FROM customer_churn
GROUP BY Contract;

# Internet Service Distribution
SELECT
    InternetService,
    COUNT(*) AS Customers
FROM customer_churn
GROUP BY InternetService;