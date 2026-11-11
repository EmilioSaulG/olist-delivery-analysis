SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    ROUND(julianday(order_delivered_customer_date)
        - julianday(order_estimated_delivery_date), 1) AS dias_retraso
FROM orders 
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
LIMIT 20;