---
icon: fontawesome/brands/java
---
# JVM (JMX Exporter)
---

???+ info "提示"

	当前文章主要是通过 JMX Exporter 方式来采集 jvm 相关指标信息。

## 视图预览

JVM 性能指标展示：堆与非堆内存、线程、类加载数等。

![image](../imgs/jvm_jmx_exporter_1.png)

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装部署

说明：开启 `jvm 采集器`，通过 `jvm 采集器`采集 jvm 指标信息。

## 应用接入 JMX Exporter


以下均以 jar 运行方式为例。

1、下载

根据实际需要选择下载版本 [https://github.com/prometheus/jmx_exporter/releases](https://github.com/prometheus/jmx_exporter/releases) ，这里选择 0.18.0 版本。

2、启动配置 javaagent

```
java -javaagent:jmx_prometheus_javaagent-0.18.0.jar=8080:config.yaml -jar yourJar.jar
```

3、 DataKit 开启 prom 采集器

采集器所在目录 `datakit/conf.d/prom`，进入目录后，复制 prom.conf.sample 并将新文件重命名为 `jvm-prom.conf`，主要配置 url 、 source 和 measurement_prefix ,其他参数可按需调整。

``` toml
urls =["http://localhost:8080/metrics"]
source = "jmx_jmx_exporter_prom"
measurement_prefix = "jvm_"
[inputs.prom.tags]
  server="server"  
```

以上配置会生成 `jvm_`开头的指标集。

4、重启 DataKit

略

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - JVM 监控视图 by JMX Exporter>

## 故障排查

- [无数据上报排查](../../datakit/why-no-data.md)

## 进一步阅读

- 更多[JVM](jvm.md)采集方式

- [JVM 可观测最佳实践](../../best-practices/monitoring/jvm.md)
