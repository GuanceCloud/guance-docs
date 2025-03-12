# <<< custom_key.brand_name >>> Self-developed Time Series Database —— GuanceDB
---

**GuanceDB** is a distributed multimodal time series database developed by <<< custom_key.brand_name >>>, designed to provide a more efficient and comprehensive one-stop storage solution for data storage and querying in observability scenarios.

GuanceDB now supports the storage and querying of metrics data, with support for other types of data currently under active development and will be introduced to users gradually.

GuanceDB features the following characteristics in its design:

<div class="grid" markdown>

=== "Flexible Design"
  
    One of the most important features of GuanceDB's design is Schemaless, allowing for the writing of any fields and real-time addition or deletion of data fields without manual maintenance of the data model.

    GuanceDB uses a distributed architecture, ensuring high availability on one hand, and enabling horizontal scaling of the cluster through dynamic addition or removal of nodes on the other.

=== "Powerful Query Engine"
  
    GuanceDB queries are based on the volcano model, supporting stream processing in batches, which can achieve unlimited raw data computation. We also accelerate queries using SIMD instruction sets, reaching peak performance of tens of billions of rows per second on a single machine.

    In addition to supporting <<< custom_key.brand_name >>>'s self-developed multimodal query language DQL, GuanceDB is also compatible with Prometheus's PromQL. Users can write data once and freely choose their preferred syntax for querying.

=== "High-performance Metrics Engine"
  
    The metrics engine in GuanceDB excels in write performance, query performance, and storage compression efficiency. Compared to the time series database InfluxDB previously used by <<< custom_key.brand_name >>>, the write performance has improved threefold, storage space usage has been reduced threefold, and query performance has increased by over 30 times.

    The metrics engine in GuanceDB has been optimized for high-cardinality metrics during writes and queries, ensuring that high cardinality does not affect database stability.

    GuanceDB continues to support <<< custom_key.brand_name >>>'s feature of configuring storage policies at the measurement granularity level, allowing users to set shorter retention periods for large but relatively temporary metrics. This not only releases storage space faster to reduce resource costs but also accelerates queries.


We would like to express our sincere gratitude to the VictoriaMetrics open-source project for its inspiration and assistance to GuanceDB. <<< custom_key.brand_name >>> will continue to strive to provide users with higher-quality observability solutions. We sincerely invite you to follow the development of GuanceDB and witness our growth together.