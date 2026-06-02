 Sales Performance Analysis Using SQL & Python

 Project Overview

This project analyzes retail order data using SQL and Python (Pandas) to generate business insights related to revenue, profit, customer segments, products, regions, discounts, and sales trends.

The objective is to demonstrate data analysis skills by answering real-world business questions through SQL queries and applying the Pareto Principle (80/20 Rule) using Python.

---

 Dataset Structure

The dataset contains order-level information with the following fields:

| Column           | Description                   |
| ---------------- | ----------------------------- |
| order_id         | Unique order identifier       |
| order_date       | Date of order                 |
| ship_mode        | Shipping method               |
| segment          | Customer segment              |
| country          | Country                       |
| city             | City                          |
| state            | State                         |
| postal_code      | Postal code                   |
| region           | Sales region                  |
| category         | Product category              |
| sub_category     | Product sub-category          |
| product_id       | Product identifier            |
| cost_price       | Product cost price            |
| list_price       | Selling price before discount |
| quantity         | Quantity sold                 |
| discount_percent | Discount applied (%)          |

---

 Business Metrics Calculated

 Revenue

```sql
Revenue = list_price × quantity × (1 - discount_percent/100)
```

 Profit

```sql
Profit = Revenue - (cost_price × quantity)
```

---

 SQL Analysis Performed

 Revenue & Profit Analysis

 Revenue generated per order
 Profit generated per order
 Top 10 most profitable orders
 Loss-making orders

 Customer Segment Analysis

 Revenue by segment
 Average order value by segment
 Segment contribution percentage
 Most profitable segment in each region

 Regional Analysis

 Revenue by region
 Revenue per order by state
 Profit by city
 Loss-making regions for Furniture category

 Product Analysis

 Top-selling products by quantity
 Most profitable sub-categories
 Products generating high revenue but negative profit
 Product revenue ranking within categories

 Discount Analysis

 Average discount by category
 Profitability by discount bucket
 High-discount profitable orders
 Impact of discounts on average profit

 Time Series Analysis

 Monthly revenue trends
 Yearly revenue trends
 Most profitable month
 Monthly Technology category revenue
 Daily revenue with running totals

 Shipping Analysis

 Revenue by shipping mode
 Profit by shipping mode
 Detection of invalid shipping modes

 Data Quality Checks

 Missing or invalid values
 Zero pricing issues
 Discount validation
 Duplicate order detection

 Advanced SQL Techniques Used

 Window Functions
 RANK()
 Running Totals
 PARTITION BY
 Aggregate Functions
 HAVING Clauses
 CASE Statements
 Subqueries

---

 Pareto Analysis (80/20 Rule)

 Objective

Identify the small percentage of products responsible for the majority of revenue.

The Pareto Principle states:

> Approximately 80% of revenue often comes from 20% of products.

 Python Implementation

```python
product_revenue = df.groupby("product id")["total_revenue"].sum()

product_revenue = product_revenue.sort_values(ascending=False)

total_revenue = product_revenue.sum()

cumulative_revenue = product_revenue.cumsum()

cumulative_percent = (cumulative_revenue / total_revenue)  100

pareto_df = pd.DataFrame({
    "Revenue": product_revenue,
    "Cumulative Revenue": cumulative_revenue,
    "Cumulative %": cumulative_percent
})

top_20_products = product_revenue.head(
    int(len(product_revenue)  0.2)
)
```

 Output Generated

 Product revenue ranking
 Cumulative revenue contribution
 Cumulative revenue percentage
 Top 20% revenue-generating products

 Business Value

Pareto Analysis helps organizations:

 Focus marketing efforts on high-value products
 Optimize inventory management
 Improve profitability
 Prioritize product investments
 Identify key revenue drivers

---

 Technologies Used

 SQL
 PostgreSQL / MySQL Compatible Queries
 Python
 Pandas
 Jupyter Notebook

---

 Key Insights Generated

 Most profitable customer segments
 Highest-performing regions
 Best-selling products
 Impact of discounts on profit margins
 Revenue trends over time
 Shipping mode effectiveness
 Top revenue-contributing products using Pareto Analysis

---

 Project Structure

```text
├── data/
│   └── orders.csv
│
├── sql/
│   ├── revenue_analysis.sql
│   ├── profit_analysis.sql
│   ├── segment_analysis.sql
│   ├── regional_analysis.sql
│   ├── discount_analysis.sql
│   └── time_series_analysis.sql
│
├── notebooks/
│   └── pareto_analysis.ipynb
│
├── README.md
└── requirements.txt
```

---

 Future Improvements

 Interactive dashboard using Power BI or Tableau
 Customer lifetime value analysis
 Forecasting future sales
 Product recommendation system
 Automated reporting pipeline



 Author

Uroosa Khan


