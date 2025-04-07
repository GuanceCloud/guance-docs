---
title     : 'APISIX'
summary   : 'Collect APISIX related Metrics, LOGs, and APM information'
__int_icon: 'icon/apisix'
dashboard :
  - desc  : 'APISIX Monitoring View'
    path  : 'dashboard/en/apisix'
monitor   :
  - desc  : 'APISIX Monitor'
    path  : 'monitor/en/apisix'
---

## Installation and Configuration {#config}

### Prerequisites

- [x] Install `APISIX`
- [x] Install DataKit

### APISIX Configuration

The configuration file for APISIX is `config.yaml`. Note that you should adjust `datakit_host` to the actual address, such as filling in an IP for a host environment or setting it to `datakit-service.datakit.svc` in a Kubernetes environment.

#### Metrics

APISIX supports exposing metrics via the Prometheus protocol. Add the following configuration to the APISIX configuration file:

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

You also need to enable the `prometheus` plugin globally in APISIX.

#### Logs

APISIX supports multiple methods for reporting log information. Here, we mainly use the `http-logger` plugin for reporting:

```yaml
apisix:
  plugins:
    - http-logger
```

You also need to configure the `http-logger` reporting address on APISIX routes with the following content:

```json
{
  "batch_max_size": 1,
  "uri": "http://<datakit_host>:9529/v1/write/logstreaming?source=apisix_logstreaming"
}
```


#### Traces

APISIX supports reporting trace information via the Opentelemetry protocol. Enable the `opentelemetry` plugin for reporting:

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

#### HOST

When DataKit runs on a HOST, you can collect data using the HOST method by configuring within the DataKit installation directory.

- Metrics

Enable the `prometheus` collector to collect APISIX metrics. Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/prom`, and execute the following command:

> `cp prom.conf.sample apisix.conf`

Adjust the `apisix.conf` content, mainly focusing on the `urls`, as follows:

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9091/apisix/prometheus/metrics"]
```


- Logs

Enable the `logstreaming` collector to collect APISIX logs. Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/log`, and execute the following command:

> `cp logstreaming.conf.sample logstreaming.conf`

No adjustments are needed for the content.

- Traces

Enable the `opentelemetry` collector to collect APISIX trace data. Navigate to the [DataKit installation directory](./datakit_dir.md) under `conf.d/opentelemetry`, and execute the following command:

> `cp opentelemetry.conf.sample opentelemetry.conf`

No adjustments are needed for the content.

- Restart

After making all adjustments, restart DataKit.

#### Kubernetes

When DataKit runs on Kubernetes, you can configure it as follows:

- Metrics

Through the KubernetesPrometheus collector, you can collect `Prometheus` metric information.

Edit `datakit.yaml` and add the `apisix.conf` section in the ConfigMap.

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

Then mount `apisix.conf` to the `/usr/local/datakit/conf.d/kubernetesprometheus/` directory of DataKit.

```yaml
    - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/apisix.conf
        name: datakit-conf
        subPath: apisix.conf
```

- Logs

Edit `datakit.yaml` and append `logstreaming` to the `ENV_DEFAULT_ENABLED_INPUTS` environment variable value, as shown below:

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,logstreaming
```

- Traces

Edit `datakit.yaml` and append `opentelemetry` to the `ENV_DEFAULT_ENABLED_INPUTS` environment variable value, while enabling `ENV_INPUT_DDTRACE_COMPATIBLE_OTEL` to ensure compatibility between OTEL and DDTrace data.

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,logstreaming,opentelemetry
        - name: ENV_INPUT_DDTRACE_COMPATIBLE_OTEL
          value: 'true'
```

- Restart

After completing all adjustments, restart DataKit.


## Metrics {#metric}

| Metric                         | Description                                       | Type   |
|----------------------------|------------------------------------------|------|
| bandwidth                  | APISIX traffic (ingress/egress)               | int  |
| etcd_modify_indexes        | Number of etcd index records                            | int  |
| etcd_reachable             | Etcd availability, 1 means available, 0 means unavailable | int  |
| http_latency_bucket        | Service request time delay                           | int  |
| http_latency_count         | Number of service request time delays                       | int  |
| http_latency_sum           | Total service request time delays                       | int  |
| http_requests_total        | Total number of HTTP requests                               | int  |
| http_status                | HTTP status                                 | int  |
| nginx_http_current_connections | Current number of Nginx connections                        | int  |
| nginx_metric_errors_total  | Total number of Nginx error metrics                          | int  |
| node_info                  | Node information                                   | int  |
| shared_dict_capacity_bytes | Capacity of APISIX Nginx                         | int  |
| shared_dict_free_space_bytes | Available space of APISIX Nginx                     | int  |

## Logs {#loggging}

Use Pipeline to extract `trace_id` from APISIX logs to achieve correlation between traces and logs.

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
## Best Practices {#best-practices}
<div class="grid cards" data-href="https://learning.guance.com/uploads/banner_3840a1da19.png" data-title="APISIX Observability Best Practices" data-desc="This article explains how to collect APISIX Metrics, LOGs, and APM data through <<< custom_key.brand_name >>>, optimize APISIX performance, ensure business continuity, and provide users with a better experience."  markdown>
<[APISIX Observability Best Practices](https://<<< custom_key.brand_main_domain >>>/learn/articles/apisix){:target="_blank"}>
</div>
<<<% endif %>>>