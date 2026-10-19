
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
