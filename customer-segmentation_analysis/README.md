Got it — you want a **clean, GitHub-style README with the same structure and tone** as your Pareto example. Here is your version:

---

# Customer Segmentation & Sales Analytics in SQL

## Project Overview

This project analyzes customer purchasing behavior using SQL window functions, aggregations, and segmentation logic.

Using **AdventureWorks data** (`FactInternetSales`, `DimCustomer`, `DimDate`), the query builds a customer-level analytical model that identifies high-value and at-risk customers.

The analysis segments customers into **VIP, Loyal, At Risk, and Regular** groups based on:

* Total sales contribution
* Purchase frequency
* Recency of orders
* Sales performance quartiles

It also calculates key customer KPIs such as revenue contribution, order behavior, and segment distribution.

---

## SQL Concepts Used

### Aggregations

* `SUM()`
* `COUNT(DISTINCT)`
* `MAX()`
* `AVG()`

### Window Functions

* `SUM() OVER()` (total company sales)
* `NTILE(4)` (customer quartiles)
* `RANK() OVER()` (sales ranking)

### Analytical Logic

* Customer segmentation rules
* Recency analysis (DATEDIFF)
* Revenue contribution calculation
* Percent-of-total analysis

### Defensive SQL

* `NULLIF()` (avoid division by zero)
* Handling NULL values in joins

---

## Dataset

**AdventureWorksDW**

Tables used:

* `FactInternetSales`
* `DimCustomer`
* `DimDate`

---

## Analytical Logic

The analysis is structured in 3 steps:

### 1. Data Preparation

Joins sales transactions with customer and date dimensions.

### 2. Customer Metrics Calculation

Builds customer-level KPIs:

* Total sales per customer
* Number of unique orders
* Latest purchase date
* Time since last order
* Sales quartile ranking

### 3. Segmentation Logic

Customers are grouped using business rules:

* **VIP** → Top quartile + high order frequency (>10 orders)
* **Loyal** → Middle quartiles (2 & 3)
* **At Risk** → Lowest quartile + inactive >24 months
* **Regular** → Remaining customers

---

## Key Business Question

Which customers generate the most revenue, and how can we segment them to improve retention, loyalty, and marketing targeting?

---

## Example Output

| CustomerSegmentation | CustomersPerSegment | AvgSalesPerSegment | MaxSalesPerSegment | AvgNumberOfOrders | PercentageOfTotalCustomers | SalesContribution |
| -------------------- | ------------------- | ------------------ | ------------------ | ----------------- | -------------------------- | ----------------- |
| VIP                  | 120                 | 8500               | 45000              | 18.4              | 10.2%                      | 55.3%             |
| Loyal                | 340                 | 4200               | 21000              | 9.7               | 28.6%                      | 32.1%             |
| At Risk              | 90                  | 1500               | 8000               | 3.2               | 7.5%                       | 5.4%              |
| Regular              | 640                 | 2100               | 12000              | 5.1               | 53.7%                      | 7.2%              |

---

## File

```
customer_segmentation.sql
