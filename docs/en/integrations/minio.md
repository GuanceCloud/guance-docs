---
title     : 'MinIO'
summary   : 'Collection of MinIO related Metrics information'
__int_icon: 'icon/minio'
dashboard :
  - desc  : 'MinIO monitoring view'
    path  : 'dashboard/en/minio'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# MinIO
<!-- markdownlint-enable -->


Display of MinIO performance Metrics, including MinIO uptime, storage space distribution, bucket details, file size range distribution, S3 TTFB (s) distribution, S3 traffic, S3 requests, etc.


## Configuration {#config}

### Version Support

- MinIO version: ALL

Note: The example MinIO version is RELEASE.2022-06-25T15-50-16Z (commit-id=bd099f5e71d0ea511846372869bfcb280a5da2f6)

### Metrics Collection

MinIO by default exposes [metrics](https://docs.min.io/minio/baremetal/monitoring/metrics-alerts/collect-minio-metrics-using-prometheus.html?ref=con#minio-metrics-collect-using-prometheus), which can be directly collected through Prometheus.

- Use `minio-client` (shortened to `mc`) to create authorization information

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

???+ info "Note"
    MinIO only provides the ability to generate `token` information via `mc`, which can be used for `prometheus` Metrics collection. This does not include generating a corresponding prometheus server; the output information includes `bearer_token`, `metrics_path`, `scheme`, and `targets`. These pieces of information can be used to construct the final URL.

- Enable DataKit collector

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom-minio.conf
```

- Modify the `prom-minio.conf` configuration file
<!-- markdownlint-disable MD046 -->
??? quote "`prom-minio.conf`"
    ```toml hl_lines="3 8 9 12 24 28 29 30"
    [[inputs.prom]]
      # Exporter URLs
      urls = ["http://192.168.0.210:9000/minio/v2/metrics/cluster"]

      # Ignore request errors for the url
      ignore_req_err = false
      # Collector alias
      source = "minio"
      metric_types = []

      # Retain Metrics to prevent Time Series from exploding
      metric_name_filter = ["minio_bucket","minio_cluster","minio_node","minio_s3","minio_usage"]
      # Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "1m"

      # TLS configuration
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"

      # Filter tags, multiple tags can be configured
      # Matched tags will be ignored, but the corresponding data will still be reported
      tags_ignore = ["version","le","commit"]

      # Custom authentication method, currently only supports Bearer Token
      # token and token_file: Only one needs to be configured
      [inputs.prom.auth]
        type = "bearer_token"
        token = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjQ4MTAwNzIxNDQsImlzcyI6InByb21ldGhldXMiLCJzdWIiOiJtaW5pb2FkbWluIn0.tzoJ7ifMxgx4jXfUKdD_Sq5Ll2-YlbaBu6FuNTZcc88t9o9STyg4yicRAgYmezVGFwYR2VFKvBSBnOnVnb0n4w"
      # token_file = "/tmp/token"

      # Customize Measurement name
      # Metrics with the prefix can be grouped into one Measurement
      # Custom Measurement name configuration takes precedence over measurement_name configuration item
      #[[inputs.prom.measurements]]
      #  prefix = "cpu_"
      #  name = "cpu"

      # [[inputs.prom.measurements]]
      # prefix = "mem_"
      # name = "mem"

      # Discard data matching the following tag-related data
      [inputs.prom.ignore_tag_kv_match]
      # key1 = [ "val1.*", "val2.*"]
      # key2 = [ "val1.*", "val2.*"]

      # Add extra request headers in the HTTP request for data fetching
      [inputs.prom.http_headers]
      # Root = "passwd"
      # Michael = "1234"

      # Rename tag keys in prom data
      [inputs.prom.tags_rename]
        overwrite_exist_tags = false
        [inputs.prom.tags_rename.mapping]
        # tag1 = "new-name-1"
        # tag2 = "new-name-2"
        # tag3 = "new-name-3"

      # Send collected Metrics as logs to the center
      # If the service field is left blank, it will set the service tag to the Measurement name
      [inputs.prom.as_logging]
        enable = false
        service = "service_name"

      # Custom Tags
      [inputs.prom.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
<!-- markdownlint-enable -->
Main parameter description:

- urls: `prometheus` Metrics address, fill in the exposed Metrics url for MinIO
- source: Collector alias, recommended to use `minio`
- interval: Collection interval
- metric_name_filter: Metric filtering, collect only required Metrics items
- tls_open: TLS configuration
- metric_types: Metric types, if left blank, it means collect all Metrics
- tags_ignore: Ignore unnecessary tags
- [inputs.prom.auth]: Configure authorization information
- token: bearer_token value

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


## Metrics {#metric}

| Metrics                              | Meaning                    |
| ------------------------------------ | -------------------------- |
| node_process_uptime_seconds          | Node uptime               |
| node_disk_free_bytes                 | Node disk free size       |
| node_disk_used_bytes                 | Node disk used size       |
| node_file_descriptor_open_total      | Node file descriptor open count |
| node_go_routine_total                | Node go_routine count     |
| cluster_disk_online_total            | Cluster online disks      |
| cluster_disk_offline_total           | Cluster offline disks     |
| bucket_usage_object_total            | Bucket used object count  |
| bucket_usage_total_bytes             | Bucket used bytes         |
| bucket_objects_size_distribution     | Bucket object size range distribution |
| s3_traffic_received_bytes            | S3 received traffic       |
| s3_traffic_sent_bytes                | S3 sent traffic           |
| s3_requests_total                    | S3 total requests         |
| s3_requests_waiting_total            | S3 waiting requests       |
| s3_requests_errors_total             | S3 total errors           |
| s3_requests_4xx_errors_total         | S3 4xx errors             |
| s3_time_ttfb_seconds_distribution    | S3 TTFB                  |
| usage_last_activity_nano_seconds     | Time since last activity |