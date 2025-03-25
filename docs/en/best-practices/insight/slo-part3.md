# SLO from Methodology to Practice: Part3 Best Practices for Managing SLOs with <<< custom_key.brand_name >>>

---

We conducted an SLO tool selection in [the previous part](slo-part2.md), and now let's take a look at the best practices for SLOs within [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/).

Collaboration and communication are crucial for successfully implementing service level objectives. Development and operations teams need to assess the impact of their work based on established service reliability goals to improve the end-user experience. <<< custom_key.brand_name >>> allows everyone in your organization to track, manage, and monitor the status of all SLOs and error budgets in one place, simplifying cross-team collaboration. Teams can visualize their SLOs along with relevant services and infrastructure components on dashboards and share the real-time status of these SLOs with any stakeholders who depend on them.

#### Selecting the Best SLO for Each Use Case

In <<< custom_key.brand_name >>>, you can create various types of monitors, and you can use one or more monitors to calculate your SLIs. SLI is defined as the proportion of time your service behaves well (tracked by underlying monitors that are not in an alert state).

<<< custom_key.brand_name >>> Monitors
> - Threshold detection
> - Log detection
> - Mutation detection
> - Range detection
> - Watermark detection
> - Security checks
> - Application performance metric detection
> - User access metric detection
> - Process anomaly detection
> - Synthetic testing anomaly detection

You can create different types of monitors to meet the needs of respective SLOs.

You can create an SLO using a monitor based on user access metric detection, which uses metrics in <<< custom_key.brand_name >>> to calculate its SLI. The SLI is defined as the number of good requests out of the total number of valid requests.

If you want to track the latency of requests to a payment endpoint, creating an SLO based on an application performance metric detection monitor to track time-based data may be more appropriate: the percentage of time the endpoint behaves well (i.e., responds quickly enough) to meet your SLO goal. To create this SLO, you can choose a <<< custom_key.brand_name >>> threshold monitor that triggers when the request latency to the payment endpoint exceeds a specific threshold.

This SLO can be expressed verbally as "99% of the time, the request processing should be faster than 0.5 seconds within a 30-day time window." <<< custom_key.brand_name >>> uses a status bar to visualize the historical and current status of SLOs based on monitors, making it easy to see how often the SLO has been breached. The error budget next to this status bar will tell you how much time the monitor can spend in an alert state before the SLO turns red.

![image.png](../images/slo-part3-1.png)

On the other hand, if you want to track whether your payment endpoint successfully processes requests, you can define an SLO based on metrics from an application performance metric monitor. Application performance metric detection primarily tracks the frequency of requests reaching the endpoint and when they succeed, based on APM tracking metrics. This SLO uses count-based data (i.e., the number of good events compared to the total number of valid events) for its SLI. One way to address this is to count the number of HTTP responses with non-2xx status codes (which we consider as the number of abnormal events).

![image.png](../images/slo-part3-2.png)

If your application is deployed on Docker and you want the application environment to provide good service — i.e., a secure container SLO — you can also create a Docker monitor from a template and specify the corresponding monitor when setting up the SLO.

![image.png](../images/slo-part3-3.png)

![image.png](../images/slo-part3-4.png)

#### Enhancing Your Dashboards with SLOs

You may already be using dashboards to visualize key performance indicators from your infrastructure and applications. You can enhance these dashboards by adding SLO summary widgets to track the status of your SLOs over time. To gain more context about the status of SLOs, we also recommend adding SLI charts corresponding to metric-based SLOs and displaying the status of the monitors that make up monitor-based SLOs.
![image.png](../images/slo-part3-5.png)

#### Ensuring Service Reliability with <<< custom_key.brand_name >>> SLOs

In this article, we explored some useful tips that will help you get the most value from service level objectives in <<< custom_key.brand_name >>>. SLOs, together with your infrastructure metrics, distributed tracing, logs, synthetic tests, and network data, help ensure you deliver the best possible end-user experience. The built-in collaboration features in <<< custom_key.brand_name >>> make it easy not only to define SLOs but also to easily share insights with stakeholders both inside and outside your organization.

Check out our [documentation](<<< homepage >>>/) to start defining and managing your SLOs. If you haven't used <<< custom_key.brand_name >>> yet, you can start a free trial immediately.