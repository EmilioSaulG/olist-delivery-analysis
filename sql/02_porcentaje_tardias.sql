SELECT 
    COUNT(*) AS total_entregadas,
    SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) AS tardias,
    ROUND(100.0  * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_tardias
FROM orders
WHERE order_status = "delivered"
  AND order_delivered_customer_date IS NOT NULL;
