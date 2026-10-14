# Logical Database Design

## 1. Introduction

Logical database design translates the conceptual model of Jacobian HarvestHub Limited into a relational schema.

The design defines the tables, attributes, primary keys, foreign keys, and integrity constraints needed to represent the business requirements and relationships identified during requirements analysis and conceptual design.

The schema is designed to support customer management, product management, inventory, order processing, payments, deliveries, and customer reviews.

## 2. Design Principles

The logical design follows these principles:

- Each table represents a distinct entity or business concept.
- Each table has a primary key that uniquely identifies its records.
- Foreign keys maintain relationships between related tables.
- Attributes store information appropriate to their entities.
- Integrity constraints prevent invalid or inconsistent data.
- Purchase-time prices are preserved in order items.
- Repeating groups and unnecessary duplication will be addressed during normalisation.

## 3. Relational Schema

The notation `PK` identifies a primary key, while `FK` identifies a foreign key.

### 3.1 CUSTOMER

CUSTOMER(
customer_id PK,
full_name,
email,
telephone,
delivery_address,
registration_date
)

Purpose: Stores customer account and contact information.

Constraints:
- `customer_id` uniquely identifies each customer.
- `email` must be unique where required.
- Required customer fields must not be NULL.

### 3.2 SUPPLIER

SUPPLIER(
supplier_id PK,
supplier_name,
email,
telephone,
address,
registration_date
)

Purpose: Stores information about farmers and agricultural suppliers.

Constraints:
- `supplier_id` uniquely identifies each supplier.
- Required supplier information must be provided.

### 3.3 CATEGORY

CATEGORY(
category_id PK,
category_name,
description
)

Purpose: Stores product categories.

Constraints:
- `category_id` uniquely identifies each category.
- `category_name` must be unique.

### 3.4 PRODUCT

PRODUCT(
product_id PK,
product_name,
description,
price,
supplier_id FK,
category_id FK,
product_status
)

Foreign keys:
- `supplier_id` references SUPPLIER(`supplier_id`).
- `category_id` references CATEGORY(`category_id`).

Purpose: Stores product information and associates each product with a supplier and category.

Constraints:
- Product price must not be negative.
- Each product must reference a valid supplier.
- Each product must reference a valid category.
- Required product fields must not be NULL.

### 3.5 INVENTORY

INVENTORY(
inventory_id PK,
product_id FK,
quantity_available,
last_updated
)

Foreign key:
- `product_id` references PRODUCT(`product_id`).

Purpose: Stores available stock quantities for products.

Constraints:
- `product_id` must be unique in INVENTORY under the initial one-record-per-product design.
- Inventory quantity must not be negative.
- Each inventory record must reference a valid product.

### 3.6 CUSTOMER_ORDER

CUSTOMER_ORDER(
order_id PK,
customer_id FK,
order_date,
order_status
)

Foreign key:
- `customer_id` references CUSTOMER(`customer_id`).

Purpose: Stores customer purchase records.

Constraints:
- Each order must reference a valid customer.
- Order status must use a permitted value.
- An order must contain at least one order item before it is submitted as a valid order.

### 3.7 ORDER_ITEM

ORDER_ITEM(
order_item_id PK,
order_id FK,
product_id FK,
quantity,
unit_price
)

Foreign keys:
- `order_id` references CUSTOMER_ORDER(`order_id`).
- `product_id` references PRODUCT(`product_id`).

Purpose: Stores individual products included in customer orders.

Constraints:
- Quantity must be greater than zero.
- Unit price must not be negative.
- Each order item must reference a valid order and product.
- Under the initial design, the combination of `order_id` and `product_id` must be unique so that each product appears at most once per order. Quantities can be combined into one line.

### 3.8 PAYMENT

PAYMENT(
payment_id PK,
order_id FK,
amount,
payment_method,
payment_status,
transaction_reference,
payment_date
)

Foreign key:
- `order_id` references CUSTOMER_ORDER(`order_id`).

Purpose: Records payment attempts and their outcomes.

Constraints:
- Each payment must reference a valid order.
- Payment amount must satisfy the defined amount-validation rules.
- Payment status must use a permitted value.
- Transaction references should be unique where the payment provider guarantees their uniqueness.

### 3.9 DELIVERY

DELIVERY(
delivery_id PK,
order_id FK,
delivery_address,
delivery_status,
assigned_personnel,
dispatched_at,
delivered_at
)

Foreign key:
- `order_id` references CUSTOMER_ORDER(`order_id`).

Purpose: Stores delivery and fulfilment information.

Constraints:
- Each delivery must reference a valid order.
- Delivery status must use a permitted value.
- Delivery timestamps must be consistent with the delivery workflow.

### 3.10 REVIEW

REVIEW(
review_id PK,
customer_id FK,
product_id FK,
rating,
review_comment,
review_date
)

Foreign keys:
- `customer_id` references CUSTOMER(`customer_id`).
- `product_id` references PRODUCT(`product_id`).

Purpose: Stores customer feedback about products.

Constraints:
- Each review must reference a valid customer and product.
- Rating must be between 1 and 5.
- Any rule restricting reviews to verified purchasers will require additional validation against order records.

## 4. Primary Key Summary

| Table | Primary Key |
|---|---|
| CUSTOMER | customer_id |
| SUPPLIER | supplier_id |
| CATEGORY | category_id |
| PRODUCT | product_id |
| INVENTORY | inventory_id |
| CUSTOMER_ORDER | order_id |
| ORDER_ITEM | order_item_id |
| PAYMENT | payment_id |
| DELIVERY | delivery_id |
| REVIEW | review_id |

Each primary key uniquely identifies a record within its table.

## 5. Foreign Key Summary

| Child Table | Foreign Key | Referenced Table |
|---|---|---|
| PRODUCT | supplier_id | SUPPLIER |
| PRODUCT | category_id | CATEGORY |
| INVENTORY | product_id | PRODUCT |
| CUSTOMER_ORDER | customer_id | CUSTOMER |
| ORDER_ITEM | order_id | CUSTOMER_ORDER |
| ORDER_ITEM | product_id | PRODUCT |
| PAYMENT | order_id | CUSTOMER_ORDER |
| DELIVERY | order_id | CUSTOMER_ORDER |
| REVIEW | customer_id | CUSTOMER |
| REVIEW | product_id | PRODUCT |

Foreign keys preserve referential integrity by preventing records from referencing non-existent parent records.

## 6. Important Integrity Constraints

The implementation will enforce appropriate constraints, including:

- Primary key constraints.
- Foreign key constraints.
- NOT NULL constraints for mandatory attributes.
- UNIQUE constraints for identifiers such as customer email and category name.
- CHECK constraints for values such as positive order-item quantities, non-negative prices, valid inventory quantities, and permitted ratings.
- Appropriate status validation for orders, payments, and deliveries.

Some business rules, such as ensuring that every submitted order contains at least one order item, require transactional or application-level validation in addition to ordinary column constraints.

## 7. Design Decisions

### 7.1 Separate Order and Order Item

An order may contain multiple products. ORDER_ITEM records the products, quantities, and purchase-time prices associated with each order.

This avoids storing multiple product columns within a single order record.

### 7.2 Preserve Purchase-Time Prices

The unit price is stored in ORDER_ITEM so that historical purchases retain their original prices even if PRODUCT prices change later.

### 7.3 Separate Payment and Delivery

PAYMENT and DELIVERY are separate tables because payments and fulfilment have their own attributes, statuses, and operational workflows.

### 7.4 Separate Product and Inventory

PRODUCT stores descriptive and commercial product information, while INVENTORY stores stock quantities.

The initial model assumes one inventory record per product. Multi-warehouse inventory would require a revised model.

### 7.5 Use Surrogate Primary Keys

The schema uses generated identifiers such as `customer_id` and `product_id` as primary keys. These identifiers provide stable references even when business attributes such as names or email addresses change.

## 8. Relationship to Normalisation

The schema separates customers, suppliers, categories, products, orders, order items, payments, deliveries, inventory, and reviews into distinct relations.

This provides a foundation for reducing duplication and update anomalies.

The functional dependencies, candidate keys, and normalisation of the relations will be examined in the next stage.

## 9. Conclusion

The logical design defines the initial relational schema for Jacobian HarvestHub Limited, including ten tables, their primary keys, foreign keys, and important integrity constraints.

The schema translates the conceptual model into a structure suitable for subsequent normalisation, physical design, SQL implementation, and testing.
