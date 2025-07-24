SELECT * FROM sql_project.sqlproject;

                    -- RENAMING TABLE 
RENAME TABLE sql_project.sqlproject TO sql_project.orders;



                                -- MONTHLY REVENUE
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    SUM(total_sale) AS monthly_revenue
FROM sql_project.orders
GROUP BY month
ORDER BY month;

              
              -- AVERAGE ORDER VALUE
SELECT 
    AVG(total_sale) AS average_order_value
FROM sql_project.orders;

                 -- CHANGING COLUMN NAME
ALTER TABLE sql_project.orders CHANGE quantiy quantity INT;




                  -- TOP SELLING PRODUCT BY CATEGORY
SELECT 
    category,
    SUM(quantity) AS total_quantity_sold
FROM sql_project.orders
GROUP BY category
ORDER BY total_quantity_sold DESC;

use sql_project;


                                -- CREATING VIEW

CREATE VIEW monthly_sales_summary AS
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS month,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    SUM(total_sale) AS total_revenue
FROM sql_project.orders
GROUP BY DATE_FORMAT(sale_date, '%Y-%m');

select* from monthly_sales_summary;


SELECT *
FROM sql_project.orders WHERE total_sale < cogs;


                               -- INACTIVE CUSTOMERS
SELECT DISTINCT customer_id
FROM sql_project.orders
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM sql_project.orders
    WHERE sale_date >= DATE_SUB('31-12-2023', INTERVAL 6 MONTH)
);


SELECT DISTINCT customer_id
FROM sql_project.orders
WHERE total_sale > (
    SELECT AVG(total_sale)
    FROM sql_project.orders
);



SELECT 
    customer_id,
    sale_date,
    total_sale,
    SUM(total_sale) OVER (PARTITION BY customer_id ORDER BY sale_date) AS running_total
FROM sql_project.orders;



--               WINDOW FUNCTIONS 

SELECT 
    customer_id,
    sale_date,
    total_sale,
    FIRST_VALUE(sale_date) OVER (PARTITION BY customer_id ORDER BY sale_date) AS first_purchase
FROM sql_project.orders;



SELECT 
    customer_id,
    SUM(total_sale) AS total_spent,
    RANK() OVER (ORDER BY SUM(total_sale) DESC) AS spending_rank
FROM sql_project.orders
GROUP BY customer_id;



