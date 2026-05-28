WITH Stg_InternetSales AS
(
SELECT
	dc.CustomerKey AS CustomerKey,
	fis.SalesAmount,
	fis.SalesOrderNumber,
	dd.FullDateAlternateKey AS OrderDate
FROM FactInternetSales fis
LEFT JOIN DimCustomer dc
ON fis.CustomerKey = dc.CustomerKey
LEFT JOIN DimDate dd
ON fis.OrderDateKey = dd.DateKey
), Fct_CustomerMetrics AS
(
SELECT
	CustomerKey,
	SUM(SalesAmount) AS SalesByCustomer,
	SUM(SUM(SalesAmount)) OVER() AS CompanySales,
	COUNT(DISTINCT SalesOrderNumber) AS UniqueOrders,
	MAX(OrderDate) AS LatestOrder,
	DATEDIFF(MONTH, MAX(OrderDate), GETDATE()) AS TimeFromLastOrder,
	NTILE(4) OVER(ORDER BY SUM(SalesAmount) DESC) AS ClientQuartile
FROM Stg_InternetSales
GROUP BY CustomerKey
), Segmentation AS
(
SELECT
	*,
	SalesByCustomer * 1.00 / NULLIF(CompanySales, 0) * 100 AS CustPercentageShereSales,
	RANK() OVER(ORDER BY SalesByCustomer DESC) AS RankBySales,
	CASE
		WHEN ClientQuartile = 1 AND UniqueOrders > 10 THEN 'VIP'
		WHEN ClientQuartile IN (2, 3) THEN 'Loyal'
		WHEN ClientQuartile = 4 AND TimeFromLastOrder > 24 THEN 'At Risk'
		ELSE 'Regular'
	END AS CustomerSegmentation
FROM Fct_CustomerMetrics
)
SELECT
	CustomerSegmentation,
	COUNT(*) CustomersPerSegment,
	AVG(SalesByCustomer) AvgSalesPerSegment,
	MAX(SalesByCustomer) MaxSalesPerSegment,
	AVG(UniqueOrders * 1.0) AS AvgNumberOfOrders,
	(COUNT(*) * 1.00 / SUM(COUNT(*)) OVER()) * 100 AS PercentageOfTotalCustomers,
	SUM(SalesByCustomer) / MAX(CompanySales) AS SalesContribution
FROM Segmentation
GROUP BY CustomerSegmentation
