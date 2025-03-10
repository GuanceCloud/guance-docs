---
title     : 'JuiceFS'
summary   : 'Collect JuiceFS data size, IO, things, objects, clients and other related component metric information'
__int_icon: 'icon/juicefs'
dashboard :
  - desc  : 'JuiceFS Monitoring View'
    path  : 'dashboard/zh/juicefs'
monitor   :
  - desc  : 'No'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# [JuiceFS](https://juicefs.com/docs/zh/community/introduction/)
<!-- markdownlint-enable -->

Collect JuiceFS data size, IO, things, objects, clients and other related component metrics information.

## Configuration {#config}


### JuiceFS Metrics

JuiceFS default exposure metrics port is: `9567`, you can view metrics related information through the browser: `http://clientIP:9567/metrics`.

### DataKit Collector Configuration

Because `JuiceFS` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.



The adjustments are as follows:

```toml

urls = ["http://localhost:9567/metrics"]

source = "juicefs"

interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations are adjusted as needed*</font>
<!-- markdownlint-enable -->
, adjust parameter description:

- Urls: `prometheus` Metric address, where you fill in the metric URL exposed by the corresponding component
- Source: Collector alias, recommended to distinguish
- Interval: collection interval

### Restart DataKit

```shell
systemctl restart datakit
```

## index{#metric}

Detailed Metric Information Reference [doc](https://juicefs.com/docs/zh/community/p8s_metrics)


