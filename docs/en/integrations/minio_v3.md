---
title     : 'MinIO V3'
summary   : 'Collect MinIO related Metrics information'
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

MinIO officially provides Prometheus-style Metrics for tools like Prometheus to scrape and use for analysis and alerts. MinIO’s Metrics endpoints include API metrics, Audit metrics, Cluster metrics, Debug metrics, among others, which can be obtained from various endpoints; see the documentation for more details. The latest MinIO Metrics version 3 allows all Metrics to be retrieved from a single endpoint (/minio/metrics/v3), greatly simplifying the collection process.

By default, when scraping MinIO metrics, monitoring tools need to generate a bearer token using the `mc` command first; refer to [MinIO v2](./minio.md).

If passwordless scraping is required, you can set the exposure method to `Public` by configuring the `MINIO_PROMETHEUS_AUTH_TYPE` environment variable in MinIO. Specifically:

Edit the `/etc/default/minio` file and add `MINIO_PROMETHEUS_AUTH_TYPE="public"` to allow passwordless metric scraping.

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
Adjust the above parameters as follows:

- urls: Prometheus Metrics address, enter the MinIO exposed Metrics URL here.
- source: Collector alias, it is recommended to write `minio`.
- [inputs.prom.tags]: Tag information

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


## Metrics {#metric}

| Metric Name                                    | Description                                      | Unit       |
|------------------------------------------|------------------------------------------|----------|
| api_requests_4xx_errors_total             | Total number of API request 4xx errors                         | Occurrences        |
| api_requests_errors_total                | Total number of API request errors                           | Occurrences        |
| api_requests_rejected_auth_total          | Total number of API requests rejected due to authentication                     | Occurrences        |
| api_requests_rejected_invalid_total       | Total number of API requests rejected due to invalidity                     | Occurrences        |
| api_requests_total                       | Total number of API requests                             | Occurrences        |
| api_requests_traffic_received_bytes        | Number of bytes received from API requests                     | Bytes(B)   |
| api_requests_traffic_sent_bytes           | Number of bytes sent from API requests                     | Bytes(B)   |
| api_requests_ttfb_seconds_distribution     | Distribution of time to first byte for API requests (seconds)             | Seconds(s)     |
| audit_failed_messages                    | Number of failed audit messages                           | Entries        |
| audit_target_queue_length                 | Length of audit target queue                         | Entries        |
| audit_total_messages                     | Total number of audit messages                             | Entries        |
| cluster_erasure_set_health                 | Health status of cluster erasure sets                       | Health Status   |
| cluster_erasure_set_online_drives_count    | Number of online drives in cluster erasure sets                 | Count        |
| cluster_erasure_set_overall_health         | Overall health status of cluster erasure sets                   | Health Status   |
| cluster_erasure_set_overall_write_quorum   | Overall write quorum of cluster erasure sets                 | Quorum     |
| cluster_erasure_set_read_health            | Read health status of cluster erasure sets                   | Health Status   |
| cluster_erasure_set_read_quorum            | Read quorum of cluster erasure sets                     | Quorum     |
| cluster_erasure_set_write_health           | Write health status of cluster erasure sets                   | Health Status   |
| cluster_erasure_set_write_quorum           | Write quorum of cluster erasure sets                     | Quorum     |
| cluster_health_capacity_raw_free_bytes     | Raw free bytes capacity of the cluster               | Bytes(B)   |
| cluster_health_capacity_raw_total_bytes    | Total raw bytes capacity of the cluster                 | Bytes(B)   |
| cluster_health_capacity_usable_free_bytes  | Usable free bytes capacity of the cluster               | Bytes(B)   |
| cluster_health_capacity_usable_total_bytes | Total usable bytes capacity of the cluster                 | Bytes(B)   |
| cluster_health_drives_count                | Number of drives in the cluster                       | Count        |
| cluster_health_drives_online_count         | Number of online drives in the cluster                   | Count        |
| cluster_health_nodes_online_count         | Number of online nodes in the cluster                     | Count        |
| cluster_iam_since_last_sync_millis        | Milliseconds since the last synchronization                   | Milliseconds(ms)  |
| cluster_iam_sync_successes                | Number of successful IAM syncs                     | Occurrences        |
| cluster_usage_buckets_object_size_distribution | Object size distribution in buckets within the cluster             | Bytes(B)   |
| cluster_usage_buckets_object_version_count_distribution | Object version count distribution in buckets within the cluster       | Count        |
| cluster_usage_buckets_objects_count       | Number of objects in buckets within the cluster                     | Count        |
| cluster_usage_buckets_since_last_update_seconds | Seconds since the last update of buckets within the cluster             | Seconds(s)     |
| cluster_usage_buckets_total_bytes         | Total bytes in buckets within the cluster                     | Bytes(B)   |
| cluster_usage_objects_buckets_count       | Number of object buckets within the cluster                     | Count        |
| cluster_usage_objects_count               | Number of objects within the cluster                       | Count        |
| cluster_usage_objects_since_last_update_seconds | Seconds since the last update of objects within the cluster           | Seconds(s)     |
| cluster_usage_objects_size_distribution   | Size distribution of objects within the cluster                   | Bytes(B)   |
| cluster_usage_objects_total_bytes         | Total bytes of objects within the cluster                   | Bytes(B)   |
| cluster_usage_objects_version_count_distribution | Object version count distribution within the cluster         | Count        |
| ilm_versions_scanned                      | Number of ILM versions scanned                         | Occurrences        |
| logger_webhook_failed_messages            | Number of failed webhook messages in logs                   | Entries        |
| logger_webhook_queue_length               | Length of webhook queue in logs                     | Entries        |
| logger_webhook_total_messages             | Total number of webhook messages in logs                     | Entries        |
| scanner_bucket_scans_finished             | Number of completed bucket scans by the scanner                     | Occurrences        |
| scanner_bucket_scans_started              | Number of started bucket scans by the scanner                     | Occurrences        |
| scanner_directories_scanned               | Number of directories scanned by the scanner                       | Count        |
| scanner_last_activity_seconds            | Seconds since the last activity of the scanner                       | Seconds(s)     |
| scanner_objects_scanned                   | Number of objects scanned by the scanner                       | Count        |
| scanner_versions_scanned                  | Number of versions scanned by the scanner                       | Count        |
| system_cpu_avg_idle                       | Average idle percentage of system CPU                     | %         |
| system_cpu_avg_iowait                     | Average IO wait percentage of system CPU                   | %         |
| system_cpu_load                          | System CPU load                             | Load      |
| system_cpu_load_perc                      | System CPU load percentage                       | %         |
| system_cpu_system                        | Percentage of system CPU used by the system                     | %         |
| system_cpu_user                          | Percentage of system CPU used by users                     | %         |
| system_drive_api_latency_micros           | Microseconds latency of system drive API                 | Microseconds(μs)  |
| system_drive_count                       | Number of system drives                         | Count        |
| system_drive_free_bytes                   | Free bytes on system drives                     | Bytes(B)   |
| system_drive_free_inodes                  | Free inodes on system drives                   | Count        |
| system_drive_health                       | Health status of system drives                       | Health Status   |
| system_drive_online_count                  | Number of online system drives                       | Count        |
| system_drive_perc_util                    | Percentage utilization of system drives                     | %         |
| system_drive_total_bytes                  | Total bytes on system drives                       | Bytes(B)   |
| system_drive_total_inodes                 | Total inodes on system drives                     | Count        |
| system_drive_used_bytes                   | Used bytes on system drives                     | Bytes(B)   |
| system_drive_used_inodes                  | Used inodes on system drives                   | Count        |
| system_drive_writes_await                 | Write await time of system drives                   | Time      |
| system_drive_writes_kb_per_sec             | KB written per second on system drives                 | KB/second     |
| system_drive_writes_per_sec                | Writes per second on system drives                   | Occurrences/second     |
| system_memory_available                   | Available bytes of system memory                       | Bytes(B)   |
| system_memory_buffers                     | Buffer bytes of system memory                     | Bytes(B)   |
| system_memory_cache                       | Cache bytes of system memory                       | Bytes(B)   |
| system_memory_free                        | Free bytes of system memory                       | Bytes(B)   |
| system_memory_shared                      | Shared bytes of system memory                       | Bytes(B)   |
| system_memory_total                       | Total bytes of system memory                         | Bytes(B)   |
| system_memory_used                        | Used bytes of system memory                       | Bytes(B)   |
| system_memory_used_perc                    | Percentage of used system memory                     | %         |
| system_process_cpu_total_seconds           | Total seconds of system process CPU usage                       | Seconds(s)     |
| system_process_file_descriptor_limit_total  | Total limit of file descriptors for system processes               | Count        |
| system_process_file_descriptor_open_total   | Total open file descriptors for system processes               | Count        |
| system_process_go_routine_total            | Total Go routines for system processes                     | Count        |
| system_process_io_rchar_bytes              | Total bytes read from IO by system processes                 | Bytes(B)   |
| system_process_io_read_bytes               | Total bytes read by system processes                     | Bytes(B)   |
| system_process_io_wchar_bytes              | Total bytes written to IO by system processes                 | Bytes(B)   |
| system_process_io_write_bytes              | Total bytes written by system processes                     | Bytes(B)   |
| system_process_resident_memory_bytes       | Resident memory bytes of system processes                   | Bytes(B)   |
| system_process_start_time_seconds          | Start time in seconds of system processes                     | Seconds |

For more MinIO V3 Metrics, refer to the [official MinIO website](https://min.io/docs/minio/linux/operations/monitoring/metrics-and-alerts.html#version-3-endpoints).