---
title     : 'KubeCost'
summary   : 'Collect KubeCost metrics'
__int_icon: 'icon/kubecost'
dashboard :
  - desc  : 'KubeCost'
    path  : 'dashboard/en/kubecost'
monitor   :
  - desc  : 'No'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# KubeCost
<!-- markdownlint-enable -->

## Installation Configuration{#config}

### Preconditions

- [x] Installed K8S
- [x] Installed [KubeCost](https://docs.kubecost.com/install-and-configure/install)
- [x] Installed [DataKit](../datakit/datakit-daemonset-deploy.md)
- [x] Installed Prometheus Operator

### CRD configure

KubeCost has exposed the metrics, just let DataKit discover the metrics and report them.

- Add `kubecost-serverMonitor.yaml`

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: kubecost-metrics
  labels:
    app.kubernetes.io/name: cost-analyzer
  namespace: kubecost
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: cost-analyzer
  endpoints:
  - port: metrics
```

- Run

> kubectl apply  -f `kubecost-serverMonitor.yaml`

#### DataKit configure

If enabled, please ignore.


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

## Metric {#metric}

### `kubecost-cost-analyzer`

| Metric | Description |
| -- | -- |
| container_cpu_allocation | container CPU allocation |
| container_gpu_allocation | container GPU allocation |
| container_memory_allocation_bytes | container memory allocation |
| pv_hourly_cost | PersistentVolume hourly cost  |
| node_total_hourly_cost | Total hourly cost of nodes |
| node_cpu_hourly_cost | Node CPU hourly cost |
| node_ram_hourly_cost | Node RAM hourly cost |
| node_gpu_hourly_cost | Node GPU hourly cost |
