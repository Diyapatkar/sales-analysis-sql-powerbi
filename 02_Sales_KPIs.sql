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

