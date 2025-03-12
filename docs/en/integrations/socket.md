---
title     : 'Socket'
summary   : 'Collect metrics of TCP/UDP ports'
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

The socket collector is used to collect UDP/TCP port information.

## Configuration {#config}

### Preconditions {#requrements}

UDP metrics require the operating system to have `nc` programs.

<!-- markdownlint-disable MD046 -->
???+ attention

    The socket collector are suitable for collecting local network TCP/UDP service. For public network, [Dialtesting](dialtest.md) is recommended. If the URLs point to localhost, please turn off the election flag(`election: false`).
<!-- markdownlint-enable -->

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/socket` directory under the DataKit installation directory, copy `socket.conf.sample` and name it `socket.conf`. Examples are as follows:
    
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
    
    After configuration, restart DataKit.

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following measurements, the `proto/dest_host/dest_port` global tag is appended by default, or other tags can be specified in the configuration by `[inputs.socket.tags]`:

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
|`proto`|Protocol, const to be `tcp`|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`response_time`|TCP connection time(without DNS query time)|int|μs|
|`response_time_with_dns`|TCP connection time(with DNS query time)|int|μs|
|`success`|1: success/-1: failed|int|-|



### `udp`

- Tags


| Tag | Description |
|  ----  | --------|
|`dest_host`|UDP host|
|`dest_port`|UDP port|
|`proto`|Protocol, const to be `udp`|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`success`|1: success/-1: failed|int|-|


