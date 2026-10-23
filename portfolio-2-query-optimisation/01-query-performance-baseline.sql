
-- Portfolio 2: Query Processing and Optimisation
-- Baseline query before adding a custom index

EXPLAIN ANALYZE
SELECT
    co.order_id,
    co.order_date,
    co.order_status,
    c.full_name
FROM customer_order co
JOIN customer c
    ON c.customer_id = co.customer_id
WHERE co.customer_id = (
    SELECT customer_id
    FROM customer
    WHERE email = 'amina.yusuf@example.com'
);
