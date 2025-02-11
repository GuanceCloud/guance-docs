# Create HTTP Synthetic Tests Task
---

HTTP Synthetic Tests monitor the availability of websites, domains, and backend APIs based on the `HTTP` protocol. By continuously monitoring these endpoints in real-time, it provides availability statistics, synthetic testing logs, and real-time alerts, helping you quickly identify network issues and improve network access quality.

HTTP Synthetic Tests allow you to send HTTP requests to your application's API interfaces to verify request definitions and judgment criteria, such as request headers, status codes, response times, etc.

## Create a Task

In the Guance workspace, click **New > Synthetic Tests**, and select **HTTP Protocol**.

![](../img/4.dailtesting_http_1.png)

You can add [labels](../../management/global-label.md) for the current Synthetic Tests task in the top-left corner, enabling data correlation within the current workspace through global labels. Once added, the labels will be displayed directly in the list. You can quickly find Synthetic Tests tasks under specific labels using the left-side **Shortcut > Labels**.

**Label Logic Note**: Set the Synthetic Tests task node to `node_name: South China - Guangzhou - China Telecom`. If you add the label `node_name: User-defined Node`, this custom label `node_name: User-defined Node` will not be written into the Synthetic Tests result attributes.

### Define Request Format

<img src="../../img/4.dailtesting_http_2.png" width="70%" >

1. URL: Supports entering HTTP or HTTPS URLs, including four request methods: `GET`, `POST`, `PUT`, and `HEAD`;
2. Advanced Settings: Adjust advanced settings according to actual needs, including request settings, request body content, certificates, proxies, and privacy;
3. Name: Customize the name of the HTTP Synthetic Tests task; duplicate names are not allowed within the current workspace.

### Availability Judgment {#test}

You can add judgment conditions to match data based on filtering criteria. When multiple judgment conditions are selected, they can be evaluated with "All" (`AND`) or "Any" (`OR`) relationships.

<img src="../../img/4.dailtesting_http_3.png" width="70%" >

After defining the request format and adding availability judgment conditions, you can click **Test** next to the URL to check if the Synthetic Tests connection configuration is successful.

**Note**: The test is independent of the selected nodes.

### Select Synthetic Tests Nodes

Guance currently covers 14 Synthetic Tests nodes globally. You can choose one or more nodes from China or overseas regions (only available for Commercial Plan and above users) to quickly start monitoring the service quality of your site.

<img src="../../img/4.dailtesting_http_4.png" width="80%" >

### Select Synthetic Tests Frequency

Choose the frequency of data returns for cloud-based Synthetic Tests. Options include 1 minute (only available for Commercial Plan and above users), 5 minutes (only available for Commercial Plan and above users), 15 minutes (only available for Commercial Plan and above users), 30 minutes, 1 hour, 6 hours, 12 hours, and 24 hours.

<img src="../../img/4.dailtesting_http_5.png" width="70%" >