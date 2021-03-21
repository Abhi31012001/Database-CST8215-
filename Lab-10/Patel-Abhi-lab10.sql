SELECT * FROM customers INNER JOIN countries
ON customers.country_id = countries.id
WHERE countries.name = 'Canada'

SELECT a.name, a.city, b.id, b.order_date
FROM customers AS a JOIN orders AS b
ON a.id = b.customer_id
WHERE a.id BETWEEN 4563 AND 5678
ORDER BY b.order_date DESC

SELECT a.name, a.city, a.country_id, b.id, b.order_date
FROM customers a JOIN orders b
On a.id BETWEEN 4563 AND 5678
AND a.country_id = (SELECT id FROM countries WHERE name LIKE 'Canada')

SELECT a.name, a.city, c.name AS provinceName, b.id AS order_ID, b.order_date
FROM customers a JOIN orders b
ON a.id = b.customer_id
JOIN state_provinces c
ON a.state_province_id = c.id
JOIN countries d
ON a.country_id = d.id
WHERE a.id < 5678 AND a.id > 4563
AND d.name = 'Canada'
ORDER BY b.order_date

SELECT cast (AVG(price)AS DECIMAL (8,2))as avg_price FROM ORDER_LINES
WHERE product_version_id = 198

SELECT MAX (price) as max_price FROM order_lines 
WHERE product_version_id = 198

SELECT orders.id, orders.order_date, COUNT(*), SUM(extended_price)as sum_ex_price
FROM orders JOIN order_lines
ON orders.id = order_lines.order_id
WHERE orders.id = 34567
GROUP BY orders.id

SELECT A.id, A.name, CAST (AVG(price) AS DECIMAL(9,2)) as avg_price
FROM products A JOIN product_versions B
ON A.id = B.product_id
JOIN order_lines C
ON B.id = C.product_version_id
GROUP BY A.id, A.name
HAVING name = 'Groovecom'

SELECT CAST(AVG(price) AS DECIMAL(9,2)) as avg_price FROM order_lines
WHERE product_version_id IN (SELECT id FROM product_versions
WHERE product_id IN (SELECT id FROM products WHERE name = 'Groovecom'))	

SELECT ROUND (AVG(od.lines),0)AS avg_lines,
MAX(od.lines) AS max_lines,
MIN(od.lines) AS min_lines
FROM 
(SELECT orders.id, COUNT(order_lines.order_id) AS lines FROM orders JOIN
 order_lines
 ON orders.id = order_lines.order_id
 GROUP BY orders.id
 ORDER BY lines DESC
 )AS od
 
 SELECT ROUND(AVG(od.total_orders),2) AS avg_orders
 FROM (SELECT customers.id AS c_id, COUNT (orders.id) AS total_orders
 FROM customers JOIN orders
 ON customers.id = orders.customer_id
 WHERE state_province_id IN
 (SELECT id FROM state_provinces WHERE name = 'Ontario')
 GROUP BY c_id) AS od
 
 SELECT ROUND (AVG (od.sum_price),2)AS avg_price
 FROM (SELECT orders.customer_id AS cus_id, sum(order_lines.extended_price) as
 sum_price
 FROM order_lines JOIN orders
 ON order_lines.order_id = orders.id
 GROUP BY cus_id
 ORDER BY cus_id
 LIMIT 500) AS od
 
SELECT * FROM products JOIN product_versions ON products.id = product_versions.product_id

SELECT * FROM products LEFT JOIN product_versions ON products.id = product_versions.product_id

SELECT products.id, name, products.active FROM products
LEFT JOIN product_versions
ON products.id = product_versions.product_id
WHERE product_versions.id ISNULL

SELECT email FROM customers
UNION
SELECT email FROM tradeshow_leads

SELECT id, name, email FROM tradeshow_leads
WHERE email IN 
(SELECT email FROM tradeshow_leads
EXCEPT
SELECT email FROM customers)

SELECT id, name, email FROM tradeshow_leads
WHERE email IN 
(SELECT email FROM tradeshow_leads 
INTERSECT
SELECT email FROM customers)