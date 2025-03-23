---
title     : 'Dameng Database (DM8)'
summary   : 'Collect operational Metrics information from Dameng Database'
__int_icon: 'icon/dm'
dashboard :
  - desc  : 'Dameng Database (DM8) Monitoring View'
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

**DEM**, which stands for `Dameng Enterprise Manager`, is a web-based tool provided by Dameng, written in `java`, used to monitor the Dameng database.

The directory is `$DM_HOME/web`, where this directory contains the DEM installation manual (`DEM.pdf`) and the running program `dem.war`. Deployment can be carried out according to the manual.

### Metric Exposure

DEM exposes metrics on port `8090` by default. You can view metric-related information through a browser at `http://clientIP:8090/dem/metrics`. If access fails, it indicates that the capability to expose metrics has not been enabled. Follow the steps below to enable it.

- Add Database

By default, after a successful installation of DEM, it does not directly monitor databases; configuration is required for the database to be monitored.

1. Click on the menu **Intelligent Inspection** -> **Resource Monitoring**, switch the bottom Tab to **Database**,
2. Click `Add` **Single Instance/Cluster**, fill in the details of the database to be monitored.


- Configure Prometheus

1. Click on the menu **System Management** -> **System Settings**, select `prometheus_metric_nodes` under the **Other Features** module,
2. Select the databases that need to be monitored. Click the **Confirm** button to complete the configuration.

- Verification

View metric-related information through a browser at `http://clientIP:8090/dem/metrics`. The port is the DEM access port, which may vary. Use the actual port as appropriate.


### DataKit Collector Configuration

Since `DEM` can directly expose a `metrics` url, collection can be performed using the [`prom`](./prom.md) collector.



Adjustments are as follows:

```toml

urls = ["http://clientIP:8090/dem/metrics"]
source = "dm"
interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations can be adjusted as needed*</font>
<!-- markdownlint-enable -->
, parameter adjustment description:

- urls: `Prometheus` Metrics address, fill in the corresponding component-exposed Metrics url here.
- source: Collector alias, recommended for differentiation.
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
| `global_status_tps` | TPS |
| `global_status_qps` | QPS |
| `global_status_ddlps` | `ddlps` |
| `global_status_ips` | Number of `insert` per second |
| `global_status_ups` | Number of `update` per second |
| `global_status_dps` | Number of `delete` per second |
| `mf_status_memory_mem_used_bytes` | Used memory size |
| `mf_status_memory_mem_total_bytes` | Total memory size |
| `mf_status_disk_used_bytes` | Used disk size |
| `mf_status_disk_total_bytes` | Total disk size |
| `mf_status_disk_read_speed_bytes` | Disk read speed |
| `mf_status_disk_write_speed_bytes` | Write speed |
| `mf_status_network_receive_speed_bytes` | Receive speed |
| `mf_status_network_transmit_speed_bytes` | Send speed |