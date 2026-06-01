WITH SalesBase AS(
-- Joining tables and selecting basic information
Select
	fis.SalesAmount AS SalesAmount,
	dpc.EnglishProductCategoryName AS CategoryName,
	DATEFROMPARTS(dd.CalendarYear, dd.MonthNumberOfYear, 1) AS DateMonth
FROM FactInternetSales fis
LEFT JOIN DimDate dd
	ON fis.OrderDateKey = dd.DateKey
LEFT JOIN DimProduct dp
	ON fis.ProductKey = dp.ProductKey
LEFT JOIN DimProductSubcategory dps
	ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
LEFT JOIN DimProductCategory dpc
	ON dps.ProductCategoryKey = dpc.ProductCategoryKey
),
BestProduct As(
-- Ranking categories for final report
Select
	DateMonth,
	SUM(SalesAmount) AS MonthlySales,
	CategoryName,
	ROW_NUMBER() OVER(PARTITION BY DateMonth ORDER BY SUM(SalesAmount) DESC) AS CatRank
FROM SalesBase
GROUP BY DateMonth, CategoryName
),
Revenue AS (
-- Calculating monthly revenue for final report
Select
	DateMonth,
	SUM(SalesAmount) MonthlySales
From SalesBase
GROUP BY DateMonth
),
MonthLag AS (
-- Creating 1 month lag column in order to calculate difference in monthly sales
SELECT
	DateMonth,
	MonthlySales,
	LAG(MonthlySales) OVER(ORDER BY DateMonth) PreviousMonthSales
FROM Revenue
)
Select
-- final calculations
	ml.DateMonth,
	ml.MonthlySales,
	ml.PreviousMonthSales,
	(ml.MonthlySales - ml.PreviousMonthSales) AS MonthlyDiff,
	(ml.MonthlySales - ml.PreviousMonthSales) * 1.00  / NULLIF(ml.PreviousMonthSales, 0) * 100 AS PercChange,
	AVG(ml.MonthlySales) OVER(ORDER BY ml.DateMonth ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Avg3Month,
	SUM(ml.MonthlySales) OVER(ORDER BY ml.DateMonth ASC) AS RunTotal,
	RANK() OVER(ORDER BY ml.MonthlySales DESC) AS SalesRank,
	bp.CategoryName
FROM MonthLag ml
INNER JOIN BestProduct bp
    ON bp.DateMonth = ml.DateMonth
   AND bp.CatRank = 1
