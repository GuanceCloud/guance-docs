---
title     : 'Milvus 向量数据库'
summary   : '采集 Mlivus 向量数据库相关指标信息'
__int_icon: 'icon/milvus'
dashboard :
  - desc  : 'Milvus 监控视图'
    path  : 'dashboard/zh/milvus'
monitor   :
  - desc  : 'Milvus 监控器'
    path  : 'monitor/zh/milvus'
---

采集 Mlivus 向量数据库相关指标信息

## 配置 {#config}

### 前置条件 {#requirement}

- [x] 已安装 DataKit
- [x] 安装 [Milvus](https://www.bookstack.cn/read/milvus-0.10.0-zh/0895869624c7d37e.md)

### 开启 Milvus 监控

进入 Milvus `/home/$USER/milvus/conf` 目录，修改 `server_config.yaml` 文件，开启 Milvus 监控

```yaml
metric:
  enable: true
  address: 127.0.0.1 
  port: 9091
```

注意：如果 milvus 部署在Docker容器中，上述 address 地址应修改为宿主机IP

- 修改后重启 Milvus，通过`http://localhost:9091/metrics`查看监控数据

### 配置 DataKit

- 进入 datakit 安装目录下的 `conf.d/prom` 目录，复制 `prom.conf.sample` 并命名为 `milvus.conf`

```shell
cp prom.conf.sample milvus.conf
```

- 调整 `milvus.conf` 内容如下：

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
<font color="red">*其他配置按需调整*</font>，调整参数说明 ：
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls：指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- keep_exist_metric_name: 保持指标名称
- interval：采集间隔
- inputs.prom.tags: 新增额外的 tag
<!-- markdownlint-enable -->

重启 datakit,执行以下命令

```shell
datakit service -R
```

## 指标 {#metric}

### Milvus 指标集

Milvus 指标位于 milvus 指标集下，这里介绍 Milvus 指标相关说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`CPU_usage_percent`|`CPU 使用率`| % |
|`RAM_usage_percent`|`RAM（随机存取存储器）使用率`| % |
|`memory_usage_percent`|`内存使用率`| % |
|`memory_usage_total`|`总内存使用量`| bytes |
|`add_group_request_total`|`添加组的请求总数`| count |
|`add_vectors_request_total`|`添加向量的请求总数`| count |
|`get_group_files_request_total`|`获取组文件的请求总数`| count |
|`has_group_request_total`|`检查组存在的请求总数`| count |
|`search_request_total`|`搜索请求总数`| count |
|`add_vector_duration_microseconds_bucket`|`添加向量操作持续时间的桶分布`| microsecond |
|`add_vector_duration_microseconds_count`|`添加向量操作持续时间的计数`| count |
|`add_vector_duration_microseconds_sum`|`添加向量操作持续时间的总和`| microsecond |
|`all_build_index_duration_microseconds_bucket`|`构建索引操作持续时间的桶分布`| microsecond |
|`all_build_index_duration_microseconds_count`|`构建索引操作持续时间计数总和`| count |
|`all_build_index_duration_microseconds_sum`|`构建索引操作持续时间总和`| microsecond |
|`add_vectors_throughput_per_microsecond`|`添加向量的吞吐量`| count/μs |
|`query_index_throughtout_per_microsecond`|`查询索引的吞吐量`| count/microsecond |
|`query_response_per_microsecond`|`查询响应的速率`| count/microsecond |
|`query_vector_response_per_microsecond`|`查询向量响应的速率`| count/microsecond |
|`octets_bytes_per_second`|`每秒传输的字节数`| bytes/second |
|`cache_access_total`|`缓存访问总数`| count |
|`cache_usage_bytes`|`缓存使用量`| bytes |
|`connection_number`|`连接数`| count |
|`data_file_size_bytes`|`数据文件大小`| bytes |
|`disk_load_IO_speed_byte_per_microsec`|`磁盘加载 I/O 速度`| bytes/microsecond |
|`keeping_alive_seconds_total`|`保持活动的总秒数`| seconds |
|`search_data_duration_microseconds_bucket`|`磁盘存储 I/O 速度`| bytes/microsecond |
|`search_data_duration_microseconds_count`|`磁盘存储 I/O 速度`| bytes/microsecond |
|`search_data_duration_microseconds_sum`|`搜索数据操作持续时间的桶分布`| microsecond |
|`disk_store_IO_speed_bytes_per_microseconds`|`搜索数据操作持续时间计数总和`| microsecond |
|`disk_store_IO_speed_bytes_per_microseconds`|`搜索数据操作持续时间总和`| microsecond |
|`disk_load_size_bytes_bucket`|`磁盘加载数据大小的桶分布`| bytes |
|`disk_load_size_bytes_count`|`磁盘加载数据大小的桶计数`| bytes |
|`disk_load_size_bytes_sum`|`磁盘加载数据大小的桶总和`| bytes |
