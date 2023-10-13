---
title     : 'MinIO'
summary   : '采集 MinIO 相关指标信息'
__int_icon: 'icon/minio'
dashboard :
  - desc  : 'MinIO 监控视图'
    path  : 'dashboard/zh/minio'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# MinIO
<!-- markdownlint-enable -->


MinIO 性能指标展示，包括 MinIO 在线时长、存储空间分布、bucket 明细、文件大小区间分布、S3 TTFB (s) 分布、S3 流量、S3 请求等。


## 配置 {#config}

### 版本支持

- MinIO 版本：ALL

说明：示例 MinIO 版本为 RELEASE.2022-06-25T15-50-16Z (commit-id=bd099f5e71d0ea511846372869bfcb280a5da2f6)

### 指标采集

MinIO 默认已暴露 [metric](https://docs.min.io/minio/baremetal/monitoring/metrics-alerts/collect-minio-metrics-using-prometheus.html?ref=con#minio-metrics-collect-using-prometheus) ，可以直接通过 Prometheus 来采集相关指标。

- 使用`minio-client`（简称`mc`）创建授权信息

```shell
$ mc alias set myminio http://192.168.0.210:9000 minioadmin minioadmin

scrape_configs:
- job_name: minio-job
  bearer_token: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjQ4MTAwNzIxNDQsImlzcyI6InByb21ldGhldXMiLCJzdWIiOiJtaW5pb2FkbWluIn0.tzoJ7ifMxgx4jXfUKdD_Sq5Ll2-YlbaBu6FuNTZcc88t9o9STyg4yicRAgYmezVGFwYR2VFKvBSBnOnVnb0n4w
  metrics_path: /minio/v2/metrics/cluster
  scheme: http
  static_configs:
  - targets: ['192.168.0.210:9000']
```

???+ info "注意"
    Minio 只提供了通过 `mc` 来生成`token` 信息，可用于`prometheus` 指标采集。其中并不包含生成对应 prometheus server, 输出信息包含了 `bearer_token`、`metrics_path`、`scheme`以及`targets`，通过这些信息可以进行拼装最终的 url 。

- 开启 DataKit 采集器

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom-minio.conf
```

-修改 `prom-minio.conf` 配置文件
<!-- markdownlint-disable MD046 -->
??? quote "`prom-minio.conf`"
    ```toml hl_lines="3 8 9 12 24 28 29 30"
    [[inputs.prom]]
      # Exporter URLs
      urls = ["http://192.168.0.210:9000/minio/v2/metrics/cluster"]

      # 忽略对 url 的请求错误
      ignore_req_err = false
      # 采集器别名
      source = "minio"
      metric_types = []

      # 保留指标，防止时间线炸裂
      metric_name_filter = ["minio_bucket","minio_cluster","minio_node","minio_s3","minio_usage"]
      # 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "1m"

      # TLS 配置
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"

      # 过滤 tags, 可配置多个tag
      # 匹配的 tag 将被忽略，但对应的数据仍然会上报上来
      tags_ignore = ["version","le","commit"]

      # 自定义认证方式，目前仅支持 Bearer Token
      # token 和 token_file: 仅需配置其中一项即可
      [inputs.prom.auth]
        type = "bearer_token"
        token = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjQ4MTAwNzIxNDQsImlzcyI6InByb21ldGhldXMiLCJzdWIiOiJtaW5pb2FkbWluIn0.tzoJ7ifMxgx4jXfUKdD_Sq5Ll2-YlbaBu6FuNTZcc88t9o9STyg4yicRAgYmezVGFwYR2VFKvBSBnOnVnb0n4w"
      # token_file = "/tmp/token"

      # 自定义指标集名称
      # 可以将包含前缀 prefix 的指标归为一类指标集
      # 自定义指标集名称配置优先 measurement_name 配置项
      #[[inputs.prom.measurements]]
      #  prefix = "cpu_"
      #  name = "cpu"

      # [[inputs.prom.measurements]]
      # prefix = "mem_"
      # name = "mem"

      # 对于匹配如下 tag 相关的数据，丢弃这些数据不予采集
      [inputs.prom.ignore_tag_kv_match]
      # key1 = [ "val1.*", "val2.*"]
      # key2 = [ "val1.*", "val2.*"]

      # 在数据拉取的 HTTP 请求中添加额外的请求头
      [inputs.prom.http_headers]
      # Root = "passwd"
      # Michael = "1234"

      # 重命名 prom 数据中的 tag key
      [inputs.prom.tags_rename]
        overwrite_exist_tags = false
        [inputs.prom.tags_rename.mapping]
        # tag1 = "new-name-1"
        # tag2 = "new-name-2"
        # tag3 = "new-name-3"

      # 将采集到的指标作为日志打到中心
      # service 字段留空时，会把 service tag 设为指标集名称
      [inputs.prom.as_logging]
        enable = false
        service = "service_name"

      # 自定义Tags
      [inputs.prom.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
<!-- markdownlint-enable -->
主要参数说明 ：

- urls：`prometheus` 指标地址，这里填写 MinIO 暴露出来的指标 url
- source：采集器别名，建议写成`minio`
- interval：采集间隔
- metric_name_filter: 指标过滤，只采集需要的指标项
- tls_open：TLS 配置
- metric_types：指标类型，不填，代表采集所有指标
- tags_ignore： 忽略不需要的 tag
- [inputs.prom.auth]：配置授权信息
- token : bearer_token 值

- 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)


## 指标 {#metric}

| 指标                              | 含义                    |
| --------------------------------- | ----------------------- |
| node_process_uptime_seconds       | 节点在线时长            |
| node_disk_free_bytes              | 节点空间空闲大小        |
| node_disk_used_bytes              | 节点空间使用大小        |
| node_file_descriptor_open_total   | 节点文件描述打开次数    |
| node_go_routine_total             | 节点 go_routine 次数    |
| cluster_disk_online_total         | 集群磁盘在线数          |
| cluster_disk_offline_total        | 集群磁盘离线数          |
| bucket_usage_object_total         | bucket 已用对象数       |
| bucket_usage_total_bytes          | bucket 已用字节         |
| bucket_objects_size_distribution  | bucket 对象大小区间分布 |
| s3_traffic_received_bytes         | s3 接收流量             |
| s3_traffic_sent_bytes             | s3 发送流量             |
| s3_requests_total                 | s3 请求总数             |
| s3_requests_waiting_total         | s3 正在等待请求数       |
| s3_requests_errors_total          | s3 异常总数             |
| s3_requests_4xx_errors_total      | s3 4xx 异常数           |
| s3_time_ttfb_seconds_distribution | s3 TTFB                 |
| usage_last_activity_nano_seconds  | 自上使用活动以来的时间  |
