---
title     : 'Diatesting'
summary   : 'Obtain network performance through network dialing test'
__int_icon      : 'icon/dialtesting'
tags:
  - 'TESTING'
  - 'NETWORK'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The collector collects the data of network dialing test results, and all the data generated by dialing test are reported to Guance Cloud.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "host installation"

    To deploy private dial-test nodes, you need to [create private dial-test nodes on Guance Cloud page](../usability-monitoring/self-node.md). When you're done, fill in the page with the relevant information in `conf.d/network/dialtesting.conf`:
    
    Go to the `conf.d/network` directory under the DataKit installation directory, copy `dialtesting.conf.sample` and name it `dialtesting.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.dialtesting]]
      # We can also configure a JSON path like "file:///your/dir/json-file-name"
      server = "https://dflux-dial.guance.com"
    
      # [require] node ID
      region_id = "default"
    
      # if server are dflux-dial.guance.com, ak/sk required
      ak = ""
      sk = ""
    
      # The interval to pull the tasks.
      pull_interval = "1m"
    
      # The timeout for the HTTP request.
      time_out = "30s"
    
      # The number of the workers.
      workers = 6
    
      # Collect related metric when job execution time error interval is larger than task_exec_time_interval
      task_exec_time_interval = "5s"
     
      # Stop the task when the task failed to send data to dataway over max_send_fail_count.
      max_send_fail_count = 16
    
      # The max sleep time when send data to dataway failed.
      max_send_fail_sleep_time = "30m"
    
      # The max number of jobs sending data to dataway in parallel. Default 10.
      max_job_number = 10
    
      # The max number of job chan. Default 1000.
      max_job_chan_number = 1000
    
      # Disable internal network task.
      disable_internal_network_task = true
    
      # Disable internal network cidr list.
      disabled_internal_network_cidr_list = []
    
      # Custom tags.
      [inputs.dialtesting.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_DIALTESTING_ENV_INPUT_DIALTESTING_DISABLE_INTERNAL_NETWORK_TASK**
    
        Enable or disable internal IP/service testing
    
        **Type**: Boolean
    
        **input.conf**: `disable_internal_network_task`
    
        **Example**: `true`
    
        **Default**: `false`
    
    - **ENV_INPUT_DIALTESTING_ENV_INPUT_DIALTESTING_DISABLED_INTERNAL_NETWORK_CIDR_LIST**
    
        Disable testing on specific internal CIDR IP ranges
    
        **Type**: List
    
        **input.conf**: `disabled_internal_network_cidr_list`
    
        **Example**: `["192.168.0.0/16"]`
    
        **Default**: `-`
    
    - **ENV_INPUT_DIALTESTING_ENV_INPUT_DIALTESTING_ENABLE_DEBUG_API**
    
        Disable debug API on dial-testing(Default disabled)
    
        **Type**: Boolean
    
        **input.conf**: `env_input_dialtesting_enable_debug_api`
    
        **Example**: `false`
    
        **Default**: `false`

---

???+ attention

    Currently, only Linux dial-up nodes support, and the tracing data is stored in the [traceroute](#traceroute) field of the relevant metrics.
<!-- markdownlint-enable -->

### Dialtesting Node Deployment {#arch}

The following is a network deployment topology for dialtesting nodes, which includes two deployment methods for dialtesting nodes:

- Public Network Nodes: Directly use the nodes deployed globally to check the healthy of **public network** services.
- Private Network Nodes: If you need to check **private network** services, you need to deploy **private** nodes. Of course, if the network allows, these private nodes can also check services deployed on the public network.

Whether it is a public or private node, they can both create probe tasks through the Web page.

```mermaid
graph TD
  %% node definitions
  dt_web(Probe Web UI)
  dt_db(Public Task Storage)
  dt_pub(Public Datakit Node)
  dt_pri(Private Datakit Node)
  site_inner(Private Site)
  site_pub(Public Site)
  dw_inner(Private Dataway)
  dw_pub(Public Dataway)
  guance(GuanceCloud)

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  dt_web -->|Create Task| dt_db;
  dt_db -->|Pull Tasks| dt_pub -->|Results| dw_pub --> guance;
  dt_db -->|Pull Tasks| dt_pri;
  dt_pub <-->|Checking...| site_pub;

  dt_pri <-.->|Checking...| site_pub;
  dw_inner --> guance;
  subgraph "User's Private Network"
  dt_pri <-->|Checking...| site_inner;
  dt_pri -->|Results| dw_inner;
  end
```

## Log {#logging}

All of the following data collections are appended with a global tag named `host` by default (the tag value is the host name of the DataKit), or can be named in the configuration by `[[inputs.dialtesting.tags]]` alternative host.



### `http_dial_testing`

- Tags


| Tag | Description |
|  ----  | --------|
|`city`|The name of the city|
|`country`|The name of the country|
|`datakit_version`|The DataKit version|
|`dest_ip`|The IP address of the destination|
|`df_label`|The label of the task|
|`internal`|The boolean value, true for domestic and false for overseas|
|`isp`|ISP, such as `chinamobile`, `chinaunicom`, `chinatelecom`|
|`method`|HTTP method, such as `GET`|
|`name`|The name of the task|
|`node_name`|The name of the node|
|`owner`|The owner name|
|`proto`|The protocol of the HTTP, such as 'HTTP/1.1'|
|`province`|The name of the province|
|`status`|The status of the task, either 'OK' or 'FAIL'|
|`status_code_class`|The class of the status code, such as '2xx'|
|`status_code_string`|The status string, such as '200 OK'|
|`url`|The URL of the endpoint to be monitored|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`config_vars`|The configuration variables of the task|string|-|
|`fail_reason`|The reason that leads to the failure of the task|string|-|
|`message`|The message string which includes the header and the body of the request or the response|string|-|
|`response_body_size`|The length of the body of the response|int|B|
|`response_connection`|HTTP connection time|float|μs|
|`response_dns`|HTTP DNS parsing time|float|μs|
|`response_download`|HTTP downloading time|float|μs|
|`response_ssl`|HTTP ssl handshake time|float|μs|
|`response_time`|The time of the response|int|μs|
|`response_ttfb`|HTTP response `ttfb`|float|μs|
|`seq_number`|The sequence number of the test|int|count|
|`status_code`|The response code|int|-|
|`success`|The number to specify whether is successful, 1 for success, -1 for failure|int|-|
|`task`|The raw task string|string|-|



### `tcp_dial_testing`

- Tags


| Tag | Description |
|  ----  | --------|
|`city`|The name of the city|
|`country`|The name of the country|
|`datakit_version`|The DataKit version|
|`dest_host`|The name of the host to be monitored|
|`dest_ip`|The IP address|
|`dest_port`|The port of the TCP connection|
|`df_label`|The label of the task|
|`internal`|The boolean value, true for domestic and false for overseas|
|`isp`|ISP, such as `chinamobile`, `chinaunicom`, `chinatelecom`|
|`name`|The name of the task|
|`node_name`|The name of the node|
|`owner`|The owner name|
|`proto`|The protocol of the task|
|`province`|The name of the province|
|`status`|The status of the task, either 'OK' or 'FAIL'|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`config_vars`|The configuration variables of the task|string|-|
|`fail_reason`|The reason that leads to the failure of the task|string|-|
|`message`|The message string includes the response time or fail reason|string|-|
|`response_time`|The time of the response |int|μs|
|`response_time_with_dns`|The time of the response, which contains DNS time|int|μs|
|`seq_number`|The sequence number of the test|int|count|
|`success`|The number to specify whether is successful, 1 for success, -1 for failure|int|-|
|`task`|The raw task string|string|-|
|`traceroute`|The json string fo the `traceroute` result|string|-|



### `icmp_dial_testing`

- Tags


| Tag | Description |
|  ----  | --------|
|`city`|The name of the city|
|`country`|The name of the country|
|`datakit_version`|The DataKit version|
|`dest_host`|The name of the host to be monitored|
|`df_label`|The label of the task|
|`internal`|The boolean value, true for domestic and false for overseas|
|`isp`|ISP, such as `chinamobile`, `chinaunicom`, `chinatelecom`|
|`name`|The name of the task|
|`node_name`|The name of the node|
|`owner`|The owner name|
|`proto`|The protocol of the task|
|`province`|The name of the province|
|`status`|The status of the task, either 'OK' or 'FAIL'|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`average_round_trip_time`|The average time of the round trip(RTT)|float|μs|
|`average_round_trip_time_in_millis`|The average time of the round trip(RTT), deprecated|float|ms|
|`config_vars`|The configuration variables of the task|string|-|
|`fail_reason`|The reason that leads to the failure of the task|string|-|
|`max_round_trip_time`|The maximum time of the round trip(RTT)|float|μs|
|`max_round_trip_time_in_millis`|The maximum time of the round trip(RTT), deprecated|float|ms|
|`message`|The message string includes the average time of the round trip or the failure reason|string|-|
|`min_round_trip_time`|The minimum time of the round trip(RTT)|float|μs|
|`min_round_trip_time_in_millis`|The minimum time of the round trip(RTT), deprecated|float|ms|
|`packet_loss_percent`|The loss percent of the packets|float|-|
|`packets_received`|The number of the packets received|int|count|
|`packets_sent`|The number of the packets sent|int|count|
|`seq_number`|The sequence number of the test|int|count|
|`std_round_trip_time`|The standard deviation of the round trip|float|μs|
|`std_round_trip_time_in_millis`|The standard deviation of the round trip, deprecated|float|ms|
|`success`|The number to specify whether is successful, 1 for success, -1 for failure|int|-|
|`task`|The raw task string|string|-|
|`traceroute`|The `json` string fo the `traceroute` result|string|-|



### `websocket_dial_testing`

- Tags


| Tag | Description |
|  ----  | --------|
|`city`|The name of the city|
|`country`|The name of the country|
|`datakit_version`|The DataKit version|
|`df_label`|The label of the task|
|`internal`|The boolean value, true for domestic and false for overseas|
|`isp`|ISP, such as `chinamobile`, `chinaunicom`, `chinatelecom`|
|`name`|The name of the task|
|`node_name`|The name of the node|
|`owner`|The owner name|
|`proto`|The protocol of the task|
|`province`|The name of the province|
|`status`|The status of the task, either 'OK' or 'FAIL'|
|`url`|The URL string, such as `ws://www.abc.com`|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`config_vars`|The configuration variables of the task|string|-|
|`fail_reason`|The reason that leads to the failure of the task|string|-|
|`message`|The message string includes the response time or the failure reason|string|-|
|`response_message`|The message of the response|string|-|
|`response_time`|The time of the response|int|μs|
|`response_time_with_dns`|The time of the response, include DNS|int|μs|
|`sent_message`|The sent message |string|-|
|`seq_number`|The sequence number of the test|int|count|
|`success`|The number to specify whether is successful, 1 for success, -1 for failure|int|-|
|`task`|The raw task string|string|-|



### `multi_dial_testing`

- Tags


| Tag | Description |
|  ----  | --------|
|`city`|The name of the city|
|`country`|The name of the country|
|`datakit_version`|The DataKit version|
|`df_label`|The label of the task|
|`internal`|The boolean value, true for domestic and false for overseas|
|`isp`|ISP, such as `chinamobile`, `chinaunicom`, `chinatelecom`|
|`name`|The name of the task|
|`node_name`|The name of the node|
|`owner`|The owner name|
|`province`|The name of the province|
|`status`|The status of the task, either 'OK' or 'FAIL'|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`config_vars`|The configuration variables of the task|string|-|
|`fail_reason`|The reason that leads to the failure of the task|string|-|
|`last_step`|The last number of the task be executed|int|-|
|`message`|The message string which includes the header and the body of the request or the response|string|-|
|`response_time`|The time of the response|int|μs|
|`seq_number`|The sequence number of the test|int|count|
|`steps`|The result of each step|string|-|
|`success`|The number to specify whether is successful, 1 for success, -1 for failure|int|-|
|`task`|The raw task string|string|-|




### `traceroute` {#traceroute}

`traceroute` is the JSON text of the "route trace" data, and the entire data is an array object in which each array element records a route probe, as shown in the following example:

```json
[
    {
        "total": 2,
        "failed": 0,
        "loss": 0,
        "avg_cost": 12700395,
        "min_cost": 11902041,
        "max_cost": 13498750,
        "std_cost": 1129043,
        "items": [
            {
                "ip": "10.8.9.1",
                "response_time": 13498750
            },
            {
                "ip": "10.8.9.1",
                "response_time": 11902041
            }
        ]
    },
    {
        "total": 2,
        "failed": 0,
        "loss": 0,
        "avg_cost": 13775021,
        "min_cost": 13740084,
        "max_cost": 13809959,
        "std_cost": 49409,
        "items": [
            {
                "ip": "10.12.168.218",
                "response_time": 13740084
            },
            {
                "ip": "10.12.168.218",
                "response_time": 13809959
            }
        ]
    }
]
```

**Field description:**

| Field  | Type      | Description            |
| :---       | ---           | ---                         |
| `total`    | number        | Total number of detections |
| `failed`   | number        | Number of failures  |
| `loss`     | number        | Percentage of failure |
| `avg_cost` | number        | Average time spent (μs) |
| `min_cost` | number        | Minimum time consumption (μs) |
| `max_cost` | number        | Maximum time consumption(μs) |
| `std_cost` | number        | Standard deviation of time consumption(μs) |
| `items`    | Array of items | Per probe information (see following items) |

**`items`**

| Field           | Type   | Description                             |
| :-------------- | ------ | --------------------------------------- |
| `ip`            | string | IP address, if it fails, the value is * |
| `response_time` | number | Response time (μs)                      |

## Metric {#metric}

Dialtesting collector could expose some [Prometheus metrics](../datakit/datakit-metrics.md). You can upload these metrics to Guance Cloud through [Datakit collector](dk.md). The relevant configuration is as follows:

```toml
[[inputs.dk]]
  ......

  metric_name_filter = [
  
  ### others...
  
  ### dialtesting
  "datakit_dialtesting_.*",

  ]

  ......

```
