# Top 10 Customers by Total Charges
SELECT
    customerID,
    Contract,
    CAST(TotalCharges AS DECIMAL(10,2)) AS Total_Charges,
    DENSE_RANK() OVER (
        ORDER BY CAST(TotalCharges AS DECIMAL(10,2)) DESC
    ) AS Customer_Rank
FROM customer_churn
WHERE TRIM(TotalCharges) <> ''
LIMIT 10;

# Average Monthly Charges by Contract Type
SELECT
    Contract,
    ROUND(AVG(MonthlyCharges),2) AS Avg_Monthly_Charges
FROM customer_churn
GROUP BY Contract;
SELECT
    Contract,
    ROUND(AVG(MonthlyCharges)) AS Avg_Monthly_Charges
FROM customer_churn
GROUP BY Contract;

# Highest Churn Payment Method
SELECT
    PaymentMethod,
    COUNT(*) AS Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned,
    ROUND(
        SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY Churn_Rate DESC
LIMIT 1;

# High-Risk Customers
SELECT
    customerID,
    Contract,
    InternetService,
    MonthlyCharges,
    tenure
FROM customer_churn
WHERE Contract='Month-to-month'
AND InternetService='Fiber optic'
AND MonthlyCharges > 70
AND tenure < 12
Order by tenure Desc;

# Create a View
CREATE VIEW churn_summary AS
SELECT
    customerID,
    gender,
    Contract,
    InternetService,
    MonthlyCharges,
    Churn
FROM customer_churn;

SELECT *
FROM churn_summary
LIMIT 10;

SELECT customerID,
    gender,
    Contract,
    InternetService,
    MonthlyCharges,
    Churn FROM customer_churn
LIMIT 10;

# CTE
WITH Contract_Churn AS
(SELECT Contract, COUNT(*) AS Total_Customers, SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned
    FROM customer_churn GROUP BY Contract)
SELECT *,
ROUND(Churned*100.0/Total_Customers,2) AS Churn_Rate
FROM Contract_Churn;