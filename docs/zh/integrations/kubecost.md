---
title     : 'KubeCost'
summary   : '采集 KubeCost 指标信息'
__int_icon: 'icon/kubecost'
dashboard :
  - desc  : 'KubeCost'
    path  : 'dashboard/zh/kubecost'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# KubeCost
<!-- markdownlint-enable -->

## 配置 {#config}

### 前置条件

- [x] 安装 K8S 环境
- [x] 安装 [KubeCost](https://docs.kubecost.com/install-and-configure/install)
- [x] 安装 [DataKit](../datakit/datakit-daemonset-deploy.md)
- [x] 安装 Prometheus Operator

### CRD 配置

KubeCost 已暴露了指标，只需要让 DataKit 能够发现指标并上报。

- 新增 `kubecost-serverMonitor.yaml`

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

- 执行

> kubectl apply  -f `kubecost-serverMonitor.yaml`

#### DataKit 配置

如已开启，请忽略

- 开启 DataKit Service Monitor 自动发现

添加 `env : ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS`

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

- 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### `kubecost-cost-analyzer`

| Metric | 描述 |
| -- | -- |
| container_cpu_allocation | container cpu 分配 |
| container_gpu_allocation | container gpu 分配 |
| container_memory_allocation_bytes | container 内存分配 |
| pv_hourly_cost | PersistentVolume 每小时成本  |
| node_total_hourly_cost | 节点每小时总成本 |
| node_cpu_hourly_cost | 节点 cpu 每小时成本 |
| node_ram_hourly_cost | 节点 ram 每小时成本 |
| node_gpu_hourly_cost | 节点 gpu 每小时成本 |
