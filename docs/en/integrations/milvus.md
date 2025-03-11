---
title     : 'Milvus Vector Database'
summary   : 'Collect metrics related to the Milvus vector database'
__int_icon: 'icon/milvus'
dashboard :
  - desc  : 'Milvus Monitoring View'
    path  : 'dashboard/en/milvus'
monitor   :
  - desc  : 'Milvus Monitor'
    path  : 'monitor/en/milvus'
---

Collect metrics related to the Milvus vector database

## Configuration {#config}

### Prerequisites {#requirement}

- [x] DataKit is installed
- [x] Install [Milvus](https://www.bookstack.cn/read/milvus-0.10.0-zh/0895869624c7d37e.md)

### Enable Milvus Monitoring

Enter the Milvus `/home/$USER/milvus/conf` directory, modify the `server_config.yaml` file to enable Milvus monitoring

```yaml
metric:
  enable: true
  address: 127.0.0.1 
  port: 9091
```

Note: If Milvus is deployed in a Docker container, the above address should be changed to the host machine IP.

- After modification, restart Milvus and view the monitoring data via `http://localhost:9091/metrics`

### Configure DataKit

- Go to the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample` and rename it to `milvus.conf`

```shell
cp prom.conf.sample milvus.conf
```

- Adjust the content of `milvus.conf` as follows:

```yaml
## Exporter URLs.
  urls = ["http://127.0.0.1:9091/metrics"]

  ## Stream Size. 
  ## The source stream segmentation size, (defaults to 1).
  ## 0 source stream undivided. 
  stream_size = 1

  ## Unix Domain Socket URL. Using socket to request data when not empty.
  uds_path = ""

  ## Ignore URL request errors.
  ignore_req_err = false

  ## Collector alias.
  source = "milvus"

  ## Measurement prefix.
  ## Add prefix to measurement set name.
  measurement_prefix = ""
  measurement_name = "milvus"

  ## (Optional) Collect interval: (defaults to "30s").
  interval = "30s"

  # [inputs.prom.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>, parameter adjustment instructions:
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls: Metrics address, fill in the metric URL exposed by the corresponding component
- source: Collector alias, recommended for differentiation
- keep_exist_metric_name: Keep metric names
- interval: Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

Restart DataKit, execute the following command

```shell
datakit service -R
```

## Metrics {#metric}

### Milvus Measurement Set

Milvus metrics are located under the Milvus measurement set. Here is an introduction to Milvus metrics

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`ann_iterator_init_latency_bucket`| Distribution bucket for ANN iterator initialization latency | s |
|`bitset_ratio_bucket`| Distribution bucket for bitset ratio | s |
|`build_latency_bucket`| Distribution bucket for index build latency | s |
|`build_latency_count`| Count of index build latency | count |
|`build_latency_sum`| Sum of index build latency | s |
|`search_latency_bucket`| Distribution bucket for search latency | s |
|`search_latency_count`| Count of search latency | count |
|`search_latency_sum`| Sum of search latency | count |
|`search_topk_bucket`| Distribution bucket for search topk | s |
|`search_topk_count`| Count of search topk | count |
|`search_topk_sum`| Sum of search topk | count |
|`milvus_datanode_consume_msg_count`| Number of messages consumed by the data node | count |
|`milvus_datanode_flush_buffer_op_count`| Number of buffer flush operations by the data node | count |
|`milvus_datanode_msg_rows_count`| Number of message rows processed by the data node | count |
|`milvus_querynode_consume_tt_lag_ms`| Time lag in consuming messages by the query node | microsecond |
|`milvus_querynode_disk_used_size`| Disk usage size by the query node | bytes |
|`milvus_querynode_entity_num`| Number of entities in the query node | count |
|`milvus_querynode_entity_size`| Size of entities in the query node | bytes |
|`milvus_querynode_search_group_nq_bucket`| Distribution bucket for search group queries in the query node | s |
|`milvus_querynode_search_group_nq_count`| Count of search group queries in the query node | count |
|`milvus_querynode_search_group_nq_sum`| Sum of search group queries in the query node | count |
|`milvus_proxy_req_count`| Number of proxy requests | count |
|`milvus_proxy_req_latency_bucket`| Distribution bucket for proxy request latency | s |
|`milvus_proxy_req_latency_count`| Count of proxy request latency | count |
|`milvus_proxy_req_latency_sum`| Sum of proxy request latency | s |
|`milvus_proxy_search_vectors_count`| Number of vector searches by the proxy | count |
|`milvus_proxy_send_bytes_count`| Number of bytes sent by the proxy | bytes |
|`milvus_rootcoord_collection_num`| Number of collections in the root coordinator | count |
|`milvus_rootcoord_ddl_req_count`| Number of DDL requests in the root coordinator | count |
|`milvus_rootcoord_ddl_req_latency_bucket`| Distribution bucket for DDL request latency in the root coordinator | s |
|`milvus_rootcoord_ddl_req_latency_count`| Count of DDL request latency in the root coordinator | count |
|`milvus_rootcoord_ddl_req_latency_sum`| Sum of DDL request latency in the root coordinator | s |
|`milvus_rootcoord_entity_num`| Number of entities in the root coordinator | count |
|`milvus_rootcoord_partition_num`| Number of partitions in the root coordinator | count |
|`milvus_rootcoord_produce_tt_lag_ms`| Time lag in producing messages by the root coordinator | microsecond |
|`milvus_storage_kv_size_bucket`| Distribution bucket for key-value pair sizes in Milvus storage | bytes |
|`milvus_storage_kv_size_count`| Count of key-value pair sizes in Milvus storage | count |
|`milvus_storage_kv_size_sum`| Sum of key-value pair sizes in Milvus storage | bytes |
|`milvus_storage_op_count`| Number of operations in Milvus storage | count |
|`milvus_storage_request_latency_bucket`| Distribution bucket for request latency in Milvus storage | s |
|`milvus_storage_request_latency_count`| Count of request latency in Milvus storage | count |
|`milvus_storage_request_latency_sum`| Sum of request latency in Milvus storage | s |
|`milvus_num_node`| Number of nodes in Milvus | count |
|`milvus_runtime_info`| Runtime information of Milvus | - |
|`process_max_fds`| Maximum number of file descriptors for the process | count |
|`process_open_fds`| Number of open file descriptors for the process | count |
|`process_start_time_seconds`| Start time of the process | s |
|`process_virtual_memory_bytes`| Virtual memory bytes for the process | bytes |
|`process_virtual_memory_max_bytes`| Maximum virtual memory bytes for the process | bytes |
