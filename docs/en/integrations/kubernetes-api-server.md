---
title     : 'Kubernetes API Server'
summary   : 'Collect metrics related to the Kubernetes API Server'
__int_icon: 'icon/kubernetes'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'Kubernetes API Server Monitoring View'
    path  : 'dashboard/en/kubernetes_api_server'
monitor   :
  - desc  : 'Kubernetes API Server'
    path  : 'monitor/en/kubernetes_api_server'
---

## Configuration {#config}

### [Install DataKit on Kubernetes](../datakit/datakit-daemonset-deploy.md)

### Configure Collector

Create the following ConfigMap to manage the collector configuration:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf-kube-apiserver
  namespace: datakit
data:
  kube-apiserver.conf: |-
    [[inputs.kubernetesprometheus.instances]]
      role       = "pod"
      namespaces = ["kube-system"]
      selector   = "component=kube-apiserver,tier=control-plane"
      scrape          = "true"
      scheme          = "https"
      port            = "6443"
      path            = "/metrics"
      scrape_interval = "60s"
      node_local      = "ture"
      [inputs.kubernetesprometheus.instances.custom]
        measurement        = "kube_apiserver"
        job_as_measurement = false
        [inputs.kubernetesprometheus.instances.custom.tags]
          cluster_name_k8s = "fill-your-cluster-name"
          instance         = "__kubernetes_mate_instance"
          pod_name         = "__kubernetes_pod_name"
          pod_namespace    = "__kubernetes_pod_namespace"
          node_name        = "__kubernetes_pod_node_name"
      [inputs.kubernetesprometheus.instances.auth]
        bearer_token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"
        [inputs.kubernetesprometheus.instances.auth.tls_config]
          insecure_skip_verify = false
          ca_certs = ["/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"]
```
For detailed configuration, refer to Kubernetes Prometheus Discovery.

### Mount Configuration File for DataKit

Modify the DataKit resource file and mount the collection configuration to enable the corresponding collector:

```yaml
apiVersion: apps/v1
kind: DaemonSet
...
spec:
  ...
  template:
    ...
    spec:
      ...
      containers:
        ...
        volumeMounts:
          ...
          - name: datakit-conf-kube-apiserver
            subPath: kube-apiserver.conf
            mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kube-apiserver.conf
      volumes:
        ...
        - name: datakit-conf-kube-apiserver
          configMap:
            name: datakit-conf-kube-apiserver
```
## Metrics {#metric}

The following table lists key metrics and their descriptions:


| Metric                                             | Metric Type | Description   |
|----------------------------------------------------|-------------|--------------------------------------------------------------|
| `apiserver_request_total`                          | Counter     | Counts requests by verb, dry_run, group, version, resource, scope, component, and code           |
| `apiserver_current_inflight_requests`              | Gauge       | Current number of read/write requests, categorized by request_kind                               |
| `apiserver_request_terminations_total`             | Counter     | Counts discarded requests due to self-protection, categorized by code, component, group, resource, scope, subresource, verb, and version |
| `apiserver_request_duration_seconds_bucket`        | Histogram   | Response latency distribution, categorized by verb, dry_run, group, version, resource, subresource, scope, and component |
| `etcd_request_duration_seconds_bucket`             | Histogram   | Etcd response latency distribution, categorized by operation and type                           |
| `apiserver_admission_controller_admission_duration_seconds_bucket` | Histogram | Admission controller latency distribution, categorized by name, operation, rejected, and type  |
| `apiserver_admission_webhook_admission_duration_seconds_bucket` | Histogram | Admission Webhook response latency distribution, categorized by name, operation, rejected, and type |
| `workqueue_queue_duration_seconds_bucket`          | Histogram   | Distribution of time requests stay in the work queue, categorized by name                        |
| `workqueue_work_duration_seconds_bucket`           | Histogram   | Distribution of time taken to process requests in the queue, categorized by name                 |
| `apiserver_storage_objects`                        | Gauge       | Latest count of resources, categorized by resource                                               |
