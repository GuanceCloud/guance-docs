---
icon: material/middleware
---

# 中间件

---

[DataKit](../../datakit/) 是观测云中至关重要的一个数据采集组件，几乎所有观测云中的数据都是来源于 DataKit。

<br/>

[**安装 DataKit**](../../datakit/datakit-install.md)之后，对于如下指标集，用户可通过{==**自定义开启内置插件**==}或 {++**其他采集器**++} 协助采集相关数据：

| {==**自定义开启**==}                                  |                                                           |                                                             |                                                     |                                                       |
| ----------------------------------------------------- | --------------------------------------------------------- | ----------------------------------------------------------- | --------------------------------------------------- | ----------------------------------------------------- |
| [Kafka](kafka.md){ .md-button .md-button--primary }   | [RabbitMQ](rabbitmq.md){ .md-button .md-button--primary } | [RocketMQ](rocketmq.md){ .md-button .md-button--primary }   | [Resin](resin.md){ .md-button .md-button--primary } | [Tomcat](tomcat.md){ .md-button .md-button--primary } |
| [Consul](consul.md){ .md-button .md-button--primary } | [Nacos](nacos.md){ .md-button .md-button--primary }       | [Zookeeper](zookeeper.md){ .md-button .md-button--primary } | [JVM](jvm.md){ .md-button .md-button--primary }     | [Solr](solr.md){ .md-button .md-button--primary }     |

| 其他采集器              |                                                                 |                                                                   |                                                         |     |
| ----------------------- | --------------------------------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------- | --- |
| {++**DataFlux.Func**++} | [Fluentd](fluentd-metrics.md){ .md-button .md-button--primary } | [Logstash](logstash-metrics.md){ .md-button .md-button--primary } |                                                         |     |
| {++**Prometheus**++}    | [Flink](flink.md){ .md-button .md-button--primary }             | [Seata](seata.md){ .md-button .md-button--primary }               |                                                         |     |
| {++**Telegraf**++}      | [Consul](consul.md){ .md-button .md-button--primary }           | [Beats](beats.md){ .md-button .md-button--primary }               | [PHP-FPM](php-fpm.md){ .md-button .md-button--primary } |     |

<br/>

**开始[安装 DataKit](../../datakit/datakit-install.md)，开启你的观测云之旅！**
