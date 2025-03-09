---
title     : 'Kube Scheduler'
summary   : '通过监控 Kube Scheduler 指标,帮助配置和优化Kube Scheduler，可以提高集群的资源利用率和应用程序的性能'
__int_icon: 'icon/kube_scheduler'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'Kube Schedule'
    path  : 'dashboard/zh/kube_scheduler'
monitor   :
  - desc  : 'Kube Schedule'
    path  : 'monitor/zh/kube_scheduler'
---

通过监控 Kube Scheduler 指标,帮助配置和优化Kube Scheduler，可以提高集群的资源利用率和应用程序的性能

## 配置 {#config}

### 前置条件 {#requirement}

- [x] 已安装 DataKit

### 采集器配置

- 在 `datakit.yaml` 中配置 `ConfigMap` 资源来收集 Kube Scheduler 的指标数据

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
   kubernetesprometheus.conf: |-  
   # 以下配置不是一成不变，请根据实际情况进行修改
        [[inputs.kubernetesprometheus.instances]]
          role       = "pod"
          namespaces = ["kube-system"]
          selector   = "component=Kube Scheduler,tier=control-plane"      
          scrape   = "true"
          scheme   = "https"
          port     = "10259"
          path     = "/metrics"
          interval = "30s"

         [inputs.kubernetesprometheus.instances.custom]
           measurement        = "Kube Scheduler"
           job_as_measurement = false
           [inputs.kubernetesprometheus.instances.custom.tags]
             cluster_name_k8s = "k8s-test"           
             node_name        = "__kubernetes_pod_node_name"
             instance         = "__kubernetes_mate_instance"
      
         [inputs.kubernetesprometheus.instances.auth]
           bearer_token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"
           [inputs.kubernetesprometheus.instances.auth.tls_config]
             insecure_skip_verify = true
             ca_certs = []
             cert     = ""
             cert_key = ""
```

- 重启 datakit

```shell
kubectl rollout restart ds  datakit -n datakit
```

## 指标 {#metric}

### kube scheduler 指标集

Kube Scheduler 指标位于 kube-scheduler 指标集下，这里介绍 Kube Scheduler 指标相关说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`scheduler_scheduler_cache_size`|`调度器缓存中节点、Pod和AssumedPod（假定要调度的Pod）的数量`| count |
|`scheduler_pending_pods`|`Pending Pod的数量`| count |
|`process_cpu_seconds_total`|`kube-scheduler 进程的 CPU 使用总`| s |
|`rest_client_request_duration_seconds_bucket`|`从方法（Verb）和URL维度分析HTTP请求时延`| ms |
|`rest_client_requests_total`|`从状态值（Status Code）、方法（Method）和主机（Host）维度分析HTTP请求数`| count |
|`rest_client_requests_total`|`kube-scheduler 向 kube-apiserver 发起的 HTTP 请求总数`| count |
