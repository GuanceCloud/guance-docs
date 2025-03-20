---
title     : 'GreenPlum'
summary   : 'Collect GreenPlum Metrics information'
__int_icon: 'icon/greenplum'
dashboard :
  - desc  : 'GreenPlum'
    path  : 'dashboard/zh/greenplum'
monitor   :
  - desc  : 'GreenPlum'
    path  : 'monitor/zh/greenplum'
---

<!-- markdownlint-disable MD025 -->
# GreenPlum
<!-- markdownlint-enable -->

Greenplum is a high-performance, highly available database system based on the Massively Parallel Processing (MPP) architecture. It is mainly used for processing and analyzing large-scale datasets. Greenplum applies to data warehousing, business intelligence, and big data analytics scenarios, especially when handling PB-level data volumes, providing efficient data storage and analysis capabilities. The observability of Greenplum includes monitoring database performance, detecting and notifying failures, as well as visualizing the system's operational status.

## Installation Configuration {#config}

### Prerequisites {#requirement}

Greenplum version 5 or 6, tested versions:

- 6.24.3

### Exporter Installation

You can download and install [greenplum exporter](https://github.com/tangyibo/greenplum_exporter/releases/tag/v1.1), which is a data collector that exposes Greenplum metrics as Prometheus data and supports both GP5 and GP6.

- For example, on CentOS, the startup command is as follows:

```bash
export GPDB_DATA_SOURCE_URL=postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable
./greenplum_exporter --web.listen-address="0.0.0.0:9297" --web.telemetry-path="/metrics" --log.level=error
```

- If running via Docker, the startup command is as follows:

```bash
docker run -d -p 9297:9297 -e GPDB_DATA_SOURCE_URL=postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable inrgihc/greenplum-exporter:latest 
```

Note: The environment variable GPDB_DATA_SOURCE_URL specifies the connection string for connecting to the Greenplum database (please use the gpadmin account to connect to the postgres database). This connection string starts with `postgres://`, and its format is as follows:

```bash
postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable
postgres://[Database connection account, must be gpadmin]:[Account password, i.e., gpadmin's password]@[Database IP address]:[Database port]/[Database name, must be postgres]?[Parameter name]=[Parameter value]&[Parameter name]=[Parameter value] 
```

Then access the URL for monitoring metrics: `http://127.0.0.1:9297/metrics`

More startup parameters:

```bash
usage: greenplum_exporter [<flags>]

Flags:
  -h, --help                   Show context-sensitive help (also try --help-long and --help-man).
      --web.listen-address="0.0.0.0:9297"  
                               web endpoint
      --web.telemetry-path="/metrics"
                               Path under which to expose metrics.
      --disableDefaultMetrics  do not report default metric
      (go metrics and process metrics)
      --version                Show application version.
      --log.level="info"       Only log messages with the given severity or above. Valid levels: [debug, info, warn, error, fatal]
      --log.format="logger:stderr"  
                               Set the log target and format. Example: "logger:syslog?appname=bob&local=7" or "logger:stdout?json=true"
```

### Collector Configuration

#### Host Installation

- [Install Datakit](https://docs.guance.com/datakit/datakit-install/)
  
#### Configure Collector
Since `greenplum exporter` can directly expose `metrics` URLs, it can be collected directly through the prom collector by configuring the corresponding URL for collection.
Navigate to the `conf.d/prom` directory under the DataKit installation directory, copy `prom.conf.sample` and rename it to `greenplum.conf`

``` yaml
cp prom.conf.sample greenplum.conf
```

Adjust the content of `greenplum.conf` as follows:

```yaml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://127.0.0.1:9297/metrics"]
  ## Collector alias.
  source = "greenplum"
...
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Other configurations should be adjusted as needed*</font>,
Parameter adjustment description:
<!-- markdownlint-enable -->
- urls: prom metrics address; here fill in the metrics url exposed by greenplum. If DataKit is installed on the Greenplum host, the default is `http://127.0.0.1:9297/metrics`
- source: data source, change to greenplum for easier filtering of metrics later
- interval: collection interval

#### Restart Datakit

[Restart Datakit](https://docs.guance.com/datakit/datakit-service-how-to/#manage-service)

## Metrics {#metric}

### GreenPlum Metric Sets

| Metrics | Description | Unit |
|:--------|:-----|:-- |
|`cluster_state`|`gp reachable state ? 1→ Available; 0→ Unavailable`| boolean |
|`cluster_uptime`|`Time since start`| s |
|`cluster_max_connections`|`Maximum number of connections`| int |
|`cluster_total_connections`|`Current number of connections`| int |
|`cluster_idle_connections`|`Idle connections`| int |
|`cluster_active_connections`|`Active connections`| int |
|`cluster_running_connections`|`Connections currently executing queries`| int |
|`cluster_waiting_connections`|`Connections waiting to execute queries`| int |
|`node_segment_status`|`Segment status`| int |
|`node_segment_role`|`Segment role`| int |
|`node_segment_mode`|`Segment mode`| int |
|`node_segment_disk_free_mb_size`|`Free disk space size (MB) on segment host`| MB |
|`cluster_total_connections_per_client`|`Total number of connections per client`| int |
|`cluster_idle_connections_per_client`|`Idle connections per client`| int |
|`cluster_active_connections_per_client`|`Active connections per client`| int |
|`cluster_total_online_user_count`|`Number of online accounts`| int |
|`cluster_total_client_count`|`Total number of clients connected`| int |
|`cluster_total_connections_per_user`|`Total number of connections per user`| int |
|`cluster_idle_connections_per_user`|`Idle connections per user`| int |
|`cluster_active_connections_per_user`|`Active connections per user`| int |
|`cluster_config_last_load_time_seconds`|`System configuration load time`| s |
|`node_database_name_mb_size`|`Storage space occupied by each database`| MB |
|`node_database_table_total_count`|`Total number of tables in each database`| int |
|`exporter_total_scraped`|`Number of successfully scraped metrics`| int |
|`exporter_total_error`|`Total number of errors`| int |
|`exporter_scrape_duration_second`|`Duration of data collection`| s |
|`server_users_name_list`|`Total number of users`| int |
|`server_users_total_count`|`User details`| int |
|`server_locks_table_detail`|`Lock information`| int |
|`server_database_hit_cache_percent_rate`|`Cache hit rate`| float |
|`server_database_transition_commit_percent_rate`|`Transaction commit rate`| float |
|`server_database_table_bloat_list`|`Data bloat list`| int |
|`server_locks_table_detail`|`Lock information`| int |