---
title     : 'MinIO V3'
summary   : 'Collect relevant Metrics information for MinIO'
__int_icon: 'icon/minio'
dashboard :
  - desc  : 'MinIO V3 monitoring view'
    path  : 'dashboard/en/minio_v3'
monitor   :
  - desc  : 'MinIO V3 Monitor'
    path  : 'monitor/en/minio_v3' 
---

MinIO V3 performance Metrics display, including MinIO uptime, storage space distribution, bucket details, file size range distribution, S3 TTFB (s) distribution, S3 traffic, S3 requests, etc.


## Configuration {#config}

### Version Support

- MinIO Version: v3

### MinIO Metrics Exposure


The official MinIO provides Metrics in Prometheus style, which can be fetched by related observability tools such as Prometheus for analysis and alerts. MinIO’s Metrics endpoint includes API metrics, Audit metrics, Cluster metrics, Debug metrics, and more categories, which can be obtained from various endpoints separately; see the documentation for details. The latest Metrics version 3 of MinIO allows fetching all Metrics from one endpoint (/minio/metrics/v3), providing significant convenience for Metrics collection.

By default, when observability tools fetch MinIO Metrics, they need to generate a bearer token using the mc command first; refer to [MinIO v2](./minio.md).

If password-free fetching is required, the exposure method can be set to `Public` via the `MINIO_PROMETHEUS_AUTH_TYPE` environment variable in MinIO. The specific method is:

Modify the `/etc/default/minio` file and add `MINIO_PROMETHEUS_AUTH_TYPE="public"` to the file, allowing password-free Metric fetching.

### Enable DataKit Collector

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom-minio.conf
```

Edit the `prom-minio.conf` configuration file:
<!-- markdownlint-disable MD046 -->

```toml
[[inputs.prom]]
    # Exporter URLs
    urls = ["http://minio-endpoint:9000/minio/metrics/v3"]

    # Collector alias
    source = "minio"
    metric_types = []

    # Custom Tags
    [inputs.prom.tags]
    version="v3"
    ...
```
<!-- markdownlint-enable -->
Adjust the above parameters, parameter descriptions:

- urls: `prometheus` Metrics address, fill in the exposed Metrics url of MinIO here.
- source: collector alias, it is recommended to use `minio`.
- [inputs.prom.tags]: tag information.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


## Metrics {#metric}

| Metric Name                                    | Description                                      | Unit       |
|-----------------------------------------------|------------------------------------------------|------------|
| api_requests_4xx_errors_total                  | Total number of API request 4xx errors          | Times      |
| api_requests_errors_total                      | Total number of API request errors              | Times      |
| api_requests_rejected_auth_total               | Total number of API requests rejected due to authentication | Times      |
| api_requests_rejected_invalid_total            | Total number of API requests rejected due to invalidity | Times      |
| api_requests_total                             | Total number of API requests                   | Times      |
| api_requests_traffic_received_bytes            | Number of received bytes in API requests        | Bytes(B)   |
| api_requests_traffic_sent_bytes                | Number of sent bytes in API requests           | Bytes(B)   |
| api_requests_ttfb_seconds_distribution         | Distribution of time for the first byte in API requests (seconds) | Seconds(s) |
| audit_failed_messages                         | Number of failed audit messages                | Items      |
| audit_target_queue_length                     | Length of audit target queue                   | Items      |
| audit_total_messages                          | Total number of audit messages                 | Items      |
| cluster_erasure_set_health                    | Health status of cluster erasure set           | Health Status |
| cluster_erasure_set_online_drives_count       | Number of online drives in cluster erasure set | Units      |
| cluster_erasure_set_overall_health             | Overall health status of cluster erasure set   | Health Status |
| cluster_erasure_set_overall_write_quorum       | Overall write quorum of cluster erasure set     | Quorum     |
| cluster_erasure_set_read_health                | Read health status of cluster erasure set      | Health Status |
| cluster_erasure_set_read_quorum                | Read quorum of cluster erasure set             | Quorum     |
| cluster_erasure_set_write_health               | Write health status of cluster erasure set     | Health Status |
| cluster_erasure_set_write_quorum               | Write quorum of cluster erasure set            | Quorum     |
| cluster_health_capacity_raw_free_bytes         | Raw free bytes capacity in cluster health      | Bytes(B)   |
| cluster_health_capacity_raw_total_bytes        | Raw total bytes capacity in cluster health     | Bytes(B)   |
| cluster_health_capacity_usable_free_bytes      | Usable free bytes capacity in cluster health   | Bytes(B)   |
| cluster_health_capacity_usable_total_bytes     | Usable total bytes capacity in cluster health  | Bytes(B)   |
| cluster_health_drives_count                   | Number of drives in cluster health             | Units      |
| cluster_health_drives_online_count            | Number of online drives in cluster health      | Units      |
| cluster_health_nodes_online_count             | Number of online nodes in cluster health       | Units      |
| cluster_iam_since_last_sync_millis            | Milliseconds since last synchronization         | Milliseconds(ms) |
| cluster_iam_sync_successes                    | Successful IAM synchronization count in cluster  | Times      |
| cluster_usage_buckets_object_size_distribution | Bucket object size distribution in cluster usage | Bytes(B)   |
| cluster_usage_buckets_object_version_count_distribution | Bucket object version count distribution in cluster usage | Units      |
| cluster_usage_buckets_objects_count           | Number of objects in buckets in cluster usage  | Units      |
| cluster_usage_buckets_since_last_update_seconds | Seconds since last update in cluster usage   | Seconds(s) |
| cluster_usage_buckets_total_bytes             | Total bytes in buckets in cluster usage        | Bytes(B)   |
| cluster_usage_objects_buckets_count           | Number of object buckets in cluster usage      | Units      |
| cluster_usage_objects_count                   | Number of objects in cluster usage            | Units      |
| cluster_usage_objects_since_last_update_seconds | Seconds since last update in cluster usage   | Seconds(s) |
| cluster_usage_objects_size_distribution       | Object size distribution in cluster usage       | Bytes(B)   |
| cluster_usage_objects_total_bytes             | Total bytes in objects in cluster usage        | Bytes(B)   |
| cluster_usage_objects_version_count_distribution | Object version count distribution in cluster usage | Units      |
| ilm_versions_scanned                         | ILM versions scanned count                     | Times      |
| logger_webhook_failed_messages               | Number of failed webhook messages in logs      | Items      |
| logger_webhook_queue_length                  | Length of webhook queue in logs               | Items      |
| logger_webhook_total_messages                | Total number of webhook messages in logs      | Items      |
| scanner_bucket_scans_finished                | Completed bucket scans by scanner             | Times      |
| scanner_bucket_scans_started                 | Started bucket scans by scanner              | Times      |
| scanner_directories_scanned                  | Scanned directories by scanner                | Units      |
| scanner_last_activity_seconds                | Last activity seconds by scanner             | Seconds(s) |
| scanner_objects_scanned                      | Scanned objects by scanner                   | Units      |
| scanner_versions_scanned                     | Scanned versions by scanner                 | Units      |
| system_cpu_avg_idle                          | Average idle percentage of system CPU         | %          |
| system_cpu_avg_iowait                        | Average IO wait percentage of system CPU      | %          |
| system_cpu_load                             | System CPU load                            | Load       |
| system_cpu_load_perc                         | System CPU load percentage                  | %          |
| system_cpu_system                           | System CPU system usage percentage          | %          |
| system_cpu_user                             | System CPU user usage percentage            | %          |
| system_drive_api_latency_micros              | System drive API latency in microseconds    | Microseconds(μs) |
| system_drive_count                          | Number of system drives                    | Units      |
| system_drive_free_bytes                      | Free bytes on system drives                | Bytes(B)   |
| system_drive_free_inodes                    | Free inodes on system drives               | Units      |
| system_drive_health                         | Health status of system drives             | Health Status |
| system_drive_online_count                   | Number of online system drives             | Units      |
| system_drive_perc_util                      | Percentage utilization of system drives       | %          |
| system_drive_total_bytes                    | Total bytes on system drives               | Bytes(B)   |
| system_drive_total_inodes                   | Total inodes on system drives              | Units      |
| system_drive_used_bytes                     | Used bytes on system drives                | Bytes(B)   |
| system_drive_used_inodes                    | Used inodes on system drives               | Units      |
| system_drive_writes_await                   | Write await time on system drives          | Time       |
| system_drive_writes_kb_per_sec               | KB written per second on system drives     | KB/second  |
| system_drive_writes_per_sec                 | Writes per second on system drives         | Times/second |
| system_memory_available                     | Available memory bytes on system            | Bytes(B)   |
| system_memory_buffers                       | Buffer memory bytes on system              | Bytes(B)   |
| system_memory_cache                         | Cache memory bytes on system               | Bytes(B)   |
| system_memory_free                          | Free memory bytes on system                | Bytes(B)   |
| system_memory_shared                        | Shared memory bytes on system              | Bytes(B)   |
| system_memory_total                         | Total memory bytes on system               | Bytes(B)   |
| system_memory_used                          | Used memory bytes on system                | Bytes(B)   |
| system_memory_used_perc                     | Used memory percentage on system            | %          |
| system_process_cpu_total_seconds            | Total CPU seconds for system processes     | Seconds(s) |
| system_process_file_descriptor_limit_total    | Total limit of file descriptors for system processes | Units      |
| system_process_file_descriptor_open_total     | Total open file descriptors for system processes | Units      |
| system_process_go_routine_total             | Total Go routines for system processes     | Units      |
| system_process_io_rchar_bytes               | Read character bytes for system process IO | Bytes(B)   |
| system_process_io_read_bytes                | Read bytes for system process IO           | Bytes(B)   |
| system_process_io_wchar_bytes               | Written character bytes for system process IO | Bytes(B)   |
| system_process_io_write_bytes               | Written bytes for system process IO        | Bytes(B)   |
| system_process_resident_memory_bytes        | Resident memory bytes for system processes | Bytes(B)   |
| system_process_start_time_seconds           | Start time seconds for system processes    | Seconds |


For more MinIO V3 Metrics, refer to the [MinIO Official Website](https://min.io/docs/minio/linux/operations/monitoring/metrics-and-alerts.html#version-3-endpoints)

</translated_content>