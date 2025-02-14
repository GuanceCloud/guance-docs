---
title     : 'ArgoCD'
summary   : '采集 Argo CD 服务状态和应用状态及日志、链路信息'
__int_icon: 'icon/argocd'
dashboard :
  - desc  : 'ArgoCD 监控视图'
    path  : 'dashboard/zh/argocd'
monitor   :
  - desc  : 'AutoMQ'
    path  : 'monitor/zh/argocd'
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

### DataKit 开启 KubernetesPrometheus

1. mountPath 挂载把 KubernetesPrometheus 的配置文件挂载到容器内 

```yaml
          - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
            name: datakit-conf
            subPath: kubernetesprometheus.conf
            readOnly: true
```

2. 添加 datakit.yaml 的 configmap 文件下添加 kubernetesprometheus.conf

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

调整后[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)


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
