# Monthly Sales Performance & Category Analysis in SQL

## Project Overview

This project analyzes monthly sales performance using SQL aggregations, Common Table Expressions (CTEs), and window functions.

Using **AdventureWorks data** (`FactInternetSales`, `DimDate`, `DimProduct`, `DimProductSubcategory`, `DimProductCategory`), the query builds a month-level analytical report that tracks sales trends and identifies the top-performing product category each month.

The analysis calculates key sales KPIs such as:

* Monthly revenue
* Previous month sales
* Month-over-month (MoM) growth
* Percentage sales change
* 3-month moving average
* Running total sales
* Monthly sales ranking
* Best-selling product category per month

---

## SQL Concepts Used

### Aggregations

* `SUM()`
* `GROUP BY`

### Window Functions

* `LAG()` (previous month sales)
* `AVG() OVER()` (3-month moving average)
* `SUM() OVER()` (running total)
* `RANK() OVER()` (sales ranking)
* `ROW_NUMBER() OVER()` (top category selection)

### Analytical Logic

* Month-over-Month (MoM) analysis
* Sales trend analysis
* Running total calculation
* Moving average calculation
* Category performance ranking

### Defensive SQL

* `NULLIF()` (avoid division by zero in percentage calculations)

---

## Dataset

**AdventureWorksDW**

Tables used:

* `FactInternetSales`
* `DimDate`
* `DimProduct`
* `DimProductSubcategory`
* `DimProductCategory`

---

## Analytical Logic

The analysis is structured in 4 steps:

### 1. Data Preparation

Creates a unified sales dataset by joining sales transactions with date and product dimensions.

### 2. Category Performance Analysis

Calculates monthly sales by product category and identifies the highest-performing category for each month using:

* `ROW_NUMBER()`

### 3. Monthly Sales Calculation

Aggregates total sales at the monthly level.

### 4. Sales Trend Analysis

Calculates business KPIs using window functions:

* Previous month sales
* Monthly sales difference
* Percentage change
* 3-month moving average
* Running total
* Sales ranking

---

## Key Business Question

How does monthly sales performance evolve over time, and which product categories contribute the most revenue in each month?

---

## Example Output

| DateMonth  | MonthlySales | PreviousMonthSales | MonthlyDiff | PercChange | Avg3Month | RunTotal | SalesRank | CategoryName |
| ---------- | -----------: | -----------------: | ----------: | ---------: | --------: | -------: | --------: | ------------ |
| 2005-07-01 |        28401 |               NULL |        NULL |       NULL |     28401 |    28401 |        38 | Bikes        |
| 2005-08-01 |       163856 |              28401 |      135455 |     476.93 |     96128 |   192257 |        31 | Bikes        |
| 2005-09-01 |       214968 |             163856 |       51112 |      31.19 |    135742 |   407225 |        24 | Bikes        |
| 2005-10-01 |       173500 |             214968 |      -41468 |     -19.29 |    184108 |   580725 |        29 | Bikes        |

---

## Business Insights Generated

The report enables analysts to:

* Monitor monthly revenue performance.
* Detect growth and decline trends.
* Identify seasonal sales patterns.
* Track cumulative revenue over time.
* Determine the strongest product category each month.
* Compare sales performance across all months.

---
