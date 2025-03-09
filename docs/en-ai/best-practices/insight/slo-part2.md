# SLO from Methodology to Practice: Part 2 - SLO Tool Selection

---

Service Level Objectives (SLOs) are a key part of the Site Reliability Engineering toolkit. SLOs provide a framework for defining clear goals around application performance, ultimately helping teams deliver consistent customer experiences, balance feature development with platform stability, and improve communication with both internal and external users.

### SLOs and SLIs
As we saw in [Part 1](slo-part1.md), SLOs set precise targets for your Service Level Indicators (SLIs), which are metrics that reflect service health and performance. By managing your SLOs in [<<< custom_key.brand_name >>>](https://guance.com/), you can seamlessly access monitoring data—including APM traces, custom metrics, synthetic data, and metrics generated from logs—to use as SLIs. For example, if you want to ensure fast processing of typical user requests, you can use the median latency of an APM service as an SLI. Then, you can define an SLO as "in any calendar month, the median latency (calculated per minute) of all user requests will be less than 250 milliseconds for 99% of the time." To accurately track how actual performance compares to your set goals, you need a method not only to monitor real-time performance (e.g., calculating the median latency every 60 seconds and comparing it to the 250-millisecond threshold) but also to measure the frequency of threshold violations over longer periods (to ensure the 99% target is met each calendar month). <<< custom_key.brand_name >>> tracks your SLIs and visualizes their status relative to the SLOs you establish, so you can immediately see how actual performance compares to your goals over a given period.

### Tool Selection
For SLI metrics, data primarily comes from three main sources: Metrics, Logs, and Traces.
![image.png](../images/opentelemetry-observable-2.png)

**Metrics**: Metrics mainly collect system and application metrics, which significantly impact our services. For example, a sudden spike in CPU usage to 100% can drastically reduce application processing capabilities, leading to severe lagging for users.

**Traces**: Traces are based on directed acyclic graphs that represent the invocation relationships between different software modules. Through trace information, we can quickly identify which services or statements have a significant impact on customers, such as slow database queries.

**Logs**: Logs are time-related records output by systems or applications, typically by system/software developers, to help locate errors and system states. Extracting correlated data from logs into Tags or Fields allows for easier aggregation and grouping with Tags, while Fields facilitate calculations and aggregations.

Common tools:
> **Metrics**
> Prometheus, OpenTelemetry...
> **Traces**
> SkyWalking, OpenTelemetry, Jaeger, Sleuth, Zipkin...
> **Logs**
> ELK, Filebeat, Flume...

There are too many free open-source tools, each with its own specific Console and syntax. These tools come with high learning and maintenance costs. Disparate systems and user interfaces force you to switch between multiple platforms, which is precisely what SLIs need to avoid—a centralized platform that aggregates various system components. Using one platform to integrate multiple tools and unify the syntax can effectively reduce learning costs. [<<< custom_key.brand_name >>>](https://guance.com/) is the best choice, providing a one-stop solution with over 200 integrated open-source tool components. Of course, you could build such a platform yourself, but it's not recommended.

![image.png](../images/opentelemetry-observable-3.png)

### Managing All Your SLOs in One Place
If your organization has various SLOs across multiple products and teams, visualizing all SLO statuses in one place can help you prioritize and address issues. The Service Level Objective view in <<< custom_key.brand_name >>> allows you to see the status of all SLOs and the remaining error budget for each SLO.

![image.png](../images/opentelemetry-observable-4.png)

### Creating SLOs Based on Metrics and Monitors

In the SLO list view, you can create a new SLO by clicking the Create SLO button. SLOs in <<< custom_key.brand_name >>> can be based on existing monitors (for example, a monitor that compares p90 latency with a target threshold) or calculated in real-time based on metrics. Metric-based SLOs can be used to monitor the percentage of metrics that meet specific definitions, such as non-5xx responses from a load balancer divided by the total number of responses.

![image.png](../images/opentelemetry-observable-5.png)

### At-a-Glance View of Your SLOs and Error Budgets

Clicking an SLO or opening an event opens a side panel displaying detailed information about the SLO, such as its status, target value, and remaining error budget. <<< custom_key.brand_name >>> automatically generates an error budget for each SLO, indicating the level of unreliability you can tolerate before violating the SLO. This helps you quickly understand whether you're meeting your targets and whether your development pace aligns with your established performance and stability goals. <<< custom_key.brand_name >>> automatically calculates the error budget based on the SLO target and time window you specify. For example, a 99% SLO target over 7 days would give you approximately 3.5 hours of error budget during that period.

![image.png](../images/opentelemetry-observable-6.png)

### Visualizing SLO Status

![image.png](../images/opentelemetry-observable-7.png) To track the status of SLOs in context along with detailed data about related services or infrastructure components, you can add SLO widgets to your <<< custom_key.brand_name >>> dashboard. You can then share your dashboard internally or externally to communicate the real-time status of your SLOs to anyone who depends on your services.

You can also visualize the frequency of threshold violations using common SLO benchmarks, such as last week, last month, this week to date, or this month to date. If you set a 99% target for the past 30 days and a warning target of 99.5%, your SLO status will show as green when above 99.5%, yellow when below 99.5%, and red when below 99%.

### Showcasing and Sharing Your Service Status

<<< custom_key.brand_name >>> makes it simple to monitor and manage your SLOs in the same place where you already monitor applications, infrastructure, user experience, etc. Perhaps equally important, <<< custom_key.brand_name >>> enables you to provide transparency to any stakeholders or users who depend on meeting these SLOs. If you haven't started monitoring your service health and performance with <<< custom_key.brand_name >>>, you can start here with a [free trial account](https://auth.guance.com/redirectpage/register).

Continue reading the next and final part of this series [here](slo-part3.md), where we will share best practices for maximizing the value of your SLOs in <<< custom_key.brand_name >>>.