
-- Jacobian HarvestHub Limited
-- Portfolio 3: Transactions and Concurrency
-- Demonstration: Row-level locking with SELECT FOR UPDATE
--
-- IMPORTANT:
-- Run the statements in Session A and Session B
-- in two separate SQL Shell windows.
-- Do not run the entire file in one session.

-- SESSION A
-- Step 1: Start a transaction and lock the inventory row.
BEGIN;

SELECT product_id, quantity_available
FROM inventory
WHERE product_id = (
    SELECT product_id
    FROM product
    WHERE product_name = 'Fresh Tomatoes'
)
FOR UPDATE;

-- Leave Session A open here.
-- Run the Session B UPDATE in the second SQL Shell.
-- Then return to Session A and execute:
COMMIT;


-- SESSION B
-- Run these statements in the second SQL Shell,
-- only after Session A has acquired the lock.
BEGIN;

UPDATE inventory
SET quantity_available = quantity_available - 1,
    last_updated = CURRENT_TIMESTAMP
WHERE product_id = (
    SELECT product_id
    FROM product
    WHERE product_name = 'Fresh Tomatoes'
)
AND quantity_available > 0;

-- This UPDATE should wait until Session A commits.
-- After it completes, execute:
COMMIT;
