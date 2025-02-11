# Log Engine Capacity Planning

Before using Elasticsearch/OpenSearch as the backend for Guance log/tracing storage, please evaluate the storage capacity and cluster specifications. This article provides an estimation algorithm based on community content and actual tests.

???+ warning
    - Due to the change in Elasticsearch's open-source license, it is recommended to prioritize OpenSearch;
    - It is suggested to first test the monitoring data generation rate with a smaller Elasticsearch/OpenSearch setup and plan the cluster based on the test results.

## Data Compression

The following table shows the compression test results for Elasticsearch using the official esrally dataset `nyc_taxis`, which is 74GB in size.

| Codec Configuration | Compression Algorithm | Compressed Size (GB) | Compression Ratio |
|---|---|---|---|
| default | LZ4 | 35.5 | 0.48 |
| best_compression | DEFLATE | 26.4 | 0.36 |

The following table shows the compression test results for OpenSearch using the `opensearch-benchmark` dataset `eventdata`, which is 15GB in size.

| Codec Configuration | Compression Algorithm | Compressed Size (GB) | Compression Ratio |
|---|---|---|---|
| default | LZ4 | 5.1 | 0.34 |
| best_compression | DEFLATE | 3.7 | 0.25 |

## Disk Capacity Estimation

Assume the following conditions:

- Daily generation of **1TB** of raw monitoring data
- Compression ratio of **0.5**
- Each index has **1** replica
- Monitoring data retention for the last **7** days

Here we refer to Tencent Cloud Elasticsearch storage calculation formula.

| Parameter | Reference Value |
|---|---|
| Data Expansion/Index Overhead | 10% |
| Internal Task Overhead | 20% |
| Operating System Reserved | 5% |
| Safety Reserve | 15% |

According to Guance's data retention policy, we increase the safety reserve to 30%. The original formula is as follows.

```
Actual Space = Raw Data × Compression Ratio × (1 + Number of Replicas) × (1 + Data Expansion) / (1 - Internal Task Overhead) / (1 - Operating System Reserved) × (1 + Reserved Space)
```

Substituting the reference values:

```
Actual Space ≈ Raw Data × Compression Ratio × (1 + Number of Replicas) × 1.89
```

If retaining data for the last 7 days, the possible peak value would be:

```
7[day] × 1[TB] × 0.5 × (1 + 1) * 1.89 ≈ 13[TB]
```

## Cluster Planning

### Data Nodes

Below is the Elasticsearch cluster planning. Higher single-node configurations can support larger cluster scales.

| Single Node Specification | Maximum Number of Cluster Nodes | Maximum Disk Capacity per Node |
|---|---|---|
| 2C4GB | 10 | 200GB |
| 2C8GB | 10 | 400GB |
| 4C16GB | 20 | 800GB |
| 8C32GB | 40 | 1.5TB |
| 16C64GB | 80 | 3TB |

If using nodes with **4C16GB**, according to the above capacity estimation, the recommended number of data nodes in the cluster is:
```
13T / 800G ≈ 16
```

If using nodes with **8C32GB**, according to the above capacity estimation, the recommended number of data nodes in the cluster is:
```
13T / 1.5T ≈ 9
```

If using nodes with **16C64GB**, according to the above capacity estimation, the recommended number of data nodes in the cluster is:
```
13T / 3T ≈ 5
```

### Coordinating Nodes

It is recommended to add independent coordinating nodes at a ratio of 1:5 (minimum of 2), with CPU:Memory ratios of 1:4 or 1:8. For example, for 10 data nodes with 8C32GB configuration, it is recommended to configure 2 independent coordinating nodes with 8C32GB. Management nodes should be deployed in a highly available configuration of 2n+1 to prevent cluster split-brain.