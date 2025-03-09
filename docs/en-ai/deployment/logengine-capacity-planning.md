# Log Engine Capacity Planning

Before using Elasticsearch/OpenSearch as the <<< custom_key.brand_name >>> log/tracing storage backend, please evaluate the storage capacity and cluster specifications. This article provides an evaluation algorithm based on community content and actual tests.

???+ warning
    - Due to changes in the Elasticsearch open-source license, we recommend using OpenSearch as a priority;
    - It is suggested to first test the monitoring data generation rate with a smaller configuration of Elasticsearch/OpenSearch, and plan the cluster according to the test results.

## Data Compression

The following are the compression test results for Elasticsearch using the official esrally dataset nyc_taxis, which is 74GB in size.

| Codec Configuration | Compression Algorithm | Compressed Size/GB | Compression Ratio |
|---|---|---|---|
| default | LZ4 | 35.5 | 0.48 |
| best_compression | DEFLATE | 26.4 | 0.36 |

The following are the compression test results for OpenSearch using the eventdata dataset provided by opensearch-benchmark, which is 15GB in size.

| Codec Configuration | Compression Algorithm | Compressed Size/GB | Compression Ratio |
|---|---|---|---|
| default | LZ4 | 5.1 | 0.34 |
| best_compression | DEFLATE | 3.7 | 0.25 |

## Disk Capacity Estimation

Assume the following conditions:

- Daily generation of 【1TB】 monitoring source data
- Compression ratio is 【0.5】
- Each index has 【1】 replica
- Monitoring data retention for the last 【7】 days

Here, we refer to the Tencent Cloud Elasticsearch storage calculation formula.

| Parameter | Reference Value |
|---|---|
| Data Expansion/Index Overhead | 10% |
| Internal Task Overhead | 20% |
| Operating System Reserved | 5% |
| Safety Reserve | 15% |

According to <<< custom_key.brand_name >>>'s data retention policy, we increase the safety reserve to 30%. The original formula is as follows.

```
Actual Space = Source Data x Compression Ratio × (1 + Number of Replicas) × (1 + Data Expansion) / (1 - Internal Task Overhead) / (1 - Operating System Reserved) x (1 + Reserved Space)
```

Substituting the reference values:

```
Actual Space ~= Source Data x Compression Ratio x (1 + Number of Replicas) × 1.89
```

For retaining the most recent 7 days of data, the possible peak value would be:

```
7[day] x 1[TB] x 0.5 x (1 + 1) * 1.89 ~= 13[TB]
```

## Cluster Planning

### Data Nodes

Below is the Elasticsearch cluster planning. The higher the single-node configuration, the larger the cluster scale it can support.

| Single Node Specification | Maximum Number of Cluster Nodes | Maximum Disk Capacity per Node |
|---|---|---|
| 2C4GB | 10 | 200GB |
| 2C8GB | 10 | 400GB |
| 4C16GB | 20 | 800GB |
| 8C32GB | 40 | 1.5TB |
| 16C64GB | 80 | 3TB |

If using a 【4C16GB】 node, based on the above capacity estimation, the recommended number of data nodes in the cluster is:
```
13T / 800G ~= 16
```

If using a 【8C32GB】 node, based on the above capacity estimation, the recommended number of data nodes in the cluster is:
```
13T / 1.5T ~= 9
```

If using a 【16C64GB】 node, based on the above capacity estimation, the recommended number of data nodes in the cluster is:
```
13T / 3T ~= 5
```

### Coordinating Nodes

It is recommended to add independent coordinating nodes at a ratio of 1:5 (starting with at least 2), with a CPU:Memory ratio of 1:4 or 1:8. For example, for 10 8C32GB data nodes, it is recommended to configure 2 independent 8C32GB coordinating nodes. Management nodes should use a highly available deployment of 2n+1 to prevent cluster split-brain.