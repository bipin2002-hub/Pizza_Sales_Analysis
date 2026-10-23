# Pizza Sales Analysis

An end-to-end analysis of one year of pizza sales (2015) using Python, SQL, and Power BI. The project covers data cleaning, exploratory analysis, statistical testing, an interactive dashboard, and business recommendations to grow sales.

## Key Metrics

| Metric | Value |
|---|---|
| Total sales | $817.86K |
| Unique orders | 21,350 |
| Pizzas sold | 49,574 |
| Average sales per order | $38.31 |
| Order lines | 48,620 |

## Key Findings

- **Stable but seasonal:** Monthly sales hover around $68K. July is the strongest month ($72.6K) and October the weakest ($64.0K).
- **Friday leads, Sunday lags:** Friday earns $136.1K, about $36.9K more than Sunday ($99.2K).
- **Two daily rushes:** 12-1 PM and 5-7 PM account for roughly 56% of order lines. Activity before 11 AM is minimal.
- **Large pizzas drive revenue:** Large pizzas bring 45.9% of sales. XL and XXL together contribute only 1.8%.
- **Chicken pizzas perform strongly:** Chicken is the lowest-volume category but holds the top three revenue pizzas (Thai Chicken, Barbecue Chicken, California Chicken).
- **Small baskets:** 38% of orders contain a single pizza. Weekend and weekday order values are statistically the same ($38.46 vs $38.25, p = 0.33).

## Recommendations

1. Run Sunday and Monday promotions, such as a family bundle or a Monday upgrade deal.
2. Increase basket size with combos and second-pizza offers.
3. Upsell from Small to Medium and from Medium to Large.
4. Fill the 2-4 PM gap with off-peak deals.
5. Promote and bundle the Chicken range.
6. Fix, bundle, or retire the weakest pizzas.
7. Decide whether to keep XXL, which sold only 28 times.
8. Plan seasonal campaigns for September, October, and December.
9. Align staffing and prep with the lunch and dinner peaks.
10. Improve KPI tracking by adding cost, customer, and channel data.

Impact estimates are what-if calculations based on 2015 data, not forecasts. Validate them with a pilot before relying on them.

## Tools Used

- **Python:** Pandas, NumPy, Seaborn, Matplotlib, SciPy (Jupyter Notebook)
- **SQL:** MySQL (aggregations, window functions, CTEs)
- **Power BI:** Interactive dashboard with slicers for category, quarter, pizza name, and month range
- **Excel:** Supporting data file

## Repository Contents

| File | Description |
|---|---|
| `Pizza Sales Analysis (1).ipynb` | Python analysis: cleaning, EDA, charts, statistical tests |
| `Pizza_sales.sql` | SQL queries for KPIs, trends, rankings, and window functions |
| `Pizza sales Anakysis.pbix` | Power BI dashboard |
| `Pizza Sales Analysis Dashboard.pdf` | Static export of the dashboard |
| `Pizza_Sales_Analysis_Report.pdf` | Full written report with findings and recommendations |
| `pizza_sales excel file.xlsx` | Dataset |
| `requirements.txt` | Python dependencies |

## Dataset

- **Records:** 48,620 order lines, 12 original columns, no missing values or duplicates
- **Categories:** Classic, Supreme, Chicken, Veggie
- **Sizes:** S, M, L, XL, XXL
- **Engineered features:** Month, weekday, and order hour, derived from the timestamp
- **Outliers:** 613 total-price outliers were kept because they represent genuine sales


### SQL analysis
1. Import `pizza_sales excel file.xlsx` into MySQL as a table named `pizza_sales`. Alternatively, export it to CSV and use MySQL's import tool.
2. Run `Pizza_sales.sql` in MySQL Workbench or the MySQL command line.

### Power BI dashboard
Open `Pizza sales Anakysis.pbix` in Power BI Desktop. If prompted, update the data source to point to the Excel file on your machine.

## SQL Techniques Covered

| Analysis | Technique |
|---|---|
| KPIs (orders, sales, averages) | `COUNT`, `SUM`, `ROUND` |
| Monthly and daily trends | `GROUP BY` with `CASE` ordering |
| Peak hours | `GROUP BY` on order hour |
| Category and size share | Subquery for percentage of total |
| Top and bottom pizzas | `ORDER BY ... LIMIT`, `RANK()` |
| Large orders (> $100) | `GROUP BY` with `HAVING` |
| Month-over-month growth | CTE with `LAG()` |
| Cumulative revenue, 7-day moving average | Window `SUM()` and `AVG()` with `ROWS` frame |
| Above-average revenue days | CTE with subquery on `AVG` |
| Best size per category | CTE with `PARTITION BY` and `RANK()` |

## Statistical Tests

- **Weekend vs weekday order value:** $38.46 vs $38.25, p = 0.325 (no significant difference)
- **Category vs size (chi-square):** χ² = 3,347.8, p < 0.001 (size preference depends on category)
- **Correlation, unit price vs total price:** 0.84
- **Correlation, quantity vs total price:** 0.54
- **Correlation, quantity vs unit price:** 0.01

## Author

**Bipin Chandra**
