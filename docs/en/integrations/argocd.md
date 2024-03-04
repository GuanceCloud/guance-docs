---
title     : 'ArgoCD'
summary   : 'Collect Argo CD service status, application status, logs, and link information'
__int_icon: 'icon/argocd'
dashboard :
  - desc  : 'ArgoCD Monitoring View'
    path  : 'dashboard/zh/argocd'
monitor   :
  - desc  : 'No'
    path  : '-'
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

### DataKit 开启 `ServiceMonitor`

[Automatically Discover the Service Exposure Metrics Interface](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

Collect `ArgoCD` indicator information through the `ServiceMonitor` method below.


#### Installed Prometheus Operator

```shell
git clone https://github.com/coreos/prometheus-operator.git
cd prometheus-operator
kubectl create -f bundle.yaml
kubectl get pod -n default
```


#### Created ServiceMonitor

- Created `argocd-metrics.yaml`

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

- Created `argocd-server-metrics.yaml`

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

- Created `argocd-repo-server.yaml`

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

- Created `argocd-applicationset-controller.yaml`

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

- Run

```shell
kubectl apply -f argocd-metrics.yaml
kubectl apply -f argocd-server-metrics.yaml 
kubectl apply -f argocd-repo-server.yaml
kubectl apply -f argocd-applicationset-controller.yaml
```

- Query

```shell
[root@k8s-master ~]# kubectl get ServiceMonitor -n argocd
NAME                                       AGE
argocd-applicationset-controller-metrics   7d6h
argocd-metrics                             7d6h
argocd-repo-server-metrics                 7d6h
argocd-server-metrics                      7d6h

```

#### DataKit configure

- Enable DataKit Service Monitor automatic discovery

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

### Restart DataKit

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
