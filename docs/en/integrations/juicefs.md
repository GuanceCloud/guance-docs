---
title     : 'JuiceFS'
summary   : 'Collect information on component metrics related to JuiceFS data size, IO, transactions, objects, clients, etc.'
__int_icon: 'icon/juicefs'
dashboard :
  - desc  : 'JuiceFS monitoring view'
    path  : 'dashboard/en/juicefs'
monitor   :
  - desc  : 'None available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# [JuiceFS](https://juicefs.com/docs/en/community/introduction/)
<!-- markdownlint-enable -->

Collect information on component metrics related to JuiceFS data size, IO, transactions, objects, clients, etc.

## Installation and Configuration {#config}


### JuiceFS Metrics

JuiceFS exposes the default metrics port as `9567`, where you can view relevant metric information through a browser: `http://clientIP:9567/metrics`.

### DataKit Collector Configuration

Since `JuiceFS` can directly expose a `metrics` URL, it is possible to collect data directly using the [`prom`](./prom.md) collector.



The content to be adjusted is as follows:

```toml

urls = ["http://localhost:9567/metrics"]

source = "juicefs"

interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations may need adjustment*</font>
<!-- markdownlint-enable -->
, parameter adjustment description:

- urls: The `prometheus` metrics address; here, fill in the metrics URL exposed by the corresponding component.
- source: Collector alias, it's recommended to make distinctions.
- interval: Collection interval

### Restart DataKit

```shell
systemctl restart datakit
```

## Metrics {#metric}

For detailed metrics information, refer to the [official documentation](https://juicefs.com/docs/en/community/p8s_metrics)

```