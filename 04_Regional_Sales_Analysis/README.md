# Regional Sales Performance & Market Share Analysis in SQL

## Project Overview

This project analyzes regional sales performance using SQL aggregations, Common Table Expressions (CTEs), and window functions.

Using **AdventureWorks data** (`FactInternetSales`, `DimSalesTerritory`, `DimDate`), the query builds a year-level analytical report that evaluates sales performance across geographic regions and measures their contribution to overall company revenue.

The analysis calculates key business KPIs such as:

* Regional sales revenue
* Total yearly sales
* Market share by region
* Number of orders
* Average order value (AOV)
* Regional sales ranking
* Previous year sales
* Year-over-Year (YoY) growth rate
* Top-performing region per year

---

## SQL Concepts Used

### Aggregations

* `SUM()`
* `COUNT(DISTINCT)`
* `GROUP BY`

### Common Table Expressions (CTEs)

* `SalesBase`
* `Calculations`
* `Final`

### Window Functions

* `SUM() OVER()` (yearly market size calculation)
* `RANK() OVER()` (regional ranking)
* `LAG()` (previous year sales)
* `FIRST_VALUE()` (top-performing region)

### Analytical Logic

* Market share analysis
* Regional performance benchmarking
* Year-over-Year growth analysis
* Sales trend tracking
* Revenue ranking

### Defensive SQL

* `NULLIF()` (avoid division by zero)
* `CASE` expressions for safe growth-rate calculations

---

## Dataset

**AdventureWorksDW**

Tables used:

* `FactInternetSales`
* `DimSalesTerritory`
* `DimDate`

---

## Analytical Logic

The analysis is structured in 3 steps:

### 1. Regional Sales Aggregation

Aggregates sales performance by region and calendar year.

Metrics calculated:

* Total regional revenue
* Number of unique sales orders

### 2. KPI Calculations

Uses window functions to derive advanced business metrics:

* Total yearly revenue
* Regional market share
* Average order value
* Regional sales ranking
* Previous year sales

### 3. Performance Analysis

Calculates strategic KPIs:

* Year-over-Year growth rate
* Top-performing region for each year

---

## Key Business Questions

* Which sales regions generate the highest revenue?
* How much market share does each region contribute annually?
* Which regions are growing or declining year-over-year?
* What is the average order value across regions?
* Which region leads sales performance each year?

---

## Example Output

| Region        | CalendarYear | TotalYearSales | RegionRank | RegionSales | PreviousYearSales | Orders | SalesShare (%) | AvgOrderValue | YoYGrowthRate |
| ------------- | -----------: | -------------: | ---------: | ----------: | ----------------: | -----: | -------------: | ------------: | ------------: |
| North America |         2005 |     43,000,000 |          1 |  18,500,000 |              NULL |  8,421 |          43.02 |         2,197 |          NULL |
| Europe        |         2005 |     43,000,000 |          2 |  14,700,000 |              NULL |  6,982 |          34.19 |         2,105 |          NULL |
| Pacific       |         2005 |     43,000,000 |          3 |   9,800,000 |              NULL |  4,521 |          22.79 |         2,168 |          NULL |
| North America |         2006 |     51,200,000 |          1 |  22,400,000 |        18,500,000 | 10,112 |          43.75 |         2,215 |          0.21 |

---

## Business Insights Generated

The report enables analysts to:

* Evaluate regional sales performance across multiple years.
* Measure each region’s contribution to total company revenue.
* Identify market leaders and underperforming regions.
* Monitor year-over-year sales growth trends.
* Compare average order values between regions.
* Support strategic decisions related to territory management and resource allocation.

---

## Skills Demonstrated

* Data aggregation and dimensional modeling
* Multi-step analysis using CTEs
* Advanced window functions
* Time-series analysis with `LAG()`
* Market share calculations
* Revenue ranking and benchmarking
* Business KPI development
* Defensive SQL programming practices
