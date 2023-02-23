
# TDengine
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

TDEngine is a high-performance, distributed, SQL-enabled time series Database (Database). Familiarize yourself with the [basic concepts of TDEngine](https://docs.taosdata.com/concept/){:target="_blank"} before opening the collector.

TDengine collector needs to connect `taos_adapter` can work normally, taosAdapter from TDengine v2.4. 0.0 version comes to becoming a part of TDengine server software, this paper is mainly a detailed introduction of measurement.

## Configuration  {#config}

=== "Host Installation"


    Go to the `conf.d/db` directory under the DataKit installation directory, copy `tdengine.conf.sample` and name it `tdengine.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.tdengine]]
      ## adapter restApi Addr, example: http://taosadapter.test.com  (Required)
      adapter_endpoint = "http://<FQND>:6041"
      user = "<userName>"
      password = "<pw>"
    
      ##    ## log_files: TdEngine log file path or dirName (optional).
      ## log_files = ["tdengine_log_path.log"]
      ## pipeline = "tdengine.p"
    
      ## Set true to enable election
      election = true
    	
      ## add tag (optional)
      [inputs.tdengine.tags]
    	## Different clusters can be distinguished by tag. Such as testing,product,local ,default is 'testing'
    	## cluster_name = "testing"
    
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```
    
    After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).


=== "Kubernetes"

    At present, the collector can be turned on by [injecting the collector configuration in ConfigMap mode](datakit-daemonset-deploy.md#configmap-setting).


### TdEngine Dashboard {#td-dashboard}

    At present, Guance Cloud has provided a built-in TDEngine dashboard, and you can select the TDEngine dashboard in ***Guance Cloud*** -- ***Scene***--***New Dashboard***.


## Measurement {#td-metrics}



### `tdengine`



- tag


| Tag | Descrition |
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

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`client_ip_count`|客户端 IP 请求次数统计|float|count|
|`cpu_cores`|每个数据节点的 CPU 总核数|float|count|
|`cpu_engine`|每个数据节点的CPU使用率|float|percent|
|`cpu_percent`|adapter 占用 CPU 使用率|float|percent|
|`cpu_system`|数据节点的cpu系统使用率|float|count|
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
|`mem_engine`|tdengine占用内存量|float|MB|
|`mem_engine_percent`|taosd 占用内存率|float|percent|
|`mem_percent`|adapter 占用 MEM 使用率|float|percent|
|`mem_system`|数据节点系统占用总内存量|float|MB|
|`mem_total`|数据节点总内存量|float|GB|
|`mnodes_alive`|数据库管理节点存活个数|float|count|
|`mnodes_total`|数据库管理节点(mnode)个数|float|count|
|`net_in`|入口网络的IO速率|float|KB|
|`net_out`|出口网络的IO速率|float|KB|
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
|`total_req_count`|adapter总请求量|float|count|
|`vgroups_alive`|数据库中虚拟节点组总存活数|float|count|
|`vgroups_total`|数据库中虚拟节点组总数|float|count|
|`vnodes`|单个数据节点中包括虚拟节点组的数量|float|count|
|`vnodes_alive`|数据库中虚拟节点总存活数|float|count|
|`vnodes_num`|每个数据节点的虚拟节点总数|float|count|
|`vnodes_total`|数据库中虚拟节点总数|float|count|



> - Some tables in the database do not have the `ts` field, and Datakit uses the current collection time.
