---
title     : 'Profiling'
summary   : '采集应用程序的运行时性能数据'
__int_icon: 'icon/profiling'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->

# Profiling
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Profile 支持采集使用 Java, Python 和 Go 等不同语言环境下应用程序运行过程中的动态性能数据，帮助用户查看 CPU、内存、IO 的性能问题。

## 配置 {#config}

目前 DataKit 采集 profiling 数据有两种方式：

- 推送方式：需要开启 DataKit Profile 服务，由客户端向 DataKit 主动推送数据
- 拉取方式：目前仅 [Go](profile-go.md) 支持，需要手动配置相关信息

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/profile` 目录，复制 `profile.conf.sample` 并命名为  `profile.conf` 。配置文件说明如下：
    
    ```shell
        
    [[inputs.profile]]
      ## profile Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/profiling/v1/input"]
    
      ## set true to enable election, pull mode only
      election = true
    
      ## the max allowed size of http request body (of MB), 32MB by default.
      body_size_limit_mb = 32 # MB
    
      ## io_config is used to control profiling uploading behavior.
      ## cache_path set the disk directory where temporarily cache profiling data.
      ## cache_capacity_mb specify the max storage space (in MiB) that profiling cache can use.
      ## clear_cache_on_start set whether we should clear all previous profiling cache on restarting Datakit.
      ## upload_workers set the count of profiling uploading workers.
      ## send_timeout specify the http timeout when uploading profiling data to dataway.
      ## send_retry_count set the max retry count when sending every profiling request.
      # [inputs.profile.io_config]
      #   cache_path = "/usr/local/datakit/cache/profile_inputs"  # C:\Program Files\datakit\cache\profile_inputs by default on Windows
      #   cache_capacity_mb = 10240  # 10240MB
      #   clear_cache_on_start = false
      #   upload_workers = 8
      #   send_timeout = "75s"
      #   send_retry_count = 4
    
      ## set custom tags for profiling data
      # [inputs.profile.tags]
      #   some_tag = "some_value"
      #   more_tag = "some_other_value"
    
    ## go pprof config
    ## collect profiling data in pull mode
    #[[inputs.profile.go]]
      ## pprof url
      #url = "http://localhost:6060"
    
      ## pull interval, should be greater or equal than 10s
      #interval = "10s"
    
      ## service name
      #service = "go-demo"
    
      ## app env
      #env = "dev"
    
      ## app version
      #version = "0.0.0"
    
      ## types to pull
      ## values: cpu, goroutine, heap, mutex, block
      #enabled_types = ["cpu","goroutine","heap","mutex","block"]
    
    #[inputs.profile.go.tags]
      # tag1 = "val1"
    
    ## pyroscope config
    #[[inputs.profile.pyroscope]]
      ## listen url
      #url = "0.0.0.0:4040"
    
      ## service name
      #service = "pyroscope-demo"
    
      ## app env
      #env = "dev"
    
      ## app version
      #version = "0.0.0"
    
    #[inputs.profile.pyroscope.tags]
      #tag1 = "val1"
    
    ```
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) ，开启 Profile 服务。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

### 客户端应用配置 {#app-config}

客户的应用根据编程语言需要分别进行配置，目前支持的语言如下：

- [Java](profile-java.md)
- [Go](profile-go.md)
- [Python](profile-python.md)
- [C/C++](profile-cpp.md)
- [NodeJS](profile-nodejs.md)
- [.NET](profile-dotnet.md)

## Profiling 字段 {#profiling}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.profile.tags]` 指定其它标签：

``` toml
 [inputs.profile.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `profile`



- 标签


| Tag | Description |
|  ----  | --------|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
|`endpoint`|Endpoint info. Available in SkyWalking, Zipkin. Optional.|
|`env`|Application environment info. Available in Jaeger. Optional.|
|`host`|Hostname.|
|`http_method`|HTTP request method name. Available in DDTrace, OpenTelemetry. Optional.|
|`http_route`|HTTP route. Optional.|
|`http_status_code`|HTTP response code. Available in DDTrace, OpenTelemetry. Optional.|
|`http_url`|HTTP URL. Optional.|
|`operation`|Span name|
|`project`|Project name. Available in Jaeger. Optional.|
|`service`|Service name. Optional.|
|`source_type`|Tracing source type|
|`span_type`|Span type|
|`status`|Span status|
|`version`|Application version info. Available in Jaeger. Optional.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|


