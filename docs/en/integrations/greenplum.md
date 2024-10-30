---
title     : 'GreenPlum'
summary   : 'Collect information on greenplum metrics'
__int_icon: 'icon/greenplum'
dashboard :
  - desc  : 'GreenPlum'
    path  : 'dashboard/en/greenplum'
monitor   :
  - desc  : 'GreenPlum'
    path  : 'monitor/en/greenplum'
---

<!-- markdownlint-disable MD025 -->
# GreenPlum
<!-- markdownlint-enable -->

Greenplum is a high-performance and highly available database system based on the massive parallel processing (MPP) architecture, primarily used for processing and analyzing large-scale datasets. Greenplum is suitable for scenarios such as data warehousing, business intelligence, and big data analysis, especially when dealing with PB level data volumes, it can provide efficient data storage and analysis capabilities. Greenplum's observability includes monitoring database performance, detecting and notifying faults, and visualizing system operating status.

## Installation configuration {#config}

### Preconditions {#requirement}

Greenblum 5 or 6 version, tested version:
  
- 6.24.3

### Install Exporter

You can download and install from here [greenlum exporter](https://github.com/tangyibo/greenplum_exporter/releases/tag/v1.1)，This is a data collector that exposes the greenlum metric as prometheus and supports both GP5 and GP6

- Taking CentOS as an example, the startup command is as follows：

```bash
export GPDB_DATA_SOURCE_URL=postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable
./greenplum_exporter --web.listen-address="0.0.0.0:9297" --web.telemetry-path="/metrics" --log.level=error
```

- If running Docker, the startup command is as follows：

```bash
docker run -d -p 9297:9297 -e GPDB_DATA_SOURCE_URL=postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable inrgihc/greenplum-exporter:latest 
```

Note: The environment variable GPDBDATA_SOURCE-URL specifies the connection string to the Greenplum database (please use the gpadmin account to connect to the postgres database), which is prefixed with postgres://and follows the following format:

```bash
postgres://gpadmin:password@10.17.20.11:5432/postgres?sslmode=disable
postgres://[Database connection account, must be gpadmin]:[Account password, i.e. gpadmin password] @ [IP address of database]:[Database port number]/[Database name, must be postgres]?[Parameter Name]=[Parameter Value]&[Parameter Name]=[Parameter Value]
```

Then access the URL address of the monitoring indicator：`http://127.0.0.1:9297/metrics`

More startup parameters：

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

### Collector configuration

#### Host installation

- [Install Datakit](https://docs.guance.com/datakit/datakit-install/)
  
#### Configure collector
Due to the ability of `greenlum exporter` to directly expose metrics URLs, data can be collected directly through the Prom collector by configuring the corresponding URLs.
Go to the`conf.d/prom` directory in the DataKit installation directory, copy `prom.conf.sample` and name it `greenplum.conf`

``` yaml
cp prom.conf.sample greenplum.conf
```

Adjust the content of  `greenblum.conf` as follows：

```yaml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://127.0.0.1:9297/metrics"]
  ## Collector alias.
  source = "greenplum"
...
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>，
Parameter adjustment instructions ：
<!-- markdownlint-enable -->
- urls：prom metrics address, fill in the corresponding indicator URL exposed by greenlum here，If DataKit is installed on the greenlum host, the default is`http://127.0.0.1:9297/metrics`
- source：Change the data source to greenlum for easy filtering of indicators in the future
- interval：Collection interval

#### Restart Datakit

[Restart Datakit](https://docs.guance.com/datakit/datakit-service-how-to/#manage-service)

## Metric {#metric}

### GreenPlum Metric set

| Metrics | Description | Unit |
|:--------|:-----|:-- |
|`cluster_state`|`gp reachable state?: 1 → Available; 0 → Unavailable`| boolean |
|`cluster_uptime`|`Duration of startup`| s |
|`cluster_max_connections`|`Maximum number of connections`| int |
|`cluster_total_connections`|`Current number of connections`| int |
|`cluster_idle_connections`|`Number of idle connections`| int |
|`cluster_active_connections`|`Number of activity connections`| int |
|`cluster_running_connections`|`Number of connections executing query`| int |
|`cluster_waiting_connections`|`Number of connections waiting for query execution`| int |
|`node_segment_status`|`The status of the segment`| int |
|`node_segment_role`|`The role of a segment`| int |
|`node_segment_mode`|`segment of mode`| int |
|`node_segment_disk_free_mb_size`|`Remaining size of segment host disk space (MB)`| MB |
|`cluster_total_connections_per_client`|`Total number of connections per client`| int |
|`cluster_idle_connections_per_client`|`Number of idle connections per client`| int |
|`cluster_active_connections_per_client`|`Number of active connections per client`| int |
|`cluster_total_online_user_count`|`Number of online accounts`| int |
|`cluster_total_client_count`|`The current number of connected clients`| int |
|`cluster_total_connections_per_user`|`Total number of connections per account`| int |
|`cluster_idle_connections_per_user`|`Number of idle connections per account`| int |
|`cluster_active_connections_per_user`|`Number of active connections per account`| int |
|`cluster_config_last_load_time_seconds`|`System configuration loading time`| s |
|`node_database_name_mb_size`|`The storage space size occupied by each database`| MB |
|`node_database_table_total_count`|`The total number of tables in each database`| int |
|`exporter_total_scraped`|`The number of indicators successfully scraped`| int |
|`exporter_total_error`|`Total number of errors`| int |
|`exporter_scrape_duration_second`|`Duration of data collection`| s |
|`server_users_name_list`|`Total number of users`| int |
|`server_users_total_count`|`User Details`| int |
|`server_locks_table_detail`|`Lock information`| int |
|`server_database_hit_cache_percent_rate`|`cache hit rate`| float |
|`server_database_transition_commit_percent_rate`|`Transaction submission rate`| float |
|`server_database_table_bloat_list`|`Data inflation list`| int |
|`server_locks_table_detail`|`Lock information`| int |
