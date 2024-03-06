---
title     : '健康检查'
summary   : '定期检查主机进程和网络健康状况'
__int_icon      : 'icon/healthcheck'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# 健康检查
<!-- markdownlint-enable -->

[:octicons-tag-24: Version-1.24.0](../datakit/changelog.md#cl-1.24.0)

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

健康检查采集器可以定期去监控主机的进程和网络（如 TCP 和 HTTP）的健康状况，如果不符合健康要求，DataKit 会收集相应的信息，并上报指标数据。

## 配置 {#config}

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `host_healthcheck.conf.sample` 并命名为 `host_healthcheck.conf`。示例如下：

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

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_HEALTHCHECK_INTERVAL**
    
        采集器重复间隔时长
    
        **Type**: TimeDuration
    
        **ConfField**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_HEALTHCHECK_PROCESS**
    
        检查处理器
    
        **Type**: JSON
    
        **ConfField**: `process`
    
        **Example**: [{"names":["nginx","mysql"],"min_run_time":"10m"}]
    
    - **ENV_INPUT_HEALTHCHECK_TCP**
    
        检查 TCP
    
        **Type**: JSON
    
        **ConfField**: `tcp`
    
        **Example**: [{"host_ports":["10.100.1.2:3369","192.168.1.2:6379"],"connection_timeout":"3s"}]
    
    - **ENV_INPUT_HEALTHCHECK_HTTP**
    
        检查 HTTP
    
        **Type**: JSON
    
        **ConfField**: `http`
    
        **Example**: [{"http_urls":["http://local-ip:port/path/to/api?arg1=x&arg2=y"],"method":"GET","expect_status":200,"timeout":"30s","ignore_insecure_tls":false,"headers":{"Header1":"header-value-1","Hedaer2":"header-value-2"}}]
    
    - **ENV_INPUT_HEALTHCHECK_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: JSON
    
        **ConfField**: `tags`
    
        **Example**: {"some_tag":"some_value","more_tag":"some_other_value"}

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.host_healthcheck.tags]` 指定其它标签：

```toml
 [inputs.host_healthcheck.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `host_process_exception`



- 标签


| Tag | Description |
|  ----  | --------|
|`host`|System hostname|
|`process`|The name of the process|
|`type`|The type of the exception|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value|int|-|
|`pid`|The process ID|int|int|
|`start_duration`|The total time the process has run|int|μs|






### `host_tcp_exception`



- 标签


| Tag | Description |
|  ----  | --------|
|`host`|System hostname|
|`port`|The port|
|`type`|The type of the exception|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value|int|-|






### `host_http_exception`



- 标签


| Tag | Description |
|  ----  | --------|
|`error`|The error message|
|`host`|System hostname|
|`url`|The URL|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`exception`|Exception value|int|-|


