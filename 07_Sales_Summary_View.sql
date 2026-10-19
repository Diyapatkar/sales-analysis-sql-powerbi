
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
