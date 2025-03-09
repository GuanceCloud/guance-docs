---
title     : 'Kube Scheduler'
summary   : 'By monitoring Kube Scheduler Metrics, it helps configure and optimize the Kube Scheduler, which can improve cluster resource utilization and application performance'
__int_icon: 'icon/kube_scheduler'
dashboard :
  - desc  : 'Kube Schedule'
    path  : 'dashboard/en/kube_scheduler'
monitor   :
  - desc  : 'Kube Schedule'
    path  : 'monitor/en/kube_scheduler'
---

By monitoring Kube Scheduler Metrics, it helps configure and optimize the Kube Scheduler, which can improve cluster resource utilization and application performance

## Configuration {#config}

### Prerequisites {#requirement}

- [x] DataKit is installed

### Collector Configuration

- Configure a `ConfigMap` resource in `datakit.yaml` to collect Kube Scheduler Metrics data

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
   kubernetesprometheus.conf: |-  
   # The following configuration is not static; please modify according to actual conditions
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

## Metrics {#metric}

### Kube Scheduler Metrics Set

Kube Scheduler metrics are located under the kube-scheduler Metrics set. Here is an introduction to the relevant Kube Scheduler Metrics

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`scheduler_scheduler_cache_size`| Number of nodes, Pods, and AssumedPods (assumed to be scheduled Pods) in the scheduler cache | count |
|`scheduler_pending_pods`| Number of Pending Pods | count |
|`process_cpu_seconds_total`| Total CPU usage of the kube-scheduler process | s |
|`rest_client_request_duration_seconds_bucket`| Analysis of HTTP request latency from the method (Verb) and URL dimensions | ms |
|`rest_client_requests_total`| Analysis of HTTP requests from status code (Status Code), method (Method), and host (Host) dimensions | count |
|`rest_client_requests_total`| Total number of HTTP requests initiated by kube-scheduler to kube-apiserver | count |