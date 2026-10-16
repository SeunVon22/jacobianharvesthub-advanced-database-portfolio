
-- Table 7: Order Item
CREATE TABLE order_item (
    order_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES customer_order(order_id),
    product_id BIGINT NOT NULL REFERENCES product(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12, 2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT uq_order_item_product UNIQUE (order_id, product_id)
);

-- Table 8: Payment
CREATE TABLE payment (
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES customer_order(order_id),
    amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (payment_status IN (
            'pending', 'successful', 'failed', 'refunded'
        )),
    transaction_reference VARCHAR(150) UNIQUE,
    payment_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 9: Delivery
CREATE TABLE delivery (
    delivery_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL REFERENCES customer_order(order_id),
    delivery_address TEXT NOT NULL,
    delivery_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (delivery_status IN (
            'pending', 'dispatched', 'in_transit',
            'delivered', 'failed', 'returned'
        )),
    assigned_personnel VARCHAR(150),
    dispatched_at TIMESTAMPTZ,
    delivered_at TIMESTAMPTZ,
    CHECK (
        delivered_at IS NULL
        OR dispatched_at IS NULL
        OR delivered_at >= dispatched_at
    )
);

-- Table 10: Review
CREATE TABLE review (
    review_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES customer(customer_id),
    product_id BIGINT NOT NULL REFERENCES product(product_id),
    rating SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_comment TEXT,
    review_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
