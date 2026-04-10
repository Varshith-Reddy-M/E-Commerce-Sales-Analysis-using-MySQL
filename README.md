# 🛒 E-Commerce Sales Analytics — MySQL

A structured SQL project analysing 10,000 e-commerce orders to extract business insights across revenue, categories, geographies, and customer value.

---

## 📁 Dataset Overview

| Field | Details |
|---|---|
| **Source** | `ecommerce_orders_10k_updated.csv` |
| **Rows** | 10,000 orders |
| **Columns** | 10 (after cleaning) |
| **Date Range** | Multi-month order history |
| **Total Revenue** | $1,595,831.17 |

### Columns

| Column | Description |
|---|---|
| `order_id` | Unique order identifier |
| `user_id` | Customer identifier |
| `product_id` | Product identifier |
| `category` | Product category (Clothing, Electronics, Home, etc.) |
| `price` | Unit price |
| `qty` | Quantity ordered |
| `total_price` | Total order value |
| `order_date` | Date of order |
| `country` | Customer country |
| `customer_segment` | Customer value tier (Low / Mid / High) |

---

## 🛠️ Tech Stack

- **Database:** MySQL
- **Language:** SQL
- **Concepts Used:** DDL, DML, Aggregations, Date Functions, Filtering, Grouping, Sorting

---

## 🧹 Data Cleaning

```sql
-- Drop column with NULL values
ALTER TABLE orders
DROP COLUMN product_name;

-- Rename columns for business clarity
ALTER TABLE orders
RENAME COLUMN city TO country,
RENAME COLUMN payment_method TO customer_segment;

-- Verify no NULLs remain in key columns
SELECT * FROM orders WHERE price IS NULL;
```

---

## 📊 Analysis Queries

### 1. Total Revenue
```sql
SELECT SUM(total_amount) AS total_revenue FROM orders;
-- Result: $1,595,831.17
```

### 2. Top 5 Categories by Units Sold
```sql
SELECT category, SUM(quantity) AS total_sold
FROM orders
GROUP BY category
ORDER BY total_sold DESC
LIMIT 5;
```

| Category | Units Sold |
|---|---|
| Clothing | 1,859 |
| Electronics | 1,462 |
| Home | 1,430 |
| Sports | 1,171 |
| Grocery | 1,106 |

### 3. Revenue by Category
```sql
SELECT category, SUM(total_amount) AS revenue
FROM orders
GROUP BY category;
```

### 4. Monthly Sales Trend
```sql
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;
```

### 5. Top 5 Countries by Revenue
```sql
SELECT country, SUM(total_amount) AS revenue
FROM orders
GROUP BY country
ORDER BY revenue DESC
LIMIT 5;
```

| Country | Revenue |
|---|---|
| United States | Highest |
| India | 2nd |
| United Kingdom | 3rd |
| Germany | 4th |
| Canada | 5th |

### 6. Customer Lifetime Value (CLV)
```sql
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;
```

---

## 💡 Key Insights

- **Clothing** is the highest-selling category by volume, followed by Electronics and Home.
- **United States** accounts for the largest share of revenue (~26.6% of orders), with India second (~16.3%).
- **Monthly trend analysis** reveals seasonal patterns in order volumes that can guide inventory and marketing decisions.
- **84% of customers** fall in the Low-Value segment — indicating a significant opportunity to move customers up the value ladder through targeted retention strategies.
- **High-Value customers** (only 6.84% of the base) likely contribute disproportionately to revenue — a classic Pareto effect worth investigating further.

---

## 🗂️ Project Structure

```
ecommerce-sql-analysis/
│
├── ecommerce_orders_10k_updated.csv   # Raw dataset
├── analysis.sql                       # All SQL queries
└── README.md                          # Project documentation
```

---

## 🚀 How to Run

1. Start your MySQL server and open MySQL Workbench (or CLI).
2. Create a new database:
   ```sql
   CREATE DATABASE ecommerce;
   USE ecommerce;
   ```
3. Run the `CREATE TABLE` statement to set up the schema.
4. Load the CSV using `LOAD DATA LOCAL INFILE` (update the file path).
5. Execute the analysis queries in order.

> **Note:** Enable local infile loading if you get an error:
> ```sql
> SET GLOBAL local_infile = 1;
> ```

---
