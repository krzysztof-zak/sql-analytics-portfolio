# Customer Cohort Retention Analysis in SQL

## Project Overview
This project analyzes customer retention using SQL Common Table Expressions (CTEs) to build a cohort-based retention report.

Using **AdventureWorks data** (`FactInternetSales`, `DimDate`), the query identifies customer cohorts based on their first purchase month and tracks how many customers from each cohort return in subsequent months.

The analysis calculates key retention metrics such as:
* Cohort size (number of customers who made their first purchase in a given month)
* Monthly active customers per cohort
* Retention rate (percentage of cohort still active in each subsequent month)

---
## SQL Concepts Used
### Aggregations
* `MIN()`
* `COUNT(*)`
* `COUNT(DISTINCT)`
* `GROUP BY`

### Common Table Expressions (CTEs)
* `EarliestOrderDate`
* `CohortSize`
* `ClientsOrders`
* `RetentionBase`
* `CustomersByMonth`

### Date Functions
* `DATEFROMPARTS()`
* `DATEDIFF()`

### Analytical Logic
* Cohort analysis
* Customer retention tracking
* Time-based customer behavior analysis

### Defensive SQL
* Proper date truncation to month level
* DISTINCT counting to avoid duplicates

---
## Dataset
**AdventureWorksDW**

Tables used:
* `FactInternetSales`
* `DimDate`

---
## Analytical Logic
The analysis is structured in multiple CTE steps:

### 1. Cohort Identification (`EarliestOrderDate`)
Determines the first purchase month (CohortMonth) for each customer.

### 2. Cohort Sizing (`CohortSize`)
Calculates how many customers belong to each monthly cohort.

### 3. Order Activity (`ClientsOrders`)
Identifies all months in which each customer made purchases.

### 4. Retention Calculation (`RetentionBase`)
Computes the number of months since the customer's first purchase for each active month.

### 5. Monthly Metrics (`CustomersByMonth`)
Counts unique active customers per cohort and month number.

### 6. Final Retention Report
Joins everything together and calculates the retention percentage.

---
## Key Business Questions
* How many customers are acquired each month?
* What percentage of customers from a cohort return after 1, 3, 6, or 12 months?
* Which acquisition months show the strongest long-term retention?
* How does customer retention evolve over time?

---
## Example Output
| CohortMonth | CohortSize | MonthNumber | Customers | CohortRetentionPct |
| ----------- | ---------: | ----------: | --------: | -----------------: |
| 2005-07-01  | 123        | 0           | 123       | 100.00             |
| 2005-07-01  | 123        | 1           | 45        | 36.59              |
| 2005-07-01  | 123        | 2           | 32        | 26.02              |
| 2005-08-01  | 98         | 0           | 98        | 100.00             |
| 2005-08-01  | 98         | 1           | 41        | 41.84              |

---
## Business Insights Generated
This retention analysis enables businesses to:
* Understand customer loyalty and repeat purchase behavior
* Evaluate the quality of customers acquired in different periods
* Identify seasonal patterns in retention
* Measure the effectiveness of customer acquisition and engagement strategies
* Support decisions on marketing spend, loyalty programs, and product improvements

---
## Skills Demonstrated
* Advanced cohort analysis
* Multi-step CTE chaining
* Customer journey tracking over time
* Retention rate calculations
* Date manipulation and time intelligence in SQL
* Building business intelligence reports with modular SQL
