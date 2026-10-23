create database Pizza_data;
use Pizza_data;
select * from pizza_data;

----------- Business Insight ---------- 
-- KPI's
-- Total Orders, Total Sales, avg_sales_per_orders
select count(order_id) as total_Order from pizza_data; -- 48620
select round(sum(total_price),2) as Total_Revenue  from pizza_data; -- 817860.05 

SELECT SUM(total_price) / (SELECT COUNT(DISTINCT order_id) FROM pizza_data) AS avg_sales_per_order
FROM pizza_data;

-- Daily trend 
select weekday ,round(sum(total_price),2) as total_Sales from Pizza_data group by Weekday ORDER BY  CASE Weekday
             WHEN 'Monday'    THEN 1
             WHEN 'Tuesday'   THEN 2
             WHEN 'Wednesday' THEN 3
             WHEN 'Thursday'  THEN 4
             WHEN 'Friday'    THEN 5
             WHEN 'Saturday'  THEN 6
             WHEN 'Sunday'    THEN 7
         END;
         
 -- Monthly trend:
  select month ,round(sum(total_price),2) as total_Sales from pizza_data group by month;
  
  -- Peak Hour  
  select order_hour , count(order_id) as total_orders from pizza_data group by order_hour order by total_orders  desc ;
  
-- Category Share 
SELECT pizza_category,
       ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_data), 2) AS category_percentage
FROM pizza_data
GROUP BY pizza_category
ORDER BY category_percentage DESC;

--   size share:

SELECT pizza_size,
       ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_data), 2) AS category_percentage
FROM pizza_data
GROUP BY pizza_size
ORDER BY category_percentage DESC;

-- Top 5 by revenue:
select pizza_name ,round(sum(total_price),2) as total_sales from pizza_data group by pizza_name order by total_sales desc limit 5;

-- 5 pizzas sold the fewest units
select pizza_name ,count(order_id) as total_orders from pizza_data group by pizza_name order by total_orders asc  limit 10;


-- total quantity sold per category
select pizza_category ,sum(Quantity) as total_Quantity from pizza_data group by pizza_category order by total_quantity desc; 

-- Big Orders by Order Total Revenue 
SELECT order_id,
       SUM(total_price) AS order_total
FROM pizza_data
GROUP BY order_id
HAVING SUM(total_price) > 100
ORDER BY order_total DESC;

-- top 3 pizzas by revenue.
SELECT pizza_name,
       SUM(total_price) AS total_revenue,
       RANK() OVER (ORDER BY SUM(total_price) DESC) AS rank_pizza
FROM pizza_data
GROUP BY pizza_name
ORDER BY rank_pizza limit 3;

--  Month over Month Growth
WITH monthly AS (
    SELECT Month,
           SUM(total_price) AS revenue
    FROM pizza_data
    GROUP BY Month
)
SELECT Month,
       revenue,
       LAG(revenue) OVER (ORDER BY Month) AS prev_month_revenue,
       ROUND((revenue - LAG(revenue) OVER (ORDER BY Month)) * 100.0
             / LAG(revenue) OVER (ORDER BY Month), 2) AS mom_growth_pct
FROM monthly
ORDER BY Month;

--  Cumulative revenue > running total of daily revenue over time
WITH daily AS (
    SELECT order_date,
           SUM(total_price) AS daily_revenue
    FROM pizza_data
    GROUP BY order_date
)
SELECT order_date,
       daily_revenue,
       SUM(daily_revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM daily
ORDER BY order_date;
select * from pizza_data;


-- Above-average days: Which days had revenue above the overall daily average?
WITH daily AS (
    SELECT order_date,
           SUM(total_price) AS daily_revenue
    FROM pizza_data
    GROUP BY order_date
)
SELECT order_date,
       daily_revenue
FROM daily
WHERE daily_revenue > (SELECT AVG(daily_revenue) FROM daily)
ORDER BY order_date;

-- Moving average: Calculate the 7-day moving average of daily revenue. 

WITH daily AS (
    SELECT order_date,
           SUM(total_price) AS daily_revenue
    FROM pizza_data
    GROUP BY order_date
)
SELECT order_date,
       round(daily_revenue,2) as daily_revenue,
       ROUND(AVG(daily_revenue) OVER (ORDER BY order_date
                                      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS moving_avg_7d
FROM daily
ORDER BY order_date;

-- Best size within each category > For every category, which pizza size contributes the highest percentage of that category's revenue.
WITH size_rev AS (
    SELECT pizza_category,
           pizza_size,
           SUM(total_price) AS revenue
    FROM pizza_data
    GROUP BY pizza_category, pizza_size
),
pct AS (
    SELECT pizza_category,
           pizza_size,
           revenue,
           ROUND(revenue * 100.0 / SUM(revenue) OVER (PARTITION BY pizza_category), 2) AS pct_of_category,
           RANK() OVER (PARTITION BY pizza_category ORDER BY revenue DESC) AS rnk
    FROM size_rev
)
SELECT pizza_category,
       pizza_size,
       revenue,
       pct_of_category
FROM pct
WHERE rnk = 1
ORDER BY pizza_category;


----------- ----- Thank you happy learning --------------------- 