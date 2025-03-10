# Tracing
---

For business organizations deploying services in distributed systems, serverless computing, and containerized environments, <<< custom_key.brand_name >>> helps teams gain real-time insights into performance issues such as application outages or unresponsive services through APM. It also ensures comprehensive visibility end-to-end to fully grasp performance issues. However, improper tracing cost management can lead to data loss, prolong issue resolution times, and even exacerbate minor issues, significantly impacting the business.

<<< custom_key.brand_name >>>'s APM supports the Opentracing protocol, enabling end-to-end tracing analysis for distributed architecture applications, and can be correlated with infrastructure, logs, RUM, etc., for comprehensive analysis. You can search, filter, and export tracing data under **APM > Tracing**, view detailed tracing information, and use tools like [Flame Graphs](./explorer-analysis.md#flame), [Span List](./explorer-analysis.md#span), [Waterfall Charts](./explorer-analysis.md#waterfall) to comprehensively analyze tracing performance. Whether it's synchronous or asynchronous calls, <<< custom_key.brand_name >>> can clearly track every detail of tracing performance data, ensuring you have complete and effective control over tracing data.

Before querying and analyzing data in the tracing Explorer, please [configure collection first](#get_started).

## Get Started {#get_started}

![Configuration](../img/explorer-config.png)

![Configuration 1](../img/explorer-config-1.png)

Enter the tracing section and start configuring immediately.

### Manual Installation {#manual}

- [Deploy on Host](./manual/deploy_on_host.md);
- [Deploy on Kubernetes](./manual/deploy_on_k8s.md).

### Automatic Injection {#auto_wire}

The Datakit Operator is a collaborative project of Datakit orchestrated in Kubernetes, assisting in easier deployment of Datakit and enabling automatic injection of DDTrace SDK (Java, Python, Node.js), Profiler, etc.