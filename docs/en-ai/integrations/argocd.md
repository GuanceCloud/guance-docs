---
title     : 'ArgoCD'
summary   : 'Collect Argo CD service status, application status, logs, and tracing information'
__int_icon: 'icon/argocd'
dashboard :
  - desc  : 'ArgoCD Monitoring View'
    path  : 'dashboard/en/argocd'
monitor   :
  - desc  : 'AutoMQ'
    path  : 'monitor/en/argocd'
---

<!-- markdownlint-disable MD025 -->
# ArgoCD
<!-- markdownlint-enable -->

Argo CD exposes metrics via the Prometheus protocol. These metrics can be used to monitor the status of Argo CD services and applications. Argo CD primarily exposes three types of metrics:

- Application Controller Metrics: Metrics related to Argo CD applications, such as the number of applications and Argo CD status.
- API Server Metrics: Metrics for Argo CD API requests, such as request counts and response codes.
- Repo Server Metrics: Metrics related to the Repo Server, such as Git request counts and Git response times.


## Configuration {#config}

### Prerequisites

- [x] Install K8S environment
- [x] Install ArgoCD
- [x] Install [DataKit](../datakit/datakit-daemonset-deploy.md)

### Enable KubernetesPrometheus in DataKit

- MountPath configuration to mount the KubernetesPrometheus configuration file into the container

```yaml
          - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
            name: datakit-conf
            subPath: kubernetesprometheus.conf
            readOnly: true
```

- Add `kubernetesprometheus.conf` to the `datakit.yaml` ConfigMap

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

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Tracing

Argo CD 2.4 [#7539](https://github.com/argoproj/argo-cd/pull/7539) added support for the OpenTelemetry protocol, allowing trace data to be obtained through the exposed `otlp` address.

#### Enable OpenTelemetry Collector in DataKit

- Modify the DataKit ConfigMap

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

- Mounting

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

- Enable `4317` port in DataKit

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

After making these changes, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


#### Enable `otlp` Reporting in ArgoCD

- Create `argocd-cmd-params-cm.yaml`

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

Then execute the following command:

```shell
kubectl apply -f argocd-cmd-params-cm.yaml
```

- Restart ArgoCD

Traces will only take effect after restarting ArgoCD.


### Logs

After installing the DataKit collector, it will automatically collect logs from Argo CD Pods by default, with no additional configuration required.

## Metrics {#metric}

### `argocd-server`

| Metric | Description |
| -- | -- |
| `process_start_time_seconds` | The start time of the process since the Unix epoch in seconds in the API Server |
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
| `argocd_git_request_duration_seconds_bucket`| Performance of Git Ls-Remote Requests |

For more metrics, refer to the [official ArgoCD documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/metrics/)