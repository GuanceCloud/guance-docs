# Link Data Collection
---

## Introduction

Link data collection of Guance currently supports collectors using Opentracing protocol. After the link data receiving service is started in DataKit, DataKit will automatically complete the format conversion and collection of data by completing the embedding point of the collector in the code, and finally report it to the Guance center.



## Data Collection

DataKit currently supports collecting Tracing data from third parties such as `DDTrace`, `Apache Jaeger`, `OpenTelemetry`, `Skywalking` and `Zipkin`.

First of all, you need to [install DataKit](../../datakit/datakit-install.md). After the installation is completed, you need to open the configuration file of the link collector. You can log in to the Guance console, enter the "Integration" page and enter the search for "Application Performance Monitoring", and you can view the relevant collectors for all link data collection, open the configuration description document of the collector, and configure according to the steps in the document. Or you can directly click the following link to view the corresponding collector configuration:

|                          Collector Configuration                          |                                                              |                                                              |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [DDTrace](../../datakit/ddtrace.md){ .md-button .md-button--primary } | [Skywalking](../../datakit/skywalking.md){ .md-button .md-button--primary } | [OpenTelemetry](../../datakit/opentelemetry.md){ .md-button .md-button--primary } | [Zipkin](../../datakit/zipkin.md){ .md-button .md-button--primary } | [Jaeger](../../datakit/jaeger.md){ .md-button .md-button--primary } |

### Schematic Diagram of Data Collection Steps

- Step 1: [install host DataKit](../../datakit/datakit-install.md) or [install Kubernetes DataKit](../../datakit/datakit-daemonset-deploy.md)
- Step 2: Open the link data receiving service in the DataKit
- Step 3: Report data to Endpoint of DataKit's link tracing service by integrating an SDK for open source link data collection, such as Zipkin or Jaeger or Skywalking, into the business system
- Step 4: DataKit will automatically clean the data into the link data format of Guance itself and report it to the Guance center
- Step 5: Conduct link analysis and view service-related performance metrics at the console of Guance

![](../img/1.apm-1.png)

## Field Description

DataKit will convert the reported data into the format of Guance link data according to different collectors, and retain labels and metrics. The following is a description of the commonly used fields, and the documentation [DataKit Tracing Data Structure](../../datakit/datakit-tracing-struct.md#point-proto).

| Field Name    | Description                                                    |
| --------- | ------------------------------------------------------------ |
| host      | Hostname, default global label                                         |
| source    | The source of the link is `zipkin` if it is collected by zipkin, `jaeger` if it is collected by jaeger, and so on |
| service   | The name of the service through which the user is advised to specify the name of the service system that generates the link data |
| parent_id | ID of the previous `span` of the current `span`                            |
| operation | The name of the current `span` operation, which can also be understood as the span name                     |
| span_id   | Unique ID of the current `span`                                        |
| trace_id  | Represent the unique ID of the current link                                        |
| span_type | The type of span, currently supported: `entry`, `local`, `exit`, `unknow`. <br><li>`entry span` represents the span created by the entry service, the endpoint of that service that provides invocation requests to other services, and most of the spans should be entry spans. Only calls with span of type `entry` are a separate request. <br><li>`local span` indicates that the span has nothing to do with the remote call and is created when the local method is called, such as a normal Java method. <br><li>`exit span` indicates leaving a span created by a service, such as when a remote call is initiated, or when a message queue generates a message. <br><li>`unknow span` denotes an unknown span. |
| endpoint  | The destination address of the request, the network address the client uses to access the destination service, such as `127.0.0.1:8080`, default: `null` |
| message   | Raw data collected before link conversion                                 |
| duration  | The duration of the current link span                                      |
| status    | Link state, info: prompt, warning: warning, error: error, critical: critical, ok: successful |
| env       | The environment to which the link belongs, for example, dev can be used to represent the development environment, prod can be used to represent the production environment, and users can customize it. |

## More References


- Best Practices: [Distributed Link Tracing (apm) Best Practices](../../best-practices/monitoring/apm/)


