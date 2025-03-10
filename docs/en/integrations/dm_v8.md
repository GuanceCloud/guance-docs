---
title     : 'Dameng Database (DM8)'
summary   : 'Collect runtime Metrics information from Dameng Database'
__int_icon: 'icon/dm'
dashboard :
  - desc  : 'Dameng Database (DM8) monitoring view'
    path  : 'dashboard/en/dm_v8'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Dameng Database (DM8)
<!-- markdownlint-enable -->

## Installation and Configuration {#config}

### Prerequisites

- [x] Install DM8
- [x] Install DEM

**DEM** stands for `Dameng Enterprise Manager`, a web tool provided by Dameng, written in `Java` for monitoring the Dameng database.

The directory is `$DM_HOME/web`, which contains the DEM installation manual (`DEM.pdf`) and the runtime program `dem.war`. Follow the manual for deployment.

### Exposing Metrics

DEM exposes metrics on port `8090` by default. You can view metric information via a browser at `http://clientIP:8090/dem/metrics`. If access is not possible, it indicates that the metrics exposure capability has not been enabled. Follow these steps to enable it:

- Add Database

By default, DEM does not monitor databases after installation; configuration is required to start monitoring.

1. Click the menu **Intelligent O&M** -> **Resource Monitoring**, switch the bottom Tab to **Database**.
2. Click `Add` **Single Instance/Cluster**, and fill in the details of the database to be monitored.

- Configure Prometheus

1. Click the menu **System Management** -> **System Settings**, select `prometheus_metric_nodes` under the **Other Features** module.
2. Check the databases you want to monitor. Click the **Confirm** button to complete the configuration.

- Verification

View metric information via a browser at `http://clientIP:8090/dem/metrics`. The port is the DEM access port, which may vary; use the actual port number.

### DataKit Collector Configuration

Since `DEM` can directly expose `metrics` URLs, you can collect metrics using the [`prom`](./prom.md) collector.

Adjust the content as follows:

```toml

urls = ["http://clientIP:8090/dem/metrics"]
source = "dm"
interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->
Parameter adjustment notes:

- urls: Prometheus Metrics URL, enter the exposed Metrics URL of the corresponding component.
- source: Collector alias, recommended to differentiate.
- interval: Collection interval.

### Restart DataKit

```shell
systemctl restart datakit
```

## Metrics {#metric}

| Metric | Description |
| --- | --- |
| `global_status_sessions` | Number of sessions |
| `global_status_threads` | Threads |
| `global_status_tps` | Transactions per second (TPS) |
| `global_status_qps` | Queries per second (QPS) |
| `global_status_ddlps` | DDL operations per second |
| `global_status_ips` | Insert operations per second |
| `global_status_ups` | Update operations per second |
| `global_status_dps` | Delete operations per second |
| `mf_status_memory_mem_used_bytes` | Used memory size |
| `mf_status_memory_mem_total_bytes` | Total memory size |
| `mf_status_disk_used_bytes` | Used disk size |
| `mf_status_disk_total_bytes` | Total disk size |
| `mf_status_disk_read_speed_bytes` | Disk read speed |
| `mf_status_disk_write_speed_bytes` | Write speed |
| `mf_status_network_receive_speed_bytes` | Receive speed |
| `mf_status_network_transmit_speed_bytes` | Transmit speed |