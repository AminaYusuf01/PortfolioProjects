--KPIs--
SELECT * FROM pizza_sales$

--Total Revenue--

SELECT SUM(total_price)as total_revenue from pizza_sales$

--Average Order Value

SELECT SUM(total_price)/ count(distinct order_id) as Avg_OrderValue from pizza_sales$

--Total Pizzas Sold--

Select SUM(quantity) as Total_PizzaSold from pizza_sales$

--Total Orders Placed--

Select COUNT(distinct order_id) as Total_Orders from pizza_sales$

--Avearge Pizzas Per Order--

Select ROUND( CAST(SUM(quantity)AS decimal(10,2))/
CAST(COUNT(distinct order_id)AS decimal(10,2)),2) as Avg_PizzaperOrder from pizza_sales$

--VISUALS--
SELECT*FROM pizza_sales$

--Daily Trend for Total Orders--

Select DATENAME(WEEKDAY,order_date) as Order_day, COUNT(distinct order_id) as total_orders
from pizza_sales$
Group by DATENAME(WEEKDAY,order_date)

--Monthly Trend for Total Orders--

Select DATENAME(MONTH,order_date) as Month_Name, COUNT(distinct order_id) as total_orders
from pizza_sales$
Group by DATENAME(MONTH,order_date)
Order by total_orders desc

--Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) as Total_Sales, SUM(total_price) *100 /
( Select sum(total_price)  FROM pizza_sales$) as PCT
FROM pizza_sales$
GROUP BY pizza_category

--Percentage of Sales by Pizza Size

SELECT pizza_size, ROUND(SUM(total_price),2) as Total_Sales, ROUND( SUM(total_price)*100 /
( Select sum(total_price) FROM pizza_sales$),2) as PCT
FROM pizza_sales$
GROUP BY pizza_size
Order by PCT DESC

--Top 5 by Revenue, Total Quantity and Total Orders

Select Top 5 pizza_name, Sum(total_price)as Revenue, SUM(quantity) as Total_quantity,
COUNT(distinct order_id) as Total_orders
from pizza_sales$
group by pizza_name
order by Revenue desc

--Bottom 5 

Select Top 5 pizza_name, Sum(total_price)as Revenue, SUM(quantity) as Total_quantity,
COUNT(distinct order_id) as Total_orders
from pizza_sales$
group by pizza_name
order by Total_orders asc