---
title     : 'JMX Jolokia'
summary   : 'JVM performance metrics display: heap and non heap memory, threads, class load count, etc.'
__int_icon: 'icon/jvm'
dashboard :
  - desc  : 'JVM by JMX Jolokia Monitoring View'
    path  : 'dashboard/zh/jvm_jolokia'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 MD046 -->
# JVM (Jolokia)
---

???+ info "Notice"

    The current article mainly collects information on jvm related metrics through the Jolokia method.

<!-- markdownlint-enable -->

## Configuration {#config}

Description: Enable the `jvm collector` to collect `jvm` metric information through the `jvm collector`.


### Application access to  Jolokia

The installation directory for DataKit has already provided the Jolokia Agent. Located in the `datakit/data/` directory, there are two types of agent libs available: `jolokia-jvm-agent.jar` and `jolokia-war.war`.


The following are all examples of `jar` running mode.

- Boot Configuration `javaagent`

```shell
java -javaagent:C:/'Program Files'/datakit/data/jolokia-jvm-agent.jar=port=8089,host=localhost -jar your_app.jar
```

### DataKit enables the collector

- Enables the collector

The directory where the collector is located is `datakit/conf.d/jvm`. After entering the directory, copy `jvm.conf.sample` and rename the new file to `jvm. conf`. The main configuration is `urls`, and other parameters can be adjusted as needed.

```toml
urls = ["http://localhost:8089/jolokia"]
```

The above configuration will generate `java_` The metric set at the beginning.

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)
