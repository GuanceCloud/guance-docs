---
title     : '东方通 TWeb（TongWeb）'
summary   : '采集东方通 TWeb（TongWeb）运行指标及链路信息'
__int_icon: 'icon/dongfangtong'
dashboard :
  - desc  : '东方通 TWeb（TongWeb）监控视图'
    path  : 'dashboard/zh/dongfangtong_tweb'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# 东方通 TWeb（TongWeb）
<!-- markdownlint-enable -->

## 安装配置 {#config}

### 下载 `ddtrace`

下载 [`ddtrace` agent](https://github.com/GuanceCloud/dd-trace-java/releases)

### 配置 Agent

在 bin 目录下调整 `external.vmoptions`文件，将以下变量信息添加到`server_options`下：

```shell
......
#server_options
......
-javaagent:/home/lr/agent/dd-java-agent-v1.10.2-guance.jar
-Ddd.tags=component:tongweb,env:dev
-Ddd.jmxfetch.enabled=true
-Ddd.jmxfetch.statsd.host=localhost
-Ddd.jmxfetch.statsd.port=8125
-Ddd.jmxfetch.tomcat.enabled=true
#debug
......
```

`dd-java-agent` 版本根据实际情况进行调整，这里不建议添加变量`-Ddd.service.name`，如果加上，会导致所有工程都使用同一个 serviceName。

### DataKit 开启 `Statsd` 采集器

Statsd 采集器用于采集指标相关信息，进入到 `datakit/conf.d/statsd` 目录下，复制 `statsd.conf.sample` 为 `statsd.conf`。

```shell
root:/usr/local/datakit/conf.d/statsd$ ll
total 16
drwxr-xr-x  2 root root 4096 10月  9 08:32 ./
drwxr-xr-x 53 root root 4096 10月  9 08:32 ../
-rwxr-xr-x  1 root root 2233  7月 24 16:38 statsd.conf
-rwxr-xr-x  1 root root 2233 10月  9 08:32 statsd.conf.sample
```

更多参数调整参考 [Statsd](statsd.md) 采集器集成文档


### DataKit 开启 `ddtrace` 采集器

`ddtrace` 采集器用于采集`ddtrace`链路相关信息，进入到 `datakit/conf.d/ddtrace` 目录下，复制 `ddtrace.conf.sample` 为 `ddtrace.conf`。

```shell
root:/usr/local/datakit/conf.d/ddtrace$ ll
total 16
drwxr-xr-x  2 root root 4096 10月  9 08:32 ./
drwxr-xr-x 53 root root 4096 10月  9 08:32 ../
-rwxr-xr-x  1 root root 2470  8月 16 10:42 ddtrace.conf
-rwxr-xr-x  1 root root 2474 10月  9 08:32 ddtrace.conf.sample

```

更多参数调整参考 [`ddtrace`](ddtrace.md) 采集器集成文档

### 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

### 重启 TongWeb

```shell
bin/startserver.sh restart
```


## 指标 {#metric}

全局Tag

| Tag | 描述 |
| -- | -- |
| component | 组件名称：`tongweb` |
| env | 环境：env |

jvm 参考 [JVM 指标](jvm.md#metric)
