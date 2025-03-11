---
title     : 'Dongfangtong THS（TongHttpServer）'
summary   : 'Collect information about Dongfangtong THS（TongHttpServer） metrics'
__int_icon: 'icon/dongfangtong'
dashboard :
  - desc  : 'Dongfangtong THS（TongHttpServer）Monitoring View'
    path  : 'dashboard/zh/dongfangtong_ths'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `Dongfangtong` THS（TongHttpServer）
<!-- markdownlint-enable -->

## Installation Configuration{#config}

### Configure monitoring API


The API monitoring interface only needs to be set in a virtual host, and `THS` supports HTTP data statistics. Other applications can obtain `JSON` data by adding `/http/monitor/format/JSON` to the `location` name, and integrate it into the monitoring system.

Default adjustment `httpserver.conf`

```nginx
    location /api {
        access_log off;
        api write=off;
        status_bypass on;
        allow 127.0.0.1;
        deny all;
    }
```


### Run Exporter


Due to the fact that the API interface provided by `THS` returns data in the `json` format, which does not comply with the `metric` format, it is necessary to write an additional `exporter` for conversion. **We look forward to the official conversion**.

- Download

Download `https://github.com/lrwh/dongfangtong-ths-exporter/releases`

- Start

**Note that version `jdk` requires version `jdk1.8` and above**

```shell
java -jar dongfangtong-ths-exporter.jar --ths.url=http://localhost:8080/api/http/monitor/format/json
```


### DataKit Collector Configuration

Because `dongfangtong-ths-exporter` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.

The adjustments are as follows:

```toml

urls = ["http://localhost:8081/ths/metrics"]

source = "ths-prom"

interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations are adjusted as needed*</font>
<!-- markdownlint-enable -->
, adjust parameter description:

<!-- markdownlint-disable MD004 -->
- Urls: `prometheus` Metric address, where you fill in the metric URL exposed by the corresponding component
- Source: Collector alias, recommended to distinguish
- Interval: collection interval

<!-- markdownlint-enable -->
### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

| Metric | Describe |
| -- | -- |
| `ths_info_up` | start  |
| `ths_server_zone_response` | zone response |
| `ths_server_zone_request` | zone request |
| `ths_server_zone_traffic` | zone traffic |
| `ths_shared_zone_size` | zone size |
| `ths_server_zone_over_count` | zone over count|
| `ths_connections` | `ths` connects |


More metric information [reference document](https://github.com/lrwh/dongfangtong-ths-exporter/blob/main/TongHttpServer%20v6.0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf)

