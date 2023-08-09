# CAT
---


[:octicons-tag-24: Version-1.9.0](changelog.md#cl-1.9.0) ·
[:octicons-beaker-24: Experimental](index.md#experimental)

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:


---

[dianping-cat](https://github.com/dianping/cat){:target="_blank"}  Cat is an open-source distributed real-time monitoring system mainly used to monitor the performance, capacity, and business indicators of the system. It is a monitoring system developed by Meituan Dianping Company and is currently open source and widely used.

Cat collects various indicator data of the system, such as CPU, memory, network, disk, etc., for real-time monitoring and analysis, helping developers quickly locate and solve system problems. 
At the same time, it also provides some commonly used monitoring functions, such as alarms, statistics, log analysis, etc., to facilitate system monitoring and analysis by developers.


## Data Type {#data}

Data transmission protocol:

- Plaintext: Plain text mode, currently not supported by Datakit.

- Native: Text form separated by specific symbols, currently supported by Datakit.


数据分类：

| type | long type         | doc               | datakit support | Corresponding data type |
|------|-------------------|:------------------|:---------------:|:------------------------|
| t    | transaction start | transaction start |      true       | trace                   |
| T    | transaction end   | transaction end   |      true       | trace                   |
| E    | event             | event             |      false      | -                       |
| M    | metric            | metric            |      false      | -                       |
| L    | trace             | trace             |      false      | -                       |
| H    | heartbeat         | heartbeat         |      true       | 指标                      |




## CAT start mode {#cat-start}

The data is all in the datakit, and the web page of cat no longer has data, so the significance of starting is not significant. 

Moreover, the cat server will also send transaction data to the dk, causing a large amount of garbage data on the observation cloud page. It is not recommended to start a cat_ Home (cat server) service.

The corresponding configuration can be configured in client.xml, please refer to the following text.



## Config {#config}

client config：

```xml
<?xml version="1.0" encoding="utf-8"?>
<config mode="client">
    <servers>
        <!-- datakit ip, cat port , http port -->
        <server ip="10.200.6.16" port="2280" http-port="9529"/>
    </servers>
</config>
```

> Note: The 9529 port in the configuration is the HTTP port of the datakit. 2280 is the 2280 port opened by the cat input.

Datakit config：

    Go to the `conf.d/cat` directory under the DataKit installation directory, copy `cat.conf.sample` and name it `cat.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.cat]]
      ## tcp port
      tcp_port = "2280"
    
      ##native or plaintext, datakit only support native(NT1) !!!
      decode = "native"
    
      ## This is default cat-client Kvs configs.
      startTransactionTypes = "Cache.;Squirrel."
      MatchTransactionTypes = "SQL"
      block = "false"
      routers = "127.0.0.1:2280;"
      sample = "1.0"
    
      ## global tags.
      # [inputs.cat.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
    
    ```


=== "Kubernetes"

The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).



Notes on configuration files:

1. `startTransactionTypes` `MatchTransactionTypes` `block` `routers` `sample`  is the data returned to the client end.
2. `routers` is Datakit IP or Domain.
3. `tcp_port`  client config `servers ip` address

---

## Guance Trace and Metric {#traces_mertics}

### trace {#traces}

login guance.com, and click on Application Performance.

<!-- markdownlint-disable MD033 -->
<figure>
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/cat-gateway.png" style="height: 500px" alt=" trace details">
  <figcaption> trace details </figcaption>
</figure>


### Metric {#metrics}
To [download dashboard](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/DianPing-Cat%20%E7%9B%91%E6%8E%A7%E8%A7%86%E5%9B%BE.json){:target="_blank"}

At guance `Scenes` -> `dashboard` to `Create Dashboard`.

Effect display:

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/metric.png" style="height: 500px" alt="cat metric">
  <figcaption> cat metric </figcaption>
</figure>


## Metrics Set {#cat-metrics}



### `cat`



- tag


| Tag | Description |
|  ----  | --------|
|`domain`|IP 地址|
|`hostName`|主机名|
|`os_arch`|CPU 架构：amd/arm|
|`os_name`|操作系统名称：`windows/linux/mac` 等|
|`os_version`|操作系统的内核版本|
|`runtime_java-version`|Java version|
|`runtime_user-dir`|启动程序的 jar 包位置|
|`runtime_user-name`|用户名|

- fields


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_free`|磁盘空闲大小|float|B|
|`disk_total`|数据节点磁盘总量|float|B|
|`disk_usable`|使用大小|float|B|
|`memory_free`|释放内存|float|count|
|`memory_heap-usage`|当前使用内存|float|count|
|`memory_max`|最大使用内存|float|count|
|`memory_non-heap-usage`|非堆内存|float|count|
|`memory_total`|总使用内存|float|count|
|`os_available-processors`|主机 CPU 核心数|float|count|
|`os_committed-virtual-memory`|使用内存|float|B|
|`os_free-physical-memory`|空闲内存|float|B|
|`os_free-swap-space`|交换区空闲大小|float|B|
|`os_system-load-average`|系统负载|float|percent|
|`os_total-physical-memory`|总物理内存|float|B|
|`os_total-swap-space`|交换区总大小|float|B|
|`runtime_start-time`|启动时间|int|s|
|`runtime_up-time`|运行时长|int|ms|
|`thread_cat_thread_count`|cat 使用线程数量|float|count|
|`thread_count`|总线程数量|float|count|
|`thread_daemon_count`|活跃线程数量|float|count|
|`thread_http_thread_count`|http 线程数量|float|count|
|`thread_peek_count`|线程峰值|float|count|
|`thread_pigeon_thread_count`|pigeon 线程数量|float|count|
|`thread_total_started_count`|总初始化过的线程|float|count|


