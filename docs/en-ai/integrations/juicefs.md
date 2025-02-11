---
title     : 'JuiceFS'
summary   : 'Collect metrics information related to JuiceFS data size, IO, transactions, objects, clients, and other components'
__int_icon: 'icon/juicefs'
dashboard :
  - desc  : 'JuiceFS monitoring view'
    path  : 'dashboard/en/juicefs'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# [JuiceFS](https://juicefs.com/docs/en/community/introduction/)
<!-- markdownlint-enable -->

Collect metrics information related to JuiceFS data size, IO, transactions, objects, clients, and other components.

## Installation and Configuration {#config}

### JuiceFS Metrics

JuiceFS exposes the metrics endpoint by default on port `9567`. You can view the metrics information via a browser at `http://clientIP:9567/metrics`.

### DataKit Collector Configuration

Since `JuiceFS` can directly expose a `metrics` URL, you can use the [`prom`](./prom.md) collector for metric collection.

The configuration changes are as follows:

```toml
urls = ["http://localhost:9567/metrics"]

source = "juicefs"

interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>
<!-- markdownlint-enable -->

Parameter adjustment explanation:

- urls: Prometheus metrics address, fill in the metrics URL exposed by the corresponding component.
- source: Collector alias, it is recommended to differentiate.
- interval: Collection interval

### Restart DataKit

```shell
systemctl restart datakit
```

## Metrics {#metric}

For detailed metrics information, refer to the [official documentation](https://juicefs.com/docs/en/community/p8s_metrics)