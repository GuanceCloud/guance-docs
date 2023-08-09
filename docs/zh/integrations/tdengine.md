---
title     : 'TDengine'
summary   : '采集 TDengine 的指标数据'
__int_icon      : 'icon/tdengine'
dashboard :
  - desc  : 'TDengine'
    path  : 'dashboard/zh/tdengine'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# TDengine
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

TDengine 是一款高性能、分布式、支持 SQL 的时序数据库 (Database)。在开通采集器之前请先熟悉 [TDengine 基本概念](https://docs.taosdata.com/concept/){:target="_blank"}

TDengine 采集器需要的连接 `taos_adapter` 才可以正常工作，taosAdapter 从 TDengine v2.4.0.0 版本开始成为 TDengine 服务端软件 的一部分，本文主要是指标集的详细介绍。

## 配置  {#config}

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
|`client_ip`|请求端 IP|
|`cluster_name`|集群名称|
|`database_name`|数据库名称|
|`dnode_ep`|数据节点名称，一般情况下与 end_point 等价|
|`end_point`|远端地址名称，一般命名规则是(host:port)|
|`first_ep`|first endpoint|
|`host`|主机名|
|`version`|version|
|`vgroup_id`|虚拟组 ID|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`client_ip_count`|客户端 IP 请求次数统计|float|count|
|`cpu_cores`|每个数据节点的 CPU 总核数|float|count|
|`cpu_engine`|每个数据节点的 CPU 使用率|float|percent|
|`cpu_percent`|adapter 占用 CPU 使用率|float|percent|
|`cpu_system`|数据节点的 CPU 系统使用率|float|count|
|`database_count`|数据库总个数|float|count|
|`disk_percent`|数据节点磁盘使用率|float|percent|
|`disk_total`|数据节点磁盘总量|float|GB|
|`disk_used`|数据节点的磁盘使用量|float|GB|
|`dnodes_alive`|集群中数据节点存活个数|float|count|
|`dnodes_total`|集群中数据节点(dnode) 的总个数|float|count|
|`expire_time`|企业版到期时间|int|s|
|`io_read_taosd`|平均每秒 IO read 的数据大小|float|MB|
|`io_write_taosd`|平均每秒 IO write 的数据大小|float|MB|
|`master_uptime`|从 dnode 当选为 master 的时间|float|s|
|`mem_engine`|TDEngine 占用内存量|float|MB|
|`mem_engine_percent`|`taosd` 占用内存率|float|percent|
|`mem_percent`|adapter 占用 MEM 使用率|float|percent|
|`mem_system`|数据节点系统占用总内存量|float|MB|
|`mem_total`|数据节点总内存量|float|GB|
|`mnodes_alive`|数据库管理节点存活个数|float|count|
|`mnodes_total`|数据库管理节点(`mnode`)个数|float|count|
|`net_in`|入口网络的 IO 速率|float|KB|
|`net_out`|出口网络的 IO 速率|float|KB|
|`req_http`|通过 http 请求的总数|float|count|
|`req_http_rate`|http 请求速率|float|count|
|`req_insert_batch_rate`|请求插入数据批次速率|float|count|
|`req_insert_rate`|请求插入数据的速率|float|count|
|`req_select`|查询数量|float|count|
|`req_select_rate`|查询速率|float|count|
|`request_in_flight`|正在梳理的请求数量|float|count|
|`status_code`|请求返回的状态码|float|count|
|`table_count`|数据库中的表总数|float|count|
|`tables_count`|数据库中每个 database 中表数量的指标|float|count|
|`timeseries_total`|企业版总测点数|float|count|
|`timeseries_used`|企业版已使用测点数|float|count|
|`total_req_count`|adapter 总请求量|float|count|
|`vgroups_alive`|数据库中虚拟节点组总存活数|float|count|
|`vgroups_total`|数据库中虚拟节点组总数|float|count|
|`vnodes`|单个数据节点中包括虚拟节点组的数量|float|count|
|`vnodes_alive`|数据库中虚拟节点总存活数|float|count|
|`vnodes_num`|每个数据节点的虚拟节点总数|float|count|
|`vnodes_total`|数据库中虚拟节点总数|float|count|



> - 数据库中有些表中没有 `ts` 字段，Datakit 会使用当前采集的时间。
