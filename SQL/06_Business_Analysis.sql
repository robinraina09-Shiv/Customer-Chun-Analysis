USe customer_churn_db;
# Churn by Contract Type
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn
GROUP BY Contract
ORDER BY Churn_Rate DESC;

# Churn by Internet Service
SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn
GROUP BY InternetService
ORDER BY Churn_Rate DESC;

# Churn by Gender
SELECT
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn
GROUP BY Gender
ORDER BY Churn_Rate DESC;

# Churn by Senior Citizen
SELECT
    SeniorCitizen,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn
GROUP BY SeniorCitizen
ORDER BY Churn_Rate DESC;

# Churn by Tech Support
SELECT TechSupport, COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND( SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS Churn_Rate
FROM customer_churn GROUP BY TechSupport ORDER BY Churn_Rate DESC;

# Churn by Online Security
SELECT
    OnlineSecurity,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*),
        2
    ) AS Churn_Rate
FROM customer_churn
GROUP BY OnlineSecurity
ORDER BY Churn_Rate DESC;

# Churn by Tenure Group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS Tenure_Group, COUNT(*) AS Total_Customers, SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND( SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS Churn_Rate
FROM customer_churn GROUP BY Tenure_Group ORDER BY Churn_Rate DESC;

# Churn by Payment Method
Select Paymentmethod, count(*) as Total_Customers, Sum(Case when Churn = 'Yes' Then 1 Else 0 End)
as Churned_Customer, Round(Sum(Case When Churn = 'Yes' Then 1 Else 0 End) * 100/count(*),2) as Churn_rate
from Customer_Churn
group by Paymentmethod
Order by Churn_rate Desc;

# Revenue Lost Due to Churn
# Since TotalCharges is currently stored as VARCHAR, we'll use CAST().
SELECT
    ROUND(SUM(CAST(TotalCharges AS DECIMAL(10,2))),2) AS Revenue_Lost
FROM customer_churn
WHERE Churn = 'Yes'
AND TRIM(TotalCharges) <> '';