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

## Configuration  {#config}

### Prerequisites

- Install DataKit on each ECS in **EDAS** <[Install DataKit](https://docs.guance.com/datakit/datakit-install/){:target="_blank"}>

### Installation and Configuration

Guance supports all APM monitoring methods that adopt the OpenTracing protocol by default, such as **SkyWalking**, **Jaeger**, **Zipkin**, etc.

The official recommendation here is to use the **ddtrace** integration method. **ddtrace** is an open-source APM monitoring method that supports more custom fields compared to other methods, meaning it can have enough labels to associate with other components. The specific steps for integrating **ddtrace** are as follows:

1. Log in to the Alibaba Cloud **EDAS** console [https://edasnext.console.aliyun.com](https://edasnext.console.aliyun.com/){:target="_blank"}

2. Select 「Application List」 - Choose 「Application Name」

3. Select 「Basic Information」 - Edit 「JVM Parameters」

4. Choose 「Custom」, enter the **Javaagent** parameter, and click 「Configure JVM Parameters」 after modification

5. Select 「Instance Deployment Information」, and restart the application

Parameter descriptions:

- **Javaagent**: Introduce the **dd-java-agent.jar** package
- Ddd.service.name: Service name (customizable)
- Ddd.agent.port: Port for data transmission to **DataKit** (default 9529)

```shell
-javaagent:/usr/local/datakit/data/dd-java-agent.jar -Ddd.service.name=service.name -Ddd.agent.port=9529
```

> For more information, refer to <[Alibaba Cloud **EDAS** Help Documentation](https://help.aliyun.com/product/29500.html){:target="_blank"}>

## Metrics {#metric}

| Field Name | Description |
| ---- | ---- |
| host | Hostname |
| source | Source of the trace, if collected via Zipkin, this value is Zipkin; if collected via Jaeger, this value is jaeger, and so on |
| service | Name of the service, it is recommended that users specify the name of the business system generating this trace data using this tag |
| parent_id | ID of the previous span of the current span |
| operation | Operation name of the current span, also understood as the span name |
| span_id | Unique ID of the current span |
| trace_id | Unique ID representing the current trace |
| span_type | Type of span, currently supports two values: entry and local. Entry span indicates that the span calls the service's entry point, i.e., the endpoint where the service provides calls to other services. Most spans should be entry spans. Only when a span is of entry type does it represent an independent request. Local span indicates that the span has no relation to remote calls and is just an internal function call within the program, such as an ordinary Java method. Default value: entry |
| endpoint | Target address of the request, the network address used by the client to access the target service (not necessarily IP + port), e.g., 127.0.0.1:8080, default: null |
| message | JSONString, original data collected before the trace transformation |
| duration | Integer, duration of the current trace span, **in microseconds** |
| status | Trace status: info: informational, warning: warning, error: error, critical: critical, ok: success |
| env | Environment to which the trace belongs, e.g., dev for development environment, prod for production environment, customizable by users |
