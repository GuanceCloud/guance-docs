---
title     : 'JMX Jolokia'
summary   : 'JVM 性能指标展示：堆与非堆内存、线程、类加载数等。'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by Jolokia 监控视图'
    path  : 'dashboard/zh/jmx_exporter'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 MD046 -->
# JVM (Jolokia)
---

???+ info "提示"

    当前文章主要是通过 Jolokia 方式来采集 jvm 相关指标信息。
<!-- markdownlint-enable -->

## 配置 {#config}

说明：开启 `jvm 采集器`，通过 `jvm 采集器`采集 `jvm` 指标信息。

### 应用接入 Jolokia

`DataKit` 安装目录已经提供了 `Jolokia agent` 。位于 `datakit/data/` 目录下，提供了 `jolokia-jvm-agent.jar` 和 `jolokia-war.war` 两种agent lib。

以下均以 `jar` 运行方式为例。

- 启动配置 `javaagent`

```shell
java -javaagent:C:/'Program Files'/datakit/data/jolokia-jvm-agent.jar=port=8089,host=localhost -jar your_app.jar
```

### DataKit 开启采集器

- 开启采集器

采集器所在目录 `datakit/conf.d/jvm`，进入目录后，复制 `jvm.conf.sample` 并将新文件重命名为 `jvm.conf`，主要配置 `url` ,其他参数可按需调整。

```toml
urls = ["http://localhost:8089/jolokia"]
```

以上配置会生成 `java_`开头的指标集。

- 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)
