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

**Node Problem Detector**, abbreviated as **NPD**, is an open-source Kubernetes cluster node monitoring plugin used for node failure detection.

**NPD** features:

- Generates event information and reports it to the APIServer.
- Detects metrics information and outputs them as Metrics.


## Configuration {#config}

### Prerequisites

- [x] Install K8S environment
- [x] Install [DataKit](../datakit/datakit-daemonset-deploy.md)

### Installing NPD

Refer to the [installation documentation](https://github.com/kubernetes/node-problem-detector#installation). This guide uses the `yaml` method for installation.

- Download related YAML files

1. [node-problem-detector.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector.yaml)

2. [node-problem-detector-config.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector-config.yaml)

3. [rbac.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/rbac.yaml)

- Execution

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
```

### Log Event Mode

By default, after installing NPD, no additional configuration is required. DataKit automatically collects Kubernetes events and stores them in logs with the data source `Kubernetes_events` under the `reason` (tag).

### Metrics Mode

In addition to event mode, NPD also supports outputting metrics.

#### Preparation

- [x] Install [Prometheus Operator](kubernetes-prometheus-operator-crd.md)

#### Enable DataKit `ServiceMonitor`

[Automatic discovery of Pod/Service Prometheus metrics](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

The following collects NPD metrics using the `ServiceMonitor` method.

- Modify node-problem-detector.yaml

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

- Execution

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
| type="FDProblem" | System critical resource FD file handle issue |
| type="DiskHung" | Whether the node disk has IO hang |
| type="DiskReadonly" | Whether the node disk is read-only |
| type="DiskProblem" | Node system disk issue |
| type="DiskSlow" | Whether the node disk has slow IO issues |
| type="FrequentCRIRestart" | Frequent CRI restarts |
| type="FrequentDockerRestart" | Frequent Docker restarts |
| type="FrequentKubeletRestart" | Frequent Kubelet restarts |
| type="FrequentContainerdRestart" | Frequent Containerd restarts |
| type="NTPProblem" | `ntpd` synchronization anomaly |
| type="PIDProblem" | Insufficient system critical resource PID process resources |
| type="`ResolvConfFileProblem`" | `ResolvConf` configuration anomaly |
| type="CNIProblem" | CNI (container network) component anomaly |
| type="CRIProblem" | Component CRI (container runtime component) Docker or Containerd running state anomaly |
| type="`KUBEPROXYProblem`" | Kube-proxy running anomaly |
| type="`KUBELETProblem`" | Kubelet status anomaly |
| type="ScheduledEvent" | Whether there are scheduled events on the node |
| type="ProcessD" | Node has D processes |
| type="ProcessZ" | Node has Z processes |

## Logs {#logging}

The following list includes but is not limited to the events that NPD can detect by default. Events are written into logs with the data source `Kubernetes_events`:

| **Reason** | **Persistence** | **Description** |
| --- | --- | --- |
| `DockerHung` | Yes | Docker is hung or unresponsive |
| `ReadonlyFilesystem` | Yes | Filesystem mounted as read-only, usually a protective mechanism to prevent filesystem corruption in certain situations |
| `CorruptDockerOverlay2` | Yes | Issues with the Overlay2 storage driver |
| `ContainerdUnhealthy` | Yes | Containerd is in an unhealthy state |
| `KubeletUnhealthy` | Yes | Kubelet is in an unhealthy state |
| `DockerUnhealthy` | Yes | Docker is in an unhealthy state |
| `OOMKilling` | No | Kubernetes terminates Pods due to OOM |
| `TaskHung` | No | Task is hung |
| `UnregisterNetDevice` | No | Network interface anomaly |
| `KernelOops` | No | Kernel detects abnormal behavior, such as null pointer dereference, device errors |
| `Ext4Error` | No | Ext4 filesystem issues |
| `Ext4Warning` | No | Ext4 filesystem issues |
| `IOError` | No | Buffer issues |
| `MemoryReadError` | No | Correctable memory errors; frequent occurrences suggest potential hardware issues |
| `KubeletStart` | No | Kubelet starts; frequent occurrences indicate frequent Kubelet restarts |
| `DockerStart` | No | Docker starts; frequent occurrences indicate frequent Docker restarts |
| `ContainerdStart` | No | Containerd starts; frequent occurrences indicate frequent Containerd restarts |
| `CorruptDockerImage` | No | Docker registry directory is not empty |
| `DockerContainerStartupFailure` | No | Docker fails to start |
| `ConntrackFull` | No | Network connection tracking full, affecting NAT, firewall, etc. |
| `NTPIsDown` | No | NTP time synchronization anomaly |
