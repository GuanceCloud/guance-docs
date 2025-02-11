# Create an ICMP Dial Testing Task
---

ICMP dial testing allows you to monitor network communication issues with hosts. By setting up one or more pings, it helps detect packet connections, packet loss rates, round-trip times, and other conditions. If route tracing or network hops are configured, it will return route trace results, which can track the number of network hops required to connect to the host and detailed information for each hop.

## Create a Task

In the Guance workspace, click **New > Synthetic Tests**, and select **ICMP Protocol**.

![](../img/4.dailtesting_icmp_1.png)

You can add [labels](../../management/global-label.md) in the top-left corner for the current dial testing task, using global labels to achieve data linkage within the current workspace. Added labels will be displayed directly in the list after saving. You can quickly find dial testing tasks under specific labels using the left-side **Shortcut > Labels**.

**Label Logic Supplement**: If the dial testing task node is set to `node_name: South China-Guangzhou-China Telecom`, and you add a label `node_name: User-defined Node`, the custom label `node_name: User-defined Node` will not be written into the dial test result attributes.

### Define Request Format

1. Host: Enter the host, supporting formats like `www.example.com` or gateway numbers such as `192.186.0.1`;
2. Name: Customize the name for the ICMP dial testing task; duplicate names are not allowed within the current space;
3. Route Tracing: When enabled, it opens a route tracing probe (`traceroute`) to discover all gateways on the path to the destination host;
4. Pings per Dial Test: Choose any number between 1 and 10.

### Availability Judgment

You can add judgment conditions to match data based on selected criteria. When multiple judgment conditions are chosen, they can be evaluated using "All" (AND) or "Any" (OR).

**Note**:

- Selecting "Network Hops" in availability judgment is similar to enabling route tracing, returning route tracing data;
- If the current dial test does not succeed, the round-trip time is set to 0, indicating no round-trip time.

![](../img/4.dailtesting_icmp_2.png)

After defining the request format and adding availability judgment conditions, you can click the **Test** button to the right of the URL to verify if the dial test configuration is successful. It returns the number of sent/received packets based on the selected pings per dial test. If route tracing or network hops are configured, it also returns route tracing results.

**Note**: Testing is independent of the selected nodes.

### Select Dial Testing Nodes

Currently, Guance covers 14 dial testing nodes globally. You can choose one or more nodes from China or overseas regions (only available for Commercial Plan and above users) to quickly start monitoring service quality.

<img src="../../img/4.dailtesting_http_4.png" width="80%" >

### Select Dial Testing Frequency

Choose the frequency at which cloud dial testing data is returned. Options include 1 minute (Commercial Plan and above), 5 minutes (Commercial Plan and above), 15 minutes (Commercial Plan and above), 30 minutes, 1 hour, 6 hours, 12 hours, and 24 hours.

<img src="../../img/4.dailtesting_http_5.png" width="70%" >

<!--

![](../img/4.dailtesting_icmp_3.png)

-->