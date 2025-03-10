---
title     : 'APISIX'
summary   : 'Collect APISIX related Metrics, logs, and trace information'
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

The configuration file for APISIX is `config.yaml`. Note that `datakit_host` should be adjusted to the actual address, such as an IP for host environments or `datakit-service.datakit.svc` for Kubernetes environments.

#### Metrics

APISIX supports exposing metrics via the Prometheus protocol. Add the following configuration in the APISIX configuration file:

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

You also need to enable the `prometheus` plugin in the global plugins of APISIX.

#### Logs

APISIX supports multiple methods for reporting log information, primarily using the `http-logger` plugin:

```yaml
apisix:
  plugins:
    - http-logger
```

You also need to configure the `http-logger` reporting address on the APISIX route, with the following content:

```json
{
  "batch_max_size": 1,
  "uri": "http://<datakit_host>:9529/v1/write/logstreaming?source=apisix_logstreaming"
}
```

#### Traces

APISIX supports reporting trace information via the Opentelemetry protocol by enabling the `opentelemetry` plugin:

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

#### Host

DataKit runs on the host and can collect data through host-based collection. Enter the DataKit installation directory for configuration.

- **Metrics**

Enable the `prometheus` collector to collect APISIX metrics. Navigate to the `[DataKit installation directory](./datakit_dir.md)` under `conf.d/prom`, and execute the following command:

> `cp prom.conf.sample apisix.conf`

Adjust the content of `apisix.conf`, mainly changing `urls`, as follows:

```toml
[[inputs.prom]]
  ## Exporter URLs.
  urls = ["http://localhost:9091/apisix/prometheus/metrics"]
```

- **Logs**

Enable the `logstreaming` collector to collect APISIX logs. Navigate to the `[DataKit installation directory](./datakit_dir.md)` under `conf.d/log`, and execute the following command:

> `cp logstreaming.conf.sample logstreaming.conf`

No adjustments are needed for this configuration.

- **Traces**

Enable the `opentelemetry` collector to collect APISIX trace data. Navigate to the `[DataKit installation directory](./datakit_dir.md)` under `conf.d/opentelemetry`, and execute the following command:

> `cp opentelemetry.conf.sample opentelemetry.conf`

No adjustments are needed for this configuration.

- **Restart**

After making changes, restart DataKit.

#### Kubernetes

DataKit runs on Kubernetes and can be configured as follows:

- **Metrics**

Use the KubernetesPrometheus collector to gather metrics from `Prometheus`.

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

Then mount `apisix.conf` to DataKit's `/usr/local/datakit/conf.d/kubernetesprometheus/` directory.

```yaml
    - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/apisix.conf
        name: datakit-conf
        subPath: apisix.conf
```

- **Logs**

Edit `datakit.yaml` and append `logstreaming` to the `ENV_DEFAULT_ENABLED_INPUTS` environment variable value, as shown below:

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,logstreaming
```

- **Traces**

Edit `datakit.yaml` and append `opentelemetry` to the `ENV_DEFAULT_ENABLED_INPUTS` environment variable value. Also, enable `ENV_INPUT_DDTRACE_COMPATIBLE_OTEL` for OTEL and DDTrace data compatibility.

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,logstreaming,opentelemetry
        - name: ENV_INPUT_DDTRACE_COMPATIBLE_OTEL
          value: 'true'
```

- **Restart**

After making changes, restart DataKit.

## Metrics {#metric}

| Metric                        | Description                                       | Type  |
|-------------------------------|--------------------------------------------------|------|
| bandwidth                     | APISIX traffic (ingress/egress)                   | int  |
| etcd_modify_indexes           | Number of etcd index records                      | int  |
| etcd_reachable                | Etcd availability, 1 means available, 0 means unavailable | int  |
| http_latency_bucket           | Service request time delay                       | int  |
| http_latency_count            | Number of service request time delays             | int  |
| http_latency_sum              | Total service request time delays                 | int  |
| http_requests_total           | Total HTTP requests                              | int  |
| http_status                   | HTTP status                                     | int  |
| nginx_http_current_connections| Current number of nginx connections               | int  |
| nginx_metric_errors_total     | Number of nginx error metrics                    | int  |
| node_info                     | Node information                                | int  |
| shared_dict_capacity_bytes    | Capacity of APISIX nginx                         | int  |
| shared_dict_free_space_bytes  | Available space of APISIX nginx                  | int  |

## Logs {#logging}

Use a Pipeline to extract the `trace_id` from APISIX logs to achieve correlation between traces and logs.

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