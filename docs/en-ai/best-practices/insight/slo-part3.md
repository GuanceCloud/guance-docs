# SLO from Methodology to Practice: Part 3 Best Practices for Managing SLOs with Guance

---

We previously [selected SLO tools in the last part](slo-part2.md), and now let's look at best practices for SLOs using [Guance](https://guance.com/).

Collaboration and communication are essential for successfully implementing service level objectives. Development and operations teams need to evaluate the impact of their work based on established service reliability goals to improve the end-user experience. Guance enables everyone in your organization to track, manage, and monitor all SLOs and error budget statuses in one place, simplifying cross-team collaboration. Teams can visualize their SLOs alongside relevant services and infrastructure components on dashboards and share the real-time status of these SLOs with any stakeholders who depend on them.

#### Selecting the Best SLO for Each Use Case

In Guance, you can create various monitors, and you can use one or more monitors to calculate your SLI. SLIs are defined as the proportion of time your service behaves well (tracked by underlying monitors that are not in an alert state).

Guance Monitors:
> - Threshold Detection
> - Log Detection
> - Anomaly Detection
> - Interval Detection
> - Watermark Detection
> - Security Check
> - APM Metrics Detection
> - RUM Metrics Detection
> - Process Anomaly Detection
> - Synthetic Testing Anomaly Detection

You can create different types of monitors to meet the needs of each SLO.

For example, you can create a monitor based on user access metrics detection to create an SLO. It uses metrics from Guance to calculate its SLI. The SLI is defined as the number of good requests out of the total valid requests.

If you want to track the latency of requests to a payment endpoint, creating an SLO based on an APM metrics detection monitor to track time-based data may be more appropriate: the percentage of time the endpoint behaves well (i.e., responds fast enough) to meet your SLO goal. To create this SLO, you can choose a Guance threshold monitor that triggers when the request latency to the payment endpoint exceeds a specific threshold.

This SLO can be verbally expressed as "99% of the time, requests should be processed faster than 0.5 seconds within a 30-day time window." Guance uses a status bar to visualize the historical and current state of SLOs based on monitors, making it easy to see how often the SLO has been breached. The error budget next to this status bar will tell you how much time the monitor can spend in an alert state before the SLO turns red.

![image.png](../images/slo-part3-1.png)

On the other hand, if you want to track whether your payment endpoint successfully processes requests, you can define an SLO based on APM metrics detection. APM metrics detection primarily tracks the frequency of requests reaching the endpoint and when they succeed, using count-based data (i.e., the number of good events compared to the total number of valid events) for its SLI. One way to address this is to count HTTP responses with non-2xx status codes (which we consider as anomaly events).

![image.png](../images/slo-part3-2.png)

If your application is deployed on Docker and you want the application environment to provide good service, i.e., a secure container SLO, you can also create a Docker monitor from a template and specify the corresponding monitor when setting up the SLO.

![image.png](../images/slo-part3-3.png)

![image.png](../images/slo-part3-4.png)

#### Enhancing Your Dashboards with SLOs

You may already be using dashboards to visualize key performance indicators from your infrastructure and applications. You can enhance these dashboards by adding SLO summary widgets to track the status of your SLOs over time. To gain more context about the SLO status, we also recommend adding SLI charts corresponding to metric-based SLOs and displaying the status of the monitors that constitute monitor-based SLOs.
![image.png](../images/slo-part3-5.png)

#### Ensuring Service Reliability with Guance SLOs

In this article, we explored some useful tips that will help you get the most value from service level objectives in Guance. SLOs, together with your infrastructure metrics, distributed tracing, logs, synthetic tests, and network data, help ensure the best possible end-user experience. Guance's built-in collaboration features not only make it easy to define SLOs but also facilitate sharing insights with stakeholders both inside and outside your organization.

Check out our [documentation](https://docs.guance.com/) to start defining and managing your SLOs. If you haven't used Guance yet, you can start a free trial immediately.