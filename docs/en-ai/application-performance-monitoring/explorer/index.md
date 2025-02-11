# Tracing
---

For business organizations deploying services in distributed systems, serverless computing, and containerized environments, Guance helps teams gain real-time insights into performance issues affecting their applications, such as application outages or unresponsive services. It ensures comprehensive visibility into these issues through end-to-end monitoring. However, improper management of tracing costs can lead to data gaps, extending the time required to resolve issues and potentially exacerbating minor problems, which can have significant impacts on the business.

Guance's APM supports the Opentracing protocol, enabling end-to-end trace analysis for distributed architecture applications. It also allows correlation with infrastructure, logs, RUM, and other data sources. You can search, filter, and export trace data under **APM > Tracing**, view detailed trace information, and use tools like [Flame Graphs](./explorer-analysis.md#flame), [Span Lists](./explorer-analysis.md#span), and [Waterfall Charts](./explorer-analysis.md#waterfall) to comprehensively analyze trace performance. Whether it's synchronous or asynchronous calls, Guance provides clear tracking of every detail of trace performance data, ensuring you have complete control over your trace data.

Before querying and analyzing data in the Explorer, please [configure collection first](#get_started).

## Get Started {#get_started}

![Explorer Configuration](../img/explorer-config.png)

![Explorer Configuration 1](../img/explorer-config-1.png)

Enter the tracing section and start configuring immediately.

### Manual Installation {#manual}

- [Deploy on Host](./manual/deploy_on_host.md);
- [Deploy on Kubernetes](./manual/deploy_on_k8s.md).

### Automatic Injection {#auto_wire}

The Datakit Operator is a collaborative project that orchestrates Datakit within Kubernetes, assisting with easier deployment and enabling automatic injection of DDTrace SDK (Java, Python, Node.js), Profiler, and more.