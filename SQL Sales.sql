-- Which cities had the most sales
SELECT
	City, State, sum(sales) as Sum_Of_Sales
FROM
	Sales
GROUP BY
	city, state
ORDER BY Sum_Of_Sales desc

--Which region did better in sales
SELECT
	Region, sum(sales) as sum_of_sales
FROM
	sales
GROUP BY
	region
ORDER BY
	sum_of_sales desc

-- Which mode of shipping was used the most
SELECT
	ship_mode, count(ship_mode) as Shiping_Mode
FROM 
	sales
GROUP BY
	ship_mode
ORDER BY
	Shiping_Mode desc

-- What are the top 10 days of sales in this dataset
SELECT top 10
	Order_Date, sum(sales) as Sum_of_Sales
FROM
	sales	
GROUP BY
	Order_Date
ORDER BY
	Sum_of_Sales desc

--What were the best days for sales in 2017?
SELECT top 10
	Order_Date, sum(sales) as Sum_of_Sales
FROM 
	sales
WHERE 
	order_date like '%2017'
GROUP BY
	order_date
ORDER BY
	Sum_of_Sales desc

-- Which customers had the most sales in 2017 and 2018
SELECT 
	customer_name, order_date, sum(sales) as Sum_Of_Sales
FROM
	Sales	
WHERE 
	order_date like '%2018' or order_date like '%2017'
GROUP BY
	customer_name, order_date
ORDER BY
	Sum_Of_Sales desc

-- Grouping the customers from 2016 and 2017 in tiers
with Sales2016 as (
	SELECT
		customer_name,  city, State, sum(sales) as Sum_of_Sales
	FROM
		sales
	WHERE
		 order_date like '%2016' or order_date like '%2017'
	GROUP BY
		customer_name, city, state
)
SELECT
	Customer_Name, Sum_of_Sales, city, state,
	Customer_Group =
		CASE	
			when sum_of_sales < 100 then 'Low'
			when sum_of_sales >= 100.0 and sum_of_sales < 500.0 then 'Medium'
			when sum_of_sales >= 500.0 and sum_of_sales < 1000.0 then 'High'
			when sum_of_sales > 1000.0 then 'Ver High'
		END
FROM
	Sales2016
ORDER BY
	Sum_of_Sales desc

-- Lets look at the month end Orders
with MonthEnd as (
SELECT
	customer_name, customer_id, convert(date, order_date, 104) as OrderDate, Sales
FROM
	sales
)
SELECT
	customer_id, customer_name, OrderDate, Sales
FROM 
	MonthEnd
WHERE
	OrderDate = EOMONTH(OrderDate)
ORDER BY
	Sales desc

-- A random assortment of orders
SELECT top 2 percent
	order_id, customer_name, Sales
FROM 
	sales
ORDER BY
	newid()