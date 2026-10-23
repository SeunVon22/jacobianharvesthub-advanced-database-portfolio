
-- Portfolio 2: Query Processing and Optimisation
-- Index to support customer order lookups

CREATE INDEX idx_customer_order_customer_id
ON customer_order (customer_id);
