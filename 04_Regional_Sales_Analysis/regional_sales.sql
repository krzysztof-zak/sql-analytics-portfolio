WITH SalesBase AS 
(
SELECT
	dst.SalesTerritoryRegion AS Region,
	dd.CalendarYear AS CalendarYear,
	SUM(fis.SalesAmount) AS RegionSales,
	COUNT(DISTINCT fis.SalesOrderNumber) AS Orders 
FROM FactInternetSales fis
LEFT JOIN DimSalesTerritory dst
	ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
LEFT JOIN DimDate dd
	ON fis.OrderDateKey = dd.DateKey
GROUP BY 
	dst.SalesTerritoryRegion, 
	dd.CalendarYear
), 
	Calculations AS
(
SELECT
	Region,
	CalendarYear,
	RegionSales,
	Orders,

	-- Total sales per year (market size)
	SUM(RegionSales) OVER(PARTITION BY CalendarYear) AS TotalYearSales,

	-- Share of market within year
	RegionSales * 1.0 
	/ NULLIF(SUM(RegionSales) OVER(PARTITION BY CalendarYear), 0) * 100 AS SalesShare,
	
	-- Average order value
	RegionSales * 1.0
	/ NULLIF(Orders, 0) AS AvgOrderValue,

	-- Ranking within year
	RANK() OVER(
	PARTITION BY CalendarYear
	Order By RegionSales DESC
	) AS RegionRank,

	-- Previous year sales (time-series safe)
	LAG(RegionSales) OVER(
	Partition BY Region 
	ORDER BY CalendarYear
	) AS PreviousYearSales

FROM SalesBase
),
Final AS 
(
SELECT
	Region,
	CalendarYear,
	TotalYearSales,
	RegionRank,
	RegionSales,
	PreviousYearSales,
	Orders,
	SalesShare,
	AvgOrderValue,
	
	-- YoY Growth Rate
	CASE
		WHEN PreviousYearSales IS NULL OR PreviousYearSales = 0
			THEN NULL
		ELSE
			(RegionSales - PreviousYearSales) * 1.0
			/ PreviousYearSales
	END AS YoYGrowthRate,

	-- Leader of the year (deterministic tie-safe version)
	FIRST_VALUE(Region) OVER(
	PARTITION BY CalendarYear
	ORDER BY RegionSales DESC, Region) TopRegionPerYear

FROM Calculations
)
SELECT
*
FROM Final
ORDER BY CalendarYear, RegionRank
