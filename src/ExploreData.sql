--Exploring the database and its tables
SELECT *
FROM INFORMATION_SCHEMA.TABLES;

--Explore the different countries that the customers come from
SELECT DISTINCT country
FROM Gold.dim_Customers
--Explore the categories, Major Divisions
SELECT DISTINCT category ,subcategory, product_name
FROM Gold.dim_Products
ORDER BY 1,2,3;

--Finding the dates of the first and last orders
--Finding the number of years of sales that are available
SELECT MIN(order_date) AS first_order_date, MAX(order_date) AS last_order_date
	,DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) nr_of_years
FROM Gold.fact_Sales

--Finding the youngest and oldest birthdate, with the corresponding ages
SELECT MIN(birthdate) AS oldest, DATEDIFF(YEAR, MIN(birthdate), GETDATE()) oldest_age
	,MAX(birthdate) AS youngest, DATEDIFF(YEAR, MAX(birthdate), GETDATE()) youngest_age 
FROM Gold.dim_Customers;

/*************** Measure exploration *******************/
--Finding the total sales 
SELECT SUM(sales_amount) AS total_sales
FROM Gold.fact_Sales;
--Finding the total number of items sold
SELECT SUM(quantity) AS total_quantity
FROM Gold.fact_Sales
--Finding the average selling price
SELECT AVG(price) average_price
FROM Gold.fact_Sales
--Finding the total number of orders
SELECT COUNT(DISTINCT order_number) total_orders
FROM Gold.fact_Sales;
--Finding the total number of products
SELECT COUNT(DISTINCT product_key) total_products
FROM Gold.dim_Products
--Finding the total number of customers
SELECT COUNT(customer_key) total_customers
FROM Gold.dim_Customers;
--Finding the total number of customers who placed orders
SELECT COUNT(DISTINCT customer_key) total_customers
FROM Gold.fact_Sales
WHERE order_number IS NOT NULL;

/**************** Report key metrics of the business **********************/
SELECT 'Total Sales' AS measure_name,  SUM(sales_amount) AS measure_value FROM Gold.fact_Sales
UNION ALL
SELECT 'Total Quantity' AS measure_name,  SUM(quantity) AS measure_value FROM Gold.fact_Sales
UNION ALL
SELECT 'Average price' AS measure_name,  AVG(price) AS measure_value FROM Gold.fact_Sales
UNION ALL
SELECT 'Total orders' AS measure_name,  COUNT(DISTINCT order_number) AS measure_value FROM Gold.fact_Sales
UNION ALL
SELECT 'Total products' AS measure_name,  COUNT(DISTINCT product_key) AS measure_value FROM Gold.dim_Products
UNION ALL
SELECT 'Total customers' AS measure_name,  COUNT(DISTINCT customer_key) AS measure_value FROM Gold.dim_Customers;