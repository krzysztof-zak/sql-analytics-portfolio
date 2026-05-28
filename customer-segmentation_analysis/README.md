📊 Customer Segmentation Data Mart (SQL Project)
🧾 Overview

This project builds a customer segmentation data mart using SQL on the AdventureWorksDW2022 dataset.

It transforms raw internet sales data into meaningful business insights by grouping customers into segments such as:

VIP
Loyal
At Risk
Regular

The solution follows a layered analytical SQL architecture, similar to real-world data warehouse and analytics engineering pipelines.

🎯 Business Objective

The goal of this project is to:

Identify high-value customers (VIP segment)
Analyze customer purchasing behavior
Measure customer retention and activity
Understand revenue distribution across customer groups
Support data-driven marketing strategies
🏗️ Data Architecture

The solution is structured into 3 logical layers:

🟦 Staging Layer (Stg_InternetSales)

Prepares clean transactional data.

🟨 Customer Metrics Layer (Fct_CustomerMetrics)

Aggregates data at customer level.

🟥 Segmentation Layer (Segmentation)

Applies business rules and analytical enrichment.

📌 Data Sources

The analysis uses the following tables:

FactInternetSales → sales transactions
DimCustomer → customer identifiers
DimDate → order date information
⚙️ Transformation Logic
1. Staging Layer

Creates a clean transactional dataset containing:

CustomerKey
SalesAmount
SalesOrderNumber
OrderDate
2. Customer Metrics Layer

Aggregates customer-level KPIs:

Total Sales per Customer
Number of Unique Orders
Latest Purchase Date
Time Since Last Purchase (months)
Total Company Sales
Customer Quartiles using NTILE(4)
3. Segmentation Layer

Adds business and analytical features:

Customer ranking using RANK()
Percentage contribution to total sales
Customer segmentation using business rules
📊 Customer Segments Definition
Segment	Rule
VIP	Top quartile AND more than 10 orders
Loyal	Quartiles 2–3
At Risk	Bottom quartile AND inactive > 24 months
Regular	All remaining customers
📈 Final Output Metrics

The final report groups customers by segment and provides:

Number of customers per segment
Average customer sales
Maximum customer sales
Average number of orders
Percentage of total customers
Revenue contribution per segment
📊 Key Business Questions Answered

This project helps answer:

Who are the most valuable customers?
Which customers generate the most revenue?
Which customers are at risk of churn?
How is revenue distributed across segments?
What proportion of customers belong to each group?
🧾 Example Output
Segment	Customers	Avg Sales	Max Sales	Avg Orders	% Customers	Revenue Contribution
VIP	...	...	...	...	...	...
Loyal	...	...	...	...	...	...
At Risk	...	...	...	...	...	...
Regular	...	...	...	...	...	...
🚀 Technologies Used
SQL Server (T-SQL)
Window Functions (RANK, NTILE)
Common Table Expressions (CTEs)
Data Warehouse Modeling Concepts
Analytical SQL Techniques
🧠 Skills Demonstrated

This project demonstrates:

Advanced SQL querying
Customer segmentation logic
Data warehouse thinking (layered architecture)
Business KPI design
Analytical problem solving
Window function mastery
ETL-style transformations in SQL
📁 Project Structure
customer-segmentation_analysis/
│
├── customer_segmentation.sql
├── README.md
