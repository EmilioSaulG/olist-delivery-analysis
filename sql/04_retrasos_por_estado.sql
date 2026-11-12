SELECT
    c.customer_state AS estado,
    COUNT(*) AS ordenes,
    SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 ELSE 0 END) AS tardias,
    ROUND(100.0 * SUM(CASE WHEN o.order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_tardias
FROM orders o 
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_status = "delivered"
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(*) >= 100
ORDER BY pct_tardias DESC;
