---
icon: zy/usability-monitoring
---
# Synthetic Tests
---

Synthetic Tests is a comprehensive online service monitoring solution provided by Guance. It creates API tests without coding, using globally distributed monitoring points to simulate real user access experiences under different regional and network conditions. This monitoring not only covers key business scenarios such as network quality, website performance, and critical endpoints but also provides periodic monitoring of multi-dimensional performance metrics related to user experience.

Through the visual [data analysis platform](../scene/index.md) provided by Guance, you can view and analyze monitoring data in real-time, gaining deeper insights into service performance. Guance supports multi-dimensional real-time data analysis, helping users gain a comprehensive understanding of service availability. Additionally, by setting up [alert mechanisms](../monitoring/alert-setting.md), you can detect anomalies in key performance indicators, ensuring timely responses to issues and maintaining business stability and continuity.

![](img/image_2.png)

## Application Scenarios

- **Multi-protocol Support**: Create dial testing tasks based on HTTP, TCP, ICMP, WEBSOCKET protocols for comprehensive active monitoring of online service availability and performance;
- **Global Network Monitoring**: Utilize Guance's globally distributed monitoring points to instantly monitor network performance, ensuring global service availability and performance;
- **Website Performance Analysis**: Analyze the availability and performance of websites from geographical and availability trend perspectives;
- **Real-time Alert Notifications**: Configure alert rules based on data generated from dial testing tasks. When anomalies occur in business operations, alerts are sent via [email, DingTalk bots, etc.](../monitoring/notify-object.md).

## Getting Started

- **Custom Dial Testing Tasks**: Create dial testing tasks based on `HTTP, TCP, ICMP, WEBSOCKET` protocols to monitor your site's operational quality anytime.
- **Summary**: Analyze application performance from geographical and trend dimensions for specified dial testing tasks, including response time, round-trip time, connection time, and uptime.
- **Explorer**: View all detailed data returned by dial testing tasks, including DNS, SSL, TTFB performance test results, request errors, page load performance, etc.
- **User-defined Nodes**: Guance already covers multiple detection nodes globally and supports creating nodes based on different geographic locations and cloud providers to maximize system availability.
- **Synthetic Testing Anomaly Detection**: Monitor availability monitoring data within the workspace in conjunction with [monitoring](../monitoring/index.md) features.

<!--
## Step-by-step Instructions

- **Step 1**: Go to **Synthetic Tests** > **Tasks**, click **Create Task** to create dial testing tasks based on HTTP, TCP, ICMP, WEBSOCKET protocols, and **Save**.
- **Step 2**: Use the **Explorer** to view all available data within the current workspace.
- **Step 3**: Use the **Summary** to analyze site availability and response times from region, city, carrier, and other dimensions.
- **Step 4**: Use **Monitoring > Monitors > Synthetic Testing Anomaly Detection** to monitor availability monitoring data within the workspace.
-->