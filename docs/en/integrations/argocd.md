---
title     : 'ArgoCD'
summary   : 'Collect Argo CD service status, application status, logs, and link information'
__int_icon: 'icon/argocd'
dashboard :
  - desc  : 'ArgoCD Monitoring View'
    path  : 'dashboard/en/argocd'
monitor   :
  - desc  : 'ArgoCD'
    path  : 'monitor/en/argocd'
---

<!-- markdownlint-disable MD025 -->
# ArgoCD
<!-- markdownlint-enable -->

Argo CD exposes metrics through the Prometheus protocol, which can be used to monitor the status of Argo CD services and applications. Argo CD is mainly exposed to three types of metrics:

- Application Controller Metrics：Argo CD application related metrics, such as number of applications, Argo CD status, etc.
- API Server Metrics：Argo CD API request metrics, such as number of requests, response codes, etc.
- Repo Server Metrics：Repo Server related metrics, such as the number of Git requests, Git response time, etc.


## Installation Configuration{#config}

### Preconditions

- [x] Installed K8S
- [x] Installed ArgoCD
- [x] Installed [DataKit](../datakit/datakit-daemonset-deploy.md)

### Metric

#### DataKit 开启 KubernetesPrometheus

1. Mount KubernetesPrometheus

```yaml
          - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
            name: datakit-conf
            subPath: kubernetesprometheus.conf
            readOnly: true
```

2. Add `Kubernetes prometheus.conf` to the configmap file of `datakit. yaml`

```yaml
kubernetesprometheus.conf: |-
      [inputs.kubernetesprometheus]
        [[inputs.kubernetesprometheus.instances]]
          role       = "service"
          namespaces = ["argocd"]
          selector   = "app.kubernetes.io/name=argocd-server-metrics"

          scrape     = "true"
          scheme     = "http"
          port       = "__kubernetes_service_port_metrics_targetport"
          path       = "/metrics"
          params     = ""

          [inputs.kubernetesprometheus.instances.custom]
            measurement        = "argocd-server"
            job_as_measurement = false
            [inputs.kubernetesprometheus.instances.custom.tags]
              svc_name      = "__kubernetes_service_name"
              pod_name      = "__kubernetes_service_target_name"
              pod_namespace = "__kubernetes_service_target_namespace"
        [[inputs.kubernetesprometheus.instances]]
          role       = "service"
          namespaces = ["argocd"]
          selector   = "aapp.kubernetes.io/name=argocd-metrics"

          scrape     = "true"
          scheme     = "http"
          port       = "__kubernetes_service_port_metrics_targetport"
          path       = "/metrics"
          params     = ""

          [inputs.kubernetesprometheus.instances.custom]
            measurement        = "argocd"
            job_as_measurement = false
            [inputs.kubernetesprometheus.instances.custom.tags]
              svc_name      = "__kubernetes_service_name"
              pod_name      = "__kubernetes_service_target_name"
              pod_namespace = "__kubernetes_service_target_namespace"

        [[inputs.kubernetesprometheus.instances]]
          role       = "service"
          namespaces = ["argocd"]
          selector   = "app.kubernetes.io/name=argocd-notifications-controller-metrics"

          scrape     = "true"
          scheme     = "http"
          port       = "__kubernetes_service_port_metrics_targetport"
          path       = "/metrics"
          params     = ""

          [inputs.kubernetesprometheus.instances.custom]
            measurement        = "argocd-application-controller"
            job_as_measurement = false
            [inputs.kubernetesprometheus.instances.custom.tags]
              svc_name      = "__kubernetes_service_name"
              pod_name      = "__kubernetes_service_target_name"
              pod_namespace = "__kubernetes_service_target_namespace"

      [inputs.kubernetesprometheus.global_tags]
        instance = "__kubernetes_mate_instance"
        host     = "__kubernetes_mate_host"
    
```

#### Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Tracing

Argo CD 2.4 [#7539](https://github.com/argoproj/argo-cd/pull/7539) add support for the OpenTelemetry protocol, which allows link data to be obtained through exposed 'otlp' addresses.

#### DataKit opens the OpenTelemetry collector

- Modify DataKit ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### opentelemetry
  opentelemetry.conf: |-
    [[inputs.opentelemetry]]
      [inputs.opentelemetry.http]
       enable = true
       http_status_ok = 200

      [inputs.opentelemetry.grpc]
       trace_enable = true
       metric_enable = true
       addr = "0.0.0.0:4317"
```

- Mount

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: daemonset-datakit
  name: datakit
  namespace: datakit
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
        - mountPath: /usr/local/datakit/conf.d/opentelemetry/opentelemetry.conf
          name: datakit-conf
          subPath: opentelemetry.conf
        ...
```

- DataKit enables port '4317'


```yaml
apiVersion: v1
kind: Service
metadata:
  name: datakit-service
  namespace: datakit
spec:
  selector:
    app: daemonset-datakit
  ports:
    - name: datakit
      protocol: TCP
      port: 9529
      targetPort: 9529
    - name: opentelemetry
      protocol: TCP
      port: 4317
      targetPort: 4317
```

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

#### ArgoCD Enable 'otlp' Reporting

- Created `argocd-cmd-params-cm.yaml`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-cmd-params-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cmd-params-cm
  namespace: argocd
data:
  otlp.address: datakit-service.datakit:4317
```

Then execute the following command：

```shell
kubectl apply -f argocd-cmd-params-cm.yaml
```

- Restart ArgoCD

Restart the ArgoCD link to take effect.


### Logging

After installing the DataKit collector, the logs output by Argo CD Pod will be collected by default, and no other configuration is required.

## Metric {#metric}

### `argocd-server`

| Metric | Description |
| -- | -- |
| `process_start_time_seconds` | The start time of the process since unix epoch in seconds in the API Server |
| `go_goroutines`| The number of `goroutines` that currently exist in the API Server|
| `grpc_server_handled_total` | The total number of RPCs completed on the server regardless of success or failure |
| `grpc_server_started_total`| The total number of RPCs started on the server |
| `go_memstats_alloc_bytes`| The number of heap bytes allocated and still in use in the API Server |

### `argocd-application-controller`

| Metric | Description |
| -- | -- |
| `argocd_app_info` | Information about Applications. It contains tags such as `syncstatus` and `healthstatus` that reflect the application state in Argo CD. The metric value is constant |
| `go_memstats_heap_alloc_bytes`| The number of heap bytes allocated and still in use in the Application Controller |
| `process_cpu_seconds_total` | The total user and system CPU time spent in seconds in the Application Controller |
| `argocd_app_reconcile_count` | Application reconcile count |
| `argocd_app_reconcile_bucket`| Count of Application Reconciliation by Duration Bounds|
| `workqueue_depth` | Depth of the Workqueue |
| `argocd_kubectl_exec_total` | Count of Kubectl Executions |
| `argocd_app_k8s_request_total`| Count of Kubernetes Requests Executed|
| `argocd_kubectl_exec_pending`| Count of Pending Kubectl Executions |



### `argocd-repo-server`

| Metric | Description |
| -- | -- |
| `argocd_git_request_total` | Count of Git Ls-Remote Requests |
| `argocd_git_request_duration_seconds_bucket`| Git Ls-Remote Requests Performance |


For more metrics, refer to [the official ArgoCD document](https://argo-cd.readthedocs.io/en/stable/operator-manual/metrics/)
