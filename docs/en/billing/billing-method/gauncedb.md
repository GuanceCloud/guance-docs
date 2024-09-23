# Guance's Self-Developed Timeseries Database —— GuanceDB
---

**GuanceDB** is a distributed multi-mode time-series database developed by Guance, aiming to provide a more efficient and comprehensive one-stop storage solution for observable data storage and querying.

Currently, GuanceDB has launched its support for storing and querying metric data, and other types of storage support are also vigorously under development and will be introduced to you one after another.

GuanceDB possesses the following features in its design:

**Flexible Design**

In its design, GuanceDB regards Schemaless as one of the most important features. We can support the writing of any field and also enable the real-time addition and deletion of data fields, without the need to manually maintain the data model.

GuanceDB is deployed with a distributed architecture, which can ensure its high availability and also achieve horizontal expansion of the cluster through dynamic addition and deletion of nodes.

**Powerful Query Engine**

GuanceDB's query is based on the volcano model, supporting stream batch computation, and can achieve unlimited raw data computation. We also use SIMD instruction set to accelerate the query, and the maximum computing performance of a single machine can reach tens of billions of rows per second.

In addition to supporting the multi-mode query language DQL syntax developed by Guance, GuanceDB also supports compatibility with Prometheus's PromQL. After writing the data, users can freely choose the syntax they prefer to query.


**High Performance Metric Engine**

GuanceDB's metric engine exhibits excellent performance in terms of writing, querying, and storage compression efficiency. Compared with the time-series database InfluxDB used by Guance previously, the writing performance has increased by three times, the storage space occupancy has decreased by three times, and the querying performance has increased by more than thirty times.

GuanceDB's metric engine is optimized for high-cardinality metrics in writing and querying, and users can use it without worrying about the impact of high cardinality on the stability of the database.

GuanceDB also continues to support the function of configuring data storage strategies for metric sets granularity, which can support users to configure shorter retention periods for metrics that are large in quantity but relatively temporary. This not only enables faster release of storage space to reduce resource overhead, but also speeds up querying.

We sincerely thank the open-source project VictoriaMetrics for its inspiration and help to GuanceDB. Guance will continue to work hard to provide users with better observable solutions. We sincerely invite you to pay attention to the development process of GuanceDB and witness our growth together.

