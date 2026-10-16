# Physical Database Design

## 1. Introduction

Physical database design defines how the logical relational schema of Jacobian HarvestHub Limited will be implemented in a specific database management system.

It determines the physical data types, key implementation, integrity constraints, indexes, and operational considerations required to implement the logical design.

The selected relational database platform for the initial implementation is PostgreSQL.

## 2. Selected Database Management System

### PostgreSQL

PostgreSQL is selected as the relational database management system for the core Jacobian HarvestHub database.

The selection is based on the following requirements:

- Support for relational tables and SQL.
- Primary key and foreign key enforcement.
- Check, unique, and not-null constraints.
- ACID-compliant transactions.
- Query execution plans and indexing.
- Support for concurrent database access.
- Availability of backup, recovery, and administration tools.
- Suitability for practical demonstrations of database design and optimisation.

PostgreSQL will serve as the primary relational database for the initial implementation. NoSQL and distributed/cloud approaches will be considered in their respective portfolio activities.

## 3. Physical Data Type Decisions

The following data types are proposed for the initial implementation.

| Data category | Proposed PostgreSQL type | Justification |
|---|---|---|
| Generated identifiers | BIGINT GENERATED ALWAYS AS IDENTITY | Generates numeric identifiers |
| Names and labels | VARCHAR with an appropriate limit | Stores bounded text |
| Descriptions and comments | TEXT | Stores variable-length descriptive text |
| Email addresses | VARCHAR(254) | Stores email address strings |
| Telephone numbers | VARCHAR(30) | Preserves telephone formatting and possible leading zeros |
| Prices and monetary amounts | NUMERIC(12,2) | Supports exact decimal monetary values |
| Quantities and stock counts | INTEGER | Represents whole-number quantities |
| Ratings | SMALLINT | Represents small integer ratings |
| Business dates and timestamps | TIMESTAMPTZ where a timestamp is required | Records an event time with time-zone awareness |
| Product and order statuses | VARCHAR(30) | Stores status values subject to validation |

Final lengths and precision will be reviewed against the business requirements during implementation.

## 4. Primary and Foreign Key Implementation

Each table will have a primary key.

Generated numeric identifiers will be used for the main entities, including CUSTOMER, SUPPLIER, CATEGORY, PRODUCT, INVENTORY, CUSTOMER_ORDER, ORDER_ITEM, PAYMENT, DELIVERY, and REVIEW.

Foreign keys will implement the relationships identified in the logical design.

Examples include:

- PRODUCT.supplier_id references SUPPLIER.supplier_id.
- PRODUCT.category_id references CATEGORY.category_id.
- CUSTOMER_ORDER.customer_id references CUSTOMER.customer_id.
- ORDER_ITEM.order_id references CUSTOMER_ORDER.order_id.
- ORDER_ITEM.product_id references PRODUCT.product_id.
- PAYMENT.order_id references CUSTOMER_ORDER.order_id.
- DELIVERY.order_id references CUSTOMER_ORDER.order_id.
- REVIEW.customer_id references CUSTOMER.customer_id.
- REVIEW.product_id references PRODUCT.product_id.

Referential actions such as ON DELETE RESTRICT or ON DELETE CASCADE will be selected according to the business meaning of each relationship. Historical orders and payment records should not be deleted unintentionally when related business records change.

## 5. Integrity Constraints

The PostgreSQL implementation will enforce appropriate integrity constraints.

### 5.1 Primary Key Constraints

Primary keys will prevent duplicate identifiers within each table.

### 5.2 Foreign Key Constraints

Foreign keys will prevent records from referencing non-existent parent records.

### 5.3 NOT NULL Constraints

Mandatory attributes, such as identifiers, product names, and required order references, will be declared NOT NULL.

### 5.4 UNIQUE Constraints

Uniqueness constraints will be applied where required by the business rules.

Examples include:

- Customer email, where each customer must have a unique email address.
- Category name.
- Inventory.product_id under the initial one-inventory-record-per-product model.
- The combination of order_id and product_id in ORDER_ITEM, under the assumption that each product appears at most once per order.

### 5.5 CHECK Constraints

Check constraints will validate appropriate values.

Examples include:

- Product prices must not be negative.
- Inventory quantities must not be negative.
- Order-item quantities must be greater than zero.
- Ratings must be between 1 and 5.
- Status fields must use permitted values.

More complex business rules, including ensuring an order has at least one order item before submission, may require transaction or application-level validation.

## 6. Indexing Strategy

Indexes will be considered for primary keys, foreign keys, and frequently queried attributes.

Candidate indexes include:

- CUSTOMER.email for customer lookup, with uniqueness enforced where required.
- PRODUCT.category_id for filtering products by category.
- PRODUCT.supplier_id for retrieving products supplied by a supplier.
- CUSTOMER_ORDER.customer_id for retrieving a customer's orders.
- CUSTOMER_ORDER.order_date for date-based reporting.
- CUSTOMER_ORDER.order_status for operational order filtering.
- ORDER_ITEM.order_id for retrieving the items in an order.
- PAYMENT.order_id for retrieving payment records associated with an order.
- DELIVERY.order_id for retrieving delivery records associated with an order.
- REVIEW.product_id for retrieving product reviews.

Primary key and unique constraints create supporting indexes in PostgreSQL. Foreign key declarations do not automatically create indexes on the referencing columns, so suitable indexes will be considered separately.

The final index set will be informed by query patterns and execution-plan analysis in Portfolio 2. Indexes will not be added indiscriminately because they also consume storage and can increase the cost of writes.

## 7. Transaction and Concurrency Considerations

Order processing and inventory updates must be designed to maintain data integrity.

A transaction should coordinate the relevant operations so that a failure does not leave the database in a partially updated state.

For example, confirming an order may require validating available stock, recording the order, creating its order items, and updating inventory within a suitable transaction.

Concurrency control will be examined in Portfolio 3 to prevent problems such as two customers purchasing the same remaining stock simultaneously.

## 8. Security and Access Control

The implementation should use appropriate database roles and permissions.

The application should not connect using a database superuser account during normal operation.

Permissions should follow the principle of least privilege, granting each account only the access required for its responsibilities.

Sensitive credentials must not be committed to the GitHub repository. Database connection settings and secrets should be managed separately from source code.

## 9. Backup and Recovery

The database should have an appropriate backup and recovery strategy.

Backup frequency and retention will depend on the operational requirements. Recovery procedures should be tested rather than assuming that the existence of a backup guarantees successful restoration.

Practical implementation evidence will be documented when the database environment is established.

## 10. Scalability and Future Development

PostgreSQL will provide the initial relational foundation.

As the portfolio progresses, the project will examine query optimisation, transactions, a suitable NoSQL model, and distributed/cloud database options.

Any extension will be evaluated against the requirements for consistency, availability, performance, scalability, and operational complexity.

## 11. Conclusion

The physical database design selects PostgreSQL and establishes proposed data types, key implementation, integrity constraints, indexing considerations, transaction requirements, security practices, and backup considerations.

These decisions provide the basis for implementing the relational schema and gathering practical evidence in the subsequent portfolio activities.
