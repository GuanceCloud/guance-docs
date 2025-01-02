---
title     : 'MinIO V3'
summary   : '采集 MinIO 相关指标信息'
__int_icon: 'icon/minio'
dashboard :
  - desc  : 'MinIO V3 监控视图'
    path  : 'dashboard/zh/minio_v3'
monitor   :
  - desc  : 'MinIO V3监控器'
    path  : 'monitor/zh/minio_v3' 
---

<!-- markdownlint-disable MD025 -->
# MinIO
<!-- markdownlint-enable -->


MinIO 性能指标展示，包括 MinIO 在线时长、存储空间分布、bucket 明细、文件大小区间分布、S3 TTFB (s) 分布、S3 流量、S3 请求等。


## 配置 {#config}

### 版本支持

- MinIO 版本：v3

### MinIO 指标暴露


MinIO官方提供了基于 Prometheus 风格的指标，可供 Prometheus 等相关观测工具进行抓取，用于分析和告警。 MinIO 的指标 endpoint 有 API metrics、Audit metrics、Cluster metrics、Debug metrics 等多个分类，可以从各个 endpoint 分别获取，详见文档。MinIO 最新的 Metrics version 3 允许从一个 endpoint （/minio/metrics/v3）获取到所有指标，给指标采集带来了不小的便利性。

默认情况下，观测工具去抓取 MinIO metrics 时需要先用 mc 命令生成 bearer token ，参考 [MinIO v2](./minio.md).

如果需要免密抓取，可以通过 MinIO 环境变量中的 `MINIO_PROMETHEUS_AUTH_TYPE` 将指标暴露方式设置为 `Public` ，具体方式为：

修改`/etc/default/minio`文件，将`MINIO_PROMETHEUS_AUTH_TYPE="public"`添加到文件中，当前采用免密的方式进行指标抓取。

### 开启 DataKit 采集器

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom-minio.conf
```

修改 `prom-minio.conf` 配置文件:
<!-- markdownlint-disable MD046 -->

```toml
[[inputs.prom]]
    # Exporter URLs
    urls = ["http://minio-endpoint:9000/minio/metrics/v3"]

    # 采集器别名
    source = "minio"
    metric_types = []

    # 自定义Tags
    [inputs.prom.tags]
    version="v3"
    ...
```
<!-- markdownlint-enable -->
调整以上参数，参数说明 ：

- urls：`prometheus` 指标地址，这里填写 MinIO 暴露出来的指标 url
- source：采集器别名，建议写成`minio`
- [inputs.prom.tags]：tag 信息

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

更多 MinIO V3 指标，可以参考 [MinIO 官方网站](https://min.io/docs/minio/linux/operations/monitoring/metrics-and-alerts.html#version-3-endpoints)

