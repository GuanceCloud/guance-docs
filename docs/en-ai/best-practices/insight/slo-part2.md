# SLO from Methodology to Practice: Part 2 - SLO Tool Selection

---

Service Level Objectives (SLOs) are a key part of the Site Reliability Engineering toolkit. SLOs provide a framework for defining clear goals around application performance, ultimately helping teams deliver consistent customer experiences, balance feature development with platform stability, and improve communication with both internal and external users.

### SLOs and SLIs
As we saw in [Part 1](slo-part1.md), SLOs set precise targets for your Service Level Indicators (SLIs), which are metrics that reflect service health and performance. By managing your SLOs in [Guance](https://guance.com/), you can seamlessly access monitoring data—including APM traces, custom metrics, synthetic data, and metrics generated from logs—to use as SLIs. For example, if you want to ensure fast processing of typical user requests, you can use the median latency from an APM service as an SLI. Then, you can define the SLO as "99% of the time, the median latency of all user requests (calculated per minute) will be less than 250 milliseconds in any calendar month."

To accurately track how actual performance compares to your set goals, you need a method not only to monitor real-time performance (for example, calculating the median latency every 60 seconds and comparing it to the 250-millisecond threshold) but also to measure the frequency of threshold violations over longer periods (to ensure the 99% target is met each calendar month). Guance tracks your SLIs and visualizes their status relative to the SLOs you've established, so you can immediately see how actual performance compares to your goals within a given time frame.

### Tool Selection
For SLI metrics, data primarily comes from three main sources: Metrics, Logs, and Traces.
![image.png](../images/opentelemetry-observable-2.png)

**Metrics**: Metrics are primarily system and application performance indicators that have a significant impact on services, such as CPU spikes leading to severe application slowdowns and user experience issues like lagging.

**Traces**: Traces represent the call relationships between different modules based on directed acyclic graphs. Through trace information, you can quickly identify which services or statements significantly affect customers, such as slow database queries.

**Logs**: Logs are time-related records output by systems or applications, typically provided by system/software developers for troubleshooting and understanding system states. Extracting related data from logs into Tags or Fields allows for easier aggregation and analysis; Tags facilitate grouping and aggregation, while Fields support calculations and aggregations.

Common tools:
> **Metrics**
> Prometheus, OpenTelemetry...
>
> **Traces**
> SkyWalking, OpenTelemetry, Jaeger, Sleuth, Zipkin...
>
> **Logs**
> ELK, Filebeat, Flume...

There are too many free open-source tools, each with specific consoles and syntaxes. These tools come with high learning and maintenance costs, and the fragmented systems and user bases force you to switch between multiple platforms. An integrated platform that aggregates various system components and unifies syntax can effectively reduce learning costs. [Guance](https://guance.com/) is the best choice, offering a one-stop solution and currently integrating over 200 open-source tool components. Of course, you could build such a platform yourself, but this is not recommended.
![image.png](../images/opentelemetry-observable-3.png)

### Managing All Your SLOs in One Place
If your organization has various SLOs across multiple products and teams, visualizing all SLO statuses in one place can help prioritize and address issues. The Service Level Objective view in Guance allows you to see the status of all SLOs and the remaining error budget for each SLO.

![image.png](../images/opentelemetry-observable-4.png)

### Creating SLOs Based on Metrics and Monitors

In the SLO list view, you can create a new SLO by clicking the "New SLO" button. SLOs in Guance can be based on existing monitors (e.g., comparing p90 latency to a target threshold) or calculated from real-time metric statuses. Metric-based SLOs can monitor the percentage of metrics meeting specific definitions, such as non-5xx responses from load balancers divided by total responses.

![image.png](../images/opentelemetry-observable-5.png)

### Easily View Your SLOs and Error Budgets

Clicking an SLO or opening an event reveals a side panel showing detailed information about the SLO, such as its status, target value, and remaining error budget. Guance automatically generates an error budget for each SLO, indicating the level of unreliability you can tolerate before violating the SLO. This helps quickly understand if you're meeting your goals and whether your development pace aligns with your performance and stability objectives. Guance automatically calculates the error budget based on the SLO target and time window you specify. For example, a 99% SLO target over 7 days provides approximately 3.5 hours of error budget during that period.

![image.png](../images/opentelemetry-observable-6.png)

### Visualize SLO Status

![image.png](../images/opentelemetry-observable-7.png)
To track the status of your SLOs along with detailed data about related services or infrastructure components, you can add SLO widgets to your Guance dashboard. You can then share your dashboard internally or externally to communicate the real-time status of your SLOs to anyone depending on your services.

You can also visualize the frequency of threshold violations using common SLO benchmarks (e.g., last week, last month, this week to date, or this month to date). If you set a 99% target for the past 30 days and a warning target of 99.5%, your SLO status will show as green when above 99.5%, yellow when below 99.5%, and red when below 99%.

### Showcase and Share Your Service Status

Guance makes it simple to monitor and manage your SLOs in the same place where you already monitor applications, infrastructure, user experience, etc. Perhaps equally important, Guance enables transparency for any stakeholders or users who depend on these SLOs being met. If you haven't started using Guance to monitor your service health and performance, you can start with a [free trial account](https://auth.guance.com/redirectpage/register).

Continue reading the next and final part of this series [here](slo-part3.md), where we'll share best practices for maximizing your SLOs in Guance.