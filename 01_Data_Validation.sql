CREATE DATABASE SalesAnalysisDB;

use SalesAnalysisDB;

-- Data Verification
SELECT COUNT(*) AS TOTALRECORDS
FROM Retail_Sales;

SELECT TOP 10 * FROM RETAIL_SALES;

SELECT 
	MIN(Date) AS FIRSTDATE,
	MAX(Date) AS LASTDATE
FROM RETAIL_SALES;

-- Columns verifying
SELECT 
	COLUMN_NAME, DATA_TYPE
	FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'RETAIL_SALES';

-- Data Cleaning & Validation

-- Total records check
SELECT 
	COUNT(*) AS TotalRecords
FROM Retail_Sales;

-- Duplicate Transaction ID check
SELECT 
	TransactionID,
	COUNT(*) AS Total_Duplicates
FROM Retail_Sales
GROUP BY TransactionID
HAVING COUNT(*) > 1;

-- NULL values check
SELECT
    SUM(CASE WHEN TransactionID IS NULL THEN 1 ELSE 0 END) AS MissingID,
    SUM(CASE WHEN [Date] IS NULL THEN 1 ELSE 0 END) AS MissingDate,
    SUM(CASE WHEN ProductName IS NULL THEN 1 ELSE 0 END) AS MissingProduct,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS MissingRegion,
    SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END) AS MissingRevenue,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS MissingProfit
FROM Retail_Sales;

-- Invalid values check
SELECT *
FROM Retail_Sales
WHERE Quantity <= 0
	OR UnitPrice < 0
	OR Revenue < 0
	OR Cost < 0
	OR CustomerRating > 5;

-- Date and year mismatch check
SELECT * FROM Retail_Sales
WHERE YEAR([Date]) <> [Year];

-- Revenue and Profit validate
SELECT * FROM Retail_Sales
WHERE ABS(Revenue - (Quantity * UnitPrice * (1 - Discount))) > 1
	OR ABS(Profit - (Revenue - Cost)) > 1;


-- Basic Sales Performance Analysis

-- Overall sales summary
SELECT 
	COUNT(*) AS TotalTransaction,
	SUM(Quantity) as TotalUnitSold,
	SUM(Revenue) as TotalRevenue,
	SUM(Cost) as TotalCost,
	SUM(Profit) as TotalProfit
FROM Retail_Sales;

-- Average Revenue per Transaction
SELECT 
	AVG(Revenue) AS AverageRevenue,
	AVG(Profit) as AverageProfit
FROM Retail_Sales;

-- Category-wise sales
SELECT 
	Category,
	SUM(Revenue) AS TotalRevenue,
	SUM(Profit) as TotalProfit
FROM Retail_Sales
GROUP BY Category
ORDER BY TotalRevenue DESC;

-- Channel-wise Performance
SELECT 
	Channel,
	COUNT(*) AS TotalTransactions,
	SUM(Revenue) as TotalRevenue,
	SUM(Profit) as TotalProfit
FROM Retail_Sales
GROUP BY Channel
ORDER BY TotalRevenue DESC;

-- Payment Method Analysis
SELECT 
	PaymentMethod,
	COUNT(*) AS TotalTransactions,
	SUM(Revenue) AS TotalRevenue
FROM Retail_Sales
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;

-- Overall Profit Margin
SELECT 
	SUM(Revenue) AS TotalRevenue,
	SUM(Profit) AS TotalProfit,
	CAST(
		100.0 * SUM(Profit) / nullif(sum(revenue), 0)
		as decimal(10,2)
	) as ProfitMarginPercent
FROM Retail_Sales;


-- Product Performance Analysis

-- Top 10 Products by Revenue
SELECT TOP 10
	ProductName,
	SUM(Quantity) AS TotalUnitsSold,
	SUM(Revenue) as TotalRevenue,
	SUM(Profit) as TotalProfit
FROM Retail_Sales
GROUP BY ProductName
ORDER BY TotalRevenue DESC;

-- Top 10 Products by Profit
SELECT TOP 10 
	ProductName,
	SUM(PROFIT) AS TotalProfit
FROM Retail_Sales
GROUP BY ProductName
order by TotalProfit desc;

-- Highest-Selling Products by Quantity
SELECT TOP 10
	ProductName,
	SUM(Quantity) AS TotalUnitsSold
FROM Retail_Sales
GROUP BY ProductName
ORDER BY TotalUnitsSold DESC;

-- Category-wise Product Performance
SELECT
	Category,
	COUNT(DISTINCT ProductName) AS TOTALPRODUCTS,
	SUM(Revenue) AS TOTALREVENUE,
	SUM(Profit) AS TOTALPROFIT
FROM Retail_Sales
GROUP BY Category
ORDER BY TOTALREVENUE DESC;

-- Low-Performing Products
SELECT
    ProductName,
    SUM(Revenue) AS TotalRevenue,
    SUM(Profit) AS TotalProfit
FROM Retail_Sales
GROUP BY ProductName
ORDER BY TotalRevenue ASC;

-- Products with Negative Profit
SELECT
    ProductName,
    SUM(Revenue) AS TotalRevenue,
    SUM(Profit) AS TotalProfit
FROM Retail_Sales
GROUP BY ProductName
HAVING SUM(Profit) < 0
ORDER BY TotalProfit ASC;

-- Monthly Revenue Trends

-- Monthly-wise Revenue
SELECT 
	YEAR([DATE]) AS SalesYear,
	Month([Date]) as SalesMonth,
	SUM(Revenue) as TotalRevenue,
	SUM(Profit) as TotalProfit
FROM Retail_Sales
GROUP BY YEAR([Date]), Month([Date])
ORDER BY SalesYear, SalesMonth

-- Highest Revenue Month
SELECT TOP 1
	YEAR([Date]) as SalesYear,
	Month([Date]) as SalesMonth,
	SUM(Revenue) as TotalRevenue
FROM Retail_Sales
GROUP BY YEAR([Date]), MONTH([Date])
ORDER BY TotalRevenue DESC;

-- Lowest Revenue Month
SELECT TOP 1
    YEAR([Date]) AS SalesYear,
    MONTH([Date]) AS SalesMonth,
    SUM(Revenue) AS TotalRevenue
FROM Retail_Sales
GROUP BY YEAR([Date]), MONTH([Date])
ORDER BY TotalRevenue ASC;

-- Month-over-Month Growth
SELECT *,
    (TotalRevenue - PreviousRevenue) * 100.0
    / PreviousRevenue AS GrowthPercent
FROM (
    SELECT *,
        LAG(TotalRevenue) OVER (ORDER BY SalesMonth) AS PreviousRevenue
    FROM (
        SELECT
            DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 1) AS SalesMonth,
            SUM(Revenue) AS TotalRevenue
        FROM Retail_Sales
        GROUP BY YEAR([Date]), MONTH([Date])
    ) AS A
) AS B;

-- Year wise Revenue Comparison
SELECT 
	YEAR([Date]) AS SalesYear,
	SUM(Revenue) as TotalRevenue,
	SUM(Profit) as TotalProfit
FROM Retail_Sales
GROUP BY YEAR([Date])
ORDER BY SalesYear;

-- Regional Sales Analysis

-- Region - wise Performance
SELECT 
	Region,
	COUNT(*) as TotalTransactions,
	SUM(Quantity) as TotalQuantity,
	SUM(Profit) as TotalProfit,
	SUM(Revenue) as TotalRevenue
FROM Retail_Sales
Group by Region
order by TotalRevenue desc;

-- Highest Revenue Region
SELECT TOP 1
	Region,
	SUM(Revenue) AS TotalRevenue
FROM Retail_Sales
GROUP BY Region
ORDER BY TotalRevenue DESC;

-- Underperforming Regions
SELECT 
	Region,
	SUM(Revenue) AS TotalRevenue,
	SUM(Profit) as TotalProfit
FROM Retail_Sales
group by Region
order by TotalRevenue asc;

-- Region-wise profit Margin
SELECT 
	Region,
	SUM(Revenue) AS TotalRevenue,
	SUM(Profit) as TotalProfit,
	CAST(
		SUM(Profit) * 100.0 / nullif(SUM(revenue), 0) as decimal(10,2)
	) as ProfitMarginPercent
FROM Retail_Sales
Group by Region
order by ProfitMarginPercent desc;

-- Category Performance in Each Region
SELECT 
	Region,
	Category,
	SUM(Revenue) AS TOTALREVENUE,
	SUM(Profit) AS TOTALPROFIT
FROM Retail_Sales
GROUP BY Region, Category
ORDER BY REGION, TOTALREVENUE DESC;

-- Revenue contribution by region(%)
SELECT
    Region,
    SUM(Revenue) AS TotalRevenue,
    CAST(
        SUM(Revenue) * 100.0 /
        NULLIF((SELECT SUM(Revenue)
                FROM RETAIL_SALES), 0)
        AS DECIMAL(10,2)
    ) AS RevenueContributionPercent
FROM Retail_Sales
GROUP BY Region
ORDER BY RevenueContributionPercent DESC;




-- Advanced SQL Analysis

-- Rank Top Products
SELECT 
	ProductName,
	SUM(Revenue) AS TOTALREVENUE,
	RANK() OVER (
		ORDER BY SUM(REVENUE) DESC
		) AS PRODUCTRANK
FROM Retail_Sales
GROUP BY ProductName

-- Top 5 Customers by Revenue
SELECT TOP 5
	City,
	Gender,
	COUNT(*) AS TRANSACTIONS,
	SUM(Revenue) AS TOTALREVENUE
FROM Retail_Sales
GROUP BY City, Gender
ORDER BY TOTALREVENUE DESC;

-- CTE - Profitable categories
WITH CategorySales as (
	select 
		Category,
		SUM(Revenue) AS TOTALREVENUE,
		SUM(Profit) AS TOTALPROFIT
	from Retail_Sales
	GROUP BY Category
)
SELECT * FROM CategorySales
WHERE TOTALPROFIT > 0
ORDER BY TOTALPROFIT DESC;

-- Returned vs Non-Returned Sales
select 
	Returned,
	COUNT(*) as Tramsactions,
	SUM(Revenue) as Totalrevenue,
	SUM(Profit) as Totalprofit
from Retail_Sales
group by Returned

-- Discount Analysis
SELECT
    Discount,
    COUNT(*) AS Transactions,
    SUM(Revenue) AS Revenue,
    SUM(Profit) AS Profit
FROM Retail_Sales
GROUP BY Discount
ORDER BY Discount;

-- Create a reusable sql view
CREATE VIEW dbo.vw_SalesSummary AS
SELECT
    Region,
    Category,
    SUM(Quantity) AS UnitsSold,
    SUM(Revenue) AS TotalRevenue,
    SUM(Profit) AS TotalProfit
FROM Retail_Sales
GROUP BY Region, Category;
GO

SELECT *
FROM dbo.vw_SalesSummary
ORDER BY TotalRevenue DESC;



-- Projec & Portfolio
-- KPI report

SELECT
    COUNT(*) AS TotalTransactions,
    SUM(Quantity) AS UnitsSold,
    SUM(Revenue) AS TotalRevenue,
    SUM(Cost) AS TotalCost,
    SUM(Profit) AS TotalProfit,
    CAST(
        SUM(Profit) * 100.0 / NULLIF(SUM(Revenue), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPercent
FROM Retail_Sales;

-- Final Business Insights
-- Top 5 products
SELECT TOP 5
    ProductName,
    SUM(Revenue) AS Revenue,
    SUM(Profit) AS Profit
FROM Retail_Sales
GROUP BY ProductName
ORDER BY Revenue DESC;

-- Monthly revenue
SELECT
    YEAR([Date]) AS SalesYear,
    MONTH([Date]) AS SalesMonth,
    SUM(Revenue) AS Revenue
FROM Retail_Sales
GROUP BY YEAR([Date]), MONTH([Date])
ORDER BY SalesYear, SalesMonth;

-- Lowest-revenue regions
SELECT
    Region,
    SUM(Revenue) AS Revenue,
    SUM(Profit) AS Profit
FROM Retail_Sales
GROUP BY Region
ORDER BY Revenue ASC;

-- Returned transactions
SELECT
    Returned,
    COUNT(*) AS Transactions,
    SUM(Revenue) AS Revenue,
    SUM(Profit) AS Profit
FROM Retail_Sales
where Returned > 0
GROUP BY Returned;

