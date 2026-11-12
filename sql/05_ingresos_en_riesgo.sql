WITH entregas as (
    SELECT
        o.order_id,
        CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 ELSE 0 END AS tardia,
        AVG(r.review_score) AS score
    FROM orders o 
    JOIN reviews r ON r.order_id = o.order_id
    WHERE o.order_status = "delivered"
      AND o.order_delivered_customer_date IS NOT NULL
    GROUP BY o.order_id
),
ingresos AS (
    SELECT order_id, SUM(price) AS ingreso
    FROM order_items
    GROUP BY order_id
)
SELECT 
    e.tardia,
    COUNT(*) AS ordenes,
    ROUND(SUM(i.ingreso), 0) AS ingreso_total,
    ROUND(SUM(CASE WHEN e.score <= 2 THEN i.ingreso ELSE 0 END), 0) AS ingreso_con_mala_calificacion
FROM entregas e 
JOIN ingresos i ON i.order_id = e.order_id
GROUP BY e.tardia;
