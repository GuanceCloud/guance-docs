---
icon: fontawesome/brands/java
---
# JVM (Jolokia)
---

???+ info "提示"

	当前文章主要是通过 Jolokia 方式来采集 jvm 相关指标信息。

## 视图预览

JVM 性能指标展示：CPU 负载、直接缓冲区、线程数量、堆内存、GC 次数、类加载数等。

![image](../imgs/jvm_jolokia_3.png)

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装部署

说明：开启 `jvm 采集器`，通过 `jvm 采集器`采集 jvm 指标信息。

## 应用接入 Jolokia

datakit 安装目录已经提供了 Jolokia agent 。位于 `datakit/data/` 目录下，提供了 `jolokia-jvm-agent.jar` 和 `jolokia-war.war` 两种agent lib。

以下均以 jar 运行方式为例。

1、启动配置 javaagent
```
java -javaagent:C:/'Program Files'/datakit/data/jolokia-jvm-agent.jar=port=8089,host=localhost -jar your_app.jar
```

2、DataKit 开启采集器

采集器所在目录 `datakit/conf.d/jvm`，进入目录后，复制 jvm.conf.sample 并将新文件重命名为 `jvm.conf`，主要配置 url ,其他参数可按需调整。

``` toml
urls = ["http://localhost:8089/jolokia"]
```

以上配置会生成 `java_`开头的指标集。

3、重启 DataKit

略

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - JVM 监控视图 by Jolokia>

## 故障排查

- [无数据上报排查](../../datakit/why-no-data.md)

## 进一步阅读

- 更多[JVM](jvm.md)采集方式

- [JVM 可观测最佳实践](../../best-practices/monitoring/jvm.md)
