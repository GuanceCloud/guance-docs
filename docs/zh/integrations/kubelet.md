---
title     : 'Kubelet'
summary   : '采集 Kubelet 指标信息'
__int_icon: 'icon/kubelet'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'Kubelet'
    path  : 'dashboard/zh/kubelet'
monitor   :
  - desc  : 'Kubelet'
    path  : 'monitor/zh/kubelet'
---

采集 Kubelet 指标信息

## 配置 {#config}

### 前置条件 {#requirement}

- [x] 已安装 K8s 环境

### 采集器配置

- 在 `datakit.yaml` 文件的 `ConfigMap` 中添加 `kubernetesprometheus.conf` 资源来收集 Kubelet 的指标数据

```yaml
apiVersion: v1
items:
  - apiVersion: v1
    data:
      kubernetesprometheus.conf: |-
        [inputs.kubernetesprometheus]
          [[inputs.kubernetesprometheus.instances]]
            role       = "node"
            selector   = "kubernetes.io/os=linux"
            scrape     = "true"
            scheme     = "https"
            port       = "__kubernetes_node_kubelet_endpoint_port"
            path       = "/metrics"
            params     = ""
            interval   = "15s"

            [inputs.kubernetesprometheus.instances.custom]
              measurement        = "kubelet"
              job_as_measurement = true
              [inputs.kubernetesprometheus.instances.custom.tags]
                instance      = "__kubernetes_mate_instance"
                cluster_name_k8s       = "default"
                job          =  "kubelet"
            [inputs.kubernetesprometheus.instances.auth]
              bearer_token_file      = "/var/run/secrets/kubernetes.io/serviceaccount/token"
              [inputs.kubernetesprometheus.instances.auth.tls_config]
                insecure_skip_verify = true
                cert     = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
          [[inputs.kubernetesprometheus.instances]]
            role       = "node"
            selector   = "kubernetes.io/os=linux"
            scrape     = "true"
            scheme     = "https"
            port       = "__kubernetes_node_kubelet_endpoint_port"
            path       = "/metrics/cadvisor"
            params     = ""
            interval   = "15s"

            [inputs.kubernetesprometheus.instances.custom]
              measurement        = "cadvisor"
              job_as_measurement = true
              [inputs.kubernetesprometheus.instances.custom.tags]
                instance      = "__kubernetes_mate_instance"
                cluster_name_k8s       = "default"
                job           = "kubelet"
                node          = "__kubernetes_node_name"
                label_alpha_eksctl_io_nodegroup_name          = "__kubernetes_node_label_alpha.eksctl.io/nodegroup-name"
            [inputs.kubernetesprometheus.instances.auth]
              bearer_token_file      = "/var/run/secrets/kubernetes.io/serviceaccount/token"
              [inputs.kubernetesprometheus.instances.auth.tls_config]
                insecure_skip_verify = true
                cert     = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
```

- 将 `kubernetesprometheus.conf` 挂载到 DataKit 的 `/usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf` 下

```yaml
        - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
          name: datakit-conf
          subPath: kubernetesprometheus.conf
```

- 执行以下命令，重启 DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## 指标 {#metric}

### kubelet 指标集

Kubelet 指标位于 kubelet 指标集下，这里介绍 Kubelet 指标相关说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`kubelet_node_name`|`Kubelet 所在的节点`| count |
|`kubelet_running_pods`|`当前节点正在运行的 Pod 数量`| count |
|`kubelet_running_containers`|`当前节点上正在运行的容器数量`| count |
|`volume_manager_total_volumes`|`当前节点上管理的卷总数`| count |
|`volume_manager_total_volumes`|`Kubelet 执行的容器运行时操作总数`| count |
|`kubelet_runtime_operations_total`|`Kubelet 执行的容器运行时操作失败的次数`| count |
|`kubelet_runtime_operations_errors_total`|`Kubelet 执行的容器运行时操作的持续时间分布`| s |
|`kubelet_runtime_operations_duration_seconds_bucket`|`Kubelet 启动 Pod 的总次数`| count |
|`kubelet_pod_start_duration_seconds_count`|`Kubelet 启动 Pod 的持续时间分布`| s |
|`kubelet_pod_start_duration_seconds_bucket`|`存储操作的总次数`| count |
|`storage_operation_duration_seconds_count`|`存储操作失败的总次数`| count |
|`storage_operation_errors_total`|`Kubelet 管理 cgroup 的操作总次数`| count |
|`kubelet_cgroup_manager_duration_seconds_count`|`Kubelet 管理 cgroup 的操作持续时间分布`| s |
|`kubelet_cgroup_manager_duration_seconds_bucket`|`Kubelet 的 Pod 生命周期事件生成器（PLEG）重新列出操作的总次数`| count |
|`kubelet_pleg_relist_duration_seconds_count`|`Kubelet 向 Kubernetes API Server 发送的 REST 请求总数`| count |
|`rest_client_requests_total`|`Kubelet 向 Kubernetes API Server 发送的 REST 请求的持续时间分布`| count |
|`rest_client_request_duration_seconds_bucket`|`Kubelet 进程占用的物理内存大小`| byte |
|`process_resident_memory_bytes`|`Kubelet 进程占用的 CPU 时间总和`| s |
|`process_cpu_seconds_total`|`Kubelet 进程占用的 CPU 时间总和`| s |
|`go_goroutines`|`Kubelet 进程中活跃的 Go 协程数量`| count |
