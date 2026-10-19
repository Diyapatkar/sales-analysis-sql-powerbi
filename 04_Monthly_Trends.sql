
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