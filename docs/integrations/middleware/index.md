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
| [:integrations-kafka: Kafka](kafka.md){ .md-button .md-button--primary }   | [:integrations-rabbitmq: RabbitMQ](rabbitmq.md){ .md-button .md-button--primary } | [:integrations-rocketmq: RocketMQ](rocketmq.md){ .md-button .md-button--primary }   | [:integrations-resin: Resin](resin.md){ .md-button .md-button--primary } | [:integrations-tomcat: Tomcat](tomcat.md){ .md-button .md-button--primary } |
| [:integrations-consul: Consul](consul.md){ .md-button .md-button--primary } | [:integrations-nacos: Nacos](nacos.md){ .md-button .md-button--primary }       | [:integrations-zookeeper: ZooKeeper](zookeeper.md){ .md-button .md-button--primary } | [:fontawesome-brands-java: JVM](jvm.md){ .md-button .md-button--primary }     | [:integrations-solr: Solr](solr.md){ .md-button .md-button--primary }     |


| {++**其他采集器**++}             |                                                                 |                                                                   |                                                         |     |
| ----------------------- | --------------------------------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------- | --- |
| **DataFlux.Func** | [:integrations-fluentd: Fluentd](fluentd-metrics.md){ .md-button .md-button--primary } | [:integrations-logstash: Logstash](logstash-metrics.md){ .md-button .md-button--primary } |                                                         |     |
| **Prometheus**    | [:integrations-flink: Flink](flink.md){ .md-button .md-button--primary }             | [:integrations-seata: Seata](seata.md){ .md-button .md-button--primary }               |                                                         |     |
| **Telegraf**      | [:integrations-consul: Consul](consul.md){ .md-button .md-button--primary }           | [:integrations-beats: Beats](beats.md){ .md-button .md-button--primary }               | [:integrations-php: PHP-FPM](php-fpm.md){ .md-button .md-button--primary } |     |

<br/>

**开始[安装 DataKit](../../datakit/datakit-install.md)，开启你的观测云之旅！**
