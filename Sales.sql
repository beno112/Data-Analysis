-- What date has the most purchases?
select Date, sum(price) as Price
from salesT 
group by date

-- Which customers have the most purchases
select Customer, sum(quantity) as [Number of Purchases]
from SalesT
group by Customer
order by sum(quantity) desc

-- Create a new field that shows the Total Price
select Date, Price, Discount, Customer, Quantity, (price*quantity) as [Total Price]
from SalesT

-- Show the total including the discount
select Date, Price, Discount, Customer, Quantity, ((price-discount)*quantity) as [Total Price]
from SalesT

-- What were the top 10 purchases in 2020
with Sales2020 as (
select convert(date, date) as Dates, price, quantity
from salesT	
where date >= '20200101' and date < '20210101'
)
select top 10 Date, Price, Discount, Quantity, ((Price-discount)*Quantity) as [Total Price]
from SalesT
where date in (select date from Sales2020)
order by [Total Price] desc

-- What were the top 10 days for purchases in 2020
with Sales2020 as (
select convert(date, date) as Dates, price, quantity
from salesT	
where date >= '20200101' and date < '20210101'
)
select top 10 Date, sum((Price-discount)*Quantity) as [Total Price]
from SalesT
group by date
order by [Total Price] desc

-- How many customers are there?
select count (distinct customer) as [# of Customers]
from SalesT
order by [# of Customers] desc

-- When was the first order
select min(date) as [First Order]
from SalesT

-- Find the customers who made total purchases in 2021 greater than $200,000
select Customer, sum((Price-Discount)*Quantity) as [Total Price]
from SalesT
where date >= '20210101' and date < '20220101'
group by Customer
having sum((Price-Discount)*Quantity) > 200000
order by sum((Price-Discount)*Quantity) desc

-- Find customers who made at least one order > $1,00,000
select Customer, DocumentID, sum((Price-Discount)*Quantity) as [Total Price]
from SalesT
where date >= '20210101' and date < '20220101'
group by Customer, DocumentID
having sum((Price-Discount)*Quantity) > 1000000
order by customer 

-- Show all month end orders
select Date, DocumentID
from salesT
where date = EOMONTH(date)
order by date

-- Show orders with the most individual line items
select DocumentID, sum(SKU) as [Total]
from SalesT
group by DocumentID
order by Total desc

-- Get a random list of top 10% of orders
select top 10 percent documentid
from SalesT
order by NEWID()

-- Create tiers based on sales (High, medium and low)
Select Documentid, sum((price-discount)*quantity) as [Total Sales],
	   CustomerGrouping =
		Case	
			when sum((price-discount)*quantity) >= 5000000 then 'High'
			when sum((price-discount)*quantity) >= 1000000 and sum((price-discount)*quantity) < 5000000 then 'Medium'
			when sum((price-discount)*quantity) <1000000 then 'Low'
		End
from salesT
group by documentid
order by [Total Sales] desc
