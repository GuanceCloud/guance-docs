---
title     : 'Node Problem Detector'
summary   : 'Collecting cluster node metics and events through NPD'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'Node Problem Detector'
    path  : 'dashboard/en/npd'
monitor   :
  - desc  : 'Node Problem Detector(metric) Detection Library'
    path  : 'monitor/en/npd'
  - desc  : 'Node Problem Detector(Log) Detection Library'
    path  : 'monitor/en/npd_log'
---

<!-- markdownlint-disable MD025 -->
# Node Problem Detector
<!-- markdownlint-enable -->

**Node Problem Detector** , abbreviated as NPD, is an open-source cluster node monitoring plugin for Kubernetes, used for node fault detection.


**NPD** Function:

- Generate event information and report it to APIServer.

- Detect indicator information, output as Metrics.


## Installation Configuration{#config}

### Preconditions{#requirement}

- [x] Installed K8S
- [x] Installed [DataKit](../datakit/datakit-daemonset-deploy.md)

### Installed NPD


Can [install documentation](https://github.com/kubernetes/node-problem-detector#installation) Here, the `yaml` method is used for installation.


- Download yaml

1. [node-problem-detector.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector.yaml)

2. [node-problem-detector-config.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/node-problem-detector-config.yaml)

3. [rbac.yaml](https://github.com/kubernetes/node-problem-detector/blob/master/deployment/rbac.yaml)

- Run

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
```

### Log(Event)

After installing NPD by default, no further configuration is required. Datakit collects Kubernetes events by default and stores them in the log `reason` (tag) with the data source being `Kubernetes_events`.

### Metric

In addition to event mode, NPD also supports output metrics

#### Precondition

- [x] Installed [Prometheus Operator](kubernetes-prometheus-operator-crd.md)

#### DataKit enables `ServiceMonitor`

[Automatically Discover the Service Exposure Metrics Interface](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)

Collect `NPD` indicator information through the `ServiceMonitor` method below.

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

- Created `npd-service.yaml`

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

- Created `npd-server-monitor.yaml`

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

- Run

```shell
kubectl apply -f rbac.yaml
kubectl apply -f node-problem-detector-config.yaml
kubectl apply -f node-problem-detector.yaml
kubectl apply -f npd-service.yaml
kubectl apply -f npd-server-metrics.yaml
```

## Metric {#metric}

### problem_gauge

|Tag| Description|
| -- | -- |
| `type="ConntrackFullProblem"`| Node link tracking table failure |
| type="EmptyDirVolumeGroupStatusError" | Temporary volume storage pool failure |
| type="MemoryProblem" | Node memory failure |
| type="LocalPvVolumeGroupStatusError" | Persistent volume storage pool failure on node |
| type="MountPointProblem" | Node mount point failure |
| type="FDProblem" | System critical resource FD file handle count failure |
| type="DiskHung" | Is there card IO present on the node disk |
| type="DiskReadonly" | Is the node disk read-only |
| type="DiskProblem" | Node system disk failure |
| type="DiskSlow" | Is there a slow IO fault on the node disk |
| type="FrequentCRIRestart" | CRI frequently restarts |
| type="FrequentDockerRestart" | Docker frequently restarts |
| type="FrequentKubeletRestart" | Kubelet frequently restarts|
| type="FrequentContainerdRestart" | Containerd frequently restarts|
| type="NTPProblem" | `ntpd` synchronization exception |
| type="PIDProblem" | Insufficient PID process resources for system critical resources |
| type="`ResolvConfFileProblem`" | `ResolvConf` configuration exception |
| type="CNIProblem" | CNI (Container Network) component exception |
| type="CRIProblem" | Abnormal running status of component CRI (container runtime component) Docker or Container |
| type="`KUBEPROXYProblem`" | Kube proxy running abnormally |
| type="`KUBELETProblem`" | Kubelet status is abnormal |
| type="ScheduledEvent" | Does the node have host schedule events |
| type="ProcessD" | Node has D processes present |
| type="ProcessZ" | Node has Z processes present |

## Logging {#logging}

The following list includes but is not limited to the events that NPD can detect under default configuration, and the events are written to the log with the data source `Kubernetes events`:

| **Cause** | **Persistence** | **Description** |
| --- | --- | --- |
| `DockerHung` | Yes | Docker is hung or unresponsive |
| `ReadonlyFilesystem` | Yes | The filesystem is mounted in read-only mode, typically a protective mechanism to prevent filesystem corruption in certain situations |
| `CorruptDockerOverlay2` | Yes | There is an issue with the Overlay2 storage driver |
| `ContainerdUnhealthy` | Yes | Containerd is in an unhealthy state |
| `KubeletUnhealthy` | Yes | Kubelet is in an unhealthy state |
| `DockerUnhealthy` | Yes | Docker is in an unhealthy state |
| `OOMKilling` | No | Kubernetes ends a Pod due to Out of Memory (OOM) |
| `TaskHung` | No | The task is hung |
| `UnregisterNetDevice` | No | Network interface exception |
| `KernelOops` | No | Exceptional behavior detected by the kernel, such as null pointers, device errors |
| `Ext4Error` | No | Ext4 filesystem issue |
| `Ext4Warning` | No | Ext4 filesystem issue |
| `IOError` | No | Buffer issue |
| `MemoryReadError` | No | Correctable memory error; frequent occurrences may indicate a potential problem with the memory hardware |
| `KubeletStart` | No | Kubelet starts; frequent occurrences mean Kubelet is restarting frequently |
| `DockerStart` | No | Docker starts; frequent occurrences mean Docker is restarting frequently |
| `ContainerdStart` | No | Containerd starts; frequent occurrences mean Containerd is restarting frequently |
| `CorruptDockerImage` | No | The directory used by Docker registry is not empty |
| `DockerContainerStartupFailure` | No | Docker fails to start |
| `ConntrackFull` | No | Network connection tracking is full, which will affect NAT, firewall, and other network functions |
| `NTPIsDown` | No | NTP time synchronization exception |
