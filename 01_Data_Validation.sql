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
