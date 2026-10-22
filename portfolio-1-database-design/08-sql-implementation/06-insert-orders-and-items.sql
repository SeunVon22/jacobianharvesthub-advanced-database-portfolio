
-- Jacobian HarvestHub Limited
-- Portfolio 1: Sample Data
-- Stage 4: Customer Orders and Order Items

-- Insert one order for each customer
INSERT INTO customer_order (customer_id, order_status)
SELECT customer_id, 'confirmed'
FROM customer
WHERE email IN (
    'amina.yusuf@example.com',
    'david.okafor@example.com',
    'grace.adeyemi@example.com'
);

-- Add products to the orders
INSERT INTO order_item (order_id, product_id, quantity, unit_price)
SELECT
    co.order_id,
    p.product_id,
    items.quantity,
    p.price
FROM (
    VALUES
        ('amina.yusuf@example.com', 'Fresh Tomatoes', 2),
        ('amina.yusuf@example.com', 'Fresh Oranges', 3),
        ('david.okafor@example.com', 'Premium Rice', 2),
        ('grace.adeyemi@example.com', 'Fresh Tomatoes', 4),
        ('grace.adeyemi@example.com', 'Premium Rice', 1)
) AS items(customer_email, product_name, quantity)
JOIN customer c
    ON c.email = items.customer_email
JOIN customer_order co
    ON co.customer_id = c.customer_id
JOIN product p
    ON p.product_name = items.product_name;
