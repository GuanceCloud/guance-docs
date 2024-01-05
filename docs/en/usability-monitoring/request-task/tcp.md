# TCP Tests
---

## Introduction

TCP dial test allows you to monitor TCP connections on host ports, ensure the availability of multiple port services such as SSH (22), SMTP (25), DNS (53), VPN (443) on HTTPS, and other custom port services, and track the performance of network applications through response time data; Discover all gateways on the destination path to the host through route tracing.

## Create TCP Request Task

In the Guance workspace, click "New"-"API Dial Test" and select "TCP Protocol" to create a new TCP task.

![](../img/4.dailtesting_tcp_1.png)

### Define Request Format

- Host: Enter the Host and port. The Host can enter the format of `www.example.com` or directly enter the gateway number such as `192.186.0.1`, and the port is set to `443`.
- Name: Custom TCP task name. Duplicate names are not supported in the current space.
- Route tracing: A route tracing probe (**traceroute**) opens to discover all gateways on the destination path to the host when turned on.

### Available Judgment

It supports adding judgment condition matching data. When multiple judgment conditions are selected, the relationship between multiple judgment conditions can be judged as "all and" or "all or" by selecting "all" or "any".

Note: Configuring "Network Hops" in the Available Judgment option is similar to turning on route tracing, which will return route tracing data.

![](../img/4.dailtesting_tcp_2.png)

### Select Dial Test Node

At present, Guance has covered 16 nodes in the world, and it supports selecting one or more nodes in China and overseas regions (only commercial and above users are supported), so as to quickly start the service quality monitoring of the site.
![](../img/4.dailtesting_http_4.png)

### Select Testing Frequency

Select the data return frequency of cloud automated testing, which supports 8 choices, such as 1 minute (only commercial version and above users), 5 minutes (only commercial version and above users), 15 minutes (only commercial version and above users), 30 minutes, 1 hour, 6 hours, 12 hours and 24 hours.

![](../img/4.dailtesting_http_5.png)

### Test

After the configuration is completed, click the "Test" button to confirm whether the configuration is successful, and the route tracking result will be returned at the same time.

![](../img/4.dailtesting_tcp_3.png)


