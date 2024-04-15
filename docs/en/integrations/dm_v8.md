---
title     : 'Dameng Database（DM8）'
summary   : 'Collect information about Dameng Database metrics'
__int_icon: 'icon/dm'
dashboard :
  - desc  : 'Dameng Database（DM8）Monitoring View'
    path  : 'dashboard/zh/dm_v8'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `Dameng` Database（DM8）
<!-- markdownlint-enable -->

## Installation Configuration{#config}

- [x] Installation DM8
- [x] Installation DEM

**DEM**, also known as `Dameng Enterprise Manager`, is a web tool provided by `Dameng` and written based on `Java` for monitoring `Dameng` databases.

Directory as `$DM_HOME/web`, the current directory stores the DEM installation manual (`DEM.pdf`) and the running program `dem.war`, and deploy according to the manual.

### Metrics

The default exposure metric port for DEM is `8090`, and the metric related information can be viewed through a browser: `http://clientIP:8090/dem/metrics`。


### DataKit Collector Configuration

Because `DEM` can expose `metrics` URL directly, it can be collected directly through [`prom`](./prom.md) collector.


The adjustments are as follows:

```toml

urls = ["http://clientIP:8090/dem/metrics"]
source = "dm"
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

|Tags| Describe |
| -- | -- |
| `global_status_sessions` | session count |
| `global_status_threads` | thread count |
| `global_status_tps` | TPS |
| `global_status_qps` | QPS |
| `global_status_ddlps` | `ddlps` |
| `global_status_ips` | per seconds `instert` count |
| `global_status_ups` | per seconds `update` count |
| `global_status_dps` | per seconds `delete` count |
| `mf_status_memory_mem_used_bytes` | used memory bytes |
| `mf_status_memory_mem_total_bytes` | total memory bytes |
| `mf_status_disk_used_bytes` | used disk bytes |
| `mf_status_disk_total_bytes` | total disk bytes |
| `mf_status_disk_read_speed_bytes` | disk read speed bytes |
| `mf_status_disk_write_speed_bytes` | disk write speed bytes |
| `mf_status_network_receive_speed_bytes` | network receive speed bytes |
| `mf_status_network_transmit_speed_bytes` | network transmit speed bytes |

