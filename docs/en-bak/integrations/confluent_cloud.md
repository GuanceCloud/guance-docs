---
title     : 'Confluent Cloud'
summary   : 'Collecting Kafka metric data from Confluent Cloud'
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

Collecting Kafka metric data from Confluent Cloud

## Configuration {#config}

### Confluent Cloud metric integration

1. Login [Confluent Cloud](https://login.confluent.io/)，Select **Metrics** under **ADMINISTRATION**

2. Click the button **New integration** on the **Metrics** page and select the monitoring type `Prometheus`

3. Click the **Generate Cloud API Key** button to generate an `API Key`

4. Select the **Resources** type as **All Kafka clusters**, generate the `scrpe_comfigs` for `Prometheus`

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

Because `Confluent Cloud` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.


Go to the installation directory of [DataKit](./datakit_dir.md) and copy `prom.d/prom.sample` to `confluent_cloud.conf`.

> `cp prom.conf.sample confluent_cloud.conf`


Adjust the content of `confluent_cloud.conf` as follows:

```toml
# {"version": "1.61.0-testing_testing-graphite-metric-set", "desc": "do NOT edit this line"}

[[inputs.prom]]
  ## Exporter URLs.
  urls = ["https://api.telemetry.confluent.cloud/v2/metrics/cloud/export?resource.kafka.id=lkc-xxxx"]
  
  source = "confluent_cloud"

  ## Add HTTP headers to data pulling (Example basic authentication).
  [inputs.prom.http_headers]
     Authorization = "Basic QkXXXXXXXXXXXX"

  interval = "60s"

```

Parameter adjustment instructions ：

- urls: Adjust the content copied by **Confluent Cloud** and concatenate it into a URL. If there are multiple Kafka resources, separate them with commasAdjust the content copied by Confluent Cloud and concatenate it into a URL. If there are multiple Kafka resources, separate them with commas

- Authorization: Convert username and password into Basic Authorization format

- interval: Adjusted to 60s, due to the Confluent Cloud API limitation, this value cannot be less than 60s, as a value lower than 60s will result in the inability to collect data


### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### confluent

| Metrics | Description | Unit |
| -- | -- | -- |
| `kafka_server_active_connection_count` | The count of active authenticated connections. | count |
| `kafka_server_consumer_lag_offsets` | The lag between a group member's committed offset and the partition's high watermark.|count |
| `kafka_server_partition_count` | The number of partitions. |count |
| `kafka_server_received_bytes` | The delta count of bytes of the customer's data received from the network. Each sample is the number of bytes received since the previous data sample. The count is sampled every 60 seconds. |byte |
| `kafka_server_received_records` | The delta count of records received. Each sample is the number of records received since the previous data sample. The count is sampled every 60 seconds. |count |
| `kafka_server_request_bytes` | The delta count of total request bytes from the specified request types sent over the network. Each sample is the number of bytes sent since the previous data point. The count is sampled every 60 seconds.|byte |
| `kafka_server_request_count` | The delta count of requests received over the network. Each sample is the number of requests received since the previous data point. The count sampled every 60 seconds. |count |
| `kafka_server_response_bytes` | The delta count of total response bytes from the specified response types sent over the network. Each sample is the number of bytes sent since the previous data point. The count is sampled every 60 seconds. |byte |
| `kafka_server_rest_produce_request_bytes` | The delta count of total request bytes from Kafka REST produce calls sent over the network requested by Kafka REST. |byte |
| `kafka_server_retained_bytes` | The current count of bytes retained by the cluster. The count is sampled every 60 seconds. |byte |
| `kafka_server_sent_bytes` | The delta count of bytes of the customer's data sent over the network. Each sample is the number of bytes sent since the previous data point. The count is sampled every 60 seconds. |byte |
| `kafka_server_sent_records` |The delta count of records sent. Each sample is the number of records sent since the previous data point. The count is sampled every 60 seconds. |count |
| `kafka_server_successful_authentication_count` |The delta count of successful authentications. Each sample is the number of successful authentications since the previous data point. The count sampled every 60 seconds. |count |

