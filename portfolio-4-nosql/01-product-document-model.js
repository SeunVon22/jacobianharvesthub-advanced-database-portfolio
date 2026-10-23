
/*
Portfolio 4: NoSQL and Advanced Data Models
Case study: Jacobian HarvestHub Limited

This file demonstrates the MongoDB product document model.
It defines an example document without inserting duplicate data.
*/

const productDocument = {
  productName: "Fresh Tomatoes",
  description: "Fresh tomatoes sourced from local farms",
  price: 2500,
  category: "Vegetables",
  supplier: {
    name: "GreenFields Farms"
  },
  inventory: {
    quantityAvailable: 98
  },
  status: "active",
  createdAt: new Date()
};

// Display the example document in the console.
console.log(productDocument);
