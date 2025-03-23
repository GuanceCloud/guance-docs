---
title     : 'Node Problem Detector'
summary   : 'Collect cluster node Metrics and events via NPD'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'Node Problem Detector monitoring view'
    path  : 'dashboard/en/npd'
monitor   :
  - desc  : 'Node Problem Detector detection library'
    path  : 'monitor/en/npd'
  - desc  : 'Node Problem Detector (Log) detection library'
    path  : 'monitor/en/npd_log'
---

<!-- markdownlint-disable MD025 -->
# Node Problem Detector
<!-- markdownlint-enable -->

**Node Problem Detector**, abbreviated as **NPD**, is an open-source cluster node monitoring plugin for Kubernetes used for node failure checks.

**NPD** Features:

- Generate event information, report to APIServer.
- Detect metric information, output as Metrics.


## Configuration {#config}

### Prerequisites

- [x] Install K8S environment
- [x] Install [DataKit](../datakit/datakit-daemonset-deploy.md)

### Install NPD

You can refer to the [installation documentation](https://github.com/kubernetes/node-problem-detector#installation). Here we use the `yaml` method for installation.

- Download related yaml files

1. [node-problem-detector.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector.yaml)

2. [node-problem-detector-config.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector-config.yaml)

3. [rbac.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/rbac.yaml)

- Execute

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
```

### Log Event Pattern

By default, after installing NPD, no additional configuration is required. Datakit collects Kubernetes events by default and stores them in the `reason` (tag) of logs with the data source `Kubernetes_events`.

### Metric Pattern

In addition to the event pattern, NPD also supports outputting metrics.

#### Preparations

- [x] Install [Prometheus Operator](kubernetes-prometheus-operator-crd.md)

#### Enable `ServiceMonitor` in DataKit

[Automatically discover Pod/Service Prometheus metrics](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

The following collects `NPD` metric information through the `ServiceMonitor` method.

- Modify `node-problem-detector.yaml`

```yaml
...
      - name: node-problem-detector
        command:
        - /node-problem-detector
        - --logtostderr
        - --config.system-log-monitor=/config/kernel-monitor.json,/config/docker-monitor.json
        - --address=0.0.0.0
        - --prometheus-address=0.0.0.0
...
        ports:
        - containerPort: 20257
          hostPort: 20257
          name: man-port

```

- Create `npd-service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: node-problem-detector
  namespace: kube-system
  labels:
    app: node-problem-detector
spec:
  selector:
    app: node-problem-detector
  ports:
    - protocol: TCP
      port: 20257
      targetPort: 20257
      name: metrics

```

- Create `npd-server-monitor.yaml`

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: npd-server-metrics
  labels:
    app: node-problem-detector
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: node-problem-detector
  endpoints:
  - port: metrics
    params:
      measurement:
        - node-problem-detector
```

- Execute

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
kubectl apply -f npd-service.yaml
kubectl apply -f npd-server-monitor.yaml
```

## Metrics {#metric}

### problem_gauge

|Tag| Description|
| -- | -- |
| `type="ConntrackFullProblem"`| Node connection tracking table issue |
| type="EmptyDirVolumeGroupStatusError" | Temporary volume storage pool issue |
| type="MemoryProblem" | Node memory issue |
| type="LocalPvVolumeGroupStatusError" | Persistent volume storage pool issue on the node |
| type="MountPointProblem" | Node mount point issue |
| type="FDProblem" | System critical resource FD file handle count issue |
| type="DiskHung" | Whether the node disk has IO hang |
| type="DiskReadonly" | Whether the node disk is read-only |
| type="DiskProblem" | Node system disk issue |
| type="DiskSlow" | Whether the node disk has slow IO issue |
| type="FrequentCRIRestart" | CRI frequent restarts |
| type="FrequentDockerRestart" | Docker frequent restarts |
| type="FrequentKubeletRestart" | Kubelet frequent restarts |
| type="FrequentContainerdRestart" | Containerd frequent restarts |
| type="NTPProblem" | `ntpd` synchronization anomaly |
| type="PIDProblem" | Insufficient system critical resource PID process resources |
| type="`ResolvConfFileProblem`" | `ResolvConf` configuration anomaly |
| type="CNIProblem" | CNI (container network) component anomaly |
| type="CRIProblem" | Component CRI (container runtime component) Docker or Containerd operational state anomaly |
| type="`KUBEPROXYProblem`" | Kube-proxy operational anomaly |
| type="`KUBELETProblem`" | Kubelet status anomaly |
| type="ScheduledEvent" | Whether there are scheduled events on the host |
| type="ProcessD" | Node has D processes |
| type="ProcessZ" | Node has Z processes |

## Logs {#logging}

The following list includes but is not limited to the events that NPD can detect under the default configuration. Events are written into logs with the data source `Kubernetes_events`:

| **Reason** | **Persistence** | **Description** |
| --- | --- | --- |
| `DockerHung` | Yes | Docker hung or unresponsive |
| `ReadonlyFilesystem` | Yes | File system mounted as read-only mode, usually a protection mechanism preventing file system corruption under certain circumstances |
| `CorruptDockerOverlay2` | Yes | Issue with Overlay2 storage driver |
| `ContainerdUnhealthy` | Yes | Containerd in unhealthy state |
| `KubeletUnhealthy` | Yes | Kubelet in unhealthy state |
| `DockerUnhealthy` | Yes | Docker in unhealthy state |
| `OOMKilling` | No | Kubernetes terminates Pod due to OOM |
| `TaskHung` | No | Task hung |
| `UnregisterNetDevice` | No | Network interface abnormality |
| `KernelOops` | No | Kernel detects abnormal behavior, such as null pointer, device error |
| `Ext4Error` | No | Ext4 file system issue |
| `Ext4Warning` | No | Ext4 file system issue |
| `IOError` | No | Buffer issue |
| `MemoryReadError` | No | Correctable memory error, frequent occurrences indicate potential hardware issues |
| `KubeletStart` | No | Kubelet start, frequent occurrence means Kubelet frequently restarts |
| `DockerStart` | No | Docker start, frequent occurrence means Docker frequently restarts |
| `ContainerdStart` | No | Containerd start, frequent occurrence means Containerd frequently restarts |
| `CorruptDockerImage` | No | Directory used by Docker registry is not empty |
| `DockerContainerStartupFailure` | No | Docker fails to start |
| `ConntrackFull` | No | Network connection tracking limit reached, will affect NAT, firewall, etc., network functions |
| `NTPIsDown` | No | NTP time synchronization anomaly |