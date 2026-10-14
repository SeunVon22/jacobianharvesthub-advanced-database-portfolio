# Requirements Analysis

## 1. Introduction

Requirements analysis identifies the functional requirements, data requirements, business rules, non-functional requirements, and operational constraints of the Jacobian HarvestHub Limited database system.

The analysis translates the business objectives established during database planning into requirements that will guide conceptual design, Entity-Relationship modelling, logical design, normalisation, and implementation.

## 2. System Scope

The proposed system will support the core operations of a simulated agricultural e-commerce and distribution platform.

The scope includes:

- Customer account management
- Supplier management
- Product and category management
- Inventory tracking
- Customer order processing
- Order item management
- Payment record management
- Delivery tracking
- Product reviews
- Operational reporting

The initial implementation will focus on the database and its core operations. A complete customer-facing website, live payment gateway, and real-world logistics integration are outside the initial scope unless introduced in a later development stage.

## 3. Functional Requirements

Functional requirements describe the operations the system must support.

| ID | Requirement |
|---|---|
| FR-01 | The system shall store and manage customer account information. |
| FR-02 | The system shall store supplier information. |
| FR-03 | The system shall allow authorised users to create and update product records. |
| FR-04 | The system shall organise products into categories. |
| FR-05 | The system shall maintain inventory quantities for products. |
| FR-06 | The system shall allow a customer to place an order containing one or more order items. |
| FR-07 | The system shall record the products, quantities, and prices associated with each order item. |
| FR-08 | The system shall calculate order totals from the order items and applicable charges. |
| FR-09 | The system shall record payment attempts, amounts, methods, and outcomes. |
| FR-10 | The system shall associate delivery records with relevant orders. |
| FR-11 | The system shall support delivery-status updates. |
| FR-12 | The system shall allow customers to submit product reviews. |
| FR-13 | The system shall retrieve order, inventory, payment, and sales information for reporting. |
| FR-14 | The system shall enforce appropriate relationships and data integrity constraints. |

## 4. Data Requirements

The database must manage the following categories of information.

### 4.1 Customer Data

Information required to identify customers and manage their orders.

Potential attributes include customer ID, full name, email address, telephone number, delivery address, and registration date.

### 4.2 Supplier Data

Information about farmers and agricultural suppliers.

Potential attributes include supplier ID, supplier name, contact information, address, and registration date.

### 4.3 Product Data

Information describing agricultural products available for purchase.

Potential attributes include product ID, product name, description, price, supplier, category, and product status.

### 4.4 Category Data

Information used to group similar products.

Potential attributes include category ID, category name, and category description.

### 4.5 Inventory Data

Information about product stock availability.

Potential attributes include inventory ID, product ID, available quantity, and last-updated timestamp.

### 4.6 Order Data

Information about customer orders.

Potential attributes include order ID, customer ID, order date, order status, and order total.

### 4.7 Order Item Data

Information about individual products included in an order.

Potential attributes include order-item ID, order ID, product ID, quantity, and unit price at the time of ordering.

### 4.8 Payment Data

Information about payments associated with orders.

Potential attributes include payment ID, order ID, amount, payment method, payment status, transaction reference, and payment date.

### 4.9 Delivery Data

Information used to manage order fulfilment and delivery.

Potential attributes include delivery ID, order ID, delivery address, delivery status, assigned delivery personnel, and delivery timestamps.

### 4.10 Review Data

Information about customer feedback on products.

Potential attributes include review ID, customer ID, product ID, rating, review comment, and review date.

These are proposed attributes. Their final data types, constraints, and relationships will be determined during logical and physical database design.

## 5. Business Rules

Business rules describe the conditions that govern the organisation's data and operations.

### BR-01: Customer Orders

Every order must belong to one valid customer. A customer may place multiple orders.

### BR-02: Order Items

Every order must contain at least one order item before it can be submitted as a valid order. Each order item must reference one valid product.

### BR-03: Products and Suppliers

Each product must be associated with a valid supplier. A supplier may provide multiple products.

### BR-04: Product Categories

Each product must belong to an appropriate category. A category may contain multiple products.

### BR-05: Inventory

Inventory quantities must not be negative. The system must validate stock availability before confirming an order.

### BR-06: Order Prices

The unit price recorded on an order item must represent the price applicable when the order was placed. Later product price changes must not alter historical order-item prices.

### BR-07: Payments

Every payment record must be associated with a valid order. Payment outcomes must be recorded so that successful, failed, and pending transactions can be distinguished.

### BR-08: Deliveries

Every delivery record must be associated with a valid order. Delivery status must follow the permitted operational workflow.

### BR-09: Product Reviews

Every review must reference a valid customer and product. The implementation will define whether multiple reviews by the same customer for the same product are permitted.

### BR-10: Data Integrity

Records must not reference non-existent related records. Appropriate primary keys, foreign keys, uniqueness rules, and validation constraints must be implemented.

## 6. Non-Functional Requirements

Non-functional requirements describe the quality and operational expectations of the database system.

### 6.1 Data Integrity and Reliability

The database should maintain accurate and consistent records. Related operations, such as confirming an order and updating inventory, must be designed to avoid inconsistent outcomes.

### 6.2 Security

Access to customer, supplier, payment, and administrative information must be restricted according to user roles and permissions.

Sensitive payment credentials should not be stored as ordinary database fields. Payment integration and any storage of sensitive information will follow appropriate security requirements.

### 6.3 Performance

Frequently used operations, such as product searches, order retrieval, inventory checks, and sales reports, should perform efficiently. Query execution plans and indexing will be examined in Portfolio 2.

### 6.4 Availability and Recovery

The database should support appropriate backup and recovery procedures. Availability and recovery requirements will be refined as the deployment architecture is established.

### 6.5 Scalability

The database design should support future growth in customers, products, orders, and transactions. Distributed and cloud database options will be evaluated in Portfolio 5.

### 6.6 Maintainability

The database schema, SQL scripts, configuration, and documentation should be organised so that the system can be understood, tested, maintained, and extended.

## 7. Data Integrity and Validation Requirements

The implementation should enforce the following conditions where applicable:

- Primary keys must uniquely identify records.
- Foreign keys must preserve valid relationships between entities.
- Required fields must not contain NULL values.
- Email addresses and other identifiers must follow appropriate uniqueness rules where required.
- Prices and payment amounts must satisfy appropriate non-negative or positive-value constraints.
- Inventory quantities and order-item quantities must satisfy defined range constraints.
- Order and payment statuses must use permitted values.
- Inventory updates and order confirmation must be coordinated to prevent overselling.

The precise constraints will be implemented after the database platform and final schema have been selected.

## 8. Initial Entity Identification

The requirements analysis identifies the following candidate entities:

1. Customer
2. Supplier
3. Product
4. Category
5. Inventory
6. Order
7. Order Item
8. Payment
9. Delivery
10. Review

These entities represent the major information groups identified during planning. Their attributes and relationships will be refined during conceptual design.

## 9. Assumptions and Decisions Requiring Validation

The following assumptions will guide the initial design:

- The project represents a simulated organisation rather than a live production business.
- Each order belongs to one customer.
- An order can contain multiple products through its order items.
- Each product is initially associated with one supplier and one category.
- Inventory is tracked at product level in the initial model.
- Payment processing is represented through database records rather than a live payment gateway.
- Delivery tracking is represented through delivery records and status updates.
- User authentication and detailed role permissions may be represented conceptually unless implementation scope requires them.

These assumptions will be reviewed if the conceptual model reveals a need for additional entities or relationships.

## 10. Requirements-to-Design Traceability

The requirements will guide later database design decisions.

| Requirement | Design implication |
|---|---|
| FR-01, BR-01 | Customer and Order entities with a foreign-key relationship |
| FR-03, FR-04 | Product and Category entities |
| FR-05, BR-05 | Inventory representation and quantity constraints |
| FR-06, FR-07, BR-02 | Order and Order Item entities |
| FR-08, BR-06 | Order-item price preservation and order-total calculation |
| FR-09, BR-07 | Payment entity linked to Order |
| FR-10, FR-11, BR-08 | Delivery entity and delivery-status rules |
| FR-12, BR-09 | Review entity linked to Customer and Product |
| FR-14, BR-10 | Keys, foreign keys, uniqueness rules, and validation constraints |

## 11. Conclusion

The requirements analysis has translated the business objectives of Jacobian HarvestHub Limited into functional requirements, data requirements, business rules, non-functional requirements, and initial design assumptions.

These requirements provide the basis for conceptual database design and the Entity-Relationship diagram. They will also guide the relational schema, normalisation, implementation, testing, and subsequent portfolio activities.
