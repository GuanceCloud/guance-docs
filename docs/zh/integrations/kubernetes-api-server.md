---
title     : 'Kubernetes API Server'
summary   : '采集 Kubernetes API Server 相关指标信息'
__int_icon: 'icon/kubernetes'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'Kubernetes API Server 监控视图'
    path  : 'dashboard/zh/kubernetes_api_server'
monitor   :
  - desc  : 'Kubernetes API Server'
    path  : 'monitor/zh/kubernetes_api_server'
---

## 配置 {#config}

### [Kubernetes 安装 DataKit](../datakit/datakit-daemonset-deploy.md)

### 配置采集器

创建以下 Configmap 管理采集器配置：

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  kube-apiserver.conf: |-
    [inputs.kubernetesprometheus]
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

详细配置请参考[Kubernetes Prometheus Discovery](../integrations/kubernetesprometheus.md)。

### 为 Datakit 挂载配置文件

修改 Datakit 资源文件，挂载采集配置后即可开启相应采集器：

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

## 指标 {#metric}

以下列表为关键指标和说明：

| **指标** | **指标类型** | **描述** |
| --- | --- | --- |
| `apiserver_request_total` | Counter | 分verb、dry_run、group、version、resource、scope、component、code统计请求数 |
| `apiserver_current_inflight_requests` | Gauge | 分request_kind统计当前读写请求数 |
| `apiserver_request_terminations_total` | Counter | 分code、component、group、resource、scope、subresource、verb、version统计出于自我保护丢弃的请求数 |
| `apiserver_request_duration_seconds_bucket` | Histogram | 分verb、dry_run、group、version、resource、subresource、scope、component统计响应延迟分布 |
| `etcd_request_duration_seconds_bucket` | Histogram | 分operation、type统计Etcd响应延迟分布 |
| `apiserver_admission_controller_admission_duration_seconds_bucket` | Histogram | 分name、operation、rejected、type统计准入控制器延迟分布 |
| `apiserver_admission_webhook_admission_duration_seconds_bucket` | Histogram | 分name、operation、rejected、type统计准入Webhook响应延迟分布 |
| `workqueue_queue_duration_seconds_bucket` | Histogram | 分name统计请求在工作队列中的停留时长分布 |
| `workqueue_work_duration_seconds_bucket` | Histogram | 分name统计队列中请求处理时长分布 |
| `apiserver_storage_objects` | Gauge | 分resource统计最新的资源数量 |
