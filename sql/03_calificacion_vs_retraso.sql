WITH entregas AS (
    SELECT
        o.order_id,
        julianday(o.order_delivered_customer_date) - julianday(o.order_estimated_delivery_date) AS dias_retraso,
        AVG(r.review_score) AS score
    FROM orders o 
    JOIN reviews r ON r.order_id = o.order_id
    WHERE o.order_status = "delivered"
      AND o.order_delivered_customer_date IS NOT NULL
    GROUP BY o.order_id     
)
SELECT 
    CASE
        WHEN dias_retraso <= 0 THEN "1. A tiempo o antes"
        WHEN dias_retraso <= 3 THEN "2. Retraso 1-3 días"
        WHEN dias_retraso <= 7 THEN "3. Retraso 4-7 días"
        ELSE "4. Retraso más de 7 días"
    END AS grupo,
    COUNT(*) AS ordenes,
    ROUND(AVG(score), 2) AS calificacion_promedio
FROM entregas
GROUP BY grupo
ORDER BY grupo;

