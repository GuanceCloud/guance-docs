
# TCP/UDP
---

:fontawesome-brands-linux: :fontawesome-brands-apple:

---

The socket collector is used to collect UDP/TCP port information.

## Preconditions {#requrements}

UDP metrics require the operating system to have `nc` programs.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/socket` directory under the DataKit installation directory, copy `socket.conf.sample` and name it `socket.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.socket]]
      ## support tcp, udp.If the quantity to be detected is too large, it is recommended to open more collectors
      dest_url = ["tcp://host:port", "udp://host:port"]
    
      ## @param interval - number - optional - default: 30
      interval = "30s"
      ## @param interval - number - optional - default: 10
      udp_timeout = "10s"
      ## @param interval - number - optional - default: 10
      tcp_timeout = "10s"
    
    [inputs.socket.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    After configuration, restart DataKit.

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#requrements}

For all of the following measurements, the `proto/dest_host/dest_port` global tag is appended by default, or other tags can be specified in the configuration by `[inputs.socket.tags]`:

``` toml
 [inputs.socket.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `tcp`

-  Tag


| Tag Na me | Description    |
|  ----  | --------|
|`dest_host`|for example: wwww.baidu.com|
|`dest_port`|for example: 80|
|`proto`|for example: tcp|

- Metrics List


| Metrics | Description| Data Type | Unit   |
| ---- |---- | :---:    | :----: |
|`response_time`|TCP connection time in us|int|μs|
|`response_time_with_dns`|Connection time (including DNS resolution) in us|int|μs|
|`success`|There are only 1/-1 states, 1 for success and-1 for failure|int|-|



### `udp`

-  Tag


| Tag Name | Description    |
|  ----  | --------|
|`dest_host`|Host of the destination host|
|`dest_port`|Port number of destination host|
|`proto`|for example: udp|

- Metrics List


| Metrics | Description| Data Type| Unit   |
| ---- |---- | :---:    | :----: |
|`success`|There are only 1/-1 states, 1 for success and-1 for failure|int|-|


