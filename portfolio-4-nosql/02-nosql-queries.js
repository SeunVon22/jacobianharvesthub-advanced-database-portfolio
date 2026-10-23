
/*
Portfolio 4: MongoDB query examples
Database: jacobian_harvesthub_nosql
Collection: products
*/

// 1. Count all products
db.products.countDocuments({});

// 2. Filter products by category
db.products.find({
  category: "Vegetables"
});

// 3. Find products priced above 2,000
db.products.find(
  { price: { $gt: 2000 } },
  { _id: 0, productName: 1, price: 1 }
);

// 4. Find products with stock below 100
db.products.find(
  { "inventory.quantityAvailable": { $lt: 100 } },
  { _id: 0, productName: 1, "inventory.quantityAvailable": 1 }
);

// 5. List products from lowest to highest price
db.products.find(
  {},
  { _id: 0, productName: 1, price: 1, category: 1 }
).sort({ price: 1 });

// 6. Calculate average price and product count
db.products.aggregate([
  {
    $group: {
      _id: null,
      averagePrice: { $avg: "$price" },
      productCount: { $sum: 1 }
    }
  }
]);
