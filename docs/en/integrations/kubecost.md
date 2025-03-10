---
title     : 'KubeCost'
summary   : 'Collect KubeCost Metrics information'
__int_icon: 'icon/kubecost'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'KubeCost'
    path  : 'dashboard/en/kubecost'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# KubeCost
<!-- markdownlint-enable -->

## Configuration {#config}

### Prerequisites

- [x] Install K8S environment
- [x] Install [KubeCost](https://docs.kubecost.com/install-and-configure/install)
- [x] Install [DataKit](../datakit/datakit-daemonset-deploy.md)
- [x] Install Prometheus Operator

### CRD Configuration

KubeCost has exposed metrics, so we only need to ensure that DataKit can discover and report these metrics.

- Create `kubecost-serverMonitor.yaml`

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

- Execute

> kubectl apply  -f `kubecost-serverMonitor.yaml`

#### DataKit Configuration

If already enabled, ignore this step.

- Enable DataKit Service Monitor auto-discovery

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

- Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

### `kubecost-cost-analyzer`

| Metric | Description |
| --- | --- |
| container_cpu_allocation | Container CPU allocation |
| container_gpu_allocation | Container GPU allocation |
| container_memory_allocation_bytes | Container memory allocation |
| pv_hourly_cost | PersistentVolume hourly cost |
| node_total_hourly_cost | Node total hourly cost |
| node_cpu_hourly_cost | Node CPU hourly cost |
| node_ram_hourly_cost | Node RAM hourly cost |
| node_gpu_hourly_cost | Node GPU hourly cost |