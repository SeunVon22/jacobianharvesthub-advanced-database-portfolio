
-- Portfolio 3: Transactions and Concurrency
-- Demonstration: Roll back an inventory update

BEGIN;

-- Record the current stock
SELECT quantity_available
FROM inventory
WHERE product_id = (
    SELECT product_id
    FROM product
    WHERE product_name = 'Fresh Tomatoes'
);

-- Make a temporary change
UPDATE inventory
SET quantity_available = quantity_available - 5,
    last_updated = CURRENT_TIMESTAMP
WHERE product_id = (
    SELECT product_id
    FROM product
    WHERE product_name = 'Fresh Tomatoes'
)
AND quantity_available >= 5
RETURNING quantity_available AS temporary_stock;

-- Undo the transaction
ROLLBACK;

-- Confirm the original stock was restored
SELECT quantity_available AS stock_after_rollback
FROM inventory
WHERE product_id = (
    SELECT product_id
    FROM product
    WHERE product_name = 'Fresh Tomatoes'
);
