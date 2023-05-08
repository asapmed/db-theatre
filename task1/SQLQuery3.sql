--определить средние суммы заказов по мес€цам

SELECT YEAR(sales_order.order_date) AS year, MONTH(sales_order.order_date) AS month, AVG(sales_order.total) AS average_sum
FROM SALES_ORDER
GROUP BY YEAR(sales_order.order_date), MONTH(sales_order.order_date)
ORDER BY YEAR(sales_order.order_date);

