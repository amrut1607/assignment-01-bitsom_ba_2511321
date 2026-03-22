## Anomaly Analysis

Based on the `orders_flat.csv` flat file, here are three anomalies:

1. **Insert Anomaly:** We cannot add a new Sales Representative (e.g., a newly hired employee) to the database until they process their first order. Because the table is order-centric, inserting a sales rep without an `order_id` would require leaving the primary key (order_id) NULL, which violates entity integrity.
2. **Update Anomaly:** The sales representative "Anita Desai" (SR02) operates out of "Delhi Office, Connaught Place". If she moves to a different office, we must update the `office_address` field across multiple rows (e.g., ORD1027, ORD1002, ORD1118, ORD1132). If one row is missed, the database falls into an inconsistent state.
3. **Delete Anomaly:** If customer Vikram Singh cancels order ORD1075, and we delete that row, we completely lose the record that the product "Desk Chair" (P003) even exists in our catalog, as it is the only order in the dataset containing that product.

## Normalization Justification

The manager's argument that "keeping everything in one table is simpler" is fundamentally flawed for a transactional (OLTP) system. While a flat file is simpler for *reading* (like a spreadsheet), it creates severe data integrity issues during *writes* (inserts, updates, deletes). 

For example, looking at the dataset, `customer_name`, `customer_email`, and `customer_city` are repeated every time a customer makes a new order (e.g., Neha Gupta in ORD1153, ORD1118, and ORD1083). This redundancy wastes storage space and creates massive Update Anomalies. If Neha changes her email address, the system must scan and update every single historical order she ever placed. 

Normalization to 3NF splits this into logical entities (`Customers`, `Products`, `Sales_Reps`, `Orders`). This guarantees that Neha's email is stored in exactly one place (the Customers table). Normalization is not over-engineering; it is the absolute baseline requirement to ensure data accuracy, prevent corruption, and maintain a reliable source of truth as the business scales.
