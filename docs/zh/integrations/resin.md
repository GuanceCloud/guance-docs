---
title     : 'Resin'
summary   : 'Resin 性能指标展示，包括启动时间、堆内存、非堆内存、类、线程等。'
__int_icon: 'icon/resin'
dashboard :
  - desc  : 'Resin 监控视图'
    path  : 'dashboard/zh/resin'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Resin
<!-- markdownlint-enable -->

## 安装配置 {#config}

说明：示例 Resin 版本为 Windows 环境 Resin/4.0.66 (Windows ）。

指标采集是通过 `jolokia-jvm-agent` 来采集 Resin 运行时指标。


### Resin 开启指标采集

- 配置 `config/resin.properties`

新增 `jvm_args` ，参数说明：

- `javaagent`：`jolokia-jvm-agent`
- port=9530 # `jolokia-jvm-agent`对外暴露的指标端口

```shell
jvm_args  : -Xmx2048m -XX:MaxPermSize=256m -javaagent:C:/"Program Files"/datakit/data/jolokia-jvm-agent.jar=port=9530
```

- 重启 Resin

双击`resin.exe`

### DataKit 采集器配置

- 开启 DataKit JVM 插件，复制 `sample` 文件

```shell
cd datakit/conf.d/jvm
cp jvm.conf.sample jvm.conf
```

- 修改 `jvm.conf` 配置文件

主要参数说明

- urls：`jolokia` agent 访问地址
- interval：采集频率
- inputs.jvm.metric：jvm 相关指标

```toml
# {"version": "1.2.12", "desc": "do NOT edit this line"}
[[inputs.jvm]]
# default_tag_prefix      = ""
# default_field_prefix    = ""
# default_field_separator = "."

# username = ""
# password = ""
# response_timeout = "5s"

## Optional TLS config
# tls_ca   = "/var/private/ca.pem"
# tls_cert = "/var/private/client.pem"
# tls_key  = "/var/private/client-key.pem"
# insecure_skip_verify = false

## Monitor Intreval
interval   = "10s"

# Add agents URLs to query
urls = ["http://localhost:9530/jolokia/"]

## Add metrics to read
[[inputs.jvm.metric]]
name  = "resin_runtime"
mbean = "java.lang:type=Runtime"
paths = ["Uptime","StartTime","VmVersion","SpecName"]

[[inputs.jvm.metric]]
name  = "resin_memory"
mbean = "java.lang:type=Memory"
paths = ["HeapMemoryUsage", "NonHeapMemoryUsage", "ObjectPendingFinalizationCount"]

[[inputs.jvm.metric]]
name     = "resin_garbage_collector"
mbean    = "java.lang:name=*,type=GarbageCollector"
paths    = ["CollectionTime", "CollectionCount"]
tag_keys = ["name"]

[[inputs.jvm.metric]]
name  = "resin_threading"
mbean = "java.lang:type=Threading"
paths = ["TotalStartedThreadCount", "ThreadCount", "DaemonThreadCount", "PeakThreadCount"]

[[inputs.jvm.metric]]
name  = "resin_class_loading"
mbean = "java.lang:type=ClassLoading"
paths = ["LoadedClassCount", "UnloadedClassCount", "TotalLoadedClassCount"]

[[inputs.jvm.metric]]
name     = "resin_memory_pool"
mbean    = "java.lang:name=*,type=MemoryPool"
paths    = ["Usage", "PeakUsage", "CollectionUsage"]
tag_keys = ["name"]

[inputs.jvm.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
  # ...
```

- 重启 DataKit (如果需要开启日志，请配置日志采集再重启)


## 指标 {#metric}

### 指标集 resin_runtime

| 指标 | 描述 |
| --- | --- |
| `Uptime` | 在线时长 |
| `StartTime` | 启动时间 |
| `VmVersion` | 虚拟机版本 |
| `SpecName` | Java 虚拟机规范名称 |

### 指标集 resin_memory

| 指标 | 描述 |
| --- | --- |
| `HeapMemoryUsage` | 堆内存 |
| `NonHeapMemoryUsage` | 非堆内存 |

### 指标集 resin_threading

| 指标 | 描述 |
| --- | --- |
| `TotalStartedThreadCount` | 启动线程总数 |
| `ThreadCount` | 活动线程数量 |
| `DaemonThreadCount` | 守护线程数量 |
| `PeakThreadCount` | 峰值 |

### 指标集 resin_class_loading

| 指标 | 描述 |
| --- | --- |
| LoadedClassCount | 已加载当前类 |
| UnloadedClassCount | 已卸载类总数 |
| TotalLoadedClassCount | 已加载类总数 |

### 指标集 resin_memory_pool

| 指标 | 描述 |
| --- | --- |
| Usage | 已使用内存池 |
| PeakUsage | 已使用内存池峰值 |
| CollectionUsage | 已使用内存池回收 |

### 指标集 resin_garbage_collector

| 指标 | 描述 |
| --- | --- |
| CollectionTime | GC时间 |
| CollectionCount | GC次数 |
