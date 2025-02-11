---
title     : 'PinPoint Java'
summary   : 'PinPoint Java Integration'
__int_icon: 'icon/pinpoint'
tags      :
  - 'PINPOINT'
  - 'JAVA'
  - 'Trace Linking'
---

Pinpoint Java Agent [Download Address](https://github.com/pinpoint-apm/pinpoint/releases){:target="_blank"}

---

## Configure Datakit Agent {#config-datakit-agent}

Refer to [Configure Pinpoint Agent in Datakit](pinpoint.md#config)

## Configure Pinpoint Java Agent {#config-pinpoint-java-agent}

Run the following command to start the Pinpoint Agent

```shell
java -javaagent:/path-to-pinpoint-agent-path/pinpoint-bootstrap.jar \
     -Dpinpoint.agentId=agent-id \
     -Dpinpoint.applicationName=service-name \
     -Dpinpoint.config=/path-to-pinpoint-agent-config-path/pinpoint-root.config \
     -jar /path-to-java-app
```

Basic parameter descriptions:

- pinpoint.profiler.profiles.active               : Pinpoint profiler working mode (release/local), related to log output
- pinpoint.applicationName                        : Service name
- pinpoint.agentId                                : Agent ID
- pinpoint.agentName                              : Agent name
- profiler.transport.module                       : Transport protocol (gRPC/Thrift)
- profiler.transport.grpc.collector.ip            : Collector IP address (i.e., the host address where Datakit is started)
- profiler.transport.grpc.agent.collector.port    : Agent collector port (i.e., the listening port of Pinpoint Agent in Datakit)
- profiler.transport.grpc.metadata.collector.port : Metadata collector port (i.e., the listening port of Pinpoint Agent in Datakit)
- profiler.transport.grpc.stat.collector.port     : Stat collector port (i.e., the listening port of Pinpoint Agent in Datakit)
- profiler.transport.grpc.span.collector.port     : Span collector port (i.e., the listening port of Pinpoint Agent in Datakit)
- profiler.sampling.enable                        : Whether to enable sampling
- profiler.sampling.type                          : Sampling algorithm
- profiler.sampling.counting.sampling-rate        : Sampling rate
- profiler.sampling.percent.sampling-rat          : Sampling rate

## Supported Modules {#supported-modules}

- JDK 8+
- Tomcat, Jetty, JBoss EAP, Resin, Websphere, Vertx, Weblogic, Undertow, Akka HTTP
- Spring, Spring Boot (Embedded Tomcat, Jetty, Undertow, Reactor Netty), Spring WebFlux
- Apache HttpClient 3 / 4 / 5, JDK HttpConnector, GoogleHttpClient, OkHttpClient, NingAsyncHttpClient
- Thrift, DUBBO, GRPC, Apache CXF
- ActiveMQ, RabbitMQ, Kafka, RocketMQ, Paho MQTT
- MySQL, Oracle, MSSQL, JTDS, CUBRID, POSTGRESQL, MARIA, Informix, Spring Data R2DBC
- Arcus, Memcached, Redis(Jedis, Lettuce, Redisson), CASSANDRA, MongoDB, Hbase, Elasticsearch
- iBATIS, MyBatis
- DBCP, DBCP2, HIKARICP, DRUID
- Gson, Jackson, JSON Lib, Fastjson
- log4j, Logback, log4j2
- OpenWhisk, Kotlin Coroutines

## Compatibility {#compatibility}

The current version of Pinpoint Agent used by Datakit is [pinpoint-go-agent](https://github.com/pinpoint-apm/pinpoint-go-agent){:target="_blank"}-v1.3.2

The tested versions of Pinpoint Agent include:

- pinpoint-agent-2.2.1
- pinpoint-agent-2.3.1
- pinpoint-agent-2.4.1
- pinpoint-agent-2.5.1