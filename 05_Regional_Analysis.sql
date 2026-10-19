
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
