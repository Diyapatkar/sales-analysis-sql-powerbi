
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