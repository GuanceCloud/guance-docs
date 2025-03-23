---
title     : 'HOST Health Check'
summary   : 'Periodically check the health of HOST processes and NETWORK'
tags:
  - 'HOST'
__int_icon      : 'icon/healthcheck'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

[:octicons-tag-24: Version-1.24.0](../datakit/changelog.md#cl-1.24.0)

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The health check collector can periodically monitor the health status of HOST processes and NETWORK (such as TCP and HTTP). If the health requirements are not met, DataKit will collect the corresponding information and report Metrics data.

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->

=== "HOST Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `host_healthcheck.conf.sample` and rename it to `host_healthcheck.conf`. An example is as follows:

    ```toml
        
    [[inputs.host_healthcheck]]
      ## Collect interval
      interval = "1m" 
    
      ## Check process
      [[inputs.host_healthcheck.process]]
        # Process filtering based on process name
        names = ["nginx", "mysql"]
    
        # Process filtering based on regular expression 
        # names_regex = [ "my_process_.*" ]
    
        # Process filtering based on cmd line
        # cmd_lines = ["nginx", "mysql"]
    
        # Process filtering based on regular expression 
        # cmd_lines_regex = [ "my_args_.*" ]
    
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
          # http_urls = [ "http://127.0.0.1:8000/path/to/api?arg1=x&arg2=y" ]
    
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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    It also supports modifying configuration parameters via environment variables (you need to add it as a default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_HEALTHCHECK_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_HEALTHCHECK_PROCESS**
    
        Check processor
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `process`
    
        **Example**: [{"names":["nginx","mysql"],"min_run_time":"10m"}]
    
    - **ENV_INPUT_HEALTHCHECK_TCP**
    
        Check TCP
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tcp`
    
        **Example**: [{"host_ports":["10.100.1.2:3369","192.168.1.2:6379"],"connection_timeout":"3s"}]
    
    - **ENV_INPUT_HEALTHCHECK_HTTP**
    
        Check HTTP
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `http`
    
        **Example**: [{"http_urls":["http://local-ip:port/path/to/api?arg1=x&arg2=y"],"method":"GET","expect_status":200,"timeout":"30s","ignore_insecure_tls":false,"headers":{"Header1":"header-value-1","Hedaer2":"header-value-2"}}]
    
    - **ENV_INPUT_HEALTHCHECK_TAGS**
    
        Custom tags. If there are same-name tags in the configuration file, they will overwrite it.
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `tags`
    
        **Example**: {"some_tag":"some_value","more_tag":"some_other_value"}

<!-- markdownlint-enable -->

## Metrics {#metric}

All the following data collection will append a global tag named `host` by default (the tag value is the hostname where DataKit resides), or you can specify other tags via `[inputs.host_healthcheck.tags]` in the configuration:

```toml
 [inputs.host_healthcheck.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `host_process_exception`



- Tags


| Tag | Description |
|  ----  | --------|
|`cmd_line`|The command line of the process|
|`host`|System hostname|
|`process`|The name of the process|
|`type`|The type of the exception|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value, 1 or 0|int|-|
|`pid`|The process ID|int|int|
|`start_duration`|The total time the process has run|int|μs|






### `host_tcp_exception`



- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname|
|`port`|The port|
|`type`|The type of the exception|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value, 1 or 0|int|-|






### `host_http_exception`



- Tags


| Tag | Description |
|  ----  | --------|
|`error`|The error message|
|`host`|System hostname|
|`url`|The URL|

- Field List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value, 1 or 0|int|-|