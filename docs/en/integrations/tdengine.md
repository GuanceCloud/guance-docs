---
title: 'TDengine'
summary: 'Collect Metrics data from TDengine'
tags:
  - 'Database'
__int_icon: 'icon/tdengine'
dashboard:
  - desc: 'TDengine'
    path: 'dashboard/en/tdengine'
monitor:
  - desc: 'Not available'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

TDengine is a high-performance, distributed, SQL-supported time series database (Database). Before enabling the collector, please familiarize yourself with [TDengine basic concepts](https://docs.taosdata.com/concept/){:target="_blank"}

The TDengine collector requires the connection to `taos_adapter` to function properly. The taosAdapter has been part of the TDengine server software starting from version v2.4.0.0. This document mainly provides a detailed introduction to the Measurement set.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/db` directory under the DataKit installation directory, copy `tdengine.conf.sample` and rename it to `tdengine.conf`. Example:
    
    ```toml
        
    [[inputs.tdengine]]
      ## adapter restApi Addr, example: http://taosadapter.test.com  (Required)
      adapter_endpoint = "http://<FQND>:6041"
      user = "<userName>"
      password = "<pw>"
    
      ## log_files: TdEngine log file path or dirName (optional).
      ## log_files = ["tdengine_log_path.log"]
      ## pipeline = "tdengine.p"
    
      ## Set true to enable election
      election = true
    
      ## add tag (optional)
      [inputs.tdengine.tags]
      ## Different clusters can be distinguished by tag. Such as testing, product, local, default is 'testing'
      # cluster_name = "testing"
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).

???+ tip

    - Ensure the port is open before connecting to taoAdapter. The connecting user must have read permissions.
    - If connection still fails, [refer to this guide](https://docs.taosdata.com/2.6/train-faq/faq/){:target="_blank"}.
<!-- markdownlint-enable -->

## Metrics {#metric}



### `tdengine`



- Tags


| Tag | Description |
|  ----  | --------|
|`client_ip`|Client IP|
|`cluster_name`|Cluster name|
|`database_name`|Database name|
|`dnode_ep`|Data node name, generally equivalent to `end_point`|
|`end_point`|Remote address name, the general naming rule is (host:port)|
|`first_ep`|First endpoint|
|`host`|Host name|
|`version`|Version|
|`vgroup_id`|VGroup ID|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`client_ip_count`|Client IP request statistics|float|count|
|`cpu_cores`|Total number of CPU cores per data node|float|count|
|`cpu_engine`|CPU usage per data node|float|percent|
|`cpu_percent`|Adapter occupies CPU usage|float|percent|
|`cpu_system`|CPU system usage of data nodes|float|count|
|`database_count`|Total number of databases|float|count|
|`disk_percent`|Data node disk usage percentage|float|percent|
|`disk_total`|Total disk size of data nodes|float|GB|
|`disk_used`|Disk usage of data nodes|float|GB|
|`dnodes_alive`|Total number of dnodes in ready state|float|count|
|`dnodes_total`|Total number of dnodes(data nodes) in cluster|float|count|
|`expire_time`|Time until grants expire in seconds|int|s|
|`io_read_taosd`|Average data size of IO reads per second|float|MB|
|`io_write_taosd`|Average data size of IO writes per second|float|MB|
|`master_uptime`|Seconds of master's uptime|float|s|
|`mem_engine`|Memory usage of tdengine|float|MB|
|`mem_engine_percent`|`taosd` memory usage percentage|float|percent|
|`mem_percent`|Adapter memory usage|float|percent|
|`mem_system`|Available memory on the server|float|MB|
|`mem_total`|Total memory of server|float|GB|
|`mnodes_alive`|Total number of mnodes in ready state|float|count|
|`mnodes_total`|Total number of mnodes(management nodes) in cluster|float|count|
|`net_in`|IO rate of the ingress network|float|KB|
|`net_out`|IO rate of egress network|float|KB|
|`req_http`|Total number of requests via HTTP|float|count|
|`req_http_rate`|HTTP request rate|float|count|
|`req_insert_batch_rate`|Number of batch insertions divided by monitor interval|float|count|
|`req_insert_rate`|Number of insert queries received per dnode divided by monitor interval|float|count|
|`req_select`|Number of select queries received per dnode|float|count|
|`req_select_rate`|Number of select queries received per dnode divided by monitor interval|float|count|
|`request_in_flight`|Number of requests being sorted|float|count|
|`status_code`|Status code returned by the request|float|count|
|`table_count`|Total number of tables in the database|float|count|
|`tables_count`|Number of tables per vgroup|float|count|
|`timeseries_total`|Total time series|float|count|
|`timeseries_used`|Time series used|float|count|
|`total_req_count`|Total adapter requests|float|count|
|`vgroups_alive`|Total number of vgroups in ready state|float|count|
|`vgroups_total`|Total number of vgroups in cluster|float|count|
|`vnodes`|The number of virtual node groups contained in a single data node|float|count|
|`vnodes_alive`|Total number of vnode in ready state|float|count|
|`vnodes_num`|Total number of virtual nodes per data node|float|count|
|`vnodes_total`|Total number of vnode in cluster|float|count|



> - Some tables in the database do not have a `ts` field; DataKit will use the current collection time.
