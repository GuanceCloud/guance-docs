---
title     : 'MinIO V3'
summary   : 'Collect MinIO related Metrics information'
__int_icon: 'icon/minio'
dashboard :
  - desc  : 'MinIO V3 Monitoring View'
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

MinIO officially provides Prometheus-style Metrics for collection by observability tools such as Prometheus for analysis and alerting. MinIO's Metrics endpoints include API metrics, Audit metrics, Cluster metrics, Debug metrics, among others, which can be obtained separately from each endpoint; see the documentation for more details. The latest MinIO Metrics version 3 allows all Metrics to be retrieved from a single endpoint (/minio/metrics/v3), significantly simplifying the collection process.

By default, when an observability tool fetches MinIO Metrics, it needs to generate a bearer token using the `mc` command first; refer to [MinIO v2](./minio.md).

For passwordless fetching, you can set the metric exposure method to `Public` via the `MINIO_PROMETHEUS_AUTH_TYPE` environment variable in MinIO, specifically:

Edit the `/etc/default/minio` file and add `MINIO_PROMETHEUS_AUTH_TYPE="public"` to enable public access for Metric collection.

### Enable DataKit Collector

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom-minio.conf
```

Modify the `prom-minio.conf` configuration file:
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
Adjust the parameters above. Parameter descriptions:

- urls: The Prometheus Metrics URL, fill in the exposed MinIO Metrics URL here.
- source: Collector alias, recommended to use `minio`.
- [inputs.prom.tags]: Tag information

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

| Metric Name                                    | Description                                      | Unit       |
|------------------------------------------|------------------------------------------|----------|
| api_requests_4xx_errors_total             | Total number of API request 4xx errors                         | Count        |
| api_requests_errors_total                | Total number of API request errors                           | Count        |
| api_requests_rejected_auth_total          | Total number of API requests rejected due to authentication                     | Count        |
| api_requests_rejected_invalid_total       | Total number of API requests rejected due to invalid credentials                     | Count        |
| api_requests_total                       | Total number of API requests                             | Count        |
| api_requests_traffic_received_bytes        | Received traffic bytes of API requests                     | Bytes(B)   |
| api_requests_traffic_sent_bytes           | Sent traffic bytes of API requests                     | Bytes(B)   |
| api_requests_ttfb_seconds_distribution     | Distribution of time to first byte for API requests (seconds)             | Seconds(s)     |
| audit_failed_messages                    | Number of failed audit messages                           | Count        |
| audit_target_queue_length                 | Length of audit target queue                         | Count        |
| audit_total_messages                     | Total number of audit messages                             | Count        |
| cluster_erasure_set_health                 | Health status of cluster erasure sets                       | Health Status   |
| cluster_erasure_set_online_drives_count    | Number of online drives in cluster erasure sets                 | Count        |
| cluster_erasure_set_overall_health         | Overall health status of cluster erasure sets                   | Health Status   |
| cluster_erasure_set_overall_write_quorum   | Overall write quorum of cluster erasure sets                 | Quorum     |
| cluster_erasure_set_read_health            | Read health status of cluster erasure sets                   | Health Status   |
| cluster_erasure_set_read_quorum            | Read quorum of cluster erasure sets                     | Quorum     |
| cluster_erasure_set_write_health           | Write health status of cluster erasure sets                   | Health Status   |
| cluster_erasure_set_write_quorum           | Write quorum of cluster erasure sets                     | Quorum     |
| cluster_health_capacity_raw_free_bytes     | Raw free bytes capacity of cluster health               | Bytes(B)   |
| cluster_health_capacity_raw_total_bytes    | Total raw bytes capacity of cluster health                    | Bytes(B)   |
| cluster_health_capacity_usable_free_bytes  | Usable free bytes capacity of cluster health               | Bytes(B)   |
| cluster_health_capacity_usable_total_bytes | Total usable bytes capacity of cluster health                 | Bytes(B)   |
| cluster_health_drives_count                | Number of drives in cluster health                       | Count        |
| cluster_health_drives_online_count         | Number of online drives in cluster health                   | Count        |
| cluster_health_nodes_online_count         | Number of online nodes in cluster health                     | Count        |
| cluster_iam_since_last_sync_millis        | Milliseconds since last IAM sync                   | Milliseconds(ms)  |
| cluster_iam_sync_successes                | Number of successful IAM syncs                     | Count        |
| cluster_usage_buckets_object_size_distribution | Object size distribution in buckets usage             | Bytes(B)   |
| cluster_usage_buckets_object_version_count_distribution | Object version count distribution in buckets usage       | Count        |
| cluster_usage_buckets_objects_count       | Number of objects in buckets usage                     | Count        |
| cluster_usage_buckets_since_last_update_seconds | Seconds since last update in buckets usage             | Seconds(s)     |
| cluster_usage_buckets_total_bytes         | Total bytes in buckets usage                     | Bytes(B)   |
| cluster_usage_objects_buckets_count       | Number of object buckets usage                     | Count        |
| cluster_usage_objects_count               | Number of objects usage                       | Count        |
| cluster_usage_objects_since_last_update_seconds | Seconds since last update in objects usage           | Seconds(s)     |
| cluster_usage_objects_size_distribution   | Object size distribution in usage                   | Bytes(B)   |
| cluster_usage_objects_total_bytes         | Total bytes in objects usage                   | Bytes(B)   |
| cluster_usage_objects_version_count_distribution | Object version count distribution in usage         | Count        |
| ilm_versions_scanned                      | Number of ILM versions scanned                         | Count        |
| logger_webhook_failed_messages            | Number of failed webhook messages in logger                   | Count        |
| logger_webhook_queue_length               | Webhook queue length in logger                     | Count        |
| logger_webhook_total_messages             | Total number of webhook messages in logger                     | Count        |
| scanner_bucket_scans_finished             | Number of completed bucket scans by scanner                     | Count        |
| scanner_bucket_scans_started              | Number of started bucket scans by scanner                     | Count        |
| scanner_directories_scanned               | Number of directories scanned by scanner                       | Count        |
| scanner_last_activity_seconds            | Seconds since last activity by scanner                       | Seconds(s)     |
| scanner_objects_scanned                   | Number of objects scanned by scanner                       | Count        |
| scanner_versions_scanned                  | Number of versions scanned by scanner                       | Count        |
| system_cpu_avg_idle                       | Average idle percentage of system CPU                     | %         |
| system_cpu_avg_iowait                     | Average IO wait percentage of system CPU                   | %         |
| system_cpu_load                          | System CPU load                             | Load      |
| system_cpu_load_perc                      | System CPU load percentage                       | %         |
| system_cpu_system                        | Percentage of system CPU used by system                     | %         |
| system_cpu_user                          | Percentage of system CPU used by user                     | %         |
| system_drive_api_latency_micros           | API latency of system drive in microseconds                 | Microseconds(μs)  |
| system_drive_count                       | Number of system drives                         | Count        |
| system_drive_free_bytes                   | Free bytes of system drive                     | Bytes(B)   |
| system_drive_free_inodes                  | Free inodes of system drive                   | Count        |
| system_drive_health                       | Health status of system drive                       | Health Status   |
| system_drive_online_count                  | Number of online system drives                       | Count        |
| system_drive_perc_util                    | Usage percentage of system drive                     | %         |
| system_drive_total_bytes                  | Total bytes of system drive                       | Bytes(B)   |
| system_drive_total_inodes                 | Total inodes of system drive                     | Count        |
| system_drive_used_bytes                   | Used bytes of system drive                     | Bytes(B)   |
| system_drive_used_inodes                  | Used inodes of system drive                   | Count        |
| system_drive_writes_await                 | Write await time of system drive                   | Time      |
| system_drive_writes_kb_per_sec             | KB written per second by system drive                 | KB/Second     |
| system_drive_writes_per_sec                | Writes per second by system drive                   | Writes/Second     |
| system_memory_available                   | Available memory bytes of system                       | Bytes(B)   |
| system_memory_buffers                     | Buffer memory bytes of system                     | Bytes(B)   |
| system_memory_cache                       | Cache memory bytes of system                     | Bytes(B)   |
| system_memory_free                        | Free memory bytes of system                       | Bytes(B)   |
| system_memory_shared                      | Shared memory bytes of system                     | Bytes(B)   |
| system_memory_total                       | Total memory bytes of system                         | Bytes(B)   |
| system_memory_used                        | Used memory bytes of system                       | Bytes(B)   |
| system_memory_used_perc                    | Used memory percentage of system                     | %         |
| system_process_cpu_total_seconds           | Total CPU seconds of system processes                       | Seconds(s)     |
| system_process_file_descriptor_limit_total  | Total limit of file descriptors for system processes               | Count        |
| system_process_file_descriptor_open_total   | Total open file descriptors for system processes               | Count        |
| system_process_go_routine_total            | Total Go routines for system processes                     | Count        |
| system_process_io_rchar_bytes              | Read character bytes of IO for system processes                 | Bytes(B)   |
| system_process_io_read_bytes               | Read bytes of IO for system processes                     | Bytes(B)   |
| system_process_io_wchar_bytes              | Written character bytes of IO for system processes                 | Bytes(B)   |
| system_process_io_write_bytes              | Written bytes of IO for system processes                     | Bytes(B)   |
| system_process_resident_memory_bytes       | Resident memory bytes of system processes                   | Bytes(B)   |
| system_process_start_time_seconds          | Start time seconds of system processes                     | Seconds |

For more MinIO V3 Metrics, refer to the [official MinIO website](https://min.io/docs/minio/linux/operations/monitoring/metrics-and-alerts.html#version-3-endpoints).