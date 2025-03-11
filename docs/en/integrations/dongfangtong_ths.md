---
title     : 'TongHttpServer (THS) by Dongfangtong'
summary   : 'Collect runtime Metrics information of TongHttpServer (THS) by Dongfangtong'
__int_icon: 'icon/dongfangtong'
dashboard :
  - desc  : 'TongHttpServer (THS) by Dongfangtong monitoring view'
    path  : 'dashboard/en/dongfangtong_ths'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# TongHttpServer (THS) by Dongfangtong
<!-- markdownlint-enable -->

## Installation and Configuration {#config}

### Configure API Monitoring Interface

The API monitoring interface only needs to be set up in one virtual host. `THS` supports HTTP data statistics, and other applications can obtain `json` data by appending `/http/monitor/format/json` to the `route` name, which can then be integrated into the monitoring system.

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

Since the built-in API interface of `THS` returns data in `json` format, which does not conform to `Metrics`, an additional `exporter` needs to be written for conversion. **We look forward to official support for direct conversion**.

- Download

Download from `https://github.com/lrwh/dongfangtong-ths-exporter/releases`

- Run

**Note: Ensure `JDK` version is `JDK1.8` or higher**

```shell
java -jar dongfangtong-ths-exporter.jar --ths.url=http://localhost:8080/api/http/monitor/format/json
```

### Enable DataKit Collector

Since `dongfangtong-ths-exporter` can directly expose a `metrics` URL, it can be collected directly using the [`prom`](./prom.md) collector.

Adjust the configuration as follows:

```toml
urls = ["http://localhost:8081/ths/metrics"]

source = "ths-prom"

interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>
<!-- markdownlint-enable -->
Parameter adjustment notes:

- urls: The `Prometheus` metrics address; fill in the metrics URL exposed by the corresponding component.
- source: Alias for the collector; it is recommended to differentiate this.
- interval: Collection interval

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

| Metric | Description |
| --- | --- |
| `ths_info_up` | Startup information |
| `ths_server_zone_response` | Zone response |
| `ths_server_zone_request` | Zone request |
| `ths_server_zone_traffic` | Zone traffic |
| `ths_shared_zone_size` | Zone size |
| `ths_server_zone_over_count` | Zone over count |
| `ths_connections` | Connections |

For more metric information, refer to the [documentation](https://github.com/lrwh/dongfangtong-ths-exporter/blob/main/TongHttpServer%20v6.0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf)
