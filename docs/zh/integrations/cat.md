---
title     : 'CAT'
summary   : '美团点评的性能、容量和业务指标监控系统'
__int_icon      : 'icon/cat'
dashboard :
  - desc  : 'Cat 监控视图'
    path  : 'dashboard/zh/cat'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# 点评 CAT 数据接入
<!-- markdownlint-enable -->

---

[:octicons-tag-24: Version-1.9.0](changelog.md#cl-1.9.0) · [:octicons-beaker-24: Experimental](index.md#experimental)

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

[dianping-cat](https://github.com/dianping/cat){:target="_blank"}  简称 Cat， 是一个开源的分布式实时监控系统，主要用于监控系统的性能、容量和业务指标等。它是美团点评公司研发的一款监控系统，目前已经开源并得到了广泛的应用。

Cat 通过采集系统的各种指标数据，如 CPU、内存、网络、磁盘等，进行实时监控和分析，帮助开发人员快速定位和解决系统问题。同时，它还提供了一些常用的监控功能，如告警、统计、日志分析等，方便开发人员进行系统监控和分析。


## 配置 {#config}

### Client 端配置 {#client-config}

示例：

```xml
<?xml version="1.0" encoding="utf-8"?>
<config mode="client">
    <servers>
        <!-- datakit ip, cat port , http port -->
        <server ip="10.200.6.16" port="2280" http-port="9529"/>
    </servers>
</config>
```

> 注意：配置中的 9529 端口是 Datakit 的 HTTP 端口。2280 是 cat 采集器开通的 2280 端口。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/cat` 目录，复制 `cat.conf.sample` 并命名为 `cat.conf`。示例如下：
    
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

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

配置文件注意的地方：

1. `startTransactionTypes` `MatchTransactionTypes` `block` `routers` `sample` 是返回给 client 端的数据。
1. `routers` 是 datakit 的 ip 或者域名。
1. `tcp_port` 对应的是 client 端配置 servers ip 地址。

---

## 链路字段 {#tracing}



### `cat`



- 标签


| Tag | Description |
|  ----  | --------|
|`domain`|IP 地址|
|`hostName`|主机名|
|`os_arch`|CPU 架构：amd/arm|
|`os_name`|操作系统名称：windows、linux，mac 等|
|`os_version`|操作系统的内核版本|
|`runtime_java-version`|java version|
|`runtime_user-dir`|启动程序的 jar 包位置|
|`runtime_user-name`|用户名|

- 指标列表


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



## 数据类型 {#data}

数据传输协议：

- plaintext : 纯文本模式， Datakit 目前暂时不支持。
- native ： 以特定符号为分隔符的文本形式，目前 Datakit 已经支持。

数据分类：

| 数据类型简写 | 类型                | 说明        | 当前版本的 datakit 是否接入 | 对应到观测云中的数据类型 |
| --------     | ------------------- | :---------- | :------------------:        | :-----------------       |
| t            | transaction start   | 事务开始    | true                        | trace                    |
| T            | transaction end     | 事务结束    | true                        | trace                    |
| E            | event               | 事件        | false                       | -                        |
| M            | metric              | 自定义指标  | false                       | -                        |
| L            | trace               | 链路        | false                       | -                        |
| H            | heartbeat           | 心跳包      | true                        | 指标                     |

## 客户端的启动模式 {#cat-start}

- 启动 cat server 模式

    - 数据全在 datakit 中，cat 的 web 页面已经没有数据，所以启动的意义不大，并且页面报错： **出问题 CAT 的服务端[xxx.xxx]**
    - 配置客户端行为可以在 client 的启动中做
    - cat server 也会将 transaction 数据发送到 dk，造成观测云页面大量的垃圾数据


- 不启动 cat server： 在 Datakit 中配置

    - `startTransactionTypes`：用于定义自定义事务类型，指定的事务类型会被 Cat 自动创建。多个事务类型之间使用分号进行分隔。
    - `block`：指定一个阈值用于阻塞监控，单位为毫秒。当某个事务的执行时间大于该阈值时，会触发 Cat 记录该事务的阻塞情况。
    - `routers`：指定 Cat 服务端的地址和端口号，多个服务器地址和端口号之间使用分号进行分隔。Cat 会自动将数据发送到这些服务器上，以保证数据的可靠性和容灾性。
    - `sample`：指定采样率，即只有一部分数据会被发送到 Cat 服务器。取值范围为 0 到 1，其中 1 表示全部数据都会被发送到 Cat 服务器，0 表示不发送任何数据。
    - `matchTransactionTypes`：用于定义自定义事务类型的匹配规则，通常用于 Api 服务监控中，指定需要监控哪些接口的性能。

所以：不建议去开启一个 cat_home（cat server） 服务。相应的配置可以在 *client.xml* 中配置，请看下文。