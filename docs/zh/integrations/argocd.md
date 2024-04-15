---
title     : 'ArgoCD'
summary   : '采集 Argo CD 服务状态和应用状态及日志、链路信息'
__int_icon: 'icon/argocd'
dashboard :
  - desc  : 'ArgoCD 监控视图'
    path  : 'dashboard/zh/argocd'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# ArgoCD
<!-- markdownlint-enable -->

Argo CD 通过 Prometheus 协议暴露指标，通过这些指标可用于监控 Argo CD 服务状态和应用状态。Argo CD 主要暴露三类指标：

- Application Controller Metrics：Argo CD 应用相关指标，例如应用数、Argo CD 状态等。
- API Server Metrics：Argo CD API 请求指标，例如请求数、响应码等。
- Repo Server Metrics：Repo Server 相关指标，例如 Git 请求数、Git 响应时间等。


## 配置 {#config}

### 前置条件

- [x] 安装 K8S 环境
- [x] 安装 ArgoCD
- [x] 安装 [DataKit](../datakit/datakit-daemonset-deploy.md)

### Metric

#### DataKit 开启 `ServiceMonitor`

[自动发现 Pod/Service 的 Prometheus 指标](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

以下通过`ServiceMonitor`方式采集 `ArgoCD` 指标信息

#### 安装 Prometheus Operator

```shell
git clone https://github.com/coreos/prometheus-operator.git
cd prometheus-operator
kubectl create -f bundle.yaml
kubectl get pod -n default
```


#### 创建 ServiceMonitor

- 创建 `argocd-metrics.yaml`

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

- 创建 `argocd-server-metrics.yaml`

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

- 创建 `argocd-repo-server.yaml`

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

- 创建 `argocd-applicationset-controller.yaml`

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

- 执行

```shell
kubectl apply -f argocd-metrics.yaml
kubectl apply -f argocd-server-metrics.yaml 
kubectl apply -f argocd-repo-server.yaml
kubectl apply -f argocd-applicationset-controller.yaml
```

- 查看状态

```shell
[root@k8s-master ~]# kubectl get ServiceMonitor -n argocd
NAME                                       AGE
argocd-applicationset-controller-metrics   7d6h
argocd-metrics                             7d6h
argocd-repo-server-metrics                 7d6h
argocd-server-metrics                      7d6h

```

#### DataKit 配置

- 开启 DataKit Service Monitor 自动发现

添加 `env : ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS`

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

- 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

### Tracing

Argo CD 2.4 [#7539](https://github.com/argoproj/argo-cd/pull/7539) 加入了 OpenTelemetry 协议的支持，可通过暴露的 `otlp` 地址来获取链路数据。

#### DataKit 开启 OpenTelemetry 采集器

- 修改 DataKit 的 ConfigMap

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

- 挂载

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

- DataKit 开启 `4317` 端口

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


#### ArgoCD 开启 `otlp` 上报

- 创建 `argocd-cmd-params-cm.yaml`

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

然后执行以下命令：

```shell
kubectl apply -f argocd-cmd-params-cm.yaml
```

- 重启 ArgoCD

重启 ArgoCD 链路才能生效。


### 日志

安装 DataKit 采集器之后，默认会采集 Argo CD Pod 输出的日志，无须其他配置。

## 指标 {#metric}

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
| `argocd_app_reconcile_count` | 应用 reconcile count |
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


更多指标，参考[ArgoCD 官方文档](https://argo-cd.readthedocs.io/en/stable/operator-manual/metrics/)
