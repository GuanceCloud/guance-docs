---
title     : 'Dameng Database (DM8)'
summary   : 'Collecting operational Metrics information from Dameng Database'
__int_icon: 'icon/dm'
dashboard :
  - desc  : 'Dameng Database (DM8) monitoring View'
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

**DEM** stands for `Dameng Enterprise Manager`, which is a web tool provided by Dameng, written in `Java` for monitoring the Dameng database.

The directory is `$DM_HOME/web`, where you can find the DEM installation manual (`DEM.pdf`) and the runtime program `dem.war`. Follow the manual to deploy it.

### Exposing Metrics

DEM exposes metrics on port `8090` by default. You can view the metrics information via a browser at `http://clientIP:8090/dem/metrics`. If you cannot access it, it means that the metrics exposure capability has not been enabled. Follow these steps to enable it:

- Add Database

By default, DEM does not monitor databases immediately after installation. You need to configure it to start monitoring.

1. Click on the menu **Intelligent O&M** -> **Resource Monitoring**, switch the bottom Tab to **Database**.
2. Click `Add` **Single Instance/Cluster**, and fill in the details of the database to be monitored.

- Configure Prometheus

1. Click on the menu **System Management** -> **System Settings**, select `prometheus_metric_nodes` under the **Other Features** module.
2. Check the databases you want to monitor. Click the **Confirm** button to complete the configuration.

- Verification

View the metrics information via a browser at `http://clientIP:8090/dem/metrics`. The port is the DEM access port, which may vary; use the actual port accordingly.

### DataKit Collector Configuration

Since `DEM` can directly expose a `metrics` URL, you can collect metrics using the [`prom`](./prom.md) collector.

Adjust the configuration as follows:

```toml
urls = ["http://clientIP:8090/dem/metrics"]
source = "dm"
interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>
<!-- markdownlint-enable -->

Parameter adjustment instructions:

- urls: Prometheus metrics address, fill in the exposed metrics URL of the corresponding component.
- source: Collector alias, it's recommended to differentiate them.
- interval: Collection interval

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
| `global_status_ddlps` | Data Definition Language operations per second (DDLPS) |
| `global_status_ips` | Inserts per second |
| `global_status_ups` | Updates per second |
| `global_status_dps` | Deletes per second |
| `mf_status_memory_mem_used_bytes` | Used memory size |
| `mf_status_memory_mem_total_bytes` | Total memory size |
| `mf_status_disk_used_bytes` | Used disk size |
| `mf_status_disk_total_bytes` | Total disk size |
| `mf_status_disk_read_speed_bytes` | Disk read speed |
| `mf_status_disk_write_speed_bytes` | Write speed |
| `mf_status_network_receive_speed_bytes` | Receive speed |
| `mf_status_network_transmit_speed_bytes` | Transmit speed |