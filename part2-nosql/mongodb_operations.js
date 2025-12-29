/* =========================================================
   MongoDB Operations – FlexiMart
   Database: fleximart
   Collection: products
   ========================================================= */


/* =========================================================
   Operation 1: Load Data
   Import products_catalog.json into MongoDB
   ========================================================= */

// Run this command from the terminal (not inside mongosh):
// mongoimport --db fleximart --collection products --file products_catalog.json --jsonArray



/* =========================================================
   Operation 2: Basic Query
   Find all products in the "Electronics" category
   with a price less than 50000
   Return only: name, price, stock
   ========================================================= */

db.products.find(
  {
    category: "Electronics",
    price: { $lt: 50000 }
  },
  {
    _id: 0,
    name: 1,
    price: 1,
    stock: 1
  }
);



/* =========================================================
   Operation 3: Review Analysis
   Find all products that have an average rating >= 4.0
   Uses aggregation on the embedded reviews array
   ========================================================= */

db.products.aggregate([
  { $unwind: "$reviews" },
  {
    $group: {
      _id: "$name",
      average_rating: { $avg: "$reviews.rating" }
    }
  },
  {
    $match: {
      average_rating: { $gte: 4.0 }
    }
  }
]);



/* =========================================================
   Operation 4: Update Operation
   Add a new review to the product "ELEC001."
   ========================================================= */

db.products.updateOne(
  { product_id: "ELEC001" },
  {
    $push: {
      reviews: {
        user: "U999",
        rating: 4,
        comment: "Good value",
        date: new Date()
      }
    }
  }
);



/* =========================================================
   Operation 5: Complex Aggregation
   Calculate the average price by category
   Return: category, avg_price, product_count
   Sort by avg_price descending
   ========================================================= */

db.products.aggregate([
  {
    $group: {
      _id: "$category",
      avg_price: { $avg: "$price" },
      product_count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      category: "$_id",
      avg_price: { $round: ["$avg_price", 2] },
      product_count: 1
    }
  },
  {
    $sort: { avg_price: -1 }
  }
]);

