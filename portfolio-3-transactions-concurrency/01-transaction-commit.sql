
-- Portfolio 3: Transactions and Concurrency
-- Demonstration: Commit an inventory update

BEGIN;

-- Check the stock before the transaction update
SELECT
    p.product_name,
    i.quantity_available AS stock_before
FROM inventory i
JOIN product p ON p.product_id = i.product_id
WHERE p.product_name = 'Fresh Tomatoes';

-- Deduct two units, provided sufficient stock exists
UPDATE inventory
SET quantity_available = quantity_available - 2,
    last_updated = CURRENT_TIMESTAMP
WHERE product_id = (
    SELECT product_id
    FROM product
    WHERE product_name = 'Fresh Tomatoes'
)
AND quantity_available >= 2
RETURNING product_id, quantity_available AS stock_after;

-- Make the change permanent
COMMIT;

-- Verify the committed stock
SELECT
    p.product_name,
    i.quantity_available
FROM inventory i
JOIN product p ON p.product_id = i.product_id
WHERE p.product_name = 'Fresh Tomatoes';
