## Storage Systems

For the hospital network's AI-powered data system, I have designed a hybrid architecture utilizing purpose-built storage systems for each goal:

1. **Transactional Database (PostgreSQL):** Used for storing historical treatment data and managing ongoing patient records. As a relational OLTP database, it ensures ACID compliance, which is non-negotiable for critical health records avoiding data corruption.
2. **Vector Database (Pinecone/Milvus):** Used enabling doctors to query patient history in plain English. The Vector DB stores unstructured clinic notes and treatment summaries as high-dimensional embeddings. It powers Semantic Search and Retrieval-Augmented Generation (RAG) by fetching contextually relevant patient history based on meaning rather than mere exact keywords.
3. **Data Warehouse (Snowflake/BigQuery):** Used for generating structured monthly reports (bed occupancy, department costs) for hospital management. This is an OLAP system designed to aggregate, group, and analyze massive volumes of historical data efficiently using a star schema.
4. **Time-Series Database / Message Broker (InfluxDB / Apache Kafka):** Used to stream and store real-time vitals from ICU monitoring devices. Time-series databases are specifically optimized for high-throughput, timestamp-heavy ingestion patterns, making them ideal for IoT medical device telemetry.

## OLTP vs OLAP Boundary

In this architecture, the boundary between the transactional system (OLTP) and analytical system (OLAP) is sharply defined by the **Data Integration / ETL Pipeline**.

The OLTP systems include the core Hospital Information System (HIS) running on PostgreSQL and the real-time ICU vitals streaming into InfluxDB. These systems are highly optimized for fast, discrete inserts and updates (e.g., admitting a patient, updating a sensor reading). 

The boundary is crossed when data is extracted from these operational systems, structurally transformed, and loaded into the **Data Warehouse (OLAP)**. Operations in the Data Warehouse are decoupled from the transactional databases; thus, complex, resource-heavy aggregations (like calculating the average readmission rate by department over 5 years) do not degrade the performance of the life-critical ICU monitors or patient intake forms.

## Trade-offs

One significant trade-off in this design is **System Complexity vs. Specialized Performance**. By using Polyglot Persistence—a different database for relational data, vectors, time-series, and warehousing—we achieve optimal performance for each specific workload. However, this dramatically increases the operational complexity, infrastructure costs, and the risk of data synchronization failures across the pipeline.

**Mitigation:** To mitigate this, I would implement an event-driven architecture using **Apache Kafka** acting as a central nervous system. Instead of brittle point-to-point batch ETLs, every change in patient status or new ICU reading becomes an event stream. The Data Warehouse, Vector DB, and ML predictive models can act as independent consumers of this central stream, ensuring they remain decoupled, eventually consistent, and highly resilient to single-component failures.
