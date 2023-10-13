---
title     : 'Ingress Nginx (Prometheus)'
summary   : 'Collect Ingress Nginx (Prometheus) related metric information'
__int_icon: 'icon/ingress'
dashboard :
  - desc  : 'Ingress Nginx Monitoring View'
    path  : 'dashboard/zh/ingress_nginx'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Ingress Nginx (Prometheus)
<!-- markdownlint-enable -->

Information about Ingress Nginx (Prometheus) was collected, including average CPU usage, average memory usage, network request/response totals, number of Ingress Config loads, results of the last Ingress Config load, and success rate of Ingress transfer.


## Configuration {#config}

### Preconditions

- Install DataKit: Log in [Guance Console](https://console.guance.com/) and click "Integration" - "DataKit" - "Kubernetes"

Note: The sample Ingress version is `willdockerhub/ingress-nginx-controller:v1.0.0` (deployment of `kubeadmin` in a CentOS environment), and the metrics for different versions may differ.

### Metric Collection

- Get the yaml file for deploying Ingress

```shell
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/baremetal/deploy.yaml
```

- Edit `deploy.yaml`, set the service type to `NodePort`, and expose `10254` ports externally. Refer to the following figure:

```shell
vi deploy.yaml
```

- Open Input

Observing cloud access to Ingress metrics data requires DataKit to turn on the `prom` plug-in, specify a URL `exporter` in the `prom` plug-in configuration, collect Ingress Controller metrics in the Kubernetes cluster, and recommend adding annotations. <br />
Edit the `deploy.yaml` file, find the Deployment corresponding to the ingress-nginx-controller image, increase `annotations`.

```yaml
annotations:
  datakit/prom.instances: |
    [[inputs.prom]]
      url = "http://$IP:10254/metrics"
      source = "prom-ingress"
      metric_types = ["counter", "gauge"]
      # metric_name_filter = ["cpu"]
      # measurement_prefix = ""
      measurement_name = "prom_ingress"
      interval = "60s"
      tags_ignore = ["build","le","method","release","repository"]
      metric_name_filter = ["nginx_process_cpu_seconds_total","nginx_process_resident_memory_bytes","request_size_sum","response_size_sum","requests","success","config_last_reload_successful"]
      # tags_ignore = ["xxxx"]
      [[inputs.prom.measurements]]
        prefix = "nginx_ingress_controller_"
        name = "prom_ingress"
      [inputs.prom.tags]
      namespace = "$NAMESPACE"
```

Parameter Description

- `url`: Exporter urls, multiple URLs separated by commas
- `source`:Collector Alias
- `metric_types`: Metric type, optional values are counter, gauge, histogram, summary
- `measurement_name`:Metric Set Name
- `interval`: acquisition frequency
- `inputs.prom.measurements`: Metric set whose prefix is prefix to name
- `tags_ignore`: Ignored tag
- `metric_name_filter`:Reserved metric name

- Deploy Ingress

```shell
kubectl apply -f deploy.yaml
```

## Metric Details {metric}

If `inputs.prom.measurements` is configured, the indices collected by the observation cloud need to be prefixed to match the table. <br />
For example, the prefix `nginx*ingress_controller` is configured below, and the metric set is `prom_ingress`.

```toml
 [[inputs.prom.measurements]]
              prefix = "nginx_ingress_controller_"
              name = "prom_ingress"
```

The `nginx_ingress_controller_requests` metric on the observation cloud is the `prom_ingress` metric under the metric set `requests` metric.

| Metrics                                                         |Describe| Data type | unit  |
| ------------------------------------------------------------ | ----------------------------------------------------------------------------------- | -------- | ----- |
| nginx_ingress_controller_requests                            |The total number of client requests| int      | count |
| nginx_ingress_controller_nginx_process_connections           |current number of client connections with state {active, reading, writing, waiting}| int      | count |
| nginx_ingress_controller_success                             |Cumulative number of Ingress controller reload operations| int      | count |
| nginx_ingress_controller_config_last_reload_successful       |Whether the last configuration reload attempt was successful| int      | count |
| nginx_ingress_controller_nginx_process_resident_memory_bytes |number of bytes of memory in use| float    | B     |
| nginx_ingress_controller_nginx_process_cpu_seconds_total     |Cpu usage in seconds| float    | B     |
| nginx_process_resident_memory_bytes                          |number of bytes of memory in use| int      | B     |
| nginx_ingress_controller_request_duration_seconds_bucket     |The request processing time in milliseconds| int      | count |
| nginx_ingress_controller_request_size_sum                    |The request length (including request line, header, and request body)| int      | count |
| nginx_ingress_controller_response_size_sum                   |The response length (including request line, header, and request body)| int      | count |
| nginx_ingress_controller_ssl_expire_time_seconds             |Number of seconds since 1970 to the SSL Certificate expire| int      | count |

## Doc {#doc}

<[Nginx Ingress best practices](../best-practices/cloud-native/ingress-nginx.md)>


