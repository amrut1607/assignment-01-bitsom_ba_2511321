-- Dimension: Date
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    cal_year INT NOT NULL,
    cal_month INT NOT NULL,
    cal_day INT NOT NULL
);

-- Dimension: Store
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

-- Dimension: Product (With Casing Cleanups)
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- Fact: Sales Transactions
CREATE TABLE fact_sales (
    transaction_id VARCHAR(50) PRIMARY KEY,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id VARCHAR(50) NOT NULL,
    units_sold INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_revenue DECIMAL(15, 2) NOT NULL, -- Measure
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- Note: The following INSERTs reflect data that has been standardized 
-- (Dates normalized to YYYY-MM-DD, keys generated, categories uniformly capitalized)

INSERT INTO dim_date (date_id, full_date, cal_year, cal_month, cal_day) VALUES
(20230115, '2023-01-15', 2023, 1, 15),
(20230205, '2023-02-05', 2023, 2, 5),
(20230220, '2023-02-20', 2023, 2, 20),
(20230331, '2023-03-31', 2023, 3, 31),
(20230809, '2023-08-09', 2023, 8, 9),
(20230829, '2023-08-29', 2023, 8, 29),
(20231026, '2023-10-26', 2023, 10, 26),
(20231115, '2023-11-15', 2023, 11, 15),
(20231208, '2023-12-08', 2023, 12, 8),
(20231212, '2023-12-12', 2023, 12, 12);

INSERT INTO dim_store (store_id, store_name, store_city) VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune');

INSERT INTO dim_product (product_id, product_name, category) VALUES
(101, 'Speaker', 'ELECTRONICS'),
(102, 'Tablet', 'ELECTRONICS'),
(103, 'Phone', 'ELECTRONICS'),
(104, 'Smartwatch', 'ELECTRONICS'),
(105, 'Atta 10kg', 'GROCERIES'),
(106, 'Jeans', 'CLOTHING'),
(107, 'Biscuits', 'GROCERIES');

INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_revenue) VALUES
('TXN5000', 20230829, 1, 101, 'CUST045', 3, 49262.78, 147788.34),
('TXN5001', 20231212, 1, 102, 'CUST021', 11, 23226.12, 255487.32),
('TXN5002', 20230205, 1, 103, 'CUST019', 20, 48703.39, 974067.80),
('TXN5003', 20230220, 2, 102, 'CUST007', 14, 23226.12, 325165.68),
('TXN5004', 20230115, 1, 104, 'CUST004', 10, 58851.01, 588510.10),
('TXN5005', 20230809, 3, 105, 'CUST027', 12, 52464.00, 629568.00),
('TXN5006', 20230331, 4, 104, 'CUST025', 6, 58851.01, 353106.06),
('TXN5007', 20231026, 4, 106, 'CUST041', 16, 2317.47, 37079.52),
('TXN5008', 20231208, 3, 107, 'CUST030', 9, 27469.99, 247229.91),
('TXN5009', 20231115, 2, 103, 'CUST011', 5, 48703.39, 243516.95);
