--выбрать список из 5 продуктов, которые принесли наибольшую прибыль в 1989 году

SELECT TOP(5) product.product_id, product.description, SUM(item.total) AS sum
FROM product, item, sales_order 
WHERE item.product_id = product.product_id
AND item.order_id = sales_order.order_id
AND YEAR(sales_order.order_date) = 1989
GROUP BY product.product_id, product.description
ORDER BY sum(item.total) DESC;

