/* 
	PURPOSE:
	1.This creates the database and schemas used in this porject

	WARNING:
	1.Running the code in this script will first check if the database ExpDataAnalyticsDB exists, if
	  it does, it will be dropped(deleted) and a new one will be created.
*/
USE master;
GO

--Dropping an existing database and creating a new one
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'ExpDataAnalyticsDB')
	BEGIN
		ALTER DATABASE ExpDataAnalyticsDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE ExpDataAnalyticsDB
	END;
GO
CREATE DATABASE ExpDataAnalyticsDB;
GO
USE ExpDataAnalyticsDB;
GO
--Creating the schema for the project
CREATE SCHEMA Gold;
GO

CREATE TABLE Gold.dim_Customers(
	customer_key INT,
	customer_id INT,
	customer_number NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	country NVARCHAR(50),
	marital_status NVARCHAR(50),
	gender NVARCHAR(50),
	birthdate DATE,
	create_date DATE
);
GO

CREATE TABLE Gold.dim_Products(
	product_key INT ,
	product_id INT,
	product_number NVARCHAR(50) ,
	product_name NVARCHAR(50) ,
	category_id NVARCHAR(50) ,
	category NVARCHAR(50) ,
	subcategory NVARCHAR(50) ,
	maintenance NVARCHAR(50) ,
	cost INT,
	product_line NVARCHAR(50),
	start_date DATE 
);
GO

CREATE TABLE Gold.fact_Sales(
	order_number NVARCHAR(50),
	product_key INT,
	customer_key INT,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount INT,
	quantity TINYINT,
	price INT 
);
GO

TRUNCATE TABLE Gold.dim_Customers;
GO
BULK INSERT Gold.dim_Customers
FROM 'C:\Users\Donald\source\repos\SQL-ExploratoryDataAnalytics\Datasets\gold.dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE Gold.dim_Products;
GO

BULK INSERT Gold.dim_Products
FROM 'C:\Users\Donald\source\repos\SQL-ExploratoryDataAnalytics\Datasets\gold.dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE Gold.fact_Sales;
GO

BULK INSERT Gold.fact_Sales
FROM 'C:\Users\Donald\source\repos\SQL-ExploratoryDataAnalytics\Datasets\gold.fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO