# Conceptual Database Design

## 1. Introduction

Conceptual database design translates the requirements of Jacobian HarvestHub Limited into a high-level representation of the information managed by the system.

The design identifies candidate entities, their business meanings, and the relationships between them. It provides the foundation for the Entity-Relationship (ER) diagram and subsequent logical database design.

At this stage, the focus is on the business structure rather than implementation-specific details such as SQL data types, indexes, or database engine syntax.

## 2. Design Objectives

The conceptual model aims to:

- Represent the main business objects managed by Jacobian HarvestHub.
- Establish relationships between related business objects.
- Reflect the business rules identified during requirements analysis.
- Reduce ambiguity before creating relational tables.
- Provide a consistent model for the remaining portfolio activities.

## 3. Identified Entities

### 3.1 Customer

Represents a person who registers on the platform and purchases agricultural products.

### 3.2 Supplier

Represents a farmer or business that supplies agricultural products for sale.

### 3.3 Product

Represents an agricultural product listed on the marketplace.

### 3.4 Category

Represents a classification used to organise similar products.

### 3.5 Inventory

Represents the stock quantity maintained for a product.

### 3.6 Order

Represents a purchase initiated by a customer.

### 3.7 Order Item

Represents an individual product and its quantity within a particular order.

This entity allows an order to contain multiple products and a product to appear in multiple orders.

### 3.8 Payment

Represents a payment attempt or payment record associated with an order.

### 3.9 Delivery

Represents delivery and fulfilment information associated with an order.

### 3.10 Review

Represents feedback submitted by a customer about a product.

## 4. Relationships and Cardinalities

### 4.1 Customer and Order

Relationship: Customer places Order.

Cardinality: One-to-many (1:M).

A customer may place multiple orders, while each order belongs to one customer.

### 4.2 Order and Order Item

Relationship: Order contains Order Item.

Cardinality: One-to-many (1:M).

An order must contain at least one order item when submitted as a valid order. Each order item belongs to one order.

### 4.3 Product and Order Item

Relationship: Product appears in Order Item.

Cardinality: One-to-many (1:M).

A product may appear in multiple order items, while each order item references one product.

### 4.4 Supplier and Product

Relationship: Supplier supplies Product.

Cardinality: One-to-many (1:M).

A supplier may supply multiple products. In the initial model, each product is associated with one supplier.

### 4.5 Category and Product

Relationship: Category classifies Product.

Cardinality: One-to-many (1:M).

A category may contain multiple products. In the initial model, each product belongs to one category.

### 4.6 Order and Payment

Relationship: Order has Payment records.

Cardinality: One-to-many (1:M).

An order may have multiple payment records to represent payment attempts or related payment events. Each payment record references one order.

### 4.7 Order and Delivery

Relationship: Order has Delivery records.

Cardinality: One-to-many (1:M) in the initial model.

This permits multiple delivery records for an order where the fulfilment process requires them. The implementation will define the permitted delivery workflow.

### 4.8 Customer and Review

Relationship: Customer writes Review.

Cardinality: One-to-many (1:M).

A customer may submit multiple reviews, while each review is written by one customer.

### 4.9 Product and Review

Relationship: Product receives Review.

Cardinality: One-to-many (1:M).

A product may receive multiple reviews, while each review refers to one product.

### 4.10 Product and Inventory

Relationship: Product has Inventory record.

Cardinality: One-to-one (1:1) in the initial model.

Each product has one inventory record, and each inventory record belongs to one product. This assumption may be revised if the platform later supports multiple warehouses or storage locations.

## 5. Conceptual Design Decisions

The following decisions guide the initial model:

1. Order Item is represented as a separate entity to resolve the many-to-many relationship between Order and Product.
2. Unit price will be recorded on Order Item to preserve the price applicable when a purchase was made.
3. Payment is separated from Order to support payment status and multiple payment attempts.
4. Delivery is separated from Order to support fulfilment and delivery-status tracking.
5. Inventory is separated from Product to distinguish product information from stock information.
6. Review is separated from both Customer and Product so that customer feedback can be associated with the relevant customer and product.
7. Supplier and Category are separate entities to avoid embedding repeated supplier and category information in every product record.

## 6. Initial Conceptual Model Summary

The initial conceptual model contains ten candidate entities:

- Customer
- Supplier
- Product
- Category
- Inventory
- Order
- Order Item
- Payment
- Delivery
- Review

Their relationships reflect the main business operations of customer purchasing, product management, inventory control, payment recording, delivery fulfilment, and customer feedback.

## 7. Limitations and Future Refinement

The model represents an initial business scenario and may be refined as additional requirements emerge.

Potential areas for refinement include:

- Multiple suppliers providing the same product.
- Inventory distributed across multiple warehouses.
- Multiple delivery attempts or split shipments.
- Restrictions on who may submit product reviews.
- Order cancellation and payment refund workflows.

Any changes will be documented and reflected consistently in the ER diagram and relational schema.

## 8. Conclusion

The conceptual database design establishes the principal entities and relationships required to support Jacobian HarvestHub Limited.

The next stage is to represent these relationships visually in an Entity-Relationship diagram and then translate the conceptual model into a relational schema.
