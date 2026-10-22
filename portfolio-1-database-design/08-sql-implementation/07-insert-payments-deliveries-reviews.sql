
-- Jacobian HarvestHub Limited
-- Portfolio 1: Sample Data
-- Stage 5: Payments, Deliveries, and Reviews

-- Payments: one successful payment for each order
INSERT INTO payment
    (order_id, amount, payment_method, payment_status, transaction_reference)
SELECT
    co.order_id,
    totals.order_total,
    'bank_transfer',
    'successful',
    'HH-TXN-' || co.order_id
FROM customer_order co
JOIN (
    SELECT order_id, SUM(quantity * unit_price) AS order_total
    FROM order_item
    GROUP BY order_id
) totals ON totals.order_id = co.order_id;

-- Deliveries: one delivery record for each order
INSERT INTO delivery
    (order_id, delivery_address, delivery_status, assigned_personnel)
SELECT
    co.order_id,
    c.delivery_address,
    'pending',
    CASE c.email
        WHEN 'amina.yusuf@example.com' THEN 'Delivery Staff A'
        WHEN 'david.okafor@example.com' THEN 'Delivery Staff B'
        ELSE 'Delivery Staff C'
    END
FROM customer_order co
JOIN customer c ON c.customer_id = co.customer_id;

-- Reviews: customers review products in this sample dataset
INSERT INTO review
    (customer_id, product_id, rating, review_comment)
SELECT
    c.customer_id,
    p.product_id,
    r.rating,
    r.comment
FROM (
    VALUES
        ('amina.yusuf@example.com', 'Fresh Tomatoes', 5,
         'Fresh produce and good quality'),
        ('david.okafor@example.com', 'Premium Rice', 4,
         'Good quality rice'),
        ('grace.adeyemi@example.com', 'Fresh Oranges', 5,
         'Fresh and tasty oranges')
) AS r(customer_email, product_name, rating, comment)
JOIN customer c ON c.email = r.customer_email
JOIN product p ON p.product_name = r.product_name;
