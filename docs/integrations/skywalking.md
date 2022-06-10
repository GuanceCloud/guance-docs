
# SkyWalking

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-10 10:51:49
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

Datakit 内嵌的 SkyWalking Agent 用于接收，运算，分析 Skywalking Tracing 协议数据。

## SkyWalking 文档

> APM v8.8.3 目前存在不兼容问题无法使用。目前已支持 v8.5.0 v8.6.0 v8.7.0

- [Quickstart](https://skywalking.apache.org/docs/skywalking-showcase/latest/readme/)
- [Docs](https://skywalking.apache.org/docs/)
- [Clients Download](https://skywalking.apache.org/downloads/)
- [Souce Code](https://github.com/apache/skywalking)

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
  ## skywalking grpc server listening on address
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
  ## priority uses to set tracing data propagation level, the valid values are -1, 0, 1
  ##  -1: always reject any tracing data send to datakit
  ##   0: accept tracing data and calculate with sampling_rate
  ##   1: always send to data center and do not consider sampling_rate
  ## sampling_rate used to set global sampling rate
  # [inputs.skywalking.sampler]
    # priority = 0
    # sampling_rate = 1.0

  ## Piplines use to manipulate message and meta data. If this item configured right then
  ## the current input procedure will run the scripts wrote in pipline config file against the data
  ## present in span message.
  ## The string on the left side of the equal sign must be identical to the service name that
  ## you try to handle.
  # [inputs.skywalking.pipelines]
    # service1 = "service1.p"
    # service2 = "service2.p"
    # ...

  # [inputs.skywalking.tags]
    # key1 = "value1"
    # key2 = "value2"
    # ...

```

## 启动 Java Client

```command
java -javaagent:/path/to/skywalking/agent -jar /path/to/your/service.jar
```
