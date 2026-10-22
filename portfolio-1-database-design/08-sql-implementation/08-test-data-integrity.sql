
-- Jacobian HarvestHub Limited
-- Portfolio 1: Database Integrity Testing
-- Expected result: Each INSERT should be rejected.

-- Test 1: Duplicate customer email
INSERT INTO customer
    (full_name, email, delivery_address)
VALUES
    ('Test Customer', 'amina.yusuf@example.com',
     'Test Address');

-- Test 2: Negative product price
INSERT INTO product
    (product_name, price, supplier_id, category_id)
VALUES
    (
        'Invalid Product',
        -100.00,
        (SELECT supplier_id FROM supplier
         WHERE supplier_name = 'GreenFields Farms'),
        (SELECT category_id FROM category
         WHERE category_name = 'Vegetables')
    );

-- Test 3: Negative inventory quantity
INSERT INTO inventory (product_id, quantity_available)
SELECT product_id, -10
FROM product
WHERE product_name = 'Fresh Tomatoes';

-- Test 4: Order referencing a nonexistent customer
INSERT INTO customer_order (customer_id, order_status)
VALUES (999999, 'confirmed');

-- Test 5: Rating outside the allowed range
INSERT INTO review (customer_id, product_id, rating)
SELECT
    c.customer_id,
    p.product_id,
    6
FROM customer c
CROSS JOIN product p
WHERE c.email = 'amina.yusuf@example.com'
  AND p.product_name = 'Fresh Tomatoes';
