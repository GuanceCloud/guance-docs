# WEBSOCKET Tests
---

## Introduction

WebSocket allows your client to make an HTTP request to the server and establish a WebSocket connection to validate defined requests and criteria such as request headers response times and so on.

## Create WEBSOCKET Request Task

In Guance workspace, click "New"-"API Dialing Test" and select "WEBSOCKET Protocol" to create a new WEBSOCKET task.

![](../img/4.dailtesting_websocket_1.png)

### Define Request Format

- URL: URL that supports both ws/wss protocols.
- Advanced settings: Advanced settings according to the actual situation, including request settings and authentication.

![](../img/4.dailtesting_websocket_2.png)

- Content: Enter the information sent to the client.
- Name: Custom WEBSOCKET dialing task name, duplicate name is not supported in current space.

### Available Judgment

It supports adding judgment condition matching data. When multiple judgment conditions are selected, the relationship between multiple judgment conditions can be judged as "all and" or "all or" by selecting "all" or "any".

![](../img/4.dailtesting_websocket_3.png)

### Select Request Node

At present, Guance has covered 16 nodes in the world, and it supports selecting one or more nodes in China and overseas regions (only commercial and above users are supported), so as to quickly start the service quality monitoring of the site.

![](../img/4.dailtesting_http_4.png)

### Select Dialing Frequency

Select the data return frequency of cloud dialing test, which supports 8 choices, such as 1 minute (only commercial version and above users), 5 minutes (only commercial version and above users), 15 minutes (only commercial version and above users), 30 minutes, 1 hour, 6 hours, 12 hours and 24 hours.

![](../img/4.dailtesting_http_5.png)

### Test

After the configuration is completed, click the "Test" button to confirm whether the configuration is successful.


