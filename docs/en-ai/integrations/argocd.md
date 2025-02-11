---
title     : 'ArgoCD'
summary   : 'Collect Argo CD service status, application status, logs, and trace information'
__int_icon: 'icon/argocd'
dashboard :
  - desc  : 'ArgoCD monitoring view'
    path  : 'dashboard/en/argocd'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# ArgoCD
<!-- markdownlint-enable -->

Argo CD exposes metrics via the Prometheus protocol. These metrics can be used to monitor the service status and application status of Argo CD. Argo CD primarily exposes three types of metrics:

- Application Controller Metrics: Metrics related to Argo CD applications, such as the number of applications, Argo CD status, etc.
- API Server Metrics: Metrics for Argo CD API requests, such as request count, response codes, etc.
- Repo Server Metrics: Metrics related to the Repo Server, such as Git request counts, Git response times, etc.


## Configuration {#config}

### Prerequisites

- [x] Install K8S environment
- [x] Install ArgoCD
- [x] Install [DataKit](../datakit/datakit-daemonset-deploy.md)

### Metrics

#### Enable `ServiceMonitor` in DataKit

[Auto-discover Pod/Service metrics with Prometheus](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

The following collects ArgoCD metrics using the `ServiceMonitor` method.

#### Install Prometheus Operator

```shell
git clone https://github.com/coreos/prometheus-operator.git
cd prometheus-operator
kubectl create -f bundle.yaml
kubectl get pod -n default
```

#### Create ServiceMonitor

- Create `argocd-metrics.yaml`

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: argocd-metrics
  labels:
    release: prometheus-operator
  namespace: argocd
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-metrics
  endpoints:
  - port: metrics
    params:
      measurement:
        - argocd-application-controller
```

- Create `argocd-server-metrics.yaml`

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: argocd-server-metrics
  labels:
    release: prometheus-operator
  namespace: argocd
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-server-metrics
  endpoints:
  - port: metrics
    params:
      measurement:
        - argocd-server
```

- Create `argocd-repo-server.yaml`

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: argocd-repo-server-metrics
  labels:
    release: prometheus-operator
  namespace: argocd
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-repo-server
  endpoints:
  - port: metrics
    params:
      measurement:
        - argocd-repo-server
```

- Create `argocd-applicationset-controller.yaml`

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: argocd-applicationset-controller-metrics
  labels:
    release: prometheus-operator
  namespace: argocd
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-applicationset-controller
  endpoints:
  - port: metrics
    params:
      measurement: 
        - argocd-applicationset-controller
```

- Execute

```shell
kubectl apply -f argocd-metrics.yaml
kubectl apply -f argocd-server-metrics.yaml 
kubectl apply -f argocd-repo-server.yaml
kubectl apply -f argocd-applicationset-controller.yaml
```

- Check Status

```shell
[root@k8s-master ~]# kubectl get ServiceMonitor -n argocd
NAME                                       AGE
argocd-applicationset-controller-metrics   7d6h
argocd-metrics                             7d6h
argocd-repo-server-metrics                 7d6h
argocd-server-metrics                      7d6h
```

#### DataKit Configuration

- Enable DataKit Service Monitor auto-discovery

Add `env : ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS`

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
      - env:
        ...
        - name: ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS
          value: "true"
        ...
```

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Tracing

Starting from Argo CD 2.4 [#7539](https://github.com/argoproj/argo-cd/pull/7539), support for the OpenTelemetry protocol has been added, allowing trace data to be obtained via the exposed `otlp` address.

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

Restart ArgoCD for tracing to take effect.


### Logs

After installing the DataKit collector, it will automatically collect logs output by Argo CD Pods without additional configuration.

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
| `argocd_git_request_duration_seconds_bucket`| Git Ls-Remote Requests Performance |


For more metrics, refer to the [ArgoCD official documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/metrics/)