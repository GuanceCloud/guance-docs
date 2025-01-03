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

MinIO V3 性能指标展示，包括 MinIO 在线时长、存储空间分布、bucket 明细、文件大小区间分布、S3 TTFB (s) 分布、S3 流量、S3 请求等。


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

| 指标名                                    | 描述                                      | 单位       |
|------------------------------------------|------------------------------------------|----------|
| api_requests_4xx_errors_total             | API请求4xx错误总数                         | 次        |
| api_requests_errors_total                | API请求错误总数                           | 次        |
| api_requests_rejected_auth_total          | API请求因认证拒绝总数                     | 次        |
| api_requests_rejected_invalid_total       | API请求因无效拒绝总数                     | 次        |
| api_requests_total                       | API请求总数                             | 次        |
| api_requests_traffic_received_bytes        | API请求接收流量字节数                     | 字节(B)   |
| api_requests_traffic_sent_bytes           | API请求发送流量字节数                     | 字节(B)   |
| api_requests_ttfb_seconds_distribution     | API请求首次字节时间分布（秒）             | 秒(s)     |
| audit_failed_messages                    | 审计失败消息数                           | 条        |
| audit_target_queue_length                 | 审计目标队列长度                         | 条        |
| audit_total_messages                     | 审计消息总数                             | 条        |
| cluster_erasure_set_health                 | 集群擦除集健康状态                       | 健康状态   |
| cluster_erasure_set_online_drives_count    | 集群擦除集在线驱动器数量                 | 个        |
| cluster_erasure_set_overall_health         | 集群擦除集整体健康状态                   | 健康状态   |
| cluster_erasure_set_overall_write_quorum   | 集群擦除集整体写入法定数                 | 法定数     |
| cluster_erasure_set_read_health            | 集群擦除集读取健康状态                   | 健康状态   |
| cluster_erasure_set_read_quorum            | 集群擦除集读取法定数                     | 法定数     |
| cluster_erasure_set_write_health           | 集群擦除集写入健康状态                   | 健康状态   |
| cluster_erasure_set_write_quorum           | 集群擦除集写入法定数                     | 法定数     |
| cluster_health_capacity_raw_free_bytes     | 集群健康原始容量空闲字节数               | 字节(B)   |
| cluster_health_capacity_raw_total_bytes    | 集群健康原始容量总字节数                 | 字节(B)   |
| cluster_health_capacity_usable_free_bytes  | 集群健康可用容量空闲字节数               | 字节(B)   |
| cluster_health_capacity_usable_total_bytes | 集群健康可用容量总字节数                 | 字节(B)   |
| cluster_health_drives_count                | 集群健康驱动器数量                       | 个        |
| cluster_health_drives_online_count         | 集群健康在线驱动器数量                   | 个        |
| cluster_health_nodes_online_count         | 集群健康在线节点数量                     | 个        |
| cluster_iam_since_last_sync_millis        | 自上次同步以来的毫秒数                   | 毫秒(ms)  |
| cluster_iam_sync_successes                | 集群IAM同步成功次数                     | 次        |
| cluster_usage_buckets_object_size_distribution | 集群使用桶对象大小分布             | 字节(B)   |
| cluster_usage_buckets_object_version_count_distribution | 集群使用桶对象版本计数分布       | 个        |
| cluster_usage_buckets_objects_count       | 集群使用桶对象数量                     | 个        |
| cluster_usage_buckets_since_last_update_seconds | 自上次更新以来的秒数             | 秒(s)     |
| cluster_usage_buckets_total_bytes         | 集群使用桶总字节数                     | 字节(B)   |
| cluster_usage_objects_buckets_count       | 集群使用对象桶数量                     | 个        |
| cluster_usage_objects_count               | 集群使用对象数量                       | 个        |
| cluster_usage_objects_since_last_update_seconds | 自上次更新以来的秒数           | 秒(s)     |
| cluster_usage_objects_size_distribution   | 集群使用对象大小分布                   | 字节(B)   |
| cluster_usage_objects_total_bytes         | 集群使用对象总字节数                   | 字节(B)   |
| cluster_usage_objects_version_count_distribution | 集群使用对象版本计数分布         | 个        |
| ilm_versions_scanned                      | ILM版本扫描次数                         | 次        |
| logger_webhook_failed_messages            | 日志Webhook失败消息数                   | 条        |
| logger_webhook_queue_length               | 日志Webhook队列长度                     | 条        |
| logger_webhook_total_messages             | 日志Webhook消息总数                     | 条        |
| scanner_bucket_scans_finished             | 扫描器桶扫描完成次数                     | 次        |
| scanner_bucket_scans_started              | 扫描器桶扫描启动次数                     | 次        |
| scanner_directories_scanned               | 扫描器目录扫描次数                       | 个        |
| scanner_last_activity_seconds            | 扫描器最后活动秒数                       | 秒(s)     |
| scanner_objects_scanned                   | 扫描器对象扫描次数                       | 个        |
| scanner_versions_scanned                  | 扫描器版本扫描次数                       | 个        |
| system_cpu_avg_idle                       | 系统CPU平均空闲百分比                     | %         |
| system_cpu_avg_iowait                     | 系统CPU平均IO等待百分比                   | %         |
| system_cpu_load                          | 系统CPU负载                             | 负载      |
| system_cpu_load_perc                      | 系统CPU负载百分比                       | %         |
| system_cpu_system                        | 系统CPU系统使用百分比                     | %         |
| system_cpu_user                          | 系统CPU用户使用百分比                     | %         |
| system_drive_api_latency_micros           | 系统驱动器API延迟微秒数                 | 微秒(μs)  |
| system_drive_count                       | 系统驱动器数量                         | 个        |
| system_drive_free_bytes                   | 系统驱动器空闲字节数                     | 字节(B)   |
| system_drive_free_inodes                  | 系统驱动器空闲inode数                   | 个        |
| system_drive_health                       | 系统驱动器健康状态                       | 健康状态   |
| system_drive_online_count                  | 系统驱动器在线数量                       | 个        |
| system_drive_perc_util                    | 系统驱动器使用百分比                     | %         |
| system_drive_total_bytes                  | 系统驱动器总字节数                       | 字节(B)   |
| system_drive_total_inodes                 | 系统驱动器总inode数                     | 个        |
| system_drive_used_bytes                   | 系统驱动器已用字节数                     | 字节(B)   |
| system_drive_used_inodes                  | 系统驱动器已用inode数                   | 个        |
| system_drive_writes_await                 | 系统驱动器写入等待时间                   | 时间      |
| system_drive_writes_kb_per_sec             | 系统驱动器每秒写入KB数                 | KB/秒     |
| system_drive_writes_per_sec                | 系统驱动器每秒写入次数                   | 次/秒     |
| system_memory_available                   | 系统内存可用字节数                       | 字节(B)   |
| system_memory_buffers                     | 系统内存缓冲区字节数                     | 字节(B)   |
| system_memory_cache                       | 系统内存缓存字节数                       | 字节(B)   |
| system_memory_free                        | 系统内存空闲字节数                       | 字节(B)   |
| system_memory_shared                      | 系统内存共享字节数                       | 字节(B)   |
| system_memory_total                       | 系统内存总字节数                         | 字节(B)   |
| system_memory_used                        | 系统内存已用字节数                       | 字节(B)   |
| system_memory_used_perc                    | 系统内存已用百分比                     | %         |
| system_process_cpu_total_seconds           | 系统进程CPU总秒数                       | 秒(s)     |
| system_process_file_descriptor_limit_total  | 系统进程文件描述符限制总数               | 个        |
| system_process_file_descriptor_open_total   | 系统进程文件描述符打开总数               | 个        |
| system_process_go_routine_total            | 系统进程Go例程总数                     | 个        |
| system_process_io_rchar_bytes              | 系统进程IO读取字符字节数                 | 字节(B)   |
| system_process_io_read_bytes               | 系统进程IO读取字节数                     | 字节(B)   |
| system_process_io_wchar_bytes              | 系统进程IO写入字符字节数                 | 字节(B)   |
| system_process_io_write_bytes              | 系统进程IO写入字节数                     | 字节(B)   |
| system_process_resident_memory_bytes       | 系统进程驻留内存字节数                   | 字节(B)   |
| system_process_start_time_seconds          | 系统进程启动时间秒数                     | 秒 |


更多 MinIO V3 指标，可以参考 [MinIO 官方网站](https://min.io/docs/minio/linux/operations/monitoring/metrics-and-alerts.html#version-3-endpoints)

