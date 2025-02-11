# Create a TCP Dial Testing Task
---

TCP Dial Testing allows you to monitor TCP connections to host ports, ensuring the availability of various port services such as SSH (22), SMTP (25), DNS (53), HTTPS-based VPN (443), and other custom port services. Through response time data, it tracks the performance of network applications; by tracing routes, it discovers all gateways on the path to the destination host.

## Create a Dial Testing Task

In the Guance workspace, click **New > Synthetic Tests**, and select **TCP Protocol**.

![](../img/4.dailtesting_tcp_1.png)

You can add [labels](../../management/global-label.md) in the top-left corner for the current dial testing task, enabling data linkage within the current workspace via global labels. Added labels are saved and displayed directly in the list. You can quickly find dial testing tasks under specific labels using the left-side **Shortcut > Labels**.

**Label Logic Supplement**: If you set the dial testing task node to `node_name: South China - Guangzhou - China Telecom`, and you add a label `node_name: User-defined Node` to the dial testing task, the custom label `node_name: User-defined Node` will not be written into the dial test result properties.

### Define Request Format

1. Host: Supports entering a host and port. The host can be in the format `www.example.com` or directly enter a gateway number like `192.186.0.1`. The default port is set to `443`.
2. Name: Customize the name of the TCP dial testing task. Duplicate names are not supported within the current workspace.
3. Route Tracing: When enabled, it opens a route tracing probe (traceroute) to discover all gateways on the path to the destination host.

### Availability Judgment

You can add judgment conditions based on filtering criteria to match the data. When multiple judgment conditions are selected, you can choose "All" or "Any" to determine the `AND` or `OR` relationship between conditions.

**Note**: Configuring network hops in the availability judgment, similar to enabling route tracing, returns route tracing data.

![Dial Testing Configuration](../../img/4.dailtesting_tcp_2.png)

After defining the request format and adding availability judgment conditions, you can click **Test** to the right of the URL to check if the dial test connection configuration is successful. It also returns the route tracing results.

**Note**: Testing is independent of the selected nodes.

### Select Dial Testing Nodes

Currently, Guance covers 14 dial testing nodes globally. You can choose one or more nodes from China or overseas regions (available only to Commercial Plan and above users) to quickly start monitoring the service quality of your site.

![Select Nodes](../../img/4.dailtesting_http_4.png)

### Select Dial Testing Frequency

Choose the frequency of data return for cloud dial testing. Options include 1 minute (Commercial Plan and above users only), 5 minutes (Commercial Plan and above users only), 15 minutes (Commercial Plan and above users only), 30 minutes, 1 hour, 6 hours, 12 hours, and 24 hours.

![Select Frequency](../../img/4.dailtesting_http_5.png)