---
title: 'Alibaba Cloud EDAS'
tags: 
  - Alibaba Cloud
summary: 'Collect Alibaba Cloud EDAS Metrics and tracing data'
__int_icon: icon/aliyun_edas
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud **EDAS**
<!-- markdownlint-enable -->

## Configuration {#config}

### Prerequisites

- Install DataKit on each ECS in **EDAS** <[Install DataKit](https://docs.guance.com/datakit/datakit-install/){:target="_blank"}>

### Installation and Configuration

Guance supports all APM monitoring methods that adopt the OpenTracing protocol by default, such as **SkyWalking**, **Jaeger**, and **Zipkin**.

The official recommendation here is to use the **ddtrace** integration method. **ddtrace** is an open-source APM monitoring method that supports more custom fields compared to other methods, meaning it can provide enough labels for association with other components. The detailed steps for integrating **ddtrace** are as follows:

1. Log in to the Alibaba Cloud **EDAS** console [https://edasnext.console.aliyun.com](https://edasnext.console.aliyun.com/){:target="_blank"}

2. Select 「Application List」 - Choose 「Application Name」

3. Select 「Basic Information」 - Edit 「JVM Parameters」

4. Choose 「Custom」, enter the **Javaagent** parameter, and click 「Configure JVM Parameters」

5. Select 「Instance Deployment Information」, restart the application

Parameter Description:

- **Javaagent**: Introduce the **dd-java-agent.jar** package
- Ddd.service.name: Service name (customizable)
- Ddd.agent.port: Port for data transmission to **DataKit** (default 9529)

```shell
-javaagent:/usr/local/datakit/data/dd-java-agent.jar -Ddd.service.name=service.name -Ddd.agent.port=9529
```

> For more information, refer to the <[Alibaba Cloud **EDAS** Help Documentation](https://help.aliyun.com/product/29500.html){:target="_blank"}>

## Metrics {#metric}

| Field Name | Description |
| ---- | ---- |
| host | Hostname |
| source | Source of the trace, if collected via Zipkin, this value is Zipkin; if via Jaeger, it is jaeger, and so on |
| service | Name of the service, it is recommended that users specify the name of the business system generating the trace data using this tag |
| parent_id | ID of the previous span of the current span |
| operation | Operation name of the current span, which can also be understood as the span name |
| span_id | Unique ID of the current span |
| trace_id | Unique ID representing the entire trace |
| span_type | Type of span, currently supports two values: entry and local. Entry spans indicate calls to the service's entry point, i.e., endpoints where the service provides calls to other services. Most spans should be entry spans. Only calls where the span is of entry type constitute an independent request. Local spans indicate that the span has no relation to remote calls, just internal function calls within the program, such as a regular Java method. Default value: entry |
| endpoint | Target address of the request, the network address used by the client to access the target service (not necessarily IP + port), e.g., 127.0.0.1:8080, default: null |
| message | JSONString, original data collected before trace conversion |
| duration | Integer, duration of the current trace span, **in microseconds** |
| status | Trace status: info: informational, warning: warning, error: error, critical: critical, ok: successful |
| env | Environment to which the trace belongs, e.g., dev for development environment, prod for production environment, customizable by users |

---