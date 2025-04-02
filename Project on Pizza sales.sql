Create Database Pizza_Sales_DB;

SELECT * FROM pizza_sales;

DESC pizza_sales;

Use pizza_sales;

Alter table pizza_sales
Change column ï»¿pizza_id pizza_id int;

UPDATE pizza_sales
SET order_date = str_to_date(order_date, '%m/%d/%Y');

SET SQL_safe_updates = 0;

ALTER table pizza_sales
Modify column order_date date;

Update pizza_sales
SET order_time = str_to_date(order_time, '%H:%i:%s');

Alter table pizza_sales
Modify column order_time time;

# A. ----- KPI's ------------------

#1. Total Revenue:
Select sum(total_price) AS Total_revenue
FROM pizza_sales;

#2. Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_value
FROM pizza_sales;

#3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold
FROM pizza_sales;

#4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_orders_placed
FROM pizza_sales;

#5. Average Pizzas Per Order
SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS Avg_pizza_per_order
FROM pizza_sales;

# B. ------Daily Trend for Total Orders-----
SELECT DATE_FORMAT(order_date, '%W') AS Days, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY Days;

#C.---------Monthly Trend for Orders--------
SELECT DATE_FORMAT(order_date, '%M') AS Months, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY Months;

#D. ---------% of Sales by Pizza Category------
SELECT pizza_category, ROUND(SUM(total_price)*100/ (SELECT SUM(total_price) FROM pizza_sales)) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_category;

# E.-------- % of Sales by Pizza Size--------
SELECT pizza_size, ROUND(SUM(total_price)*100/ 
(SELECT SUM(total_price) FROM pizza_sales WHERE quarter(order_date) = 2 )) AS percentage_of_sales_by_size
FROM pizza_sales
WHERE quarter(order_date) = 2
GROUP BY pizza_size;

# F. ------- Revenue, Quantity sold and Total orders by Pizza name-----
SELECT pizza_name,
SUM(total_price) As total_revenue,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders, total_revenue, total_quantity ASC;

#G.-------Bottom 5 Pizzas by Revenue-----
SELECT pizza_name, SUM(total_price) As total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

#I. Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;
