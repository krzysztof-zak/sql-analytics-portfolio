WITH EarliestOrderDate AS
-- Establishing The Earliest Order Date For Each Client
(
	SELECT
		fis.CustomerKey,
		MIN(
			DATEFROMPARTS(
						YEAR(dd.FullDateAlternateKey),
						MONTH(dd.FullDateAlternateKey),
						1)) AS CohortMonth
	FROM FactInternetSales fis
	JOIN DimDate dd
	ON fis.OrderDateKey = dd.DateKey
	GROUP BY fis.CustomerKey
), 

CohortSize AS
--How Many Customers Belong To Each Cohort
(
	SELECT
		COUNT(*) AS CohortSize,
		CohortMonth
	FROM EarliestOrderDate
	GROUP BY CohortMonth
),

ClientsOrders AS
--Finding Months In Which Orders Were Made
(
	SELECT
		fis.CustomerKey,
		DATEFROMPARTS(
					YEAR(dd.FullDateAlternateKey),
					MONTH(dd.FullDateAlternateKey),
					1) OrderMonths
	FROM FactInternetSales fis
	JOIN DimDate dd
		ON fis.OrderDateKey = dd.DateKey
),

RetentionBase AS
-- For Each Clients Active Month, Calculate How Many Month Have Passed Since EarliestOrderMonth (eod.CohortMonth)
(
SELECT
  eod.CustomerKey,
  eod.CohortMonth,
  co.OrderMonths,
  DATEDIFF(
  		MONTH,
    	eod.CohortMonth,
    	co.OrderMonths) AS MonthNumber
FROM EarliestOrderDate eod
JOIN ClientsOrders co
	ON eod.CustomerKey = co.CustomerKey
),


CustomersByMonth AS
-- Counting How Many Clients Made Orders Each Month
(
	SELECT
		COUNT(DISTINCT(CustomerKey)) Customers,
		CohortMonth,
		MonthNumber
	FROM RetentionBase
	GROUP BY CohortMonth, MonthNumber
)
SELECT
	Customers,
	cs.CohortSize,
	cs.CohortMonth,
	cbm.MonthNumber,
	ROUND(Customers * 100.0 / cs.CohortSize, 2) AS CohortRetentionPct
FROM CustomersByMonth cbm
JOIN CohortSize cs
	ON cbm.CohortMonth = cs.CohortMonth
ORDER BY CohortMonth, MonthNumber
