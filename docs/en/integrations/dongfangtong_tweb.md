---
title     : 'Dongfangtong TWeb（TongWeb）'
summary   : 'Collect information about Dongfangtong TWeb（TongWeb） metrics and tracing'
__int_icon: 'icon/dongfangtong'
dashboard :
  - desc  : 'Dongfangtong TWeb（TongWeb）Monitoring View'
    path  : 'dashboard/zh/dongfangtong_tweb'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# `Dongfangtong` TWeb（TongWeb）
<!-- markdownlint-enable -->

## Installation Configuration{#config}

### Download `ddtrace`

Download [`ddtrace` agent](https://github.com/GuanceCloud/dd-trace-java/releases)

### Configure Agent

Adjust the `external.vmoptions` file in the `bin` directory and add the following variable information to the `server_options` :

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

`dd-java-agent` ersion can be adjusted according to the actual situation. It is not recommended to add the variable `-Ddd.service.name`，here. If added, it will result in all projects using the same serviceName.

The `dd-java-agent` version can be adjusted according to the actual situation. It is not recommended to add the variable `-Ddd.service.name` here. If added, it will result in all projects using the same serviceName.

### DataKit enabled `Statsd` collector

The Statsd collector is used to collect metric related information. Go to the `datakit/conf.d/statsd` directory and copy `statsd.conf.sample` to `statsd.conf`.

```shell
root:/usr/local/datakit/conf.d/statsd$ ll
total 16
drwxr-xr-x  2 root root 4096 Oct  9 08:32 ./
drwxr-xr-x 53 root root 4096 Oct  9 08:32 ../
-rwxr-xr-x  1 root root 2233 Jul 24 16:38 statsd.conf
-rwxr-xr-x  1 root root 2233 Oct  9 08:32 statsd.conf.sample
```

For more parameter adjustments, refer to the [Statsd](statsd.md) collector integration document.

### DataKit enabled `ddtrace` collector

The `ddtrace` collector is used to collect information related to the `ddtrace` tracing. Enter the `datakit/conf.d/ddtrace` directory and copy `ddtrace.conf.sample` to `ddtrace.conf`.

```shell
root:/usr/local/datakit/conf.d/ddtrace$ ll
total 16
drwxr-xr-x  2 root root 4096 Oct  9 08:32 ./
drwxr-xr-x 53 root root 4096 Oct  9 08:32 ../
-rwxr-xr-x  1 root root 2470 Aug 16 10:42 ddtrace.conf
-rwxr-xr-x  1 root root 2474 Oct  9 08:32 ddtrace.conf.sample
```

For more parameter adjustments, refer to the [`ddtrace`](ddtrace.md) collector integration document.

### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Restart TongWeb

```shell
bin/startserver.sh restart
```


## Metric {#metric}

Global Tag

| Tag | Description |
| -- | -- |
| component | component name：`tongweb` |
| env | env |

JVM reference [JVM metrics](jvm.md#metric)
