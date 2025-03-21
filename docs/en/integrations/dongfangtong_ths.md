---
title     : 'Oriente THS (TongHttpServer)'
summary   : 'Collect running Metrics information of Oriente THS (TongHttpServer)'
__int_icon: 'icon/dongfangtong'
dashboard :
  - desc  : 'Oriente THS (TongHttpServer) monitoring view'
    path  : 'dashboard/en/dongfangtong_ths'
monitor   :
  - desc  : 'Not exist'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Oriente THS (TongHttpServer)
<!-- markdownlint-enable -->

## Installation and Configuration {#config}

### Configure API Monitoring Interface

The API monitoring interface needs to be set up in only one virtual host. `THS` supports HTTP data statistics, and other applications can obtain `json` data by adding `/http/monitor/format/json` to the `route` name, which can then be integrated into the monitoring system.

By default, adjust `httpserver.conf`

```nginx
    location /api {
        access_log off;
        api write=off;
        status_bypass on;
        allow 127.0.0.1;
        deny all;
    }
```


### Enable Exporter

Since the built-in API interface of `THS` returns data in `json` format, which does not conform to `Metrics`, an additional `exporter` is required for conversion. **We look forward to the official version being able to perform this conversion automatically**.

- Download

Download link `https://github.com/lrwh/dongfangtong-ths-exporter/releases`

- Run

**Note that the `jdk` version must be `jdk1.8` or higher**

```shell
java -jar dongfangtong-ths-exporter.jar --ths.url=http://localhost:8080/api/http/monitor/format/json
```


### Enable DataKit Collector

Since `dongfangtong-ths-exporter` can directly expose a `metrics` URL, it can be collected directly through the [`prom`](./prom.md) collector.



The adjustment content is as follows:

```toml

urls = ["http://localhost:8081/ths/metrics"]

source = "ths-prom"

interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>
<!-- markdownlint-enable -->
, parameter adjustment explanation :

- urls: `Prometheus` Metrics address, fill in the Metrics URL exposed by the corresponding component here.
- source: Collector alias, it's recommended to make distinctions.
- interval: Collection interval

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

| Metric | Description |
| -- | -- |
| `ths_info_up` | Startup information |
| `ths_server_zone_response` | Zone response |
| `ths_server_zone_request` | Zone request |
| `ths_server_zone_traffic` | Zone traffic |
| `ths_shared_zone_size` | Zone size |
| `ths_server_zone_over_count` | Zone over count |
| `ths_connections` | `ths` connects |


For more Metrics information, [refer to the documentation](https://github.com/lrwh/dongfangtong-ths-exporter/blob/main/TongHttpServer%20v6.0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf)

</example>