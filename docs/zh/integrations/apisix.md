---
title     : 'APISIX'
summary   : '采集 APISIX 相关指标、日志、链路信息'
__int_icon: 'icon/apisix'
dashboard :
  - desc  : 'APISIX 监控视图'
    path  : 'dashboard/zh/apisix'
monitor   :
  - desc  : 'APISIX 监控器'
    path  : 'monitor/zh/apisix'
---

## 安装配置 {#config}

### 前提条件

- [x] 安装 `APISIX`
- [x] 安装 DataKit

### APISIX 配置

APISIX 的配置文件为`config.yaml`，注意`datakit_host`调整为实际的地址，如主机环境则填写ip，Kubernetes 环境值调整为`datakit-service.datakit.svc`。

#### 指标

APISIX 支持通过 Prometheus 协议方式暴露指标，在 APISIX 的配置文件中添加以下配置：

```yaml
apisix:
  prometheus:
    enabled: true
    path: /apisix/prometheus/metrics
    metricPrefix: apisix_
    containerPort: 9091
  plugins:
    - prometheus
```

同时需要在 APISIX 全局插件那里开启`prometheus`插件。

#### 日志

APISIX 支持多种方式上报日志信息，这里主要通过`http-logger`插件进行上报：

```yaml
apisix:
  plugins:
    - http-logger
```

同时需要在 APISIX 路由上配置`http-logger`上报地址信息，内容如下：

```json
{
  "batch_max_size": 1,
  "uri": "http://<datakit_host>:9529/v1/write/logstreaming?source=apisix_logstreaming"
}
```



#### 链路

APISIX 支持 Opentelemetry 协议上报链路信息，开启 `opentelemetry` 插件进行上报：

```yaml
apisix:
  plugins:
    - opentelemetry
  pluginAttrs:
    opentelemetry:
      resource:
        service.name: APISIX
        tenant.id: business_id
      collector:
        address: <datakit_host>:9529/otel
        request_timeout: 3
```

### DataKit

#### 主机

DataKit 运行在主机上，可以采用主机方式采集数据，进入 DataKit 安装目录进行配置。

- 指标

开启 `prometheus` 采集器采集 APISIX 的指标，进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，执行以下命令：

> `cp prom.conf.sample apisix.conf`

调整`apisix.conf`内容，主要是调整`urls`，如下：

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9091/apisix/prometheus/metrics"]
```


- 日志

开启 `logstreaming` 采集器采集 APISIX 的日志，进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/log` ，执行以下命令：

> `cp logstreaming.conf.sample logstreaming.conf`

内容不需要调整。

- 链路

开启 `opentelemetry` 采集器采集 APISIX 的链路数据，进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/opentelemetry` ，执行以下命令：

> `cp opentelemetry.conf.sample opentelemetry.conf`

内容不需要调整。

- 重启

调整完毕后，重启 Datakit

#### Kubernetes

DataKit 运行在 Kubernetes 上，可以通过以下方式进行配置

- 指标

通过 KubernetesPrometheus 采集器可以采集`Prometheus` 的指标信息

编辑 `datakit.yaml`，在 ConfigMap 中增加 `apisix.conf` 部分。

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    apisix.conf: |-  
      [inputs.kubernetesprometheus]        
        node_local      = true
        scrape_interval = "30s"
        keep_exist_metric_name = false   
        [[inputs.kubernetesprometheus.instances]]
          role       = "pod"
          namespaces = ["apisix"]
          selector   = "app.kubernetes.io/name=apisix"      
          scrape   = "true"
          scheme   = "http"
          port     = "9091"
          path     = "/apisix/prometheus/metrics"
          interval = "30s"
      
         [inputs.kubernetesprometheus.instances.custom]
           measurement        = "apisix"
           job_as_measurement = false
         [inputs.kubernetesprometheus.instances.custom.tags]
           node_name        = "__kubernetes_pod_node_name"
           namespace        = "__kubernetes_pod_namespace"
           pod_name         = "__kubernetes_pod_name"
           instance         = "__kubernetes_mate_instance"
           host             = "__kubernetes_mate_host"
```

再把 `apisix.conf` 挂载到 DataKit 的 `/usr/local/datakit/conf.d/kubernetesprometheus/` 目录。

```yaml
    - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/apisix.conf
        name: datakit-conf
        subPath: apisix.conf
```

- 日志

编辑 datakit.yaml，在`ENV_DEFAULT_ENABLED_INPUTS`环境变量值中追加`logstreaming`，如下所示：

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,logstreaming
```

- 链路

编辑 datakit.yaml，在`ENV_DEFAULT_ENABLED_INPUTS`环境变量值中追加`opentelemetry`，同时开启 ENV_INPUT_DDTRACE_COMPATIBLE_OTEL 用于开启 OTEL 和 DDTrace 数据兼容

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,logstreaming,opentelemetry
        - name: ENV_INPUT_DDTRACE_COMPATIBLE_OTEL
          value: 'true'
```

- 重启

调整完毕后，重启 Datakit


## 指标 {#metric}

| 指标                         | 描述                                       | 类型   |
|----------------------------|------------------------------------------|------|
| bandwidth                  | APISIX 流量（ingress/egress）               | int  |
| etcd_modify_indexes        | etcd 索引记录数                             | int  |
| etcd_reachable             | etcd 可用性，1表示可用，0表示不可用           | int  |
| http_latency_bucket        | 服务的请求时间延迟                           | int  |
| http_latency_count         | 服务的请求时间延迟数量                       | int  |
| http_latency_sum           | 服务的请求时间延迟总数                       | int  |
| http_requests_total        | http 请求总数                               | int  |
| http_status                | http 状态                                 | int  |
| nginx_http_current_connections | 当前 nginx 的链接数                        | int  |
| nginx_metric_errors_total  | nginx 错误的指标数                          | int  |
| node_info                  | 节点信息                                   | int  |
| shared_dict_capacity_bytes | APISIX nginx 的容量                         | int  |
| shared_dict_free_space_bytes | APISIX nginx 的可用空间                     | int  |

## 日志 {#loggging}

使用 Pipeline 把 APISIX 日志中的 `trace_id` 提取出来，以实现链路和日志的关联。

```python
jsonData=load_json(_)
requestJson = jsonData["request"]
responseJson = jsonData["response"]
add_key(http_status,responseJson["status"])
add_key(url,requestJson["url"])
add_key(client_ip,jsonData["client_ip"])
trace_id = requestJson["headers"]["traceparent"]
grok(trace_id, "%{DATA}-%{DATA:trace_id}-%{DATA}") 
```

<<<% if custom_key.brand_key == "guance" %>>>
## 最佳实践 {#best-practices}
<div class="grid cards" data-href="https://learning.<<< custom_key.brand_main_domain >>>/uploads/banner_3840a1da19.png" data-title="APISIX 可观测性最佳实践" data-desc="本文介绍如何通过<<< custom_key.brand_name >>>采集 APISIX 指标、日志、链路数据，优化 APISIX 性能，保障业务连续性，并为用户提供更好的体验。"  markdown>
<[APISIX 可观测性最佳实践](https://<<< custom_key.brand_main_domain >>>/learn/articles/apisix){:target="_blank"}>
</div>
<<<% endif %>>>