---
title     : 'Kube Scheduler'
summary   : 'By monitoring Kube Scheduler Metrics, it helps configure and optimize the Kube Scheduler, which can improve the resource utilization of the cluster and the performance of applications'
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

By monitoring Kube Scheduler Metrics, it helps configure and optimize the Kube Scheduler, which can improve the resource utilization of the cluster and the performance of applications

## Configuration {#config}

### Prerequisites {#requirement}

- [x] DataKit is installed

### Collector Configuration

- Configure `ConfigMap` resources in `datakit.yaml` to collect Kube Scheduler Metrics data

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
   kubernetesprometheus.conf: |-  
     [inputs.kubernetesprometheus]
        [[inputs.kubernetesprometheus.instances]]
          role       = "pod"
          namespaces = ["kube-system"]
          selector   = "component=kube_scheduler,tier=control-plane"      
          scrape   = "true"
          scheme   = "https"
          port     = "10259"
          path     = "/metrics"
          interval = "30s"

         [inputs.kubernetesprometheus.instances.custom]
           measurement        = "kube_scheduler"
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

- Restart datakit

```shell
kubectl rollout restart ds  datakit -n datakit
```

## Metrics {#metric}

### Kube Scheduler Metric Sets

Kube Scheduler Metrics are located under the kube-scheduler metric set. Below is an introduction to the related explanations of Kube Scheduler Metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`scheduler_scheduler_cache_size`|`Number of nodes, Pods, and AssumedPods (pods assumed to be scheduled) in the scheduler cache`| count |
|`scheduler_pending_pods`|`Number of Pending Pods`| count |
|`process_cpu_seconds_total`|`Total CPU usage of the kube-scheduler process`| s |
|`rest_client_request_duration_seconds_bucket`|`Analyze HTTP request latency from the method (Verb) and URL dimensions`| ms |
|`rest_client_requests_total`|`Analyze HTTP requests from status value (Status Code), method (Method), and host (Host) dimensions`| count |
|`rest_client_requests_total`|`Total number of HTTP requests initiated by kube-scheduler to kube-apiserver`| count |