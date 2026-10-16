
-- Table 4: Product
CREATE TABLE product (
    product_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(12, 2) NOT NULL CHECK (price >= 0),
    supplier_id BIGINT NOT NULL REFERENCES supplier(supplier_id),
    category_id BIGINT NOT NULL REFERENCES category(category_id),
    product_status VARCHAR(20) NOT NULL DEFAULT 'active'
        CHECK (product_status IN ('active', 'inactive', 'out_of_stock'))
);

-- Table 5: Inventory
CREATE TABLE inventory (
    inventory_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT NOT NULL UNIQUE REFERENCES product(product_id),
    quantity_available INTEGER NOT NULL DEFAULT 0
        CHECK (quantity_available >= 0),
    last_updated TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 6: Customer Order
CREATE TABLE customer_order (
    order_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES customer(customer_id),
    order_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (order_status IN (
            'pending', 'confirmed', 'processing',
            'shipped', 'delivered', 'cancelled'
        ))
);
