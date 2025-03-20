---
title: 'Alibaba Cloud EDAS'
tags: 
  - Alibaba Cloud
summary: 'Collect Alibaba Cloud EDAS Metrics and APM data'
__int_icon: icon/aliyun_edas
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud **EDAS**
<!-- markdownlint-enable -->

## Configuration  {#config}

### Prerequisites

- **EDAS** each ECS installs [DataKit](https://docs.guance.com/datakit/datakit-install/){:target="_blank"}

### Installation Configuration

Guance supports by default all APM monitoring methods that adopt the OpenTracing protocol, such as **SkyWalking**, **Jaeger**, **Zipkin**, etc.

Here, the official recommendation is to use the **ddtrace** integration method. **ddtrace** is an open-source APM monitoring method. Compared with other methods, it supports more custom fields, which means there can be enough labels to associate with other components. The specific integration method for **ddtrace** is detailed below:

1. Log in to the Alibaba Cloud **EDAS** console [https://edasnext.console.aliyun.com](https://edasnext.console.aliyun.com/){:target="_blank"}

2. 「Application List」 - Select 「Application Name」

3. 「Basic Information」 - Edit 「JVM Parameters」

4. Select 「Custom」, enter the **Javaagent** parameter, and after modification, click 「Configure JVM Parameters」

5. Select 「Instance Deployment Information」, restart the application

Parameter description:

- **Javaagent**: Introduce the **dd-java-agent.jar** package
- Ddd.service.name: Service name (customizable)
- Ddd.agent.port: Data transmission to the **datakit** port (default 9529)

```shell
-javaagent:/usr/local/datakit/data/dd-java-agent.jar -Ddd.service.name=service.name -Ddd.agent.port=9529
```

> If you want to learn more, refer to <[Alibaba Cloud **EDAS** Help Documentation](https://help.aliyun.com/product/29500.html){:target="_blank"}>

## Metrics {#metric}

| Field Name    | Description                                                         |
| ---- | ---- |
| host      | Hostname                                                       |
| source    | Source of the trace; if collected via Zipkin, this value is Zipkin, if collected via Jaeger, this value is jaeger, and so on |
| service   | Service name; it is recommended that users specify the name of the business system generating this trace data using this tag |
| parent_id | ID of the previous span of the current span                                |
| operation | Operation name of the current span, or the span name                       |
| span_id   | Unique ID of the current span                                          |
| trace_id  | Unique ID representing the current trace                                        |
| span_type | Type of the span, currently supports two values: entry and local. An entry span indicates that this span's call is the entry point of the service, i.e., the endpoint where this service provides calls to other services. Most spans should be entry spans. Only calls of spans that are of type entry constitute an independent request. A local span indicates that this span has no relation to remote calls and is just an internal function call of the program, for example, a regular Java method. Default value: entry |
| endpoint  | Target address of the request, the network address used by the client to access the target service (but not necessarily IP + port), for example, 127.0.0.1:8080 , default: null |
| message   | JSONString, raw data collected before the trace conversion                     |
| duration  | int, duration of the current trace span, **in microseconds**                |
| status    | Trace status, info: informational, warning: warning, error: error, critical: critical, ok: successful |
| env       | Environment to which the trace belongs, for example, dev can represent the development environment, prod can represent the production environment, users can customize |