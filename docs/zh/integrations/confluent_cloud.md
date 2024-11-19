---
title     : 'Confluent Cloud'
summary   : '从 Confluent Cloud 采集 Kafka 指标数据'
__int_icon: 'icon/confluent'
tags:
  - '中间件'
dashboard :
  - desc  : 'Confluent Cloud'
    path  : 'dashboard/zh/confluent_cloud'
monitor   :
  - desc  : 'Confluent Cloud'
    path  : 'monitor/zh/confluent_cloud'
---

从 Confluent Cloud 采集 Kafka 指标数据

## 配置 {#config}

### Confluent Cloud 指标集成配置

1. 登陆 Confluent Cloud，在 **ADMINISTRATION** 下选择 **Metrics**

2. 在 **Metrics** 页点击按钮 **New integration**,选择监控类型 `Prometheus`

3. 点击 **Generate Cloud API key** 按钮，生成 `API Key`

4. **Resources** 选择 **All Kafka clusters**，生成 `Prometheus` 的 `scrape_configs`

5. 点击页面 **Copy** 按钮进行内容复制

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

### DataKit 采集器配置

由于`Confluent Cloud`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `confluent_cloud.conf`。

> `cp prom.conf.sample confluent_cloud.conf`

调整`confluent_cloud.conf`内容如下：

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

调整参数说明 ：

- urls: 将 `Confluent Cloud` 复制的内容调整下，拼接成 url,如果有多个kafka资源，则用逗号分割

- Authorization: 将用户名和密码转化成 Basic Authorization 格式

- interval: 调整为 60s，由于`Confluent Cloud` API 限制，这个值不能小于 `60s`,低于这个值将导致无法采集数据


### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### confluent 指标集

| 指标名称 | 描述 | 单位 |
| -- | -- | -- |
| `kafka_server_active_connection_count` | 活跃认证连接数 | count |
| `kafka_server_consumer_lag_offsets` | 组成员提交的偏移量与分区的高水位标记之间的滞后量。 |count |
| `kafka_server_partition_count` | 分区数量 |count |
| `kafka_server_received_bytes` | 从网络接收的客户数据字节数的增量计数。每个样本是自上一个数据样本以来接收的字节数。计数每60秒采样一次。 |byte |
| `kafka_server_received_records` | 接收的记录数的增量计数。每个样本是自上一个数据样本以来接收的记录数。计数每60秒采样一次。 |count |
| `kafka_server_request_bytes` | 指定请求类型通过网络发送的总请求字节数的增量计数。每个样本是自上一个数据点以来发送的字节数。计数每60秒采样一次。 |byte |
| `kafka_server_request_count` | 通过网络接收的请求数的增量计数。每个样本是自上一个数据点以来接收的请求数。计数每60秒采样一次。 |count |
| `kafka_server_response_bytes` | 指定响应类型通过网络发送的总响应字节数的增量计数。每个样本是自上一个数据点以来发送的字节数。计数每60秒采样一次。 |byte |
| `kafka_server_rest_produce_request_bytes` | Kafka REST产生调用发送的总请求字节数的增量计数。|byte |
| `kafka_server_retained_bytes` | 集群保留的字节数当前计数。计数每60秒采样一次。 |byte |
| `kafka_server_sent_bytes` | 通过网络发送的客户数据字节数的增量计数。每个样本是自上一个数据点以来发送的字节数。计数每60秒采样一次。 |byte |
| `kafka_server_sent_records` | 发送的记录数的增量计数。每个样本是自上一个数据点以来发送的记录数。计数每60秒采样一次。 |count |
| `kafka_server_successful_authentication_count` | 成功认证的增量计数。每个样本是自上一个数据点以来成功认证的数量。计数每60秒采样一次。 |count |

