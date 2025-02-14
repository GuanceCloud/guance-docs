---
title     : 'Milvus vector database'
summary   : 'Collect relevant metric information of Mlivus vector database'
__int_icon: 'icon/milvus'
dashboard :
  - desc  : 'Milvus Monitoring View'
    path  : 'dashboard/en/milvus'
monitor   :
  - desc  : 'Milvus Monitor'
    path  : 'monitor/en/milvus'
---

Collect relevant metric information of Mlivus vector database

## Config {#config}

### Preconditions {#requirement}

- [x] Installed DataKit
- [x] Install [Milvus](https://www.bookstack.cn/read/milvus-0.10.0-zh/0895869624c7d37e.md)

### Enable Milvus monitoring

Go to the Milvus `/home/$USER/milvus/conf` directory, modify the `server_config.yaml` file, enable Milvus monitoring

```yaml
metric:
  enable: true
  address: 127.0.0.1 
  port: 9091
```

Note: If milvus is deployed in a Docker container, the above address should be changed to the host IP address

- After modification, restart Milvus `http://localhost:9091/metrics` View monitoring data

### Configure Datakit

- Go to the `conf.d/prom` directory under the datakit installation directory, copy `prom.conf.sample` and name it `milvus.conf`

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
<font color="red">*Adjust other configurations as needed*</font>，parameter adjustment instructions ：
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls：Metric address, fill in the URL of the metric exposed by the corresponding component here
- source：Collector alias, it is recommended to make a distinction
- keep_exist_metric_name: Maintain metric name
- interval：Collection interval
- inputs.prom.tags: Add additional tags
<!-- markdownlint-enable -->

Restart the datakit and execute the following command

```shell
datakit service -R
```

## Metric {#metric}

### Milvus Metric set

The Milvus metric is located under the milvus metric set. Here are the relevant explanations for the Milvus metric

| Metrics | description | unit |
|:--------|:------------|:-----|
|`ann_iterator_init_latency_bucket`|`Delay distribution bucket for initialization of ANN iterators`| s |
|`bitset_ratio_bucket`|`Distribution bucket of bitset ratio`| s |
|`build_latency_bucket`|`Distributed Bucket with Index Construction Delay`| s |
|`build_latency_count`|`Count of index construction delay`| count |
|`build_latency_sum`|`The total delay in index construction`| s |
|`search_latency_bucket`|`Distribution bucket of search delay`| s |
|`search_latency_count`|`Count of Search Delay`| count |
|`search_latency_sum`|`Total search latency`| count |
|`search_topk_bucket`|`Search for the distribution bucket of topk`| s |
|`search_topk_count`|`Search for topk counts`| count |
|`search_topk_sum`|`Search for the total sum of topk`| count |
|`milvus_datanode_consume_msg_count`|`The number of messages consumed by data nodes`| count |
|`milvus_datanode_flush_buffer_op_count`|`Number of buffer refresh operations for data nodes`| count |
|`milvus_datanode_msg_rows_count`|`Number of message lines in data nodes`| count |
|`milvus_querynode_consume_tt_lag_ms`|`Query the time lag of node consumption`| microsecond |
|`milvus_querynode_disk_used_size`|`Query the size of the node disk usage`| bytes |
|`milvus_querynode_entity_num`|`Query the number of node entities`| count |
|`milvus_querynode_entity_size`|`Query node entity size`| bytes |
|`milvus_querynode_search_group_nq_bucket`|`Distribution Bucket for Query Node Search Group Query Count`| s |
|`milvus_querynode_search_group_nq_count`|`Count the number of node search group queries`| count |
|`milvus_querynode_search_group_nq_sum`|`Total number of node search group queries`| count |
|`milvus_proxy_req_count`|`Proxy request frequency`| count |
|`milvus_proxy_req_latency_bucket`|`Distribution bucket for proxy request delay`| s |
|`milvus_proxy_req_latency_count`|`Count of proxy request delays`| count |
|`milvus_proxy_req_latency_sum`|`The total delay of proxy requests`| s |
|`milvus_proxy_search_vectors_count`|`Proxy search vector count`| count |
|`milvus_proxy_send_bytes_count`|`Number of bytes sent by proxys`| bytes |
|`milvus_rootcoord_collection_num`|`Root coordination set quantity`| count |
|`milvus_rootcoord_ddl_req_count`|`Root coordination DDL request frequency`| count |
|`milvus_rootcoord_ddl_req_latency_bucket`|`Distributed Bucket for Root Coordination DDL Request Delay`| s |
|`milvus_rootcoord_ddl_req_latency_count`|`Count of root coordination DDL request delays`| count |
|`milvus_rootcoord_ddl_req_latency_sum`|`The total delay of root coordination DDL requests`| s |
|`milvus_rootcoord_entity_num`|`Number of root coordination entities`| count |
|`milvus_rootcoord_partition_num`|`Number of root coordination partitions`| count |
|`milvus_rootcoord_produce_tt_lag_ms`|`Root coordination production time lag`| microsecond |
|`milvus_storage_kv_size_bucket`|`Milvus stores the distribution bucket of key value pair sizes`| bytes |
|`milvus_storage_kv_size_count`|`Milvus stores the count of key value pair sizes`| count |
|`milvus_storage_kv_size_sum`|`Milvus stores the total size of key value pairs`| bytes |
|`milvus_storage_op_count`|`Milvus storage operation times`| count |
|`milvus_storage_request_latency_bucket`|`Milvus Storage Request Delay Distribution Bucket`| s |
|`milvus_storage_request_latency_count`|`Milvus Storage Request Delay Count`| count |
|`milvus_storage_request_latency_sum`|`The total delay of Milvus storage requests`| s |
|`milvus_num_node`|`Number of Milvus nodes`| count |
|`milvus_runtime_info`|`Milvus runtime information`| - |
|`process_max_fds`|`Maximum number of file descriptors for a process`| count |
|`process_open_fds`|`Number of file descriptors opened by the process`| count |
|`process_start_time_seconds`|`Process start time`| s |
|`process_virtual_memory_bytes`|`Number of bytes in virtual memory of the process`| bytes |
|`process_virtual_memory_max_bytes`|`Maximum bytes of process virtual memory`| bytes |
