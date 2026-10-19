--Step 1: Check total records
SELECT COUNT(*) AS TotalRecords
FROM Retail_Sales;


--Step 2: Check revenue and profit consistency
SELECT TOP 20
    TransactionID,
    Revenue,
    Cost,
    Profit,
    Revenue - Cost AS CalculatedProfit
FROM Retail_Sales
WHERE ABS(Profit - (Revenue - Cost)) > 1;


--Step 3: Check duplicate transactions
SELECT TransactionID, COUNT(*) AS Total
FROM Retail_Sales
GROUP BY TransactionID
HAVING COUNT(*) > 1;


--Step 4: Check date range
SELECT
    MIN([Date]) AS FirstDate,
    MAX([Date]) AS LastDate,
    COUNT(DISTINCT YEAR([Date])) AS TotalYears
FROM Retail_Sales;