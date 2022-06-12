
# Zipkin

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-12 09:24:51
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

Datakit 内嵌的 Zipkin Agent 用于接收，运算，分析 Zipkin Tracing 协议数据。

## Zipkin 文档

- [Quickstart](https://zipkin.io/pages/quickstart.html)
- [Docs](https://zipkin.io/pages/instrumenting.html)
- [Souce Code](https://github.com/openzipkin/zipkin)

## 配置 Zipkin Agent

进入 DataKit 安装目录下的 `conf.d/zipkin` 目录，复制 `zipkin.conf.sample` 并命名为 `zipkin.conf`。示例如下：

```toml

[[inputs.zipkin]]
  pathV1 = "/api/v1/spans"
  pathV2 = "/api/v2/spans"

  ## customer_tags is a list of keys contains keys set by client code like span.SetTag(key, value)
  ## that want to send to data center. Those keys set by client code will take precedence over
  ## keys in [inputs.zipkin.tags]. DOT(.) IN KEY WILL BE REPLACED BY DASH(_) WHEN SENDING.
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
  # [inputs.zipkin.close_resource]
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
  # [inputs.zipkin.sampler]
    # priority = 0
    # sampling_rate = 1.0

  ## Piplines use to manipulate message and meta data. If this item configured right then
  ## the current input procedure will run the scripts wrote in pipline config file against the data
  ## present in span message.
  ## The string on the left side of the equal sign must be identical to the service name that
  ## you try to handle.
  # [inputs.zipkin.pipelines]
    # service1 = "service1.p"
    # service2 = "service2.p"
    # ...

  # [inputs.zipkin.tags]
    # key1 = "value1"
    # key2 = "value2"
    # ...

```
