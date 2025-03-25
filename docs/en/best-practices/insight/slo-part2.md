# SLO from Methodology to Practice: Part 2 SLO Tool Selection

---

Service Level Objectives or SLOs are a key part of the Site Reliability Engineering toolkit. SLOs provide a framework for defining clear goals around application performance, ultimately helping teams deliver consistent customer experiences, balance feature development with platform stability, and improve communication with internal and external users.

### SLOs and SLIs
As we saw in [Part 1](slo-part1.md), SLOs set precise targets for your SLIs, which are the metrics that reflect the health and performance of your services. By managing your SLOs in [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/), you can seamlessly access monitoring data — including trace metrics from APM, custom metrics, synthetic data, and metrics generated from logs — to use as SLIs. For example, if you want to ensure fast processing of typical user requests, you could use the median latency of an APM service as an SLI. Then, you could define the SLO as "In any calendar month, the median latency (calculated per minute) of all user requests will be less than 250 milliseconds for 99% of the time."
To accurately track how actual performance compares to your set goals, you need a way not only to monitor real-time performance (e.g., calculating the median latency every 60 seconds and comparing it to the 250-millisecond threshold), but also to measure how often that threshold is violated over longer time spans (to ensure that the 99% goal is met each calendar month). <<< custom_key.brand_name >>> tracks your SLIs and visualizes their status relative to the SLOs you have established, so you can immediately see how actual performance compares to your goals over a given time period.

### Tool Selection
For SLI metrics, data primarily comes from three main sources: Metrics, Logs, Traces.
![image.png](../images/opentelemetry-observable-2.png)
Metrics: These are mainly collected system and application metrics that significantly impact our services, such as the consequences of a sudden CPU spike to 100%, which drastically reduces application processing capacity, resulting in severe lagging issues for users.

Traces: Based on directed acyclic graphs, these represent the call relationships between various software modules, providing insight into service call chains. Through trace information, we can quickly identify which services or statements have a significant impact on customers, such as slow database queries.

Logs: Time-related records output by systems/applications, typically provided by system/software developers to facilitate error and state identification. Extracting related data from logs as Tags or Fields, Tags allow for aggregation and grouping, while Fields enable calculations and aggregations.

Common tools:
> Metrics
> promethues, OpenTelemetry...
> Traces
> skyworking, OpenTelemetry, jaeger, Sleuth, Zipkin...
> Logs
> ELK, filebeat, flume...

There are too many free open-source tools, each with specific consoles and syntaxes. These tools come with high learning costs and expensive maintenance costs for you. The scattered systems and user systems force you to constantly switch between multiple platforms. SLIs require a platform that can aggregate components from various systems centrally. A platform that can integrate multiple tools and unify syntax effectively reduces learning costs. [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) is the best choice; <<< custom_key.brand_name >>> provides a one-stop solution, currently integrating more than 200 open-source tool components. Of course, you can also build a team to construct such a platform, but this is not recommended.
![image.png](../images/opentelemetry-observable-3.png)

### Manage All Your SLOs in One Place
If your organization is committed to various SLOs across multiple products and teams, visualizing the status of all SLOs in one place can help you set priorities and solve problems. <<< custom_key.brand_name >>>'s Service Level Objective view allows you to see the status of all SLOs as well as the remaining error budget for each SLO.

![image.png](../images/opentelemetry-observable-4.png)


### Create SLOs Based on Metrics and Monitors

In the SLO list view, you can create a new SLO by clicking the Create SLO button. SLOs in <<< custom_key.brand_name >>> can be based on existing monitors (for example, monitors that compare p90 latency to a target threshold) or on real-time statuses calculated from metrics. Metric-based SLOs can be used to monitor the percentage of metrics that meet a specific definition, such as the number of non-5xx responses from a load balancer divided by the total number of responses.

![image.png](../images/opentelemetry-observable-5.png)

### At-a-Glance View of Your SLOs and Error Budgets

Clicking on an SLO or opening an event opens a side panel that displays details about the SLO, such as its status, target value, and remaining error budget. <<< custom_key.brand_name >>> automatically generates an error budget for each SLO, representing the degree of unreliability you can tolerate before violating the SLO. This helps you quickly understand whether you are meeting your goals and whether your development speed aligns with your established performance and stability targets. <<< custom_key.brand_name >>> automatically calculates the error budget based on the SLO target and time window you specify. For example, a 99% SLO target over a 7-day period would give you approximately three and a half hours of error budget during that period when performance does not meet standards.

![image.png](../images/opentelemetry-observable-6.png)

### Visualize SLO Status

![image.png](../images/opentelemetry-observable-7.png) To track the status of your SLOs in context along with detailed data about related services or infrastructure components, you can add an SLO widget to your <<< custom_key.brand_name >>> dashboard. You can then share your dashboard internally or externally, communicating the real-time status of your SLOs to anyone who depends on your services.

You can also visualize how often that threshold has been violated against common SLO benchmarks like last week, last month, this week to date, or this month to date. If you set your goal for the past 30 days at 99% and your warning goal at 99.5%, your SLO status will show as green when above 99.5%, yellow when below 99.5%, and red when dropping below 99%.

### Showcase and Share Your Service Status

<<< custom_key.brand_name >>> makes it simple to monitor and manage your SLOs in the same place where you already monitor applications, infrastructure, user experience, etc. Perhaps equally important, <<< custom_key.brand_name >>> enables you to provide transparency to any stakeholders or users who depend on meeting these SLOs. If you're not already using <<< custom_key.brand_name >>> to monitor the health and performance of your services, you can start here with a [Free Trial Account](https://<<< custom_key.studio_main_site_auth >>>/redirectpage/register).

Continue reading the [next and final part of this series](slo-part3.md), where we'll share best practices for getting the most out of your SLOs in <<< custom_key.brand_name >>>.