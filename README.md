# 📊 Telecom SQL Portfolio Project – Device Utilization & Decommission Analysis

## 🚀 Overview

This project simulates a real-world telecom network inventory system similar to enterprise environments (e.g., Verizon NAR / TIRKS data).

The goal is to analyze **device utilization**, identify **underutilized network assets**, and recommend **decommission candidates** using SQL.

---

## 🎯 Business Problem

Telecom companies manage thousands of devices across regions. Many devices remain underutilized, leading to:

* Increased operational cost
* Power consumption inefficiency
* Wasted infrastructure capacity

This project answers key business questions:

* Which devices are underutilized?
* Which devices can be safely decommissioned?
* Which regions/sites have excess capacity?
* How efficiently are circuits being used?

---

## 🧱 Data Model

### 1. Sites

Contains location and regional information.

### 2. Devices

Represents telecom network equipment (routers, switches, etc.).

### 3. Circuits

Represents connectivity associated with each device.

### 4. Decommission Recommendations

Stores business decisions for device decommissioning.

---

## 📁 Project Structure

```
sql-portfolio-telecom-project/
│
├── schema.sql                  → Table creation scripts
├── queries.sql                 → Analytical SQL queries
└── data/
    ├── sites.csv
    ├── devices.csv
    ├── circuits.csv
    └── decommission_recommendations.csv
```

---

## 💡 Key Concepts & Skills Demonstrated

* SQL Joins (INNER JOIN, LEFT JOIN)
* Aggregations (COUNT, GROUP BY)
* Conditional Logic (CASE statements)
* Window Functions (DENSE_RANK, ROW_NUMBER)
* Subqueries
* Data Analysis & Business Logic Implementation

---

## 📊 Core Analysis & Insights

### 🔹 Device Utilization Logic

Devices are categorized based on working circuits:

* **Zero Fill** → 0 circuits
* **Low Fill** → 1–5 circuits
* **Working** → More than 5 circuits

---

### 🔹 Key Queries Implemented

#### 1. Site-Level Analysis

* Total devices per site
* Top sites with highest device count

#### 2. Device Utilization

* Identify Zero Fill / Low Fill / Working devices
* Detect underutilized devices (≤ 5 circuits)

#### 3. Decommission Analysis

* Devices recommended for decommission
* Decommission count by site and reason

#### 4. Circuit Analysis

* Top devices by circuit usage
* Region-wise circuit distribution
* Site-wise circuit breakdown

#### 5. Advanced SQL

* Ranking devices using `DENSE_RANK()`
* Top device per site using `ROW_NUMBER()`
* Aggregated reporting queries

---

## 🛠️ How to Run

1. Execute `schema.sql` to create tables
2. Load CSV files into respective tables
3. Run queries from `queries.sql`

---

## 📈 Sample Use Case

Using SQL, this project identifies:

* Underutilized devices that can be optimized
* Candidates for decommission to reduce cost
* High-load devices requiring capacity planning

---

## 🚀 Future Enhancements

* Build Tableau dashboard for visualization
* Add real-time data ingestion (ETL pipeline)
* Extend dataset with time-based trends
* Integrate with cloud platforms (GCP BigQuery / Snowflake)

---

## 👨‍💻 Author

**Sai Naren Burgula**
SQL | Data Analysis | Telecom Domain

---
