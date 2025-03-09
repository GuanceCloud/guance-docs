---
title     : 'Ingress Nginx (Prometheus)'
summary   : 'Collect metrics related to Ingress Nginx (Prometheus)'
__int_icon: 'icon/ingress'
dashboard :
  - desc  : 'Ingress Nginx monitoring view'
    path  : 'dashboard/en/ingress_nginx'
monitor   :
  - desc  : 'None'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Ingress Nginx (Prometheus)
<!-- markdownlint-enable -->


Display of Ingress performance metrics, including the average CPU usage, average memory usage, total network requests/responses, number of times Ingress Config is loaded, result of the last Ingress Config load, and success rate of Ingress forwarding, etc.


## Configuration {#config}

### Prerequisites

- DataKit has been deployed; please refer to Kubernetes cluster <[Install DataKit](../datakit/datakit-daemonset-deploy.md)>

### Installation and Deployment
Note: The example Ingress version is `willdockerhub/ingress-nginx-controller:v1.0.0` (deployed with `kubeadmin` in CentOS environment). Metrics may vary across different versions.

### Metric Collection

- Obtain the YAML file for deploying Ingress

```shell
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/baremetal/deploy.yaml
```

- Edit deploy.yaml
Set the service type to `NodePort` and expose port `10254` externally

```yaml

spec:
  type: NodePort
......
    - name: prometheus
      port: 10254
      targetPort: prometheus
```

Find the part where `kind: Deployment` and modify as follows:

```shell
kind: DaemonSet # Modify

---
hostNetwork: true # Add
dnsPolicy: ClusterFirstWithHostNet # Modify

```

- Enable Input
To collect Ingress metrics in Guance, you need to enable the prom plugin in DataKit and specify the exporter's URL in the prom plugin configuration. In a Kubernetes cluster, it is recommended to use annotations to add annotations for collecting Ingress Controller metrics. Open the deploy.yaml file used to deploy Ingress, find the DaemonSet part modified in the previous step, and add annotations.

```yaml
annotations:
  datakit/prom.instances: |
    [[inputs.prom]]
      url = "http://$IP:10254/metrics"
      source = "prom-ingress"
      metric_types = ["counter", "gauge", "histogram"]
      # metric_name_filter = ["cpu"]
      # measurement_prefix = ""
      measurement_name = "prom_ingress"
      interval = "60s"
      tags_ignore = ["build","le","path","method","release","repository"]
      metric_name_filter = ["nginx_process_cpu_seconds_total","nginx_process_resident_memory_bytes","request_size","response_size","requests","success","config_last_reload_successful"]
      [[inputs.prom.measurements]]
        prefix = "nginx_ingress_controller_"
        name = "prom_ingress"
      [inputs.prom.tags]
      namespace = "$NAMESPACE"
```

- Parameter Explanation:

- url: Exporter URLs, multiple URLs are separated by commas
- source: Collector alias
- metric_types: Metric types, options are counter, gauge, histogram, summary
- measurement_name: Measurement set name
- interval: Collection frequency
- inputs.prom.measurements: Metrics with the specified prefix are grouped into the named measurement set
- tags_ignore: Ignored tags
- metric_name_filter: Retained metric names

- Deploy Ingress

```shell
kubectl apply -f deploy.yaml
```

## Metrics {#metric}

If `inputs.prom.measurements` is configured, the metrics collected by Guance need to be prefixed to match the table.<br />
For example, if the prefix `nginx*ingress_controller` is configured and the measurement set is `prom_ingress`.

```toml
 [[inputs.prom.measurements]]
              prefix = "nginx_ingress_controller_"
              name = "prom_ingress"
```

The metric `nginx_ingress_controller_requests` becomes the `requests` metric under the `prom_ingress` measurement set in Guance.

| Metric                                                         | Description                                                         | Data Type | Unit  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | ----- |
| nginx_ingress_controller_requests                            | The total number of client requests                          | int      | count |
| nginx_ingress_controller_nginx_process_connections           | Current number of client connections with state {active, reading, writing, waiting} | int      | count |
| nginx_ingress_controller_success                             | Cumulative number of Ingress controller reload operations    | int      | count |
| nginx_ingress_controller_config_last_reload_successful       | Whether the last configuration reload attempt was successful | int      | count |
| nginx_ingress_controller_nginx_process_resident_memory_bytes | Number of bytes of memory in use                             | float    | B     |
| nginx_ingress_controller_nginx_process_cpu_seconds_total     | CPU usage in seconds                                         | float    | s     |
| nginx_process_resident_memory_bytes                          | Number of bytes of memory in use                             | int      | B     |
| nginx_ingress_controller_request_duration_seconds_bucket     | Request processing time in milliseconds                      | int      | ms    |
| nginx_ingress_controller_request_size_sum                    | Request length (including request line, header, and request body) | int      | B     |
| nginx_ingress_controller_response_size_sum                   | Response length (including request line, header, and response body) | int      | B     |
| nginx_ingress_controller_ssl_expire_time_seconds             | Number of seconds since 1970 to SSL certificate expiration   | int      | s     |

## Best Practices {#more-reading}

<[Nginx Ingress Observability Best Practices](../best-practices/cloud-native/ingress-nginx.md)>