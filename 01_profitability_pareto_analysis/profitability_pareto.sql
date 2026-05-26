Revenue & Profit Analytics (Core BI)
1. Top Products by Profit Contribution

Using FactInternetSales + DimProduct:

Find top 10 products by total margin
Compute:
margin %
share of total revenue
cumulative revenue contribution (Pareto / 80-20)

👉 Must use:

SUM() OVER()
RANK() or DENSE_RANK()
cumulative sum window
*/
-- Joining tables and pulling required information
WITH BasicInfo AS (
	SELECT
		dp.ProductKey AS ProductKey,
		dp.EnglishProductName AS EnglishProductName,
		fis.SalesAmount AS SalesAmount,
		fis.TotalProductCost AS TotalProductCost
	FROM FactInternetSales fis
	LEFT JOIN DimProduct dp
	ON fis.ProductKey = dp.ProductKey
),
-- Aggregating sales and margin metrics
Totals AS (
	SELECT
		ProductKey,
		EnglishProductName,
		
		SUM(SalesAmount) AS TotalProductSales,
		
		SUM(TotalProductCost) AS TotalCost,
		
		ROUND(SUM(SalesAmount) - SUM(TotalProductCost), 2) AS Margin,
		
		ROUND((SUM(SalesAmount) - SUM(TotalProductCost)) * 1.00 / NULLIF(SUM(SalesAmount), 0) * 100, 2) AS PercentageMargin,
		
		SUM(SUM(SalesAmount)) OVER() AS AllSales
	FROM BasicInfo
	GROUP BY ProductKey, EnglishProductName
),
-- Creating ranking and basic calculations for Pareto distribution
Ranking AS(
SELECT
	ProductKey,
	EnglishProductName,
	TotalProductSales,
	TotalCost,
	PercentageMargin,
	Margin,
	AllSales,
	
	(TotalProductSales * 1.00 / AllSales) AS ShareInAllSales,
	
	Rank() OVER(Order BY Margin DESC) AS ProductRank,
	
	SUM(Margin) OVER() TotalMargin,
	
	SUM(Margin) OVER(ORDER BY Margin DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeMargin
FROM Totals)

--Query containing required columns and final pareto calculations 
Select
ProductKey,
EnglishProductName,
ProductRank,
Margin,
PercentageMargin,

ROUND((CumulativeMargin * 100.00) / TotalMargin, 2)  AS CumulativeMarginPercent,

--Creating range for Pareto distribution
CASE
	WHEN (CumulativeMargin * 100.00) / TotalMargin <= 80 THEN 'Top 80%'
	ELSE 'Bottom 20%'
END AS ParetoGroup

From Ranking
WHERE ProductRank <=10
