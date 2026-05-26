# Revenue & Profit Analytics – Pareto Analysis in SQL

## Project Overview

This project analyzes product profitability using SQL window functions and Pareto analysis principles (80/20 rule).

Using AdventureWorks data (`FactInternetSales` and `DimProduct`), the query identifies the top 10 products by profit contribution and calculates:

- Product margin
- Margin percentage
- Share of total revenue
- Product ranking by profit
- Cumulative profit contribution
- Pareto segmentation (Top 80% vs Bottom 20%)

---

## SQL Concepts Used

### Aggregations
- SUM()
- GROUP BY

### Window Functions
- SUM() OVER()
- RANK() OVER()
- Running cumulative totals

### Analytical Logic
- Pareto distribution
- Revenue contribution analysis
- Profitability ranking

### Defensive SQL
- NULLIF()
- ROUND()

---

## Dataset

AdventureWorksDW

Tables used:
- FactInternetSales
- DimProduct

---

## Key Business Question

Which products contribute the most to overall company profit, and how concentrated is profitability across the product portfolio?

---

## Example Output

| Product | Margin | Rank | Cumulative Margin % | Pareto Group |
|---|---|---|---|---|
| Product A | 120000 | 1 | 18.4 | Top 80% |
| Product B | 98000 | 2 | 31.2 | Top 80% |

---

## File

- `pareto_profit_analysis.sql`
