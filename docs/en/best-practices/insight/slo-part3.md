# SLO from Methodology to Practice: Part 3 Best Practices for Managing SLO with <<< custom_key.brand_name >>>

---

We previously covered [SLO tool selection in the previous part](slo-part2.md). Now, let's look at best practices for SLO within [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/).

Collaboration and communication are crucial for successfully implementing service level objectives. Development and operations teams need to evaluate the impact of their work based on established service reliability goals to improve the end-user experience. <<< custom_key.brand_name >>> enables everyone in your organization to track, manage, and monitor all SLOs and error budget statuses in one place, simplifying cross-team collaboration. Teams can visualize their SLOs along with related services and infrastructure components on dashboards and share real-time SLO status with any stakeholders who depend on them.

#### Selecting the Best SLO for Each Use Case

In <<< custom_key.brand_name >>>, you can create various monitors, and you can use one or more monitors to calculate SLIs. SLI is defined as the proportion of time your service behaves well (tracked by underlying monitors that are not in an alert state).

<<< custom_key.brand_name >>> Monitors
> - Threshold Detection
> - Log Detection
> - Anomaly Detection
> - Range Detection
> - Level Detection
> - Security Check
> - APM Metrics Detection
> - RUM Metrics Detection
> - Process Incident Detection
> - Synthetic Testing Anomaly Detection

You can create different types of monitors to meet the requirements of each SLO.

For example, you can create a monitor based on user access metrics detection to create an SLO. This uses metrics from <<< custom_key.brand_name >>> to calculate its SLI. The SLI is defined as the number of good requests out of the total number of valid requests.

If you want to track the latency of requests to a payment endpoint, creating an SLO based on an APM metrics detection monitor to track time-based data might be more appropriate: the percentage of time the endpoint behaves well (i.e., responds fast enough) to meet your SLO target. To create this SLO, you can choose a <<< custom_key.brand_name >>> threshold monitor that triggers when the request latency to the payment endpoint exceeds a specific threshold.

This SLO can be expressed as "99% of the time, requests should be processed faster than 0.5 seconds over a 30-day window." <<< custom_key.brand_name >>> uses a status bar to visualize the historical and current status of monitor-based SLOs, making it easy to see how often the SLO has been breached. The error budget next to this status bar will tell you how much time the monitor can spend in an alert state before the SLO turns red.

![image.png](../images/slo-part3-1.png)

On the other hand, if you want to track whether your payment endpoint successfully processes requests, you can define an SLO based on APM metrics detection, which mainly tracks the frequency of requests reaching the endpoint and when they succeed. This SLO uses count-based data (i.e., the number of good events compared to the total number of valid events) for its SLI. One way to address this is by counting HTTP responses with non-2xx status codes (which we consider as incident events).

![image.png](../images/slo-part3-2.png)

If your application is deployed on Docker and you want to ensure the environment provides good service, i.e., a secure container SLO, you can also create a Docker monitor from a template and specify the corresponding monitor when setting up the SLO.

![image.png](../images/slo-part3-3.png)

![image.png](../images/slo-part3-4.png)

#### Enhancing Your Dashboards with SLOs

You may already be using dashboards to visualize key performance metrics from your infrastructure and applications. You can enhance these dashboards by adding SLO summary widgets to track the status of your SLOs over time. To gain more context about the SLO status, we also recommend adding SLI charts corresponding to metric-based SLOs and displaying the status of the monitors that constitute monitor-based SLOs.
![image.png](../images/slo-part3-5.png)

#### Ensuring Service Reliability with <<< custom_key.brand_name >>> SLOs

In this article, we explored some useful tips to help you get the most value from service level objectives in <<< custom_key.brand_name >>>. SLOs, together with your infrastructure metrics, distributed tracing, logs, synthetic tests, and network data, help ensure the best possible end-user experience. <<< custom_key.brand_name >>>'s built-in collaboration features not only make it easy to define SLOs but also easily share insights with stakeholders inside and outside the organization.

Check out our [documentation](<<< homepage >>>/) to start defining and managing your SLOs. If you haven't tried <<< custom_key.brand_name >>> yet, you can start a free trial immediately.