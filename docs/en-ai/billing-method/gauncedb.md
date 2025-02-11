# Guance Self-developed Time Series Database —— GuanceDB
---

**GuanceDB** is a distributed multimodal time series database developed by Guance, designed to provide a more efficient and comprehensive one-stop storage solution for data storage and querying in observability scenarios.

GuanceDB now supports the storage and querying of metrics data, with support for other types of data currently under active development and will be introduced gradually.

GuanceDB has the following design features:

<div class="grid" markdown>

=== "Flexible Design"
  
    One of the most important features of GuanceDB is its schemaless design, allowing for the writing of any fields and real-time addition or deletion of data fields without manual maintenance of the data model.

    GuanceDB uses a distributed architecture, ensuring high availability on one hand and enabling horizontal scaling of the cluster through dynamic addition or removal of nodes on the other.

=== "Powerful Query Engine"
  
    GuanceDB's query engine is based on the Volcano model, supporting stream-based batch computation, which can achieve unlimited raw data computation. We also accelerate queries using SIMD instruction sets, achieving peak performance of tens of billions of rows per second on a single machine.

    In addition to supporting Guance's proprietary multimodal query language DQL, GuanceDB is also compatible with Prometheus' PromQL. Users can choose their preferred query syntax to query the same dataset.

=== "High-performance Metrics Engine"
  
    The metrics engine in GuanceDB excels in write, query performance, and storage compression efficiency. Compared to the time series database InfluxDB previously used by Guance, write performance has improved threefold, storage space usage has decreased threefold, and query performance has improved by over 30 times.

    GuanceDB optimizes the handling of high-cardinality metrics during writes and queries, ensuring that high cardinality does not affect database stability.

    GuanceDB continues to support Guance’s feature of configuring storage policies at the metrics set granularity, allowing users to configure shorter retention periods for large but relatively temporary metrics. This not only releases storage space faster to reduce resource costs but also accelerates queries.


We would like to thank the open-source project VictoriaMetrics for its inspiration and assistance to GuanceDB. Guance will continue to strive to provide users with higher quality observability solutions. We sincerely invite you to follow the development of GuanceDB and witness our growth together.