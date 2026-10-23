
# Portfolio 4: NoSQL and Advanced Data Models

## 1. Case Study

Jacobian HarvestHub Limited is an agricultural e-commerce and
distribution platform connecting suppliers with customers.
The platform manages products, supplier information, inventory,
orders, payments, and fulfilment.

## 2. NoSQL Data Model

MongoDB was selected to demonstrate a document-oriented data model.
The `products` collection stores each product as a BSON document.

The document includes product details, price, category, status,
supplier information, and inventory information. Supplier and
inventory details are embedded within the product document.

## 3. Query Implementation

The implementation demonstrates:

- Counting documents in a collection.
- Filtering products by category.
- Selecting products above a specified price.
- Querying nested inventory fields.
- Sorting and projecting product information.
- Aggregating product count and average price.

The sample dataset contains three products: Fresh Tomatoes,
Premium Rice, and Fresh Oranges.

## 4. Advantages

- Flexible documents can accommodate product-specific attributes.
- Embedded fields can reduce the need for joins when retrieving
  product and inventory information together.
- MongoDB supports filtering, sorting, and aggregation.
- The document structure can evolve as the business adds features.

## 5. Limitations and Trade-offs

- Embedding related data can create duplication when the same
  supplier information appears in many product documents.
- Inventory updates require careful handling when multiple
  customers attempt to purchase the same product.
- References or separate collections may be preferable for
  frequently changing or shared supplier information.
- The relational model remains useful when strict relationships,
  foreign keys, and multi-entity transactions are important.

## 6. Comparison with PostgreSQL

The earlier PostgreSQL implementation stores products, suppliers,
and inventory in separate related tables connected by keys.
The MongoDB implementation embeds selected supplier and inventory
fields in a product document.

The relational model provides explicit foreign-key constraints.
The document model offers more flexibility and can simplify reads
that need embedded information. Neither approach is universally
better; the appropriate design depends on access patterns,
consistency requirements, and the nature of the data.

## 7. Evidence

Screenshots of query results are stored in the `evidence` folder.
They demonstrate category filtering, price filtering, low-stock
queries, and price aggregation.

## 8. Verification

The MongoDB server and shell were verified locally. Three product
documents were inserted, and the count and sorted-query results
were checked.

Further testing should be performed before using this design in
a production system.
