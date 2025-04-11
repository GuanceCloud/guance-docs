---
title     : 'Kubelet'
summary   : 'Collect Kubelet Metrics information'
__int_icon: 'icon/kubelet'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'Kubelet'
    path  : 'dashboard/en/kubelet'
monitor   :
  - desc  : 'Kubelet'
    path  : 'monitor/en/kubelet'
---

Collect Kubelet Metrics information

## Configuration {#config}

### Prerequisites {#requirement}

- [x] Kubernetes environment is already installed

### Collector Configuration

- Add the `kubernetesprometheus.conf` resource in the `ConfigMap` of the `datakit.yaml` file to collect Kubelet Metrics data

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

- Mount the `kubernetesprometheus.conf` to `/usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf` under DataKit

```yaml
        - mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
          name: datakit-conf
          subPath: kubernetesprometheus.conf
```

- Execute the following commands to restart DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metrics {#metric}

### Kubelet Measurement

Kubelet Metrics are located under the Kubelet Measurement set. Below are explanations related to Kubelet Metrics.

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`kubelet_node_name`|`Node where Kubelet resides`| count |
|`kubelet_running_pods`|`Number of Pods currently running on the node`| count |
|`kubelet_running_containers`|`Number of containers currently running on the node`| count |
|`volume_manager_total_volumes`|`Total number of volumes managed on the current node`| count |
|`volume_manager_total_volumes`|`Total number of container runtime operations performed by Kubelet`| count |
|`kubelet_runtime_operations_total`|`Total number of failures for container runtime operations performed by Kubelet`| count |
|`kubelet_runtime_operations_errors_total`|`Duration distribution of container runtime operations performed by Kubelet`| s |
|`kubelet_runtime_operations_duration_seconds_bucket`|`Total number of times Kubelet started Pods`| count |
|`kubelet_pod_start_duration_seconds_count`|`Duration distribution of Kubelet starting Pods`| s |
|`kubelet_pod_start_duration_seconds_bucket`|`Total number of storage operations`| count |
|`storage_operation_duration_seconds_count`|`Total number of failed storage operations`| count |
|`storage_operation_errors_total`|`Total number of operations managing cgroups by Kubelet`| count |
|`kubelet_cgroup_manager_duration_seconds_count`|`Duration distribution of Kubelet managing cgroups`| s |
|`kubelet_cgroup_manager_duration_seconds_bucket`|`Total number of PLEG relist operations performed by Kubelet`| count |
|`kubelet_pleg_relist_duration_seconds_count`|`Total number of REST requests sent by Kubelet to the Kubernetes API Server`| count |
|`rest_client_requests_total`|`Duration distribution of REST requests sent by Kubelet to the Kubernetes API Server`| count |
|`rest_client_request_duration_seconds_bucket`|`Amount of physical memory used by the Kubelet process`| byte |
|`process_resident_memory_bytes`|`Total CPU time used by the Kubelet process`| s |
|`process_cpu_seconds_total`|`Total CPU time used by the Kubelet process`| s |
|`go_goroutines`|`Number of active Go routines in the Kubelet process`| count |