---
title     : 'Milvus Vector Database'
summary   : 'Collect metrics information related to Milvus vector database'
__int_icon: 'icon/milvus'
dashboard :
  - desc  : 'Milvus Monitoring View'
    path  : 'dashboard/en/milvus'
monitor   :
  - desc  : 'Milvus Monitor'
    path  : 'monitor/en/milvus'
---

Collect metrics information related to Milvus vector database

## Configuration {#config}

### Prerequisites {#requirement}

- [x] DataKit is installed
- [x] Install [Milvus](https://www.bookstack.cn/read/milvus-0.10.0-zh/0895869624c7d37e.md)

### Enable Milvus Monitoring

Enter the Milvus `/home/$USER/milvus/conf` directory, modify the `server_config.yaml` file, and enable Milvus monitoring

```yaml
metric:
  enable: true
  address: 127.0.0.1 
  port: 9091
```

Note: If Milvus is deployed in a Docker container, the above address should be changed to the host machine IP.

- After modification, restart Milvus and check the monitoring data via `http://localhost:9091/metrics`

### Configure DataKit

- Enter the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample` and name it `milvus.conf`

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
<font color="red">*Other configurations can be adjusted as needed*</font>, parameter adjustment description:
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls: Metrics addresses, fill in the corresponding component exposed metrics url here
- source: Collector alias, recommended for differentiation
- keep_exist_metric_name: Keep metric names
- interval: Collection interval
- inputs.prom.tags: Add extra tags
<!-- markdownlint-enable -->

Restart DataKit by executing the following command

```shell
datakit service -R
```

## Metrics {#metric}

### Milvus Metric Sets

Milvus metrics are located under the Milvus metric sets, here we introduce the relevant descriptions of Milvus metrics

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`ann_iterator_init_latency_bucket`|`Distribution bucket for ANN iterator initialization latency`| s |
|`bitset_ratio_bucket`|`Distribution bucket for bitset ratio`| s |
|`build_latency_bucket`|`Distribution bucket for index build latency`| s |
|`build_latency_count`|`Count of index build latency`| count |
|`build_latency_sum`|`Sum of index build latency`| s |
|`search_latency_bucket`|`Distribution bucket for search latency`| s |
|`search_latency_count`|`Count of search latency`| count |
|`search_latency_sum`|`Sum of search latency`| count |
|`search_topk_bucket`|`Distribution bucket for search topk`| s |
|`search_topk_count`|`Count of search topk`| count |
|`search_topk_sum`|`Sum of search topk`| count |
|`milvus_datanode_consume_msg_count`|`Number of messages consumed by data nodes`| count |
|`milvus_datanode_flush_buffer_op_count`|`Number of buffer flush operations by data nodes`| count |
|`milvus_datanode_msg_rows_count`|`Number of message rows by data nodes`| count |
|`milvus_querynode_consume_tt_lag_ms`|`Time lag for query node consumption`| microsecond |
|`milvus_querynode_disk_used_size`|`Disk usage size for query nodes`| bytes |
|`milvus_querynode_entity_num`|`Number of entities for query nodes`| count |
|`milvus_querynode_entity_size`|`Entity size for query nodes`| bytes |
|`milvus_querynode_search_group_nq_bucket`|`Distribution bucket for search group queries on query nodes`| s |
|`milvus_querynode_search_group_nq_count`|`Count of search group queries on query nodes`| count |
|`milvus_querynode_search_group_nq_sum`|`Sum of search group queries on query nodes`| count |
|`milvus_proxy_req_count`|`Number of proxy requests`| count |
|`milvus_proxy_req_latency_bucket`|`Distribution bucket for proxy request latency`| s |
|`milvus_proxy_req_latency_count`|`Count of proxy request latency`| count |
|`milvus_proxy_req_latency_sum`|`Sum of proxy request latency`| s |
|`milvus_proxy_search_vectors_count`|`Number of vector searches by proxy`| count |
|`milvus_proxy_send_bytes_count`|`Number of bytes sent by proxy`| bytes |
|`milvus_rootcoord_collection_num`|`Number of collections coordinated by root`| count |
|`milvus_rootcoord_ddl_req_count`|`Number of DDL requests coordinated by root`| count |
|`milvus_rootcoord_ddl_req_latency_bucket`|`Distribution bucket for DDL request latency coordinated by root`| s |
|`milvus_rootcoord_ddl_req_latency_count`|`Count of DDL request latency coordinated by root`| count |
|`milvus_rootcoord_ddl_req_latency_sum`|`Sum of DDL request latency coordinated by root`| s |
|`milvus_rootcoord_entity_num`|`Number of entities coordinated by root`| count |
|`milvus_rootcoord_partition_num`|`Number of partitions coordinated by root`| count |
|`milvus_rootcoord_produce_tt_lag_ms`|`Time lag for production coordinated by root`| microsecond |
|`milvus_storage_kv_size_bucket`|`Distribution bucket for key-value pair sizes in Milvus storage`| bytes |
|`milvus_storage_kv_size_count`|`Count of key-value pair sizes in Milvus storage`| count |
|`milvus_storage_kv_size_sum`|`Sum of key-value pair sizes in Milvus storage`| bytes |
|`milvus_storage_op_count`|`Number of operations in Milvus storage`| count |
|`milvus_storage_request_latency_bucket`|`Distribution bucket for request latency in Milvus storage`| s |
|`milvus_storage_request_latency_count`|`Count of request latency in Milvus storage`| count |
|`milvus_storage_request_latency_sum`|`Sum of request latency in Milvus storage`| s |
|`milvus_num_node`|`Number of Milvus nodes`| count |
|`milvus_runtime_info`|`Runtime information for Milvus`| - |
|`process_max_fds`|`Maximum number of file descriptors for process`| count |
|`process_open_fds`|`Number of open file descriptors for process`| count |
|`process_start_time_seconds`|`Start time for process`| s |
|`process_virtual_memory_bytes`|`Virtual memory bytes for process`| bytes |
|`process_virtual_memory_max_bytes`|`Maximum virtual memory bytes for process`| bytes |
