CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    ship_mode VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code INT,
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_id VARCHAR(50),
    cost_price DECIMAL(10,2),
    list_price DECIMAL(10,2),
    quantity INT,
    discount_percent DECIMAL(5,2)
);


SELECT 
    order_id,
    (list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders;




SELECT 
    order_id,
    ((list_price * quantity * (1 - discount_percent / 100.0)) 
    - (cost_price * quantity)) AS profit
FROM orders;


SELECT 
    order_id,
    ((list_price * quantity * (1 - discount_percent / 100.0)) 
    - (cost_price * quantity)) AS profit
FROM orders
ORDER BY profit DESC
LIMIT 10;



SELECT 
    order_id,
    ((list_price * quantity * (1 - discount_percent / 100.0)) 
    - (cost_price * quantity)) AS profit
FROM orders
WHERE 
    ((list_price * quantity * (1 - discount_percent / 100.0)) 
    - (cost_price * quantity)) < 0;



SELECT 
    segment,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
GROUP BY segment;



SELECT 
    segment,
    AVG(list_price * quantity * (1 - discount_percent / 100.0)) AS avg_order_value
FROM orders
GROUP BY segment
ORDER BY avg_order_value DESC;



SELECT 
    segment,
    COUNT(*) AS total_orders,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders) AS order_share_percent
FROM orders
GROUP BY segment;


SELECT *
FROM (
    SELECT 
        region,
        segment,
        SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
            - (cost_price * quantity)) AS profit,
        RANK() OVER (PARTITION BY region 
                     ORDER BY SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
                     - (cost_price * quantity)) DESC) AS rnk
    FROM orders
    GROUP BY region, segment
) t
WHERE rnk = 1;



SELECT 
    region,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
GROUP BY region;


SELECT 
    state,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) 
    / COUNT(*) AS revenue_per_order
FROM orders
GROUP BY state
ORDER BY revenue_per_order DESC;



SELECT 
    city,
    SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS profit
FROM orders
GROUP BY city
ORDER BY profit DESC;


SELECT 
    region,
    SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS profit
FROM orders
WHERE category = 'Furniture'
GROUP BY region
HAVING SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) < 0;




SELECT 
    product_id,
    SUM(quantity) AS total_qty
FROM orders
GROUP BY product_id
ORDER BY total_qty DESC
LIMIT 5;



SELECT 
    sub_category,
    SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS profit
FROM orders
GROUP BY sub_category
ORDER BY profit DESC;


SELECT 
    category,
    AVG(discount_percent) AS avg_discount
FROM orders
GROUP BY category
ORDER BY avg_discount DESC;




SELECT *
FROM orders
WHERE cost_price = list_price;



SELECT 
    category,
    AVG(discount_percent) AS avg_discount
FROM orders
GROUP BY category;



SELECT 
    CASE 
        WHEN discount_percent <= 2 THEN '0-2%'
        WHEN discount_percent <= 4 THEN '2-4%'
        ELSE '4%+'
    END AS discount_bucket,
    SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS profit
FROM orders
GROUP BY 
    CASE 
        WHEN discount_percent <= 2 THEN '0-2%'
        WHEN discount_percent <= 4 THEN '2-4%'
        ELSE '4%+'
    END;



SELECT 
    order_id,
    discount_percent,
    ((list_price * quantity * (1 - discount_percent / 100.0)) 
    - (cost_price * quantity)) AS profit
FROM orders
WHERE discount_percent > 3
AND ((list_price * quantity * (1 - discount_percent / 100.0)) 
    - (cost_price * quantity)) > 0;



SELECT 
    discount_percent,
    AVG((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS avg_profit
FROM orders
GROUP BY discount_percent
ORDER BY avg_profit DESC;




SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month;



SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date);



SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS profit
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY profit DESC
LIMIT 1;



SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
WHERE category = 'Technology'
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month;



SELECT 
    ship_mode,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
GROUP BY ship_mode;


SELECT 
    ship_mode,
    SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS profit
FROM orders
GROUP BY ship_mode;



SELECT *
FROM orders
WHERE ship_mode IN ('unknown', 'Not Available');


SELECT *
FROM orders
WHERE cost_price = 0
   OR list_price = 0
   OR discount_percent IS NULL
   OR discount_percent > 100;



SELECT 
    order_date, product_id, city,
    COUNT(*) AS cnt
FROM orders
GROUP BY order_date, product_id, city
HAVING COUNT(*) > 1;



SELECT 
    product_id,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY SUM(list_price * quantity * (1 - discount_percent / 100.0)) DESC
    ) AS rnk
FROM orders
GROUP BY product_id, category;



SELECT 
    order_date,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS daily_revenue,
    SUM(SUM(list_price * quantity * (1 - discount_percent / 100.0))) 
        OVER (ORDER BY order_date) AS running_total
FROM orders
GROUP BY order_date;



SELECT 
    city,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) * 100.0 
        / SUM(SUM(list_price * quantity * (1 - discount_percent / 100.0))) OVER () AS pct_contribution
FROM orders
GROUP BY city;



SELECT 
    *,
    ((list_price * quantity * (1 - discount_percent / 100.0)) 
     - (cost_price * quantity)) AS profit,
    AVG((list_price * quantity * (1 - discount_percent / 100.0)) 
     - (cost_price * quantity)) OVER (PARTITION BY segment) AS segment_avg_profit
FROM orders;


SELECT 
    region, category, segment,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
GROUP BY region, category, segment
ORDER BY revenue DESC
LIMIT 3;




SELECT 
    region, category, segment,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue
FROM orders
GROUP BY region, category, segment
ORDER BY revenue DESC;



SELECT 
    product_id,
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) AS revenue,
    SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) AS profit
FROM orders
GROUP BY product_id
HAVING 
    SUM(list_price * quantity * (1 - discount_percent / 100.0)) > 1000
    AND SUM((list_price * quantity * (1 - discount_percent / 100.0)) 
        - (cost_price * quantity)) < 0;











