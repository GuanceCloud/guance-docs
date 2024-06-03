---
title     : 'JMX StatsD'
summary   : 'JVM 性能指标展示：堆与非堆内存、线程、类加载数等。'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM 监控视图'
    path  : 'dashboard/zh/jvm'
  - desc  : 'JVM Kubernetes 监控视图'
    path  : 'dashboard/zh/jvm_kubernetes'
  - desc  : 'JVM Kubernetes by podName 监控视图'
    path  : 'dashboard/zh/jvm_kubernetes_by_podname'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# JVM (StatsD)
<!-- markdownlint-enable -->
---

## 配置 {#config}

说明：示例 通过 `ddtrace` 采集 JVM 指标，通过 DataKit 内置的 Statsd 接收 `ddtrace` 发送过来的 JVM 指标。

### DataKit 开启采集器

- 开启 `Statsd` 采集器

复制 `sample` 文件，不需要修改 `statsd.conf`

```shell
cd /usr/local/datakit/conf.d/statsd
cp statsd.conf.sample statsd.conf
```

- 重启 DataKit

```shell
systemctl restart datakit
```

### 应用配置

- 调整启动参数


```shell
-javaagent:/usr/local/datakit/data/dd-java-agent.jar \
 -Ddd.service.name=<your-service>   \
 -Ddd.env=dev  \
 -Ddd.agent.port=9529  
```

使用 `java -jar`的方式启动 `jar`，默认连接本机上的 `DataKit`，如需要连接远程服务器上的 `DataKit`，请使用 `-Ddd.agent.host` 和 `-Ddd.jmxfetch.statsd.host` 指定 `ip` 。

关于 DDTrace 更详细的接入，参考[`ddtrace-java`](ddtrace-java.md)文档。
