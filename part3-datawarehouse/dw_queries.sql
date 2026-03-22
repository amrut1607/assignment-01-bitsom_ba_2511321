-- Q1: Total sales revenue by product category for each month
SELECT 
    d.cal_year,
    d.cal_month,
    p.category,
    SUM(f.total_revenue) AS total_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY d.cal_year, d.cal_month, p.category
ORDER BY d.cal_year, d.cal_month, p.category;

-- Q2: Top 2 performing stores by total revenue
SELECT 
    s.store_name,
    SUM(f.total_revenue) AS store_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_id, s.store_name
ORDER BY store_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT 
    d.cal_year,
    d.cal_month,
    SUM(f.total_revenue) AS monthly_revenue,
    SUM(f.total_revenue) - LAG(SUM(f.total_revenue), 1) OVER (ORDER BY d.cal_year, d.cal_month) AS revenue_growth
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.cal_year, d.cal_month
ORDER BY d.cal_year, d.cal_month;
