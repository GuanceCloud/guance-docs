---
icon: zy/datakit
---

# DataKit
---

## Overview {#intro}

DataKit is an open-source, all-in-one data collection Agent that supports all major operating systems (Linux/Windows/macOS). It offers comprehensive data collection capabilities covering various scenarios such as hosts, containers, middleware, Tracing, logs, and Security Check.

## Main Features {#features}

- Supports metrics, logs, and Tracing data collection across hosts, middleware, logs, APM, and other domains.
- Fully supports the Kubernetes cloud-native ecosystem.
- [Pipeline](../pipeline/use-pipeline/index.md): Simplified structured data extraction.
- Supports integration with other third-party data collectors:
    - [Telegraf](../integrations/telegraf.md)
    - [Prometheus](../integrations/prom.md)
    - [Statsd](../integrations/statsd.md)
    - [Fluentd](../integrations/logstreaming.md)
    - [Filebeat](../integrations/beats_output.md)
    - [Function](https://func.guance.com/doc/practice-write-data-via-datakit/){:target="_blank"}
    - Tracing-related:
        - [OpenTelemetry](../integrations/opentelemetry.md)
        - [DDTrace](../integrations/ddtrace.md)
        - [Zipkin](../integrations/zipkin.md)
        - [Jaeger](../integrations/jaeger.md)
        - [SkyWalking](../integrations/skywalking.md)
        - [Pinpoint](../integrations/pinpoint.md)

## Notes {#spec}

### Experimental Features {#experimental}

When DataKit is released, it includes some experimental features. These are often new features being introduced for the first time, which may have some limitations or issues. Therefore, when using experimental features, consider the following:

- The feature might be unstable.
- Some configuration options may not be compatible in future iterations.
- Due to their limitations, these features might be removed, but alternative solutions will be provided to meet the corresponding needs.

Please use these features with caution.

If you encounter any issues while using experimental features, you can submit them to the following issue trackers:

- [GitLab](https://gitlab.jiagouyun.com/cloudcare-tools/datakit/-/issues/new?issue%5Bmilestone_id%5D=){:target="_blank"}
- [GitHub](https://github.com/GuanceCloud/datakit/issues/new){:target="_blank"}
- [JiHuLab](https://jihulab.com/guance-cloud/datakit/-/issues/new){:target="_blank"}

### Legend {#legends}

| Legend                                                                                                                       | Description                                                            |
| ---                                                                                                                          | ---                                                                    |
| :fontawesome-solid-flag-checkered:                                                                                           | Indicates that the collector supports leader election.                 |
| :fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:   | Represents Linux, Windows, macOS, Kubernetes, and Docker respectively.  |
| :octicons-beaker-24:                                                                                                         | Indicates experimental features (see [Experimental Features](index.md#experimental)). |

## Precautions {#disclaimer}

Using DataKit may have the following impacts on existing systems:

1. Log collection can cause high disk read speeds; the larger the log volume, the higher the IOPS.
2. If RUM SDK is added to Web/App applications, continuous RUM-related data uploads may occur. If there are bandwidth limits for uploads, this could lead to Web/App page lag.
3. After enabling eBPF, due to the large amount of collected data, it will consume a certain amount of memory and CPU. Specifically, after enabling bpf-netlog, it will generate a large number of logs based on all TCP packets from host and container network interfaces.
4. When DataKit is busy (processing a large amount of logs/Traces and importing external data), it will consume a significant amount of CPU and memory resources. It is recommended to set up reasonable cgroups for control.
5. When DataKit is deployed in Kubernetes, it will put some pressure on the API server.
