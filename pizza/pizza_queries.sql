-- Q1: The total number of orders placed
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- Q2: The total revenue generated from pizza sales
SELECT SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id;

-- Q3: The highest priced pizza
SELECT p.pizza_id, MAX(p.price) AS highest_price
FROM pizza p
GROUP BY p.pizza_id;

-- Q4: The most common pizza size ordered
SELECT p.size, SUM(od.quantity) AS total_quantity
FROM pizza p
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;

-- Q5: The top 5 most ordered pizza types along their quantities
SELECT pt.name AS pizza_type, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- Q6: The quantity of each pizza category ordered
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- Q7: The distribution of orders by hours of the day
SELECT HOUR(o.time) AS order_hour, COUNT(*) AS order_count
FROM orders o
GROUP BY HOUR(o.time);

-- Q8: The category-wise distribution of pizzas
SELECT pt.category, COUNT(p.pizza_id) AS total_pizzas
FROM pizza p
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- Q9: The average number of pizzas ordered per day
SELECT AVG(daily_orders) AS avg_pizzas_per_day
FROM (
    SELECT date, SUM(quantity) AS daily_orders
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
    GROUP BY date
) AS daily_totals;

-- Q10: Top 3 most ordered pizza types based on revenue
SELECT pt.name AS pizza_type, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;

-- Q11: The percentage contribution of each pizza type to revenue
SELECT pt.name AS pizza_type, 
       SUM(od.quantity * p.price) AS total_revenue,
       (SUM(od.quantity * p.price) / (SELECT SUM(od.quantity * p.price) FROM order_details od JOIN pizza p ON od.pizza_id = p.pizza_id)) * 100 AS percentage_contribution
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name;

-- Q12: The cumulative revenue generated over time
SELECT date, SUM(quantity * price) AS cumulative_revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN orders o ON od.order_id = o.order_id
GROUP BY date
ORDER BY date;

-- Q13: The top 3 most ordered pizza types based on revenue for each pizza category
SELECT pt.category, pt.name AS pizza_type, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, pt.name
ORDER BY pt.category, total_revenue DESC
LIMIT 3;
