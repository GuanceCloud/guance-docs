---
title     : 'Socket'
summary   : 'Collect metrics data for TCP/UDP ports'
tags:
  - 'NETWORK'
__int_icon      : 'icon/socket'
dashboard :
  - desc  : 'Socket'
    path  : 'dashboard/en/socket'
monitor   :
  - desc  : 'Socket'
    path  : 'monitor/en/socket'
---

:fontawesome-brands-linux: :fontawesome-brands-apple:

---

Collect metrics data for UDP/TCP ports.

## Configuration {#config}

### Prerequisites {#requrements}

The UDP metrics require the operating system to have the `nc` program.

<!-- markdownlint-disable MD046 -->
???+ attention

    The socket collector is suitable for intranet TCP/UDP port detection. For public network services, it is recommended to use the [TESTING feature](dialtesting.md). If the service address points to the local machine, disable the election function of the collector (`election: false`) to avoid invalid collection.
<!-- markdownlint-enable -->

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Go to the `conf.d/socket` directory under the DataKit installation directory, copy `socket.conf.sample` and rename it to `socket.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.socket]]
      ## Support TCP/UDP.
      ## If the quantity to be detected is too large, it is recommended to open more collectors
      dest_url = [
        "tcp://host:port",
        "udp://host:port",
      ]
    
      ## @param interval - number - optional - default: 30
      interval = "30s"
    
      ## @param interval - number - optional - default: 10
      tcp_timeout = "10s"
    
      ## @param interval - number - optional - default: 10
      udp_timeout = "10s"
    
      ## set false to disable election
      election = true
    
    [inputs.socket.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    After configuring, restart DataKit.

=== "Kubernetes"

    Currently, you can enable the collector by injecting its configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

All the following metric sets will append the global tags `proto/dest_host/dest_port` by default. You can also specify other tags in the configuration through `[inputs.socket.tags]`:

``` toml
[inputs.socket.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `tcp`

- Tags


| Tag | Description |
|  ----  | --------|
|`dest_host`|TCP domain or host, such as `wwww.baidu.com`, `1.2.3.4`|
|`dest_port`|TCP port, such as `80`|
|`proto`|Protocol, constant value `tcp`|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`response_time`|TCP connection time (without DNS query time)|int|μs|
|`response_time_with_dns`|TCP connection time (with DNS query time)|int|μs|
|`success`|1: success/-1: failed|int|-|



### `udp`

- Tags


| Tag | Description |
|  ----  | --------|
|`dest_host`|UDP host|
|`dest_port`|UDP port|
|`proto`|Protocol, constant value `udp`|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`success`|1: success/-1: failed|int|-|