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
|`ann_iterator_init_latency_bucket`|`ANN迭代器初始化的延迟分布桶`| s |
|`bitset_ratio_bucket`|`bitset 比例的分布桶`| s |
|`build_latency_bucket`|`索引构建延迟的分布桶`| s |
|`build_latency_count`|`索引构建延迟的计数`| count |
|`build_latency_sum`|`索引构建延迟的总和`| s |
|`search_latency_bucket`|`搜索延迟的分布桶`| s |
|`search_latency_count`|`搜索延迟的计数`| count |
|`search_latency_sum`|`搜索延迟的总和`| count |
|`search_topk_bucket`|`搜索 topk 的分布桶`| s |
|`search_topk_count`|`搜索 topk 的计数`| count |
|`search_topk_sum`|`搜索 topk 的总和`| count |
|`milvus_datanode_consume_msg_count`|`数据节点消费的消息数量`| count |
|`milvus_datanode_flush_buffer_op_count`|`数据节点刷新缓冲区操作次数`| count |
|`milvus_datanode_msg_rows_count`|`数据节点消息行数`| count |
|`milvus_querynode_consume_tt_lag_ms`|`查询节点消费的时间滞后`| microsecond |
|`milvus_querynode_disk_used_size`|`查询节点磁盘使用大小`| bytes |
|`milvus_querynode_entity_num`|`查询节点实体数量`| count |
|`milvus_querynode_entity_size`|`查询节点实体大小`| bytes |
|`milvus_querynode_search_group_nq_bucket`|`查询节点搜索组查询数的分布桶`| s |
|`milvus_querynode_search_group_nq_count`|`查询节点搜索组查询数的计数`| count |
|`milvus_querynode_search_group_nq_sum`|`查询节点搜索组查询数的总和`| count |
|`milvus_proxy_req_count`|`代理请求次数`| count |
|`milvus_proxy_req_latency_bucket`|`代理请求延迟的分布桶`| s |
|`milvus_proxy_req_latency_count`|`代理请求延迟的计数`| count |
|`milvus_proxy_req_latency_sum`|`代理请求延迟的总和`| s |
|`milvus_proxy_search_vectors_count`|`代理搜索向量次数`| count |
|`milvus_proxy_send_bytes_count`|`代理发送字节数`| bytes |
|`milvus_rootcoord_collection_num`|`根协调集合数量`| count |
|`milvus_rootcoord_ddl_req_count`|`根协调 DDL 请求次数`| count |
|`milvus_rootcoord_ddl_req_latency_bucket`|`根协调 DDL 请求延迟的分布桶`| s |
|`milvus_rootcoord_ddl_req_latency_count`|`根协调 DDL 请求延迟的计数`| count |
|`milvus_rootcoord_ddl_req_latency_sum`|`根协调 DDL 请求延迟的总和`| s |
|`milvus_rootcoord_entity_num`|`根协调实体数量`| count |
|`milvus_rootcoord_partition_num`|`根协调分区数量`| count |
|`milvus_rootcoord_produce_tt_lag_ms`|`根协调生产的时间滞后`| microsecond |
|`milvus_storage_kv_size_bucket`|`Milvus 存储键值对大小的分布桶`| bytes |
|`milvus_storage_kv_size_count`|`Milvus 存储键值对大小的计数`| count |
|`milvus_storage_kv_size_sum`|`Milvus 存储键值对大小的总和`| bytes |
|`milvus_storage_op_count`|`Milvus 存储操作次数`| count |
|`milvus_storage_request_latency_bucket`|`Milvus 存储请求延迟的分布桶`| s |
|`milvus_storage_request_latency_count`|`Milvus 存储请求延迟的计数`| count |
|`milvus_storage_request_latency_sum`|`Milvus 存储请求延迟的总和`| s |
|`milvus_num_node`|`Milvus 节点数量`| count |
|`milvus_runtime_info`|`Milvus 运行时信息`| - |
|`process_max_fds`|`进程最大文件描述符数`| count |
|`process_open_fds`|`进程打开的文件描述符数`| count |
|`process_start_time_seconds`|`进程启动时间`| s |
|`process_virtual_memory_bytes`|`进程虚拟内存字节数`| bytes |
|`process_virtual_memory_max_bytes`|`进程虚拟内存最大字节数`| bytes |
