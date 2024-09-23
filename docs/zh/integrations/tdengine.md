---
title     : 'TDengine'
summary   : '采集 TDengine 的指标数据'
tags:
  - '数据库'
__int_icon      : 'icon/tdengine'
dashboard :
  - desc  : 'TDengine'
    path  : 'dashboard/zh/tdengine'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

TDengine 是一款高性能、分布式、支持 SQL 的时序数据库 (Database)。在开通采集器之前请先熟悉 [TDengine 基本概念](https://docs.taosdata.com/concept/){:target="_blank"}

TDengine 采集器需要的连接 `taos_adapter` 才可以正常工作，taosAdapter 从 TDengine v2.4.0.0 版本开始成为 TDengine 服务端软件 的一部分，本文主要是指标集的详细介绍。

## 配置  {#config}

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `tdengine.conf.sample` 并命名为 `tdengine.conf`。示例如下：
    
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
      ## Different clusters can be distinguished by tag. Such as testing,product,local ,default is 'testing'
      # cluster_name = "testing"
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

???+ tip

    - 连接 taoAdapter 之前请先确定端口是开放的。并且连接用户需要有 read 权限。
    - 若仍连接失败，[请参考此处](https://docs.taosdata.com/2.6/train-faq/faq/){:target="_blank"}。
<!-- markdownlint-enable -->

## 指标 {#metric}



### `tdengine`



- 标签


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

- 指标列表


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



> - 数据库中有些表中没有 `ts` 字段，Datakit 会使用当前采集的时间。
