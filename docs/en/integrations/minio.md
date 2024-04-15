---
title     : 'MinIO'
summary   : 'Collect information about MinIO related metrics'
__int_icon: 'icon/minio'
dashboard :
  - desc  : 'MinIO Monitoring View'
    path  : 'dashboard/zh/minio'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# MinIO
<!-- markdownlint-enable -->


MinIO performance metrics, including MinIO online time, storage space distribution, bucket details, file size interval distribution, S3 TTFB (s) distribution, S3 traffic, S3 requests, etc.


## Configuration {#config}

### Version support

- MinIO version: ALL

Description: Example MinIO version is RELEASE.2022-06-25T15-50-16Z (commit-id=bd099f5e71d0ea5163869bfcb280a5da2f6)

### Metric Collection

MinIO is exposed by default [metric](https://docs.min.io/minio/baremetal/monitoring/metrics-alerts/collect-minio-metrics-using-prometheus.html?ref=con#minio-metrics-collect-using-prometheus) and can collect relevant metrics directly through Prometheus.

- Create authorization information using `minio-client` (referred to as `mc`)

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

????+ Info "Attention"

- Open DataKit Collector

```shell
cd /usr/local/datakit/conf.d/prom/
cp prom.conf.sample prom-minio.conf
```

- Modify `prom-minio.conf` Profile

<!-- markdownlint-disable MD046 -->
??? Quote " `prom-minio.conf` "
    ```toml hl_lines="3 8 9 12 24 28 29 30"
    [[inputs.prom]]
      # Exporter URLs
      urls = ["http://192.168.0.210:9000/minio/v2/metrics/cluster"]

      ignore_req_err = false

      source = "minio"
      metric_types = []


      metric_name_filter = ["minio_bucket","minio_cluster","minio_node","minio_s3","minio_usage"]

      interval = "1m"

      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"

      tags_ignore = ["version","le","commit"]


      [inputs.prom.auth]
        type = "bearer_token"
        token = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjQ4MTAwNzIxNDQsImlzcyI6InByb21ldGhldXMiLCJzdWIiOiJtaW5pb2FkbWluIn0.tzoJ7ifMxgx4jXfUKdD_Sq5Ll2-YlbaBu6FuNTZcc88t9o9STyg4yicRAgYmezVGFwYR2VFKvBSBnOnVnb0n4w"
      # token_file = "/tmp/token"


      # [[inputs.prom.measurements]]
      # prefix = "mem_"
      # name = "mem"

      [inputs.prom.ignore_tag_kv_match]
      # key1 = [ "val1.*", "val2.*"]
      # key2 = [ "val1.*", "val2.*"]

      [inputs.prom.http_headers]
      # Root = "passwd"
      # Michael = "1234"

      [inputs.prom.tags_rename]
        overwrite_exist_tags = false
        [inputs.prom.tags_rename.mapping]
        # tag1 = "new-name-1"
        # tag2 = "new-name-2"
        # tag3 = "new-name-3"

      [inputs.prom.as_logging]
        enable = false
        service = "service_name"

      [inputs.prom.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
<!-- markdownlint-enable -->


- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


## Metric {#metric}

| Metric | Description                    |
| --------------------------------- | ----------------------- |
|node_process_uptime_seconds| node process uptime |
|node_disk_free_bytes| node disk free bytes        |
|node_disk_used_bytes| node disk used bytes        |
|node_file_descriptor_open_total| node file descriptor open total    |
|node_go_routine_total| node go_routine count    |
|cluster_disk_online_total| cluster disk online total          |
|cluster_disk_offline_total| cluster disk offline total          |
|bucket_usage_object_total| bucket usage object total      |
|bucket_usage_total_bytes| bucket usage total bytes  |
|bucket_objects_size_distribution| bucket objects size distribution |
|s3_traffic_received_bytes| s3 traffic received bytes |
|s3_traffic_sent_bytes| s3 traffic sent bytes|
|s3_requests_total| s3 requests total |
|s3_requests_waiting_total|s3 requests waiting total |
|s3_requests_errors_total| s3 requests errors total |
|s3_requests_4xx_errors_total| s3 requests 4xx errors total  |
|s3_time_ttfb_seconds_distribution| s3 TTFB                 |
|usage_last_activity_nano_seconds| usage last activity nano seconds  |
