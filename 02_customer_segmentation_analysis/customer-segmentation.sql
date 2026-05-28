WITH BasicInfo AS
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
), Calculations AS
(
SELECT
	CustomerKey,
	SUM(SalesAmount) AS SalesByCustomer,
	SUM(SUM(SalesAmount)) OVER() AS CompanySales,
	COUNT(DISTINCT SalesOrderNumber) AS UniqueOrders,
	MAX(OrderDate) AS LatestOrder,
	DATEDIFF(MONTH, MAX(OrderDate), GETDATE()) AS TimeFromLastOrder,
	NTILE(4) OVER(ORDER BY SUM(SalesAmount) DESC) AS ClientQuartile
FROM BasicInfo
GROUP BY CustomerKey
), WindowFunctions AS
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
FROM Calculations
)
SELECT
	wf.CustomerSegmentation,
	COUNT(*) CustomersPerSegment,
	AVG(SalesByCustomer) AvgSalesPerSegment,
	MAX(SalesByCustomer) BiggestSalePerSegment,
	AVG(UniqueOrders * 1.0) AS AvgNumberOfOrders,
	(COUNT(*) * 1.00 / SUM(COUNT(*)) OVER()) * 100 AS PercentageOfTotalCustomers,
	SUM(SalesByCustomer) / MAX(CompanySales) AS SegmentSalesContribution
FROM WindowFunctions wf
GROUP BY CustomerSegmentation
