---
icon: fontawesome/brands/java
---
# JVM (Prometheus)
---

???+ info "提示"

	本文将以 Springboot 为前提，引入 prometheus 相关依赖采集 JVM 指标。

## 视图预览

JVM 性能指标展示：CPU 使用率、线程数量、堆和非堆内存、GC 次数、类加载数等。

![image](../imgs/jvm_prometheus_1.png)

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装部署

说明：开启 `prom 采集器`，通过 `prom 采集器`采集 jvm 指标信息。

## 应用接入 Prometheus

这里使用 `spring-boot-starter-actuator` 和 `micrometer`


### Micrometer

???+ info "Micrometer"

	Micrometer 为 Java 平台上的性能数据收集提供了一个通用的 API，它提供了多种度量指标类型（Timers、Guauges、Counters等），同时支持接入不同的监控系统，例如 Influxdb、Graphite、Prometheus 等。我们可以通过 Micrometer 收集 Java 性能数据，配合 Prometheus 监控系统实时获取数据，并最终在 Grafana 上展示出来，从而很容易实现应用的监控。

1、 应用需要引入以下相关依赖

``` xml
	<!-- spring-boot-actuator依赖 -->
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-actuator</artifactId>
	</dependency>
	<!-- prometheus依赖 -->
	<dependency>
		<groupId>io.micrometer</groupId>
		<artifactId>micrometer-registry-prometheus</artifactId>
	</dependency>
```

2、 配置 application.yaml

新增如下配置

```yaml
management:
  server:
    port: 8091
  endpoints:
    web:
      exposure:
        include: "*"
  metrics:
    tags:
      application: ${spring.application.name}
      env: ${spring.profiles.active}
```

3、 打包依赖& 启动
略

4、 访问指标

浏览器打开url http://localhost:8091/actuator/prometheus ，此端口为 management 端口

如果url 访问正常，则表示应用已成功接入 prometheus 

5、 DataKit 开启 prom 采集器

采集器所在目录 `datakit/conf.d/prom`，进入目录后，复制 prom.conf.sample 并将新文件重命名为 `jvm-prom.conf`，主要配置 url 和 source ,其他参数可按需调整。

``` toml
urls =["http://localhost:8091/actuator/prometheus"]
source = "jvm-prom"

measurement_prefix = "jvm_"
```

以上配置会生成 `jvm_`开头的指标集。

6、重启 DataKit

略

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - JVM 监控视图 by Prometheus>

## 故障排查

- [无数据上报排查](../../datakit/why-no-data.md)

## 进一步阅读

- 更多[JVM](jvm.md)采集方式

- [JVM 可观测最佳实践](../../best-practices/monitoring/jvm.md)
