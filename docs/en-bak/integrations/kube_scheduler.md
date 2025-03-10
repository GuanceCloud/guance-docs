---
title     : 'Kube Scheduler'
summary   : 'By monitoring Kube Scheduler metrics to help configure and optimize Kube Scheduler, you can improve cluster resource utilization and application performance'
__int_icon: 'icon/kube_scheduler'
dashboard :
  - desc  : 'Kube Schedule'
    path  : 'dashboard/en/kube_scheduler'
monitor   :
  - desc  : 'Kube Schedule'
    path  : 'monitor/en/kube_scheduler'
---

By monitoring Kube Scheduler metrics to help configure and optimize Kube Scheduler, you can improve cluster resource utilization and application performance

## Config {#config}

### Precondition {#requirement}

- [x] Installed DataKit

### Collector configuration

- `ConfigMap` resource in `datakit.yaml` to collect metric data for Kube Scheduler

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
   kubernetesprometheus.conf: |-  
   # The following configuration is not static, please modify it according to the actual situation
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

- Restart DataKit

```shell
kubectl rollout restart ds  datakit -n datakit
```

## Metric {#metric}

### kube scheduler metric set

The Kube Scheduler metric is located under the kube-scheduler metric set. Here is the relevant description of the Kube Scheduler metric

| Metrics | Description | Unit |
|:--------|:-----|:--|
|`scheduler_scheduler_cache_size`|`Number of nodes, Pods, and AssumedPods (assuming Pods to be scheduled) in the scheduler cache`| count |
|`scheduler_pending_pods`|`Number of Pending Pods`| count |
|`process_cpu_seconds_total`|`The kube-scheduler process Total CPU usage time`| s |
|`rest_client_request_duration_seconds_bucket`|`Analysis of HTTP request latency from method (Verb) and URL dimensions`| ms |
|`rest_client_requests_total`|`Analyze the number of HTTP requests from the Status Code, Method and Host dimensions`| count |
|`rest_client_requests_total`|`Total number of HTTP requests made by kube-scheduler to kube-apiserver`| count |
