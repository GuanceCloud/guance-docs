---
title     : 'Confluent Cloud'
summary   : 'Collect Kafka Metrics data from Confluent Cloud'
__int_icon: 'icon/confluent'
tags:
  - 'MIDDLEWARE'
dashboard :
  - desc  : 'Confluent Cloud'
    path  : 'dashboard/en/confluent_cloud'
monitor   :
  - desc  : 'Confluent Cloud'
    path  : 'monitor/en/confluent_cloud'
---

Collect Kafka Metrics data from Confluent Cloud

## Configuration {#config}

### Confluent Cloud Metrics Integration Configuration

1. Log in to Confluent Cloud, under **ADMINISTRATION** select **Metrics**

2. On the **Metrics** page click the button **New integration**, choose monitoring type `Prometheus`

3. Click the **Generate Cloud API key** button to generate an `API Key`

4. Under **Resources** select **All Kafka clusters**, generating `Prometheus`'s `scrape_configs`

5. Click the **Copy** button on the page to copy the content

```yaml
scrape_configs:
  - job_name: Confluent Cloud
    scrape_interval: 1m
    scrape_timeout: 1m
    honor_timestamps: true
    static_configs:
      - targets:
        - api.telemetry.confluent.cloud
    scheme: https
    basic_auth:
      username: H5BO.....
      password: RDCgMwguHMy.....
    metrics_path: /v2/metrics/cloud/export
    params:
      "resource.kafka.id":
        - lkc-xxxx
```

### DataKit Collector Configuration

Since `Confluent Cloud` can directly expose a `metrics` url, it is possible to collect data directly using the [`prom`](./prom.md) collector.

Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, copy `prom.conf.sample` as `confluent_cloud.conf`.

> `cp prom.conf.sample confluent_cloud.conf`

Adjust the contents of `confluent_cloud.conf` as follows:

```toml
# {"version": "1.61.0-testing_testing-graphite-metric-set", "desc": "do NOT edit this line"}

[[inputs.prom]]
  ## Exporter URLs.
  urls = ["https://api.telemetry.confluent.cloud/v2/metrics/cloud/export?resource.kafka.id=lkc-xxxx"]
  
  source = "confluent_cloud"

  ## Add HTTP headers for data pulling (Example basic authentication).
  [inputs.prom.http_headers]
     Authorization = "Basic QkXXXXXXXXXXXX"

  interval = "60s"

```

Parameter adjustment notes:

- urls: Adjust the content copied from `Confluent Cloud` and concatenate into a URL; if there are multiple Kafka resources, separate them with commas.

- Authorization: Convert the username and password into Basic Authorization format.

- interval: Adjust to `60s`, due to `Confluent Cloud` API restrictions, this value cannot be less than `60s`; values below this will result in data not being collected.


### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### Confluent Measurement Set

| Metric Name | Description | Unit |
| -- | -- | -- |
| `kafka_server_active_connection_count` | Active authenticated connection count | count |
| `kafka_server_consumer_lag_offsets` | The lag in offsets between what group members have committed and the high-watermark for partitions. |count |
| `kafka_server_partition_count` | Partition count |count |
| `kafka_server_received_bytes` | Incremental count of client data bytes received over the network. Each sample represents the number of bytes received since the last data sample. Counted every 60 seconds. |byte |
| `kafka_server_received_records` | Incremental count of records received. Each sample represents the number of records received since the last data sample. Counted every 60 seconds. |count |
| `kafka_server_request_bytes` | Incremental count of total request bytes sent over the network for the specified request type. Each sample represents the number of bytes sent since the last data point. Counted every 60 seconds. |byte |
| `kafka_server_request_count` | Incremental count of requests received over the network. Each sample represents the number of requests received since the last data point. Counted every 60 seconds. |count |
| `kafka_server_response_bytes` | Incremental count of total response bytes sent over the network for the specified response type. Each sample represents the number of bytes sent since the last data point. Counted every 60 seconds. |byte |
| `kafka_server_rest_produce_request_bytes` | Incremental count of total request bytes sent by Kafka REST produce calls. |byte |
| `kafka_server_retained_bytes` | Current count of bytes retained by the cluster. Counted every 60 seconds. |byte |
| `kafka_server_sent_bytes` | Incremental count of client data bytes sent over the network. Each sample represents the number of bytes sent since the last data point. Counted every 60 seconds. |byte |
| `kafka_server_sent_records` | Incremental count of records sent. Each sample represents the number of records sent since the last data point. Counted every 60 seconds. |count |
| `kafka_server_successful_authentication_count` | Incremental count of successful authentications. Each sample represents the number of successful authentications since the last data point. Counted every 60 seconds. |count |