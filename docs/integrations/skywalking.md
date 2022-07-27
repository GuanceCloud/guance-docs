
# SkyWalking
---

- 操作系统支持：:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple:

Datakit 内嵌的 SkyWalking Agent 用于接收，运算，分析 Skywalking Tracing 协议数据。

## SkyWalking 文档

> APM v8.8.3 目前存在不兼容问题无法使用。目前已支持 v8.5.0 v8.6.0 v8.7.0

- [Quickstart](https://skywalking.apache.org/docs/skywalking-showcase/latest/readme/){:target="_blank"}
- [Docs](https://skywalking.apache.org/docs/){:target="_blank"}
- [Clients Download](https://skywalking.apache.org/downloads/){:target="_blank"}
- [Souce Code](https://github.com/apache/skywalking){:target="_blank"}

## 配置 SkyWalking Client

打开文件 /path_to_skywalking_agent/config/agent.config 进行配置

```conf
# The service name in UI
agent.service_name=${SW_AGENT_NAME:your-service-name}
# Backend service addresses.
collector.backend_service=${SW_AGENT_COLLECTOR_BACKEND_SERVICES:<datakit-ip:skywalking-agent-port>}
```

## 配置 SkyWaking Agent

进入 DataKit 安装目录下的 `conf.d/skywalking` 目录，复制 `skywalking.conf.sample` 并命名为 `skywalking.conf`。示例如下：

```toml

[[inputs.skywalking]]
  ## skywalking grpc server listening on address.
  address = "localhost:13800"

  ## customer_tags is a list of keys contains keys set by client code like span.SetTag(key, value)
  ## that want to send to data center. Those keys set by client code will take precedence over
  ## keys in [inputs.skywalking.tags]. DOT(.) IN KEY WILL BE REPLACED BY DASH(_) WHEN SENDING.
  # customer_tags = ["key1", "key2", ...]

  ## Keep rare tracing resources list switch.
  ## If some resources are rare enough(not presend in 1 hour), those resource will always send
  ## to data center and do not consider samplers and filters.
  # keep_rare_resource = false

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

```

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.skywalking.tags]` 指定其它标签：

```toml
 [inputs.skywalking.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

## 启动 Java Client

```command
java -javaagent:/path/to/skywalking/agent -jar /path/to/your/service.jar
```

## SkyWalking JVM 指标集



jvm metrics collected by skywalking language agent.

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`service`|service name|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`class_loaded_count`|loaded class count.|int|count|
|`class_total_loaded_count`|total loaded class count.|int|count|
|`class_total_unloaded_class_count`|total unloaded class count.|int|count|
|`cpu_usage_percent`|cpu usage percentile|float|percent|
|`gc_phrase_old/new_count`|gc old or new count.|int|count|
|`heap/stack_committed`|heap or stack committed amount of memory.|int|count|
|`heap/stack_init`|heap or stack initialized amount of memory.|int|count|
|`heap/stack_max`|heap or stack max amount of memory.|int|count|
|`heap/stack_used`|heap or stack used amount of memory.|int|count|
|`pool_*_committed`|committed amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`pool_*_init`|initialized amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`pool_*_max`|max amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`pool_*_used`|used amount of memory in variety of pool(code_cache_usage,newgen_usage,oldgen_usage,survivor_usage,permgen_usage,metaspace_usage).|int|count|
|`thread_blocked_state_count`|blocked state thread count|int|count|
|`thread_daemon_count`|thread daemon count.|int|count|
|`thread_live_count`|thread live count.|int|count|
|`thread_peak_count`|thread peak count.|int|count|
|`thread_runnable_state_count`|runnable state thread count.|int|count|
|`thread_time_waiting_state_count`|time waiting state thread count.|int|count|
|`thread_waiting_state_count`|waiting state thread count.|int|count|


