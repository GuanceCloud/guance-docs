---
title     : 'Health Check'
summary   : 'Regularly check the host process and network health status'
__int_icon      : 'icon/healthcheck'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Health check 
<!-- markdownlint-enable -->

[:octicons-tag-24: Version-1.24.0](../datakit/changelog.md#cl-1.24.0)

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The health check collector can regularly monitor the health of processes and networks (such as TCP and HTTP) of the main computer. If it doesn't meet the health requirements, DataKit will collect corresponding information and report the metric data.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `host_healthcheck.conf.sample` and name it `host_healthcheck.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.host_healthcheck]]
      ## Collect interval
      interval = "1m" 
    
      ## Check process
      [[inputs.host_healthcheck.process]]
        # Process filtering based on process name
        names = ["nginx", "mysql"]
    
        ## Process filtering based on regular expression 
        # names_regex = [ "my_process_.*" ]
    
        ## Process minimal run time
        # Only check the process when the running time of the process is greater than min_run_time
        min_run_time = "10m"
    
      ## Check TCP
      # [[inputs.host_healthcheck.tcp]]
        ## Host and port
        # host_ports = ["10.100.1.2:3369", "192.168.1.2:6379"]
    
        ## TCP timeout
        # connection_timeout = "3s"
    
      ## Check HTTP
      # [[inputs.host_healthcheck.http]]
          ## HTTP urls
          # http_urls = [ "http://local-ip:port/path/to/api?arg1=x&arg2=y" ]
    
          ## HTTP method
          # method = "GET"
    
          ## Expected response status code
          # expect_status = 200 
          
          ## HTTP timeout
          # timeout = "30s"
          
          ## Ignore tls validation 
          # ignore_insecure_tls = false
    
          ## HTTP headers
          # [inputs.host_healthcheck.http.headers]
            # Header1 = "header-value-1"
            # Hedaer2 = "header-value-2"
      
      ## Extra tags
      [inputs.host_healthcheck.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    It supports modifying configuration parameters as environment variables (effective only when the DataKit is running in K8s daemonset mode, which is not supported for host-deployed DataKits):

    | Environment Variable Name                              | Corresponding Configuration Parameter Item | Parameter Example                                                     |
    | :---                                 | ---              | ---                                                          |
    | `ENV_INPUT_HEALTHCHECK_INTERVAL`     | `interval`       | `5m`                                               |
    | `ENV_INPUT_HEALTHCHECK_PROCESS`      | `process`        | `[{"names":["nginx","mysql"],"min_run_time":"10m"}]`|
    | `ENV_INPUT_HEALTHCHECK_TCP`          | `tcp`            | `[{"host_ports":["10.100.1.2:3369","192.168.1.2:6379"],"connection_timeout":"3s"}]`|
    | `ENV_INPUT_HEALTHCHECK_HTTP`         | `http`           | `[{"http_urls":["http://local-ip:port/path/to/api?arg1=x&arg2=y"],"method":"GET","expect_status":200,"timeout":"30s","ignore_insecure_tls":false,"headers":{"Header1":"header-value-1","Hedaer2":"header-value-2"}}]`                                               |
    | `ENV_INPUT_HEALTHCHECK_TAGS`         | `tags`           | `{"some_tag":"some_value","more_tag":"some_other_value"}`|

<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.host_healthcheck.tags]`:

```toml
 [inputs.host_healthcheck.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD024 -->





### `host_process_exception`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|System hostname|
|`process`|The name of the process|
|`type`|The type of the exception|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value|int|-|
|`pid`|The process ID|int|int|
|`start_duration`|The total time the process has run|int|μs|






### `host_tcp_exception`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|System hostname|
|`port`|The port|
|`type`|The type of the exception|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value|int|-|






### `host_http_exception`



- tag


| Tag | Description |
|  ----  | --------|
|`error`|The error message|
|`host`|System hostname|
|`url`|The URL|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value|int|-|

