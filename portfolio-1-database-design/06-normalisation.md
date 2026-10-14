# Database Normalisation

## 1. Introduction

Database normalisation is the process of organising relational tables to reduce unnecessary duplication and prevent insertion, update, and deletion anomalies.

For Jacobian HarvestHub Limited, normalisation helps maintain accurate customer, supplier, product, inventory, order, payment, delivery, and review information.

This analysis examines First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF), using the proposed relational schema.

## 2. First Normal Form (1NF)

A relation satisfies 1NF when each attribute contains a single value for each row and repeating groups are not represented as repeated columns.

### Example of a design that violates 1NF

An order table containing columns such as:

- order_id
- customer_id
- product_1
- product_2
- product_3

would create a repeating-group problem.

The number of products per order is variable, so the design would require additional columns or leave many columns unused.

### HarvestHub solution

The design separates CUSTOMER_ORDER from ORDER_ITEM.

CUSTOMER_ORDER stores the order-level information, while ORDER_ITEM stores each product included in the order.

For example:

| order_id | customer_id |
|---|---|
| 1001 | 21 |

ORDER_ITEM:

| order_item_id | order_id | product_id | quantity |
|---|---|---|---|
| 1 | 1001 | 301 | 2 |
| 2 | 1001 | 302 | 5 |

Each order item represents one product line.

### 1NF conclusion

The proposed structure avoids repeating product columns and represents each order item as a separate row. Attributes must also be implemented as single-valued fields to satisfy 1NF.

## 3. Second Normal Form (2NF)

A relation satisfies 2NF when it is in 1NF and every non-key attribute depends on the whole of every candidate key, rather than only part of a composite candidate key.

### Example of a design that violates 2NF

Consider a combined order-item table with a composite key consisting of order_id and product_id.

Suppose it stores:

- order_id
- product_id
- order_date
- product_name
- quantity

If the combination of order_id and product_id identifies an order line, order_date depends on order_id alone, while product_name depends on product_id alone.

These are partial dependencies on parts of the composite key.

### HarvestHub solution

The design separates order-level information into CUSTOMER_ORDER and product-level information into PRODUCT.

ORDER_ITEM stores the attributes associated with the relationship between an order and a product, such as quantity and unit_price.

This prevents order dates from being repeated for every product line and product names from being stored redundantly in every order item.

### 2NF conclusion

The separation of CUSTOMER_ORDER, PRODUCT, and ORDER_ITEM helps eliminate the partial dependencies illustrated above.

The final implementation must still be checked against the candidate keys and functional dependencies of each relation.

## 4. Third Normal Form (3NF)

A relation satisfies 3NF when it is in 2NF and, for every non-trivial functional dependency X → A, either X is a superkey or A is a prime attribute.

In practical terms, this prevents inappropriate dependencies where a non-key attribute determines another non-key attribute.

### Example of a design that violates 3NF

Suppose PRODUCT contains:

- product_id
- product_name
- supplier_id
- supplier_name
- supplier_telephone

If supplier_id determines supplier_name and supplier_telephone, the supplier details depend on supplier_id rather than directly on the product's key.

This introduces a transitive dependency in the combined design.

### HarvestHub solution

The proposed schema stores supplier details in SUPPLIER and references the supplier through supplier_id in PRODUCT.

The same principle applies to categories: category details belong in CATEGORY, while PRODUCT stores category_id.

This avoids repeatedly storing supplier and category descriptions in product records.

### 3NF conclusion

Separating SUPPLIER, CATEGORY, and PRODUCT removes the illustrated transitive dependencies, assuming the documented functional dependencies hold.

## 5. Functional Dependencies

A functional dependency X → Y means that the value of X determines the value of Y.

The initial design assumes the following dependencies:

| Relation | Functional dependency |
|---|---|
| CUSTOMER | customer_id → full_name, email, telephone, delivery_address, registration_date |
| SUPPLIER | supplier_id → supplier_name, email, telephone, address, registration_date |
| CATEGORY | category_id → category_name, description |
| PRODUCT | product_id → product_name, description, price, supplier_id, category_id, product_status |
| INVENTORY | inventory_id → product_id, quantity_available, last_updated |
| CUSTOMER_ORDER | order_id → customer_id, order_date, order_status |
| ORDER_ITEM | order_item_id → order_id, product_id, quantity, unit_price |
| PAYMENT | payment_id → order_id, amount, payment_method, payment_status, transaction_reference, payment_date |
| DELIVERY | delivery_id → order_id, delivery_address, delivery_status, assigned_personnel, dispatched_at, delivered_at |
| REVIEW | review_id → customer_id, product_id, rating, review_comment, review_date |

These dependencies assume the identifiers uniquely identify records. Additional candidate keys may exist, such as a unique customer email, depending on the final business rules.

## 6. Normalisation of Key Relationships

### CUSTOMER_ORDER and ORDER_ITEM

Order-level attributes are stored in CUSTOMER_ORDER, while line-level attributes are stored in ORDER_ITEM.

This avoids repeating order dates and other order-level information for every product in the same order.

### PRODUCT and SUPPLIER

Supplier details are stored in SUPPLIER. PRODUCT stores supplier_id as a foreign key.

A supplier's contact information can therefore be updated in one place.

### PRODUCT and CATEGORY

Category information is stored in CATEGORY. PRODUCT references the category using category_id.

This prevents category descriptions from being unnecessarily duplicated across product records.

### ORDER_ITEM and PRODUCT

ORDER_ITEM stores quantity and unit_price. PRODUCT stores the current product price.

The unit_price attribute preserves the historical price applicable to an order line, rather than relying on the product's current price.

## 7. Benefits of Normalisation

The proposed design provides the following benefits:

- Reduces unnecessary duplication.
- Helps prevent insertion, update, and deletion anomalies.
- Improves consistency of supplier and category information.
- Separates order-level data from order-item data.
- Makes relationships clearer.
- Supports the enforcement of keys and integrity constraints.
- Provides a sound basis for SQL queries and transaction processing.

## 8. Design Considerations and Limitations

Normalisation does not automatically guarantee that every business rule is enforced. Constraints, transactions, and application logic may also be necessary.

The schema must be reviewed against its candidate keys and functional dependencies before claiming that every relation is formally in 3NF.

Derived values, such as an order total, should be handled consistently to avoid conflicting stored values. If totals are stored for operational reasons, their accuracy must be maintained.

Performance considerations may later justify carefully controlled denormalisation, but such decisions should be supported by evidence and must preserve data integrity.

## 9. Conclusion

The proposed relational design uses separate relations for customers, suppliers, products, categories, orders, order items, payments, deliveries, inventory, and reviews.

The examples demonstrate how separating data according to its dependencies helps address 1NF, 2NF, and 3NF concerns.

The final schema will be validated against the implemented candidate keys, functional dependencies, and integrity constraints before implementation is considered complete.
