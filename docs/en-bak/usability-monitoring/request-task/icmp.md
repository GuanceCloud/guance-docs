# ICMP Tests
---

## Introduction

ICMP test allows you to monitor network communication problems on your host. By setting one or more pings, you can help detect packet connections, packet loss rates and round trip times. If you configure Route Trace or Network Hops, a route trace result is returned that tracks the number of network hops required to connect to the host, as well as the details of each network hop.

## Create ICMP test Task

In the Guance workspace, click "New"-"API test" and select "ICMP Protocol" to create a new ICMP test task.

![](../img/4.dailtesting_icmp_1.png)

### Define Request Format

- Host: Enter the Host in the format `www.example.com` or directly enter the gateway number such as `192.186.0.1`。
- Name: Custom ICMP task name. Duplicate names are not supported in the current space.
- Route tracing: A route tracing probe (**traceroute**) opens to discover all gateways on the destination path to the host when turned on.
- Send pings per test: support to select any number from 1 to 10.

### Available Judgment

It supports adding judgment condition matching data. When multiple judgment conditions are selected, the relationship between multiple judgment conditions can be judged as "all and" or "all or" by selecting "all" or "any".

Note:

- Configure "Network Hop Count" when available, similar to turning on route tracing, which will return route tracing data.
- If there is no ping in the current task, the round trip time is set to 0, that is, there is no round trip time.

![](../img/4.dailtesting_icmp_2.png)

### Select test Node

At present, Guance has covered 16 nodes in the world, and it supports selecting one or more nodes in China and overseas regions (only commercial and above users are supported), so as to quickly start the service quality monitoring of the site.

![](../img/4.dailtesting_http_4.png)

### Select Dial Frequency

Select the data return frequency of cloud automated testing, which supports 8 choices, such as 1 minute (only commercial version and above users), 5 minutes (only commercial version and above users), 15 minutes (only commercial version and above users), 30 minutes, 1 hour, 6 hours, 12 hours and 24 hours.

![](../img/4.dailtesting_http_5.png)

### Test

After the configuration is completed, click the "Test" button to confirm whether the configuration is successful, and return the number of data packets sent/received based on the selected "Send pings per test". If "Route Tracking" or "Network Hop Count" is configured, the route tracking result will be returned at the same time.

![](../img/4.dailtesting_icmp_3.png)

