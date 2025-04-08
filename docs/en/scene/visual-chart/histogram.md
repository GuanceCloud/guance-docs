# Histogram
---

A histogram, also known as a quality distribution chart, is used to represent the distribution of data and is a common type of statistical graph. Typically, the horizontal axis represents data intervals, and the vertical axis represents the distribution situation. The shape of the chart resembles a bar chart, where taller bars indicate a greater quantity of data falling within that interval.


Histograms only support log-type data and can be used to represent the distribution of `number` type data stored in Elasticsearch, including data queries for "LOG", "Base Objects", "Resource Catalogs", "Events", "Application Performance", "User Access", "Security Check", "NETWORK", and "Profile". If the workspace uses SLS storage, data queries will result in an error.

![](../img/histogram.png)




## Chart Query

Supports **simple queries**, **expression queries**, **PromQL queries**, and **data source queries**.

> For more detailed explanations of chart query conditions, refer to [Chart Query](chart-query.md).


> For more information on storage, refer to [Data Storage Strategy](../../billing-method/data-storage.md#options).



## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).