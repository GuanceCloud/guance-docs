---
title     : 'SkyWalking'
summary   : 'SkyWalking Tracing 数据接入'
__int_icon      : 'icon/skywalking'
dashboard :
  - desc  : 'Skywalking JVM 监控视图'
    path  : 'dashboard/zh/skywalking'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# SkyWalking
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Datakit 内嵌的 SkyWalking Agent 用于接收、运算、分析 SkyWalking Tracing 协议数据。

## 配置 {#config}

### SkyWalking Client 配置 {#client-config}

打开文件 */path_to_skywalking_agent/config/agent.config* 进行配置

```conf
# The service name in UI
agent.service_name=${SW_AGENT_NAME:your-service-name}
# Backend service addresses.
collector.backend_service=${SW_AGENT_COLLECTOR_BACKEND_SERVICES:<datakit-ip:skywalking-agent-port>}
```

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/skywalking` 目录，复制 `skywalking.conf.sample` 并命名为 `skywalking.conf`。示例如下：

    ```toml
        
    [[inputs.skywalking]]
      ## Skywalking HTTP endpoints for tracing, metric, logging and profiling.
      ## NOTE: DO NOT EDIT.
      endpoints = ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/profiling"]
    
      ## Skywalking GRPC server listening on address.
      address = "127.0.0.1:11800"
    
      ## plugins is a list contains all the widgets used in program that want to be regarded as service.
      ## every key words list in plugins represents a plugin defined as special tag by skywalking.
      ## the value of the key word will be used to set the service name.
      # plugins = ["db.type"]
    
      ## ignore_tags will work as a blacklist to prevent tags send to data center.
      ## Every value in this list is a valid string of regular expression.
      # ignore_tags = ["block1", "block2"]
    
      ## Keep rare tracing resources list switch.
      ## If some resources are rare enough(not presend in 1 hour), those resource will always send
      ## to data center and do not consider samplers and filters.
      # keep_rare_resource = false
    
      ## delete trace message
      # del_message = true
    
      ## Ignore tracing resources map like service:[resources...].
      ## The service name is the full service name in current application.
      ## The resource list is regular expressions uses to block resource names.
      ## If you want to block some resources universally under all services, you can set the
      ## service name as "*". Note: double quotes "" cannot be omitted.
      # [inputs.skywalking.close_resource]
        # service1 = ["resource1", "resource2", ...]
        # service2 = ["resource1", "resource2", ...]
        # "*" = ["close_resource_under_all_services"]
        # ...
    
      ## Sampler config uses to set global sampling strategy.
      ## sampling_rate used to set global sampling rate.
      # [inputs.skywalking.sampler]
        # sampling_rate = 1.0
    
      # [inputs.skywalking.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.skywalking.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.skywalking.storage]
        # path = "./skywalking_storage"
        # capacity = 5120
    
    ```

    Datakit SkyWalking Agent 目前支持 HTTP 协议和 GRPC 协议两种网络传输方式。

    `/v3/profiling` 接口目前只作为兼容性接口使用，profiling 数据并不上报数据中心。

    通过 HTTP 协议传输

    ```toml
    ## Skywalking HTTP endpoints for tracing, metric, logging and profiling.
    ## NOTE: DO NOT EDIT.
    endpoints = ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/logs", "/v3/profiling"]
    ```

    通过 GRPC 协议传输

    ```toml
    ## Skywalking GRPC server listening on address.
    address = "localhost:11800"
    ```

    以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.skywalking.tags]` 指定其它标签：

    ```toml
    [inputs.skywalking.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    # ...
    ```

=== "Kubernetes 内安装"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_SKYWALKING_HTTP_ENDPOINTS**
    
        HTTP 端点
    
        **Type**: JSON
    
        **ConfField**: `endpoints`
    
        **Example**: ["/v3/trace", "/v3/metric", "/v3/logging", "/v3/profiling"]
    
    - **ENV_INPUT_SKYWALKING_GRPC_ENDPOINT**
    
        GRPC 服务器
    
        **Type**: String
    
        **ConfField**: `address`
    
        **Example**: 127.0.0.1:11800
    
    - **ENV_INPUT_SKYWALKING_PLUGINS**
    
        插件列表
    
        **Type**: JSON
    
        **ConfField**: `plugins`
    
        **Example**: ["db.type", "os.call"]
    
    - **ENV_INPUT_SKYWALKING_IGNORE_TAGS**
    
        标签黑名单
    
        **Type**: JSON
    
        **ConfField**: `ignore_tags`
    
        **Example**: ["block1","block2"]
    
    - **ENV_INPUT_SKYWALKING_KEEP_RARE_RESOURCE**
    
        保持稀有跟踪资源列表
    
        **Type**: Boolean
    
        **ConfField**: `keep_rare_resource`
    
        **Default**: false
    
    - **ENV_INPUT_SKYWALKING_DEL_MESSAGE**
    
        删除 trace 消息
    
        **Type**: Boolean
    
        **ConfField**: `del_message`
    
        **Default**: false
    
    - **ENV_INPUT_SKYWALKING_CLOSE_RESOURCE**
    
        忽略指定服务器的 tracing（正则匹配）
    
        **Type**: JSON
    
        **ConfField**: `close_resource`
    
        **Example**: {"service1":["resource1","other"],"service2":["resource2","other"]}
    
    - **ENV_INPUT_SKYWALKING_SAMPLER**
    
        全局采样率
    
        **Type**: Float
    
        **ConfField**: `sampler`
    
        **Example**: 0.3
    
    - **ENV_INPUT_SKYWALKING_THREADS**
    
        线程和缓存的数量
    
        **Type**: JSON
    
        **ConfField**: `threads`
    
        **Example**: {"buffer":1000, "threads":100}
    
    - **ENV_INPUT_SKYWALKING_STORAGE**
    
        本地缓存路径和大小（MB）
    
        **Type**: JSON
    
        **ConfField**: `storage`
    
        **Example**: {"storage":"./skywalking_storage", "capacity": 5120}
    
    - **ENV_INPUT_SKYWALKING_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: JSON
    
        **ConfField**: `tags`
    
        **Example**: {"k1":"v1", "k2":"v2", "k3":"v3"}

<!-- markdownlint-enable -->

### 启动 Java Client {#start-java}

```command
  java -javaagent:/path/to/skywalking/agent -jar /path/to/your/service.jar
```

### 日志采集配置 {#logging-config}

log4j2 示例。将 toolkit 依赖包添加到 maven 或者 gradle 中：

```xml
<dependency>
    <groupId>org.apache.skywalking</groupId>
    <artifactId>apm-toolkit-log4j-2.x</artifactId>
    <version>{project.release.version}</version>
</dependency>
```

通过 gRPC 协议发送出去：

```xml
  <GRPCLogClientAppender name="grpc-log">
    <PatternLayout pattern="%d{HH:mm:ss.SSS} %-5level %logger{36} - %msg%n"/>
  </GRPCLogClientAppender>
```

其它日志框架支持：

- [Log4j-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-log4j-1.x.md){:target="_blank"}
- [Logback-1.x](https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/Application-toolkit-logback-1.x.md){:target="_blank"}

## 指标字段 {#metric}

SkyWalking 会上报一些 JVM 指标数据。

- Tag

| Tag Name  | Description  |
| --------- | ------------ |
| `service` | service name |

- Metrics List

| Metrics                            | Description                                                                                                                               | Data Type |  Unit   |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | :-------: | :-----: |
| `class_loaded_count`               | loaded class count.                                                                                                                       |    int    |  count  |
| `class_total_loaded_count`         | total loaded class count.                                                                                                                 |    int    |  count  |
| `class_total_unloaded_class_count` | total unloaded class count.                                                                                                               |    int    |  count  |
| `cpu_usage_percent`                | cpu usage percentile                                                                                                                      |   float   | percent |
| `gc_phrase_old/new_count`          | gc old or new count.                                                                                                                      |    int    |  count  |
| `heap/stack_committed`             | heap or stack committed amount of memory.                                                                                                 |    int    |  count  |
| `heap/stack_init`                  | heap or stack initialized amount of memory.                                                                                               |    int    |  count  |
| `heap/stack_max`                   | heap or stack max amount of memory.                                                                                                       |    int    |  count  |
| `heap/stack_used`                  | heap or stack used amount of memory.                                                                                                      |    int    |  count  |
| `pool_*_committed`                 | committed amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).   |    int    |  count  |
| `pool_*_init`                      | initialized amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage). |    int    |  count  |
| `pool_*_max`                       | max amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).         |    int    |  count  |
| `pool_*_used`                      | used amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).        |    int    |  count  |
| `thread_blocked_state_count`       | blocked state thread count                                                                                                                |    int    |  count  |
| `thread_daemon_count`              | thread daemon count.                                                                                                                      |    int    |  count  |
| `thread_live_count`                | thread live count.                                                                                                                        |    int    |  count  |
| `thread_peak_count`                | thread peak count.                                                                                                                        |    int    |  count  |
| `thread_runnable_state_count`      | runnable state thread count.                                                                                                              |    int    |  count  |
| `thread_time_waiting_state_count`  | time waiting state thread count.                                                                                                          |    int    |  count  |
| `thread_waiting_state_count`       | waiting state thread count.                                                                                                               |    int    |  count  |

## 链路字段 {#tracing}







## SkyWalking 文档 {#doc}

> 最新的 Datakit SkyWalking 实现支持所有 8.x.x 的 SkyWalking APM Agent

- [Quick Start](https://skywalking.apache.org/docs/skywalking-showcase/latest/readme/){:target="_blank"}
- [Docs](https://skywalking.apache.org/docs/){:target="_blank"}
- [Clients Download](https://skywalking.apache.org/downloads/){:target="_blank"}
- [Source Code](https://github.com/apache/skywalking){:target="_blank"}
