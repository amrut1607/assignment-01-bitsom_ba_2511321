## ETL Decisions

### Decision 1 — Date Format Standardization
Problem: The raw `retail_transactions.csv` dataset contains highly inconsistent date formats (e.g., `29/08/2023`, `12-12-2023`, and `2023-02-05`). A data warehouse requires a strict, uniform date format to join effectively with the `dim_date` dimension table.
Resolution: During the ETL process, I implemented a transformation step using standard string parsing/regex to identify the local format and cast every value to standard ISO `YYYY-MM-DD` before loading it into the `fact_sales` and `dim_date` tables.

### Decision 2 — Categorical Value Casing & Synonyms
Problem: The category column contained case-inconsistent values and synonyms (e.g., `electronics` vs `Electronics`, and `Grocery` vs `Groceries`). If loaded directly, analytical queries grouping by category would split these into separate rows, corrupting the revenue reports.
Resolution: I applied an UPPER() transformation to all category strings to standardize casing. Additionally, I added a mapping rule to normalize synonyms (e.g., mapping `GROCERY` to `GROCERIES`) to ensure a singular source of truth in the `dim_product` table.

### Decision 3 — Handling Missing/Anomalous Identifiers
Problem: Raw transactional data occasionally contains null values for foreign keys or measures (like `unit_price` or `units_sold` being negative or null due to system glitches).
Resolution: In the ETL pipeline, any rows with a NULL `customer_id` or `product_name` were routed to an "Unknown" dimension bucket (e.g., an ID of -1) rather than dropped, preserving the total revenue aggregate. Any negative quantities were flagged and filtered out of the operational data warehouse load.
