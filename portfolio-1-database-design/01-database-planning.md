# Database Planning

# 1. Organisation Overview

# Organisation Name
Jacobian HarvestHub Limited

# Business Type
Agricultural E-Commerce and Distribution Platform

# Case Study Type
Simulated Organisation

# 2. Business Description

Jacobian HarvestHub Limited is a simulated agricultural e-commerce and
distribution platform designed to connect farmers and agricultural suppliers
with customers through an online marketplace.

The platform allows suppliers to list agricultural products, customers to
browse available products and place orders, and the organisation to manage
inventory, payments, fulfilment, deliveries, and customer reviews.

The database will serve as the central data management system supporting the
major business operations of the platform.

# 3. Purpose of the Database

The purpose of the database is to provide a structured and reliable system
for storing, managing, retrieving, and processing information required for
the operation of the Jacobian HarvestHub platform.

The database will support:

- Customer management
- Supplier management
- Product management
- Product categorisation
- Inventory management
- Order processing
- Payment processing
- Delivery management
- Customer reviews
- Business reporting and analysis

# 4. Database Users

The major users of the database system will include:

# 4.1 Customers

Customers use the platform to:

- Register accounts
- Browse agricultural products
- Place orders
- Make payments
- Track deliveries
- Submit product reviews

# 4.2 Farmers and Suppliers

Suppliers use the platform to:

- Register as suppliers
- Add products
- Update product information
- Manage available stock
- Monitor customer orders

# 4.3 Inventory Managers

Inventory managers use the system to:

- Monitor product stock
- Update inventory quantities
- Identify low-stock products
- Manage inventory associated with orders

# 4.4 Administrators

Administrators manage the overall platform and may:

- Manage users
- Manage products and categories
- Monitor orders
- Monitor payments
- Manage suppliers
- Review operational information

# 4.5 Delivery Personnel

Delivery personnel use relevant delivery information to:

- View assigned deliveries
- Update delivery status
- Record delivery information

# 4.6 Database/System Administrators

Database or system administrators are responsible for:

- Database administration
- Access control
- Backup and recovery
- Performance monitoring
- Database security and maintenance

# 5. Major Data to be Stored

The database is expected to manage the following major data entities:

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

The detailed attributes and relationships between these entities will be
defined during the conceptual and logical database design stages.

# 6. Major Business Operations

The database should support the following major operations:

1. Customer registration and account management
2. Supplier registration and management
3. Product listing and management
4. Product categorisation
5. Inventory management
6. Customer order creation
7. Order item management
8. Payment processing and recording
9. Order fulfilment
10. Delivery tracking
11. Customer product reviews
12. Operational and management reporting

# 7. Initial Database Requirements

The database should provide:

# Functional Requirements

- Store customer information.
- Store supplier information.
- Store product information.
- Organise products into categories.
- Track available product inventory.
- Record customer orders.
- Record individual items within each order.
- Record payment information associated with orders.
- Record delivery information.
- Store customer reviews.
- Retrieve information efficiently for operational activities and reporting.

# Data Integrity Requirements

The database should maintain accurate and consistent relationships
between related records.

Examples include:

- An order must belong to a valid customer.
- An order item must refer to a valid product.
- A product should be associated with a valid supplier.
- Inventory records should refer to valid products.
- A payment should be associated with a valid order.
- A review should be associated with a valid customer and product.

These requirements will later be implemented using appropriate keys,
constraints, and relationships.

# 8. Initial Database Design Direction

The initial design will use a relational database model for the core
transactional data.

The design will progress through:

1. Database planning
2. Requirements analysis
3. Conceptual database design
4. Entity-Relationship modelling
5. Logical database design
6. Normalisation
7. Physical database design
8. Database implementation
9. Query processing and optimisation
10. Transaction and concurrency testing
11. NoSQL modelling
12. Distributed and cloud database analysis

The database design may later be extended with NoSQL and distributed/cloud
database technologies as required by the remaining portfolio activities.

# 9. Expected Database Benefits

The proposed database system is expected to:

- Centralise important business information.
- Reduce unnecessary duplication of data.
- Improve data consistency.
- Support reliable order and payment processing.
- Improve inventory visibility.
- Support efficient information retrieval.
- Provide a foundation for business reporting.
- Support future scalability and distributed database requirements.

# 10. Planning Outcome

After the database planning stage, the business context,
users, major data requirements, major operations, and initial database
objectives have been identified.

The next stage is requirements analysis, where the identified business
operations will be translated into more detailed data requirements,
business rules, entities, attributes, and relationships.