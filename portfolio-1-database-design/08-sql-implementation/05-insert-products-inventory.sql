
-- Stage 2: Products
INSERT INTO product
    (product_name, description, price, supplier_id, category_id, product_status)
VALUES
    (
        'Fresh Tomatoes',
        'Locally sourced fresh tomatoes',
        2500.00,
        (SELECT supplier_id FROM supplier
         WHERE supplier_name = 'GreenFields Farms'),
        (SELECT category_id FROM category
         WHERE category_name = 'Vegetables'),
        'active'
    ),
    (
        'Premium Rice',
        'Quality locally sourced rice',
        4500.00,
        (SELECT supplier_id FROM supplier
         WHERE supplier_name = 'GoldenGrain Suppliers'),
        (SELECT category_id FROM category
         WHERE category_name = 'Grains'),
        'active'
    ),
    (
        'Fresh Oranges',
        'Fresh seasonal oranges',
        1800.00,
        (SELECT supplier_id FROM supplier
         WHERE supplier_name = 'FreshHarvest Produce'),
        (SELECT category_id FROM category
         WHERE category_name = 'Fruits'),
        'active'
    );

-- Stage 3: Inventory
INSERT INTO inventory (product_id, quantity_available)
SELECT product_id, quantity
FROM (
    VALUES
        ('Fresh Tomatoes', 100),
        ('Premium Rice', 200),
        ('Fresh Oranges', 150)
) AS stock(product_name, quantity)
JOIN product USING (product_name);
