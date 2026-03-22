// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "product_id": "E1001",
    "category": "Electronics",
    "name": "Sony 65-inch 4K Smart TV",
    "price": 85000,
    "brand": "Sony",
    "specs": {
      "display": "OLED",
      "resolution": "4K UHD",
      "smart_features": true,
      "voltage": "110-240V"
    },
    "warranty": {
      "duration_months": 24,
      "type": "Manufacturer"
    },
    "stock_quantity": 45,
    "reviews": [
      { "user": "Alice", "rating": 5, "comment": "Amazing picture quality!" }
    ]
  },
  {
    "product_id": "C2001",
    "category": "Clothing",
    "name": "Men's Classic Denim Jacket",
    "price": 3500,
    "brand": "Levi's",
    "details": {
      "material": "98% Cotton, 2% Elastane",
      "fit": "Regular",
      "care_instructions": "Machine wash cold"
    },
    "available_sizes": ["S", "M", "L", "XL"],
    "available_colors": ["Blue", "Black"],
    "stock_quantity": 120,
    "return_policy_days": 15
  },
  {
    "product_id": "G3001",
    "category": "Groceries",
    "name": "Organic Almond Milk",
    "price": 250,
    "brand": "Natures Best",
    "nutritional_info": {
      "calories_per_100ml": 45,
      "protein_g": 1.5,
      "fat_g": 3.0,
      "sugar_g": 0.5
    },
    "dietary_labels": ["Vegan", "Gluten-Free", "Dairy-Free"],
    "expiry_date": ISODate("2024-11-30T00:00:00Z"),
    "storage_instructions": "Refrigerate after opening",
    "stock_quantity": 300
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: ISODate("2025-01-01T00:00:00Z") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { product_id: "C2001" },
  { $set: { discount_percent: 15 } }
);

// OP5: createIndex() — create an index on category field and explain why
/* 
Explanation: Since an e-commerce platform revolves heavily around filtering and browsing products by category, queries like `db.products.find({ category: "Electronics" })` will be highly frequent. Creating an index on the "category" field will drastically speed up read operations because MongoDB can use the B-tree index to locate the relevant documents without having to perform a full collection scan (COLLSCAN).
*/
db.products.createIndex({ category: 1 });
