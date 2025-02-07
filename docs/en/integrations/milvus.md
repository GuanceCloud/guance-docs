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

- [x] Installed datakit
- [x] Install [Milvus](https://www.bookstack.cn/read/milvus-0.10.0-zh/0895869624c7d37e.md)
- [x] Go to the Milvus `/home/$USER/milvus/conf` directory, modify the `server_config.yaml` file, enable Prometheus monitoring

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
|`CPU_usage_percent`|`CPU usage rate`| % |
|`RAM_usage_percent`|`RAM (Random Access Memory) usage rate`| % |
|`memory_usage_percent`|`Memory usage rate`| % |
|`memory_usage_total`|`Total memory usage`| bytes |
|`add_group_request_total`|`Total number of requests to add groups`| count |
|`add_vectors_request_total`|`The total number of requests to add vectors`| count |
|`get_group_files_request_total`|`The total number of requests to obtain group files`| count |
|`has_group_request_total`|`Check the total number of requests that exist in the inspection group`| count |
|`search_request_total`|`Total number of search requests`| count |
|`add_vector_duration_microseconds_bucket`|`Add bucket distribution of vector operation duration`| microsecond |
|`add_vector_duration_microseconds_count`|`Add count of vector operation duration`| count |
|`add_vector_duration_microseconds_sum`|`Add the total duration of vector operations`| microsecond |
|`all_build_index_duration_microseconds_bucket`|`Build bucket distribution for index operation duration`| microsecond |
|`all_build_index_duration_microseconds_count`|`Total count of duration of index construction operation`| count |
|`all_build_index_duration_microseconds_sum`|`Total duration of index construction operation`| microsecond |
|`add_vectors_throughput_per_microsecond`|`Add vector throughput`| count/μs |
|`query_index_throughtout_per_microsecond`|`Query the throughput of the index`| count/microsecond |
|`query_response_per_microsecond`|`Query response rate`| count/microsecond |
|`query_vector_response_per_microsecond`|`The response rate of query vectors`| count/microsecond |
|`octets_bytes_per_second`|`The number of bytes transmitted per second`| bytes/second |
|`cache_access_total`|`Total cache access count`| count |
|`cache_usage_bytes`|`Cache usage`| bytes |
|`connection_number`|`Number of connections`| count |
|`data_file_size_bytes`|`Data file size`| bytes |
|`disk_load_IO_speed_byte_per_microsec`|`Disk loading I/O speed`| bytes/microsecond |
|`keeping_alive_seconds_total`|`Maintain the total number of seconds for the activity`| seconds |
|`search_data_duration_microseconds_bucket`|`Disk storage I/O speed`| bytes/microsecond |
|`search_data_duration_microseconds_count`|`Disk storage I/O speed`| bytes/microsecond |
|`search_data_duration_microseconds_sum`|`Bucket distribution of search data operation duration`| microsecond |
|`disk_store_IO_speed_bytes_per_microseconds`|`Total count of search data operation duration`| microsecond |
|`disk_store_IO_speed_bytes_per_microseconds`|`Total duration of search data operations`| microsecond |
|`disk_load_size_bytes_bucket`|`Bucket distribution of disk loading data size`| bytes |
|`disk_load_size_bytes_count`|`Bucket count of disk loading data size`| bytes |
|`disk_load_size_bytes_sum`|`The total bucket size of disk loaded data`| bytes |
