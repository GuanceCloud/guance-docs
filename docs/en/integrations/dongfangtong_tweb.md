---
title     : 'TongWeb'
summary   : 'Collect TongWeb runtime Metrics and tracing information'
__int_icon: 'icon/dongfangtong'
dashboard :
  - desc  : 'TongWeb monitoring view'
    path  : 'dashboard/en/dongfangtong_tweb'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# TongWeb
<!-- markdownlint-enable -->

## Installation and Configuration {#config}

### Download `ddtrace`

Download the [`ddtrace` agent](https://github.com/GuanceCloud/dd-trace-java/releases)

### Configure Agent

In the bin directory, modify the `external.vmoptions` file by adding the following variable information under `server_options`:

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

Adjust the `dd-java-agent` version according to your actual situation. It is not recommended to add the variable `-Ddd.service.name`, as it would cause all projects to use the same serviceName.

### Enable `Statsd` Collector in DataKit

The Statsd collector is used to collect Metrics-related information. Go to the `datakit/conf.d/statsd` directory and copy `statsd.conf.sample` to `statsd.conf`.

```shell
root:/usr/local/datakit/conf.d/statsd$ ll
total 16
drwxr-xr-x  2 root root 4096 Oct  9 08:32 ./
drwxr-xr-x 53 root root 4096 Oct  9 08:32 ../
-rwxr-xr-x  1 root root 2233 Jul 24 16:38 statsd.conf
-rwxr-xr-x  1 root root 2233 Oct  9 08:32 statsd.conf.sample
```

Refer to the [Statsd](statsd.md) collector integration documentation for more parameter adjustments.

### Enable `ddtrace` Collector in DataKit

The `ddtrace` collector is used to collect `ddtrace` tracing-related information. Go to the `datakit/conf.d/ddtrace` directory and copy `ddtrace.conf.sample` to `ddtrace.conf`.

```shell
root:/usr/local/datakit/conf.d/ddtrace$ ll
total 16
drwxr-xr-x  2 root root 4096 Oct  9 08:32 ./
drwxr-xr-x 53 root root 4096 Oct  9 08:32 ../
-rwxr-xr-x  1 root root 2470 Aug 16 10:42 ddtrace.conf
-rwxr-xr-x  1 root root 2474 Oct  9 08:32 ddtrace.conf.sample
```

Refer to the [`ddtrace`](ddtrace.md) collector integration documentation for more parameter adjustments.

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Restart TongWeb

```shell
bin/startserver.sh restart
```


## Metrics {#metric}

Global Tags

| Tag | Description |
| --- | --- |
| component | Component name: `tongweb` |
| env | Environment: env |

For JVM metrics, refer to [JVM Metrics](jvm.md#metric).